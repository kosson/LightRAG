#!/usr/bin/env bash
set -euo pipefail

# Quick checks to verify containers can reach the host's Ollama endpoint.
# Requirements:
# - Ollama running on the host at port 11434 (default).
# - Docker engine that supports host-gateway (most modern versions).
#
# This script tests from:
#   1) the host itself
#   2) an ephemeral container joined to the compose network (using the lightrag image)
#   3) an external curl-only container on the same network (as a double-check)
#
# Usage: ./scripts/test_ollama_connectivity.sh [url]
# Default URL: http://host.docker.internal:11434/api/tags

URL=${1:-http://host.docker.internal:11434/api/tags}
COMPOSE_FILE=${COMPOSE_FILE:-docker-compose.yml}
SERVICE=${SERVICE:-lightrag}

info() { printf "[info] %s\n" "$*"; }
ok()   { printf "[ ok ] %s\n" "$*"; }
fail() { printf "[fail] %s\n" "$*"; exit 1; }

# 1) Host check
info "Host -> $URL"
if curl -sSf "$URL" >/dev/null; then
  ok "Host can reach Ollama"
else
  fail "Host cannot reach Ollama at $URL; ensure 'ollama serve' is running"
fi

# 2) From lightrag image (same network as app). Uses Python requests inside the image.
info "Container ($SERVICE) -> $URL"
if docker compose -f "$COMPOSE_FILE" run --rm --no-deps --entrypoint python "$SERVICE" - <<'PY' URL="$URL"
import os, sys, requests
url = os.environ.get("URL")
try:
    r = requests.get(url, timeout=5)
    print("status", r.status_code)
    print("body", r.text[:200])
    sys.exit(0 if r.ok else 1)
except Exception as e:
    print("error", e)
    sys.exit(2)
PY
then
  ok "${SERVICE} container can reach Ollama"
else
  fail "${SERVICE} container cannot reach Ollama at $URL"
fi

# 3) From a tiny curl-only container on the same network (fallback + alias test)
info "Curl container -> $URL (and aliases)"
NETWORK=$(docker compose -f "$COMPOSE_FILE" ps -q "$SERVICE" | head -n1 | xargs -r docker inspect --format '{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}')
NETWORK_NAME=$(docker network ls --filter id="$NETWORK" --format '{{.Name}}')
if [ -z "$NETWORK_NAME" ]; then
  fail "Could not determine compose network name"
fi

run_curl() {
  local target="$1"
  docker run --rm \
    --network "$NETWORK_NAME" \
    --add-host host.docker.internal:host-gateway \
    --add-host ollama.host:host-gateway \
    --add-host docker.host:172.17.0.1 \
    curlimages/curl:8.9.0 -sSf "$target" >/dev/null
}

if run_curl "$URL"; then
  ok "curl container can reach $URL"
else
  info "Retrying with alias http://ollama.host:11434/api/tags"
  if run_curl http://ollama.host:11434/api/tags; then
    ok "curl container reached via alias ollama.host"
  else
    info "Retrying with fallback host IP alias http://docker.host:11434/api/tags"
    if run_curl http://docker.host:11434/api/tags; then
      ok "curl container reached via alias docker.host"
    else
      fail "curl container could not reach Ollama via host/alias/fallback"
    fi
  fi
fi

ok "All checks passed"
