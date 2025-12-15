# syntax=docker/dockerfile:1

# Frontend build stage
FROM oven/bun:1 AS frontend-builder

WORKDIR /app

# Copy frontend source code
COPY lightrag_webui/ ./lightrag_webui/

# Build frontend assets for inclusion in the API package
RUN --mount=type=cache,target=/root/.bun/install/cache \
    cd lightrag_webui \
    && bun install --frozen-lockfile \
    && bun run build

# Python build stage - using uv for faster package installation
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV UV_SYSTEM_PYTHON=1
ENV UV_COMPILE_BYTECODE=1

WORKDIR /app

# Install system deps (Rust is required by some wheels)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
        pkg-config \
    && rm -rf /var/lib/apt/lists/* \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:/root/.local/bin:${PATH}"

# Ensure shared data directory exists for uv caches
RUN mkdir -p /root/.local/share/uv

# Copy project metadata and sources
COPY pyproject.toml .
COPY setup.py .
COPY uv.lock .

# Install base, API, and offline extras without the project to improve caching
RUN --mount=type=cache,target=/root/.local/share/uv \
    uv sync --frozen --no-dev --extra api --extra offline --no-install-project --no-editable

# Copy project sources after dependency layer
COPY lightrag/ ./lightrag/

# Include pre-built frontend assets from the previous stage
COPY --from=frontend-builder /app/lightrag/api/webui ./lightrag/api/webui

# Sync project in non-editable mode and ensure pip is available for runtime installs
RUN --mount=type=cache,target=/root/.local/share/uv \
    uv sync --frozen --no-dev --extra api --extra offline --no-editable \
    && /app/.venv/bin/python -m ensurepip --upgrade

# Prepare offline cache directory and pre-populate tiktoken data
# Use uv run to execute commands from the virtual environment
RUN mkdir -p /app/data/tiktoken \
    && uv run lightrag-download-cache --cache-dir /app/data/tiktoken || status=$?; \
    if [ -n "${status:-}" ] && [ "$status" -ne 0 ] && [ "$status" -ne 2 ]; then exit "$status"; fi

# Final stage
FROM python:3.12-slim

WORKDIR /app

# Install uv for package management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

ENV UV_SYSTEM_PYTHON=1

# Copy installed packages and application code
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app/lightrag ./lightrag
COPY pyproject.toml .
COPY setup.py .
COPY uv.lock .

# Ensure the installed scripts are on PATH
ENV PATH=/app/.venv/bin:/root/.local/bin:$PATH

# Install dependencies with uv sync (uses locked versions from uv.lock)
# And ensure pip is available for runtime installs
RUN --mount=type=cache,target=/root/.local/share/uv \
    uv sync --frozen --no-dev --extra api --extra offline --no-editable \
    && /app/.venv/bin/python -m ensurepip --upgrade

# Create persistent data directories AFTER package installation
RUN mkdir -p /app/data/rag_storage /app/data/inputs /app/data/tiktoken

# Copy offline cache into the newly created directory
COPY --from=builder /app/data/tiktoken /app/data/tiktoken

# Point to the prepared cache
ENV TIKTOKEN_CACHE_DIR=/app/data/tiktoken
ENV WORKING_DIR=/app/data/rag_storage
ENV INPUT_DIR=/app/data/inputs

# Expose API port
EXPOSE 9621

ENTRYPOINT ["python", "-m", "lightrag.api.lightrag_server"]

# ====================================================================
# Additional local development services
# ====================================================================
# This repository includes `docker-compose.services.yml` which defines
# Neo4j, MongoDB, Redis, Memgraph and PostgreSQL services for local
# development. Each service maps its container ports to host ports so
# they are reachable from the host (and from other host processes,
# including an Ollama daemon running on the host).
#
# To start the services:
#
#   docker compose -f docker-compose.services.yml up -d
#
# To stop them:
#
#   docker compose -f docker-compose.services.yml down
#
# Notes about Ollama connectivity:
# - Containers are given an extra hosts entry mapping `host.docker.internal`
#   to the Docker host via `host-gateway`. Inside the containers, use the
#   hostname `host.docker.internal` to reach the host's Ollama service.
# - This requires a Docker engine that supports `host-gateway` (recent
#   Docker versions). If unavailable, provide your host IP or use
#   alternative networking such as `network_mode: host`.
#
# Helper script:
# - A convenience script is available at `scripts/start_services.sh`.
#   Make it executable and then run `./scripts/start_services.sh up`.
#
# Ports exposed by the compose file (host:container):
# - Neo4j: 7474:7474 (HTTP), 7687:7687 (Bolt)
# - MongoDB: 27017:27017
# - Redis: 6379:6379
# - Memgraph: 7688:7687 (host 7688 -> container 7687 Bolt), 3001:3000 (Lab)
# - PostgreSQL: 5432:5432
#
# If you want these services to be on the same Docker network as the
# application container, run `docker compose` with a multi-file setup
# or adjust the compose file accordingly.
# ====================================================================
