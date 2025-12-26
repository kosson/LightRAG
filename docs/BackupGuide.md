# LightRAG Backup & Restore Guide

Complete backup solution for preserving PostgreSQL and all other database volumes in your LightRAG installation.

## Quick Start

### Create a Full Backup
```bash
./scripts/backup_all_volumes.sh
```

This creates a portable backup in `./backups/lightrag_full_backup_YYYYMMDD_HHMMSS.tar.gz`

### Restore from Backup
```bash
./scripts/restore_all_volumes.sh lightrag_full_backup_YYYYMMDD_HHMMSS
```

## Backup Scripts Overview

### 1. Full System Backup (Recommended)
**Script:** `scripts/backup_all_volumes.sh`

Creates a complete, portable backup of:
- ✅ PostgreSQL (logical backup using `pg_dump`)
- ✅ Neo4j (volume backup)
- ✅ MongoDB (logical backup using `mongodump`)
- ✅ Redis (volume backup with BGSAVE)
- ✅ Memgraph (volume backup)
- ✅ Application data (`rag_storage`, `inputs`)
- ✅ Configuration files (`.env`, `config.ini`)

**Usage:**
```bash
./scripts/backup_all_volumes.sh
```

**Output:** 
- Single compressed archive: `./backups/lightrag_full_backup_YYYYMMDD_HHMMSS.tar.gz`
- Includes manifest with backup info
- Automatically keeps last 5 backups

### 2. PostgreSQL Only Backup
**Script:** `scripts/backup_postgres.sh`

Quick PostgreSQL-only backup using `pg_dump` (no Docker plugins needed).

**Usage:**
```bash
./scripts/backup_postgres.sh
```

**Output:** 
- Compressed SQL dump: `./backups/postgres/lightrag_postgres_YYYYMMDD_HHMMSS.sql.gz`
- Keeps last 7 backups

## Restore Scripts

### 1. Full System Restore
**Script:** `scripts/restore_all_volumes.sh`

Restores complete system from full backup.

**Usage:**
```bash
# List available backups
ls -lh ./backups/lightrag_full_backup_*.tar.gz

# Restore specific backup
./scripts/restore_all_volumes.sh lightrag_full_backup_20231224_120000
```

**What it does:**
1. Stops all services
2. Restores all database volumes
3. Restores application data
4. Backs up current `.env` to `.env.before_restore`

### 2. PostgreSQL Only Restore
**Script:** `scripts/restore_postgres.sh`

Restores only PostgreSQL from a backup.

**Usage:**
```bash
# List available backups
ls -lh ./backups/postgres/

# Restore specific backup
./scripts/restore_postgres.sh ./backups/postgres/lightrag_postgres_20231224_120000.sql.gz
```

## Automated Backups with Cron

Add to your crontab (`crontab -e`):

```bash
# Full backup every day at 2 AM
0 2 * * * cd /path/to/LightRAG && ./scripts/backup_all_volumes.sh >> /var/log/lightrag_backup.log 2>&1

# PostgreSQL backup every 6 hours
0 */6 * * * cd /path/to/LightRAG && ./scripts/backup_postgres.sh >> /var/log/lightrag_pg_backup.log 2>&1
```

## Backup Storage Recommendations

### Local Backups
Backups are stored in `./backups/` by default. Consider:
- Moving old backups to external storage
- Syncing to network attached storage (NAS)
- Using rsync for incremental copies

### Cloud Backup Examples

**AWS S3:**
```bash
# After creating backup
aws s3 cp ./backups/lightrag_full_backup_*.tar.gz s3://your-bucket/lightrag-backups/
```

**Google Cloud Storage:**
```bash
gsutil cp ./backups/lightrag_full_backup_*.tar.gz gs://your-bucket/lightrag-backups/
```

**Rsync to remote server:**
```bash
rsync -avz ./backups/ user@backup-server:/backups/lightrag/
```

## Portability Features

The full backup system is designed for maximum portability:

✅ **Self-contained:** Single `.tar.gz` file with all data  
✅ **Cross-machine:** Can be restored on any machine with Docker  
✅ **Version independent:** Uses standard backup tools (`pg_dump`, `mongodump`)  
✅ **Documented:** Includes `BACKUP_INFO.txt` with metadata  
✅ **No plugins needed:** Uses native Docker commands and standard tools

## Backup Strategy Recommendations

### For Production Systems
1. **Daily full backups** at low-traffic hours
2. **Keep 7 daily backups** (1 week retention)
3. **Weekly archival** to cloud storage
4. **Test restores monthly** to verify integrity

### For Development Systems
1. **Weekly full backups**
2. **PostgreSQL backups before major operations**
3. **Keep 3-5 recent backups**

## Troubleshooting

### "Container not running" errors
Ensure services are running:
```bash
docker-compose up -d
docker ps
```

### Large backup files
PostgreSQL backups compress well. If size is still an issue:
- Clean old data from databases
- Archive old documents separately
- Use incremental backup strategies

### Restore fails
1. Check backup integrity:
```bash
tar tzf backup_file.tar.gz
```

2. Ensure sufficient disk space:
```bash
df -h
```

3. Check Docker volumes:
```bash
docker volume ls
```

### No "dump plugin" error
The scripts use `pg_dump` **inside the container**, avoiding Docker plugin issues. The PostgreSQL container includes all necessary tools by default.

## Backup File Structure

```
lightrag_full_backup_YYYYMMDD_HHMMSS/
├── BACKUP_INFO.txt                    # Backup metadata
├── postgres/
│   └── lightrag.sql.gz               # PostgreSQL dump
├── neo4j/
│   └── neo4j_data.tar.gz            # Neo4j volume
├── mongodb/
│   └── mongo_backup.tar.gz          # MongoDB dump
├── redis/
│   └── redis_data.tar.gz            # Redis volume
├── memgraph/
│   └── memgraph_data.tar.gz         # Memgraph volume
└── app_data/
    ├── rag_storage.tar.gz           # RAG storage
    ├── inputs.tar.gz                # Input files
    ├── .env.backup                  # Environment config
    └── config.ini.backup            # App config
```

## Security Considerations

⚠️ **Important:** Backup files contain sensitive data:
- Database credentials
- API keys from `.env`
- All indexed documents

**Recommendations:**
1. Encrypt backups before cloud upload
2. Restrict backup directory permissions: `chmod 700 ./backups`
3. Don't commit backups to version control
4. Use secure transfer methods (scp, sftp, encrypted S3)

**Encryption example:**
```bash
# Encrypt backup
gpg -c backups/lightrag_full_backup_20231224_120000.tar.gz

# Decrypt backup
gpg -d backups/lightrag_full_backup_20231224_120000.tar.gz.gpg > backup.tar.gz
```

## Migration Between Servers

To move your LightRAG installation to a new server:

1. **On old server:**
```bash
./scripts/backup_all_volumes.sh
scp backups/lightrag_full_backup_*.tar.gz user@newserver:/tmp/
```

2. **On new server:**
```bash
# Setup LightRAG
git clone <repo>
cd LightRAG

# Extract backup
mkdir -p backups
mv /tmp/lightrag_full_backup_*.tar.gz backups/

# Restore
./scripts/restore_all_volumes.sh lightrag_full_backup_YYYYMMDD_HHMMSS

# Start services
docker-compose up -d
```

## Performance Tips

- Backups run with services online (except for restore)
- PostgreSQL uses `pg_dump` which is safe for online backups
- MongoDB uses `mongodump` for consistent snapshots
- Volume backups use minimal container resources
- Consider scheduling during low-traffic periods

## Support

For issues or questions:
1. Check backup logs in script output
2. Verify Docker service status
3. Check disk space and permissions
4. Review `BACKUP_INFO.txt` in backup archive
