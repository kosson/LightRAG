#!/bin/bash
# Complete Backup Script for all LightRAG Docker volumes and data
# This creates a portable backup of all database volumes and application data

set -e

# Configuration
BACKUP_BASE_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="lightrag_full_backup_${TIMESTAMP}"
BACKUP_DIR="${BACKUP_BASE_DIR}/${BACKUP_NAME}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  LightRAG Complete Backup System      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo "Starting full backup at $(date)"

# Create backup directory structure
mkdir -p "${BACKUP_DIR}"/{postgres,neo4j,mongodb,redis,memgraph,app_data}

# Function to check if service is running
check_service() {
    local container=$1
    if docker ps --format '{{.Names}}' | grep -q "^${container}$"; then
        return 0
    else
        echo -e "${RED}Warning: Container ${container} is not running${NC}"
        return 1
    fi
}

# ========================================
# 1. Backup PostgreSQL (using pg_dump)
# ========================================
echo -e "\n${GREEN}[1/6] Backing up PostgreSQL...${NC}"
if check_service "lightrag_postgres"; then
    docker exec -t lightrag_postgres pg_dump \
        -U postgres \
        -d lightrag \
        --verbose \
        --clean \
        --if-exists \
        --create \
        --format=plain \
        > "${BACKUP_DIR}/postgres/lightrag.sql" 2>&1
    gzip "${BACKUP_DIR}/postgres/lightrag.sql"
    echo -e "${GREEN}✓ PostgreSQL backup completed${NC}"
else
    echo -e "${YELLOW}⊘ PostgreSQL backup skipped (container not running)${NC}"
fi

# ========================================
# 2. Backup Neo4j (volume backup)
# ========================================
echo -e "\n${GREEN}[2/6] Backing up Neo4j...${NC}"
if check_service "lightrag_neo4j"; then
    docker run --rm \
        --volumes-from lightrag_neo4j \
        -v "${PWD}/${BACKUP_DIR}/neo4j:/backup" \
        alpine tar czf /backup/neo4j_data.tar.gz /data
    echo -e "${GREEN}✓ Neo4j backup completed${NC}"
else
    echo -e "${YELLOW}⊘ Neo4j backup skipped (container not running)${NC}"
fi

# ========================================
# 3. Backup MongoDB (using mongodump)
# ========================================
echo -e "\n${GREEN}[3/6] Backing up MongoDB...${NC}"
if check_service "lightrag_mongo"; then
    docker exec lightrag_mongo mongodump \
        --out=/tmp/mongo_backup \
        --quiet
    docker cp lightrag_mongo:/tmp/mongo_backup "${BACKUP_DIR}/mongodb/"
    docker exec lightrag_mongo rm -rf /tmp/mongo_backup
    (cd "${BACKUP_DIR}/mongodb" && tar czf mongo_backup.tar.gz mongo_backup && rm -rf mongo_backup)
    echo -e "${GREEN}✓ MongoDB backup completed${NC}"
else
    echo -e "${YELLOW}⊘ MongoDB backup skipped (container not running)${NC}"
fi

# ========================================
# 4. Backup Redis (volume backup)
# ========================================
echo -e "\n${GREEN}[4/6] Backing up Redis...${NC}"
if check_service "lightrag_redis"; then
    # Trigger Redis save
    docker exec lightrag_redis redis-cli BGSAVE
    sleep 2
    docker run --rm \
        --volumes-from lightrag_redis \
        -v "${PWD}/${BACKUP_DIR}/redis:/backup" \
        alpine tar czf /backup/redis_data.tar.gz /data
    echo -e "${GREEN}✓ Redis backup completed${NC}"
else
    echo -e "${YELLOW}⊘ Redis backup skipped (container not running)${NC}"
fi

# ========================================
# 5. Backup Memgraph (volume backup)
# ========================================
echo -e "\n${GREEN}[5/6] Backing up Memgraph...${NC}"
if check_service "lightrag_memgraph"; then
    docker run --rm \
        --volumes-from lightrag_memgraph \
        -v "${PWD}/${BACKUP_DIR}/memgraph:/backup" \
        alpine tar czf /backup/memgraph_data.tar.gz /var/lib/memgraph
    echo -e "${GREEN}✓ Memgraph backup completed${NC}"
else
    echo -e "${YELLOW}⊘ Memgraph backup skipped (container not running)${NC}"
fi

# ========================================
# 6. Backup Application Data
# ========================================
echo -e "\n${GREEN}[6/6] Backing up application data...${NC}"
if [ -d "./data/rag_storage" ]; then
    tar czf "${BACKUP_DIR}/app_data/rag_storage.tar.gz" ./data/rag_storage
    echo -e "${GREEN}✓ RAG storage backed up${NC}"
fi

if [ -d "./data/inputs" ]; then
    tar czf "${BACKUP_DIR}/app_data/inputs.tar.gz" ./data/inputs
    echo -e "${GREEN}✓ Input files backed up${NC}"
fi

# Copy configuration files
cp .env "${BACKUP_DIR}/app_data/.env.backup" 2>/dev/null || true
cp config.ini "${BACKUP_DIR}/app_data/config.ini.backup" 2>/dev/null || true
echo -e "${GREEN}✓ Configuration files backed up${NC}"

# ========================================
# Create backup manifest
# ========================================
echo -e "\n${YELLOW}Creating backup manifest...${NC}"
cat > "${BACKUP_DIR}/BACKUP_INFO.txt" << EOF
LightRAG Full Backup
====================
Created: $(date)
Hostname: $(hostname)
Backup Name: ${BACKUP_NAME}

Contents:
---------
$(ls -lh "${BACKUP_DIR}/"*/*.{gz,txt} 2>/dev/null | awk '{print $9, $5}')

Services Status at Backup Time:
--------------------------------
$(docker ps --filter "name=lightrag_" --format "table {{.Names}}\t{{.Status}}")

To restore this backup:
-----------------------
1. Extract to LightRAG directory
2. Run: ./scripts/restore_all_volumes.sh ${BACKUP_NAME}
3. Restart services: docker-compose down && docker-compose up -d

Notes:
------
- PostgreSQL: Logical backup using pg_dump
- Neo4j: Volume backup
- MongoDB: Logical backup using mongodump
- Redis: Volume backup with BGSAVE
- Memgraph: Volume backup
- Application data: File-level backup
EOF

# ========================================
# Create compressed archive
# ========================================
echo -e "\n${YELLOW}Creating compressed archive...${NC}"
(cd "${BACKUP_BASE_DIR}" && tar czf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}")
FINAL_SIZE=$(du -h "${BACKUP_BASE_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)

echo -e "\n${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Backup Complete!                      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo -e "\n${GREEN}Backup archive created:${NC}"
echo -e "  Location: ${BACKUP_BASE_DIR}/${BACKUP_NAME}.tar.gz"
echo -e "  Size: ${FINAL_SIZE}"
echo -e "\n${YELLOW}To restore:${NC}"
echo -e "  1. Extract: tar xzf ${BACKUP_NAME}.tar.gz"
echo -e "  2. Run: ./scripts/restore_all_volumes.sh ${BACKUP_NAME}"
echo -e "\n${YELLOW}Backup manifest: ${BACKUP_DIR}/BACKUP_INFO.txt${NC}"

# Clean up expanded directory (keep only tar.gz)
rm -rf "${BACKUP_DIR}"

# Keep only last 5 full backups
echo -e "\n${YELLOW}Cleaning old backups (keeping last 5)...${NC}"
(cd "${BACKUP_BASE_DIR}" && ls -t lightrag_full_backup_*.tar.gz 2>/dev/null | tail -n +6 | xargs -r rm)
echo -e "${GREEN}✓ Cleanup completed${NC}"
