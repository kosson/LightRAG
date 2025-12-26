#!/bin/bash
# Quick Backup - Creates a timestamped full backup
# Run this anytime before major changes or updates

cd /media/nicolaie/beckie21/LIGHT.RAG/LightRAG
./scripts/backup_all_volumes.sh

echo ""
echo "💾 Backup complete!"
echo "📁 Location: ./backups/"
echo ""
echo "To restore: ./scripts/restore_all_volumes.sh <backup_name>"
