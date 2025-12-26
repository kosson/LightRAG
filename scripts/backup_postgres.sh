#!/bin/bash
# PostgreSQL Backup Script for LightRAG
# This script creates logical backups using pg_dump inside the container

set -e

# Configuration
CONTAINER_NAME="lightrag_postgres"
BACKUP_DIR="./backups/postgres"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="lightrag_postgres_${TIMESTAMP}.sql"
DB_NAME="lightrag"
DB_USER="postgres"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== LightRAG PostgreSQL Backup ===${NC}"
echo "Starting backup at $(date)"

# Create backup directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo -e "${RED}Error: Container ${CONTAINER_NAME} is not running${NC}"
    exit 1
fi

echo -e "${YELLOW}Creating PostgreSQL dump...${NC}"

# Create SQL dump using pg_dump inside the container
docker exec -t ${CONTAINER_NAME} pg_dump \
    -U ${DB_USER} \
    -d ${DB_NAME} \
    --verbose \
    --clean \
    --if-exists \
    --create \
    --format=plain \
    > "${BACKUP_DIR}/${BACKUP_FILE}"

# Compress the backup
echo -e "${YELLOW}Compressing backup...${NC}"
gzip "${BACKUP_DIR}/${BACKUP_FILE}"

COMPRESSED_FILE="${BACKUP_FILE}.gz"
BACKUP_SIZE=$(du -h "${BACKUP_DIR}/${COMPRESSED_FILE}" | cut -f1)

echo -e "${GREEN}✓ Backup completed successfully${NC}"
echo "  File: ${BACKUP_DIR}/${COMPRESSED_FILE}"
echo "  Size: ${BACKUP_SIZE}"

# Keep only last 7 backups
echo -e "${YELLOW}Cleaning old backups (keeping last 7)...${NC}"
cd "${BACKUP_DIR}" && ls -t lightrag_postgres_*.sql.gz | tail -n +8 | xargs -r rm
echo -e "${GREEN}✓ Cleanup completed${NC}"

# Verify backup integrity
echo -e "${YELLOW}Verifying backup integrity...${NC}"
if gunzip -t "${BACKUP_DIR}/${COMPRESSED_FILE}"; then
    echo -e "${GREEN}✓ Backup file integrity verified${NC}"
else
    echo -e "${RED}✗ Backup file may be corrupted${NC}"
    exit 1
fi

echo -e "${GREEN}=== Backup Complete ===${NC}"
echo "Backup location: ${BACKUP_DIR}/${COMPRESSED_FILE}"
