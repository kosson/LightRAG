#!/bin/bash
# Backup Verification and Information Script
# Lists all backups and shows detailed information

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  LightRAG Backup Information & Verification    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"

# Full Backups
echo -e "\n${GREEN}📦 Full System Backups${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if ls ./backups/lightrag_full_backup_*.tar.gz 1> /dev/null 2>&1; then
    ls -lh ./backups/lightrag_full_backup_*.tar.gz | awk '{print "  " $9 " (" $5 ") - " $6 " " $7 " " $8}'
    echo ""
    TOTAL_FULL=$(du -sh ./backups/lightrag_full_backup_*.tar.gz 2>/dev/null | awk '{sum+=$1} END {print sum}')
    echo -e "  ${YELLOW}Total size: $(du -sh ./backups/*.tar.gz 2>/dev/null | tail -1 | cut -f1)${NC}"
else
    echo "  No full backups found"
fi

# PostgreSQL Backups
echo -e "\n${GREEN}🐘 PostgreSQL Backups${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if ls ./backups/postgres/lightrag_postgres_*.sql.gz 1> /dev/null 2>&1; then
    ls -lh ./backups/postgres/lightrag_postgres_*.sql.gz | awk '{print "  " $9 " (" $5 ") - " $6 " " $7 " " $8}'
    echo ""
    echo -e "  ${YELLOW}Total size: $(du -sh ./backups/postgres/ 2>/dev/null | cut -f1)${NC}"
else
    echo "  No PostgreSQL backups found"
fi

# Disk usage
echo -e "\n${GREEN}💾 Backup Storage Usage${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ -d "./backups" ]; then
    du -sh ./backups 2>/dev/null | awk '{print "  Total backup directory: " $1}'
    df -h ./backups | tail -1 | awk '{print "  Available on disk: " $4 " (" $5 " used)"}'
else
    echo "  Backup directory does not exist"
fi

# Service status
echo -e "\n${GREEN}🐋 Docker Services Status${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
docker ps --filter "name=lightrag_" --format "  {{.Names}}: {{.Status}}" 2>/dev/null || echo "  Docker services not available"

# Latest backup info
echo -e "\n${GREEN}📋 Latest Full Backup Details${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
LATEST_BACKUP=$(ls -t ./backups/lightrag_full_backup_*.tar.gz 2>/dev/null | head -1)
if [ -n "$LATEST_BACKUP" ]; then
    echo "  File: $(basename $LATEST_BACKUP)"
    echo "  Size: $(du -h $LATEST_BACKUP | cut -f1)"
    echo "  Date: $(stat -c %y $LATEST_BACKUP | cut -d. -f1)"
    
    # Try to extract and show backup info
    TEMP_DIR=$(mktemp -d)
    tar xzf "$LATEST_BACKUP" -C "$TEMP_DIR" --wildcards "*/BACKUP_INFO.txt" 2>/dev/null
    INFO_FILE=$(find "$TEMP_DIR" -name "BACKUP_INFO.txt" 2>/dev/null)
    if [ -f "$INFO_FILE" ]; then
        echo ""
        echo -e "  ${YELLOW}Backup Contents:${NC}"
        grep -A 20 "Contents:" "$INFO_FILE" | head -15 | sed 's/^/  /'
    fi
    rm -rf "$TEMP_DIR"
else
    echo "  No full backups found"
fi

# Recommendations
echo -e "\n${GREEN}💡 Recommendations${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Count backups
FULL_COUNT=$(ls ./backups/lightrag_full_backup_*.tar.gz 2>/dev/null | wc -l)
PG_COUNT=$(ls ./backups/postgres/lightrag_postgres_*.sql.gz 2>/dev/null | wc -l)

if [ $FULL_COUNT -eq 0 ]; then
    echo -e "  ${YELLOW}⚠  No full backups found - run: ./quick_backup.sh${NC}"
elif [ $FULL_COUNT -lt 2 ]; then
    echo -e "  ${YELLOW}⚠  Only 1 backup found - consider keeping at least 2-3 recent backups${NC}"
else
    echo -e "  ${GREEN}✓  Good backup coverage ($FULL_COUNT full backups)${NC}"
fi

if [ $PG_COUNT -lt 3 ]; then
    echo -e "  ${YELLOW}⚠  Few PostgreSQL backups - consider more frequent PG backups${NC}"
fi

# Check last backup age
if [ -n "$LATEST_BACKUP" ]; then
    BACKUP_AGE=$(( ($(date +%s) - $(stat -c %Y "$LATEST_BACKUP")) / 86400 ))
    if [ $BACKUP_AGE -gt 7 ]; then
        echo -e "  ${YELLOW}⚠  Latest backup is $BACKUP_AGE days old - consider creating a fresh backup${NC}"
    elif [ $BACKUP_AGE -gt 1 ]; then
        echo -e "  ${GREEN}✓  Latest backup is $BACKUP_AGE days old${NC}"
    else
        echo -e "  ${GREEN}✓  Latest backup is less than 1 day old${NC}"
    fi
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Quick Commands                                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo "  Create backup:  ./quick_backup.sh"
echo "  Restore backup: ./scripts/restore_all_volumes.sh <backup_name>"
echo "  Full docs:      cat docs/BackupGuide.md"
echo ""
