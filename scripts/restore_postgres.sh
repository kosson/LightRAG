#!/bin/bash
# PostgreSQL Restore Script for LightRAG
# This script restores a PostgreSQL backup from pg_dump

set -e

# Configuration
CONTAINER_NAME="lightrag_postgres"
BACKUP_DIR="./backups/postgres"
DB_NAME="lightrag"
DB_USER="postgres"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== LightRAG PostgreSQL Restore ===${NC}"

# Check if backup file is provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Available backups:${NC}"
    ls -lh "${BACKUP_DIR}"/lightrag_postgres_*.sql.gz 2>/dev/null || echo "No backups found"
    echo ""
    echo "Usage: $0 <backup_file>"
    echo "Example: $0 ${BACKUP_DIR}/lightrag_postgres_20231224_120000.sql.gz"
    exit 1
fi

BACKUP_FILE="$1"

# Check if backup file exists
if [ ! -f "${BACKUP_FILE}" ]; then
    echo -e "${RED}Error: Backup file ${BACKUP_FILE} not found${NC}"
    exit 1
fi

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo -e "${RED}Error: Container ${CONTAINER_NAME} is not running${NC}"
    exit 1
fi

echo -e "${YELLOW}⚠ WARNING: This will replace all data in the database!${NC}"
read -p "Are you sure you want to continue? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "Restore cancelled"
    exit 0
fi

echo -e "${YELLOW}Decompressing backup...${NC}"

# Decompress and restore
if [[ "${BACKUP_FILE}" == *.gz ]]; then
    gunzip -c "${BACKUP_FILE}" | docker exec -i ${CONTAINER_NAME} psql \
        -U ${DB_USER} \
        -d postgres \
        --set ON_ERROR_STOP=on
else
    docker exec -i ${CONTAINER_NAME} psql \
        -U ${DB_USER} \
        -d postgres \
        --set ON_ERROR_STOP=on \
        < "${BACKUP_FILE}"
fi

echo -e "${GREEN}✓ Restore completed successfully${NC}"
echo -e "${YELLOW}Note: You may need to restart the LightRAG service${NC}"
