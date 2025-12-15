# Ollama Connection Fix for Docker

## Problem
Docker containers cannot reach Ollama running on the host because Ollama is bound to `127.0.0.1:11434` (localhost only) instead of `0.0.0.0:11434` (all interfaces).

## Solution

### Option 1: Configure Ollama to bind to all interfaces (Recommended)

1. Set the `OLLAMA_HOST` environment variable before starting Ollama:

```bash
export OLLAMA_HOST=0.0.0.0:11434
ollama serve
```

2. Or create a systemd service override (if using systemd):

```bash
sudo mkdir -p /etc/systemd/system/ollama.service.d
sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null <<EOF
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
EOF

sudo systemctl daemon-reload
sudo systemctl restart ollama
```

3. Verify Ollama is now accessible:

```bash
# From host
curl http://localhost:11434/api/tags

# Run diagnostic from container
./scripts/diagnose_ollama.sh
```

### Option 2: Use host network mode (Linux only)

If you can't change Ollama's binding, use host network mode for the LightRAG container:

1. Edit `docker-compose.yml` and add `network_mode: host` to the lightrag service:

```yaml
services:
  lightrag:
    network_mode: host
    # Remove 'ports' section - not needed with host mode
    # Remove 'extra_hosts' - not needed with host mode
```

2. Update `.env` to use `localhost` instead of `host.docker.internal`:

```bash
LLM_BINDING_HOST=http://localhost:11434
EMBEDDING_BINDING_HOST=http://localhost:11434
```

**Note**: With host network mode, the container won't be able to reach other compose services by service name. You'll need to use `localhost` for all services.

### Option 3: Use Docker host IP directly (Fallback)

If neither option above works, find your Docker bridge IP and use it directly:

```bash
# Find Docker bridge IP
ip addr show docker0 | grep -Po 'inet \K[\d.]+'
```

Then update `.env`:

```bash
LLM_BINDING_HOST=http://172.17.0.1:11434
EMBEDDING_BINDING_HOST=http://172.17.0.1:11434
```

## Verification

After applying any fix, run:

```bash
./scripts/diagnose_ollama.sh
```

All checks should show ✓ OK.

## Security Note

When binding Ollama to `0.0.0.0`, it will be accessible from your local network. If this is a concern:
- Use a firewall to restrict access
- Or bind to the Docker bridge IP only: `export OLLAMA_HOST=172.17.0.1:11434`
