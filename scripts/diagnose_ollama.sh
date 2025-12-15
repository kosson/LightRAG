#!/usr/bin/env bash
set -euo pipefail

# Diagnose Ollama connectivity from inside the LightRAG container
# This script tests various endpoints and host aliases to identify connectivity issues

CONTAINER=${1:-lightrag}

info() { printf "\n[INFO] %s\n" "$*"; }
test_url() {
  local label="$1" url="$2"
  printf "  %-45s" "$label ($url):"
  # Use Python requests since curl may not be installed in the container
  if docker exec "$CONTAINER" python -c "import requests; r = requests.get('$url', timeout=3); exit(0 if r.ok else 1)" 2>/dev/null; then
    echo " ✓ OK"
    return 0
  else
    echo " ✗ FAIL"
    return 1
  fi
}

echo "========================================"
echo "Ollama Connectivity Diagnostic"
echo "========================================"

# Check if container is running
if ! docker ps --filter name="$CONTAINER" --format '{{.Names}}' | grep -q "^${CONTAINER}$"; then
  echo "ERROR: Container '$CONTAINER' is not running"
  exit 1
fi

info "Testing from container: $CONTAINER"

# Test various host aliases and endpoints
test_url "host.docker.internal:11434" "http://host.docker.internal:11434/api/tags" || true
test_url "ollama.host:11434" "http://ollama.host:11434/api/tags" || true
test_url "docker.host:11434" "http://docker.host:11434/api/tags" || true
test_url "gateway.docker.internal:11434" "http://gateway.docker.internal:11434/api/tags" || true

# Test if DNS resolution works
info "DNS resolution check"
docker exec "$CONTAINER" sh -c 'getent hosts host.docker.internal || echo "  ✗ Cannot resolve host.docker.internal"'
docker exec "$CONTAINER" sh -c 'getent hosts ollama.host || echo "  ✗ Cannot resolve ollama.host"'

# Check /etc/hosts entries
info "Container /etc/hosts entries (host-related)"
docker exec "$CONTAINER" grep -E "(host|gateway)" /etc/hosts || echo "  No host entries found"

# Test from host
info "Testing from host machine"
if curl -sf --max-time 3 http://localhost:11434/api/tags >/dev/null 2>&1; then
  echo "  ✓ Host can reach Ollama at localhost:11434"
else
  echo "  ✗ Host cannot reach Ollama at localhost:11434"
  echo ""
  echo "SOLUTION: Ensure Ollama is running and bound to 0.0.0.0:"
  echo "  export OLLAMA_HOST=0.0.0.0:11434"
  echo "  ollama serve"
fi

# Test if Ollama is bound to all interfaces
info "Checking Ollama binding (host)"
if command -v ss >/dev/null 2>&1; then
  echo "  Ports listening on :11434:"
  ss -tlnp 2>/dev/null | grep :11434 || echo "  ✗ No process listening on port 11434"
elif command -v netstat >/dev/null 2>&1; then
  echo "  Ports listening on :11434:"
  netstat -tlnp 2>/dev/null | grep :11434 || echo "  ✗ No process listening on port 11434"
else
  echo "  (ss/netstat not available, skipping)"
fi

echo ""
echo "========================================"
echo "Diagnostic complete"
echo "========================================"
