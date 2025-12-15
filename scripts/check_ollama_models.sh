#!/usr/bin/env bash
set -euo pipefail

# Script to verify and pull required Ollama models for LightRAG
# Reads model requirements from .env and ensures they are available

info() { printf "[INFO] %s\n" "$*"; }
ok()   { printf "[ OK ] %s\n" "$*"; }
warn() { printf "[WARN] %s\n" "$*"; }
fail() { printf "[FAIL] %s\n" "$*"; exit 1; }

ENV_FILE=${1:-.env}

if [ ! -f "$ENV_FILE" ]; then
  fail "Environment file not found: $ENV_FILE"
fi

# Extract model names from .env
LLM_MODEL=$(grep "^LLM_MODEL=" "$ENV_FILE" | cut -d'=' -f2 | tr -d '"' | tr -d "'")
EMBEDDING_MODEL=$(grep "^EMBEDDING_MODEL=" "$ENV_FILE" | cut -d'=' -f2 | tr -d '"' | tr -d "'")

info "Checking required models from $ENV_FILE"
echo "  LLM Model:       $LLM_MODEL"
echo "  Embedding Model: $EMBEDDING_MODEL"
echo ""

# Check if Ollama is running
if ! curl -sf http://localhost:11434/api/tags >/dev/null 2>&1; then
  fail "Ollama is not running or not accessible at localhost:11434"
fi

# Get list of available models
AVAILABLE_MODELS=$(ollama list | tail -n +2 | awk '{print $1}')

check_and_pull() {
  local model="$1"
  local label="$2"
  
  if echo "$AVAILABLE_MODELS" | grep -q "^${model}$"; then
    ok "$label model '$model' is available"
    return 0
  else
    warn "$label model '$model' not found, pulling..."
    if ollama pull "$model"; then
      ok "Successfully pulled $model"
      return 0
    else
      fail "Failed to pull $model"
      return 1
    fi
  fi
}

# Check and pull LLM model
check_and_pull "$LLM_MODEL" "LLM"

# Check and pull Embedding model
check_and_pull "$EMBEDDING_MODEL" "Embedding"

echo ""
info "All required models are available"
echo ""
echo "Current Ollama models:"
ollama list
