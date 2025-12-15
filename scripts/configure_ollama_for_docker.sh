#!/usr/bin/env bash
set -euo pipefail

# Script to configure and restart Ollama to bind to all interfaces
# This allows Docker containers to reach Ollama on the host

info() { printf "\n[INFO] %s\n" "$*"; }
ok()   { printf "[OK] %s\n" "$*"; }
warn() { printf "[WARN] %s\n" "$*"; }
fail() { printf "[FAIL] %s\n" "$*"; exit 1; }

echo "========================================"
echo "Configuring Ollama for Docker Access"
echo "========================================"

# Check if Ollama is installed
if ! command -v ollama >/dev/null 2>&1; then
  fail "Ollama is not installed. Install from https://ollama.com/download"
fi

# Check if running as systemd service
if systemctl is-active --quiet ollama 2>/dev/null; then
  info "Ollama is running as systemd service"
  
  # Create systemd override directory
  sudo mkdir -p /etc/systemd/system/ollama.service.d
  
  # Create override configuration
  info "Creating systemd override to bind Ollama to 0.0.0.0:11434"
  sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null <<EOF
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
EOF
  
  ok "Created /etc/systemd/system/ollama.service.d/override.conf"
  
  # Reload and restart
  info "Reloading systemd and restarting Ollama service"
  sudo systemctl daemon-reload
  sudo systemctl restart ollama
  
  sleep 2
  
  if systemctl is-active --quiet ollama; then
    ok "Ollama service restarted successfully"
  else
    fail "Failed to restart Ollama service. Check: sudo systemctl status ollama"
  fi
  
else
  info "Ollama is not running as systemd service"
  
  # Check if Ollama is running
  if pgrep -f "ollama serve" >/dev/null 2>&1; then
    info "Stopping current Ollama process"
    pkill -f "ollama serve" || true
    sleep 2
  fi
  
  # Start Ollama with correct binding
  info "Starting Ollama bound to 0.0.0.0:11434"
  export OLLAMA_HOST=0.0.0.0:11434
  
  # Start in background
  nohup ollama serve > /tmp/ollama.log 2>&1 &
  sleep 3
  
  if pgrep -f "ollama serve" >/dev/null 2>&1; then
    ok "Ollama started successfully"
    info "Ollama logs: /tmp/ollama.log"
    warn "Ollama is running in background. To make this permanent, add to your shell profile:"
    echo "    export OLLAMA_HOST=0.0.0.0:11434"
  else
    fail "Failed to start Ollama. Check logs: tail -f /tmp/ollama.log"
  fi
fi

# Verify Ollama is listening on all interfaces
info "Verifying Ollama binding"
sleep 2

if command -v ss >/dev/null 2>&1; then
  BINDING=$(ss -tlnp 2>/dev/null | grep :11434 | head -n1)
elif command -v netstat >/dev/null 2>&1; then
  BINDING=$(netstat -tlnp 2>/dev/null | grep :11434 | head -n1)
else
  BINDING=""
fi

if echo "$BINDING" | grep -q "0.0.0.0:11434"; then
  ok "Ollama is now listening on 0.0.0.0:11434 (all interfaces)"
elif echo "$BINDING" | grep -q "127.0.0.1:11434"; then
  warn "Ollama is still bound to 127.0.0.1:11434"
  warn "Try manually: export OLLAMA_HOST=0.0.0.0:11434 && ollama serve"
else
  warn "Could not verify Ollama binding (might need elevated permissions)"
fi

# Test connectivity
info "Testing connectivity"
if curl -sf --max-time 3 http://localhost:11434/api/tags >/dev/null 2>&1; then
  ok "Host can reach Ollama at localhost:11434"
else
  fail "Cannot reach Ollama. Check if it's running: curl http://localhost:11434/api/tags"
fi

echo ""
echo "========================================"
echo "Configuration Complete"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Restart Docker containers: docker compose restart"
echo "  2. Run diagnostics: ./scripts/diagnose_ollama.sh"
echo ""
