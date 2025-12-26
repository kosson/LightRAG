#!/bin/bash
# Complete Restore Script for all LightRAG Docker volumes and data
# This restores a portable backup created by backup_all_volumes.sh

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  LightRAG Complete Restore System     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Check if backup name is provided
if [ -z "$1" ]; then
    echo -e "\n${YELLOW}Available backups:${NC}"
    ls -lh ./backups/lightrag_full_backup_*.tar.gz 2>/dev/null || echo "No backups found"
    echo ""
    echo "Usage: $0 <backup_name>"
    echo "Example: $0 lightrag_full_backup_20231224_120000"
    exit 1
fi

BACKUP_NAME="$1"
BACKUP_ARCHIVE="./backups/${BACKUP_NAME}.tar.gz"
RESTORE_DIR="./backups/${BACKUP_NAME}"

# Check if backup exists
if [ ! -f "${BACKUP_ARCHIVE}" ]; then
    echo -e "${RED}Error: Backup archive ${BACKUP_ARCHIVE} not found${NC}"
    exit 1
fi

echo -e "\n${YELLOW}Backup to restore: ${BACKUP_NAME}${NC}"
echo -e "${RED}⚠ WARNING: This will REPLACE ALL CURRENT DATA!${NC}"
echo -e "${RED}⚠ All databases and application data will be overwritten!${NC}"
read -p "Are you sure you want to continue? (type 'YES' to confirm): " -r
if [[ ! $REPLY == "YES" ]]; then
    echo "Restore cancelled"
    exit 0
fi

# Extract backup
echo -e "\n${YELLOW}Extracting backup archive...${NC}"
cd ./backups
tar xzf "${BACKUP_NAME}.tar.gz"
cd ..

echo -e "${GREEN}✓ Backup extracted${NC}"

# Display backup info
if [ -f "${RESTORE_DIR}/BACKUP_INFO.txt" ]; then
    echo -e "\n${BLUE}Backup Information:${NC}"
    cat "${RESTORE_DIR}/BACKUP_INFO.txt"
    echo ""
    read -p "Press Enter to continue with restore..."
fi

# Stop all services
echo -e "\n${YELLOW}Stopping LightRAG services...${NC}"
docker-compose down
echo -e "${GREEN}✓ Services stopped${NC}"

# ========================================
# 1. Restore PostgreSQL
# ========================================
echo -e "\n${GREEN}[1/6] Restoring PostgreSQL...${NC}"
if [ -f "${RESTORE_DIR}/postgres/lightrag.sql.gz" ]; then
    # Start only postgres
    docker-compose up -d postgres
    sleep 5
    
    # Restore database
    gunzip -c "${RESTORE_DIR}/postgres/lightrag.sql.gz" | docker exec -i lightrag_postgres psql \
        -U postgres \
        -d postgres \
        --set ON_ERROR_STOP=on
    
    docker-compose stop postgres
    echo -e "${GREEN}✓ PostgreSQL restored${NC}"
else
    echo -e "${YELLOW}⊘ PostgreSQL backup not found${NC}"
fi

# ========================================
# 2. Restore Neo4j
# ========================================
echo -e "\n${GREEN}[2/6] Restoring Neo4j...${NC}"
if [ -f "${RESTORE_DIR}/neo4j/neo4j_data.tar.gz" ]; then
    # Remove old volume and create new one
    docker volume rm neo4j_data 2>/dev/null || true
    docker volume create neo4j_data
    
    # Restore data
    docker run --rm \
        -v neo4j_data:/data \
        -v "${PWD}/${RESTORE_DIR}/neo4j:/backup" \
        alpine sh -c "cd / && tar xzf /backup/neo4j_data.tar.gz"
    
    echo -e "${GREEN}✓ Neo4j restored${NC}"
else
    echo -e "${YELLOW}⊘ Neo4j backup not found${NC}"
fi

# ========================================
# 3. Restore MongoDB
# ========================================
echo -e "\n${GREEN}[3/6] Restoring MongoDB...${NC}"
if [ -f "${RESTORE_DIR}/mongodb/mongo_backup.tar.gz" ]; then
    # Start only mongodb
    docker-compose up -d mongodb
    sleep 5
    
    # Extract and restore
    cd "${RESTORE_DIR}/mongodb" && tar xzf mongo_backup.tar.gz
    docker cp mongo_backup lightrag_mongo:/tmp/
    docker exec lightrag_mongo mongorestore /tmp/mongo_backup --drop
    docker exec lightrag_mongo rm -rf /tmp/mongo_backup
    
    docker-compose stop mongodb
    echo -e "${GREEN}✓ MongoDB restored${NC}"
else
    echo -e "${YELLOW}⊘ MongoDB backup not found${NC}"
fi

# ========================================
# 4. Restore Redis
# ========================================
echo -e "\n${GREEN}[4/6] Restoring Redis...${NC}"
if [ -f "${RESTORE_DIR}/redis/redis_data.tar.gz" ]; then
    # Remove old volume and create new one
    docker volume rm redis_data 2>/dev/null || true
    docker volume create redis_data
    
    # Restore data
    docker run --rm \
        -v redis_data:/data \
        -v "${PWD}/${RESTORE_DIR}/redis:/backup" \
        alpine sh -c "cd / && tar xzf /backup/redis_data.tar.gz"
    
    echo -e "${GREEN}✓ Redis restored${NC}"
else
    echo -e "${YELLOW}⊘ Redis backup not found${NC}"
fi

# ========================================
# 5. Restore Memgraph
# ========================================
echo -e "\n${GREEN}[5/6] Restoring Memgraph...${NC}"
if [ -f "${RESTORE_DIR}/memgraph/memgraph_data.tar.gz" ]; then
    # Remove old volume and create new one
    docker volume rm memgraph_data 2>/dev/null || true
    docker volume create memgraph_data
    
    # Restore data
    docker run --rm \
        -v memgraph_data:/var/lib/memgraph \
        -v "${PWD}/${RESTORE_DIR}/memgraph:/backup" \
        alpine sh -c "cd / && tar xzf /backup/memgraph_data.tar.gz"
    
    echo -e "${GREEN}✓ Memgraph restored${NC}"
else
    echo -e "${YELLOW}⊘ Memgraph backup not found${NC}"
fi

# ========================================
# 6. Restore Application Data
# ========================================
echo -e "\n${GREEN}[6/6] Restoring application data...${NC}"

if [ -f "${RESTORE_DIR}/app_data/rag_storage.tar.gz" ]; then
    rm -rf ./data/rag_storage
    tar xzf "${RESTORE_DIR}/app_data/rag_storage.tar.gz"
    echo -e "${GREEN}✓ RAG storage restored${NC}"
fi

if [ -f "${RESTORE_DIR}/app_data/inputs.tar.gz" ]; then
    rm -rf ./data/inputs
    tar xzf "${RESTORE_DIR}/app_data/inputs.tar.gz"
    echo -e "${GREEN}✓ Input files restored${NC}"
fi

# Restore configuration files (with backup of current)
if [ -f "${RESTORE_DIR}/app_data/.env.backup" ]; then
    cp .env .env.before_restore 2>/dev/null || true
    echo -e "${YELLOW}Note: Current .env backed up to .env.before_restore${NC}"
    echo -e "${YELLOW}Review and manually merge if needed${NC}"
fi

# Clean up extracted restore directory
rm -rf "${RESTORE_DIR}"

echo -e "\n${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Restore Complete!                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo -e "\n${GREEN}All data has been restored.${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo -e "  1. Review configuration: .env and config.ini"
echo -e "  2. Start services: ${GREEN}docker-compose up -d${NC}"
echo -e "  3. Check logs: ${GREEN}docker-compose logs -f${NC}"
