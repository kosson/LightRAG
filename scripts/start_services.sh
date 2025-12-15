#!/usr/bin/env bash
set -euo pipefail

# Helper to start the local DB/services for LightRAG
# Usage: ./scripts/start_services.sh up|down|restart
CMD=${1:-up}

case "$CMD" in
  up)
    docker compose -f docker-compose.services.yml up -d
    ;;
  down)
    docker compose -f docker-compose.services.yml down
    ;;
  restart)
    docker compose -f docker-compose.services.yml down
    docker compose -f docker-compose.services.yml up -d
    ;;
  *)
    echo "Usage: $0 up|down|restart"
    exit 2
    ;;
esac

echo "Done."
