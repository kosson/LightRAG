# 🔧 LightRAG Backup & Restore - Quick Reference

## 🚀 Quick Commands

### Create Full Backup (All Databases + Data)
```bash
./quick_backup.sh
# OR
./scripts/backup_all_volumes.sh
```

### PostgreSQL Only Backup
```bash
./scripts/backup_postgres.sh
```

### Restore Full Backup
```bash
./scripts/restore_all_volumes.sh lightrag_full_backup_YYYYMMDD_HHMMSS
```

### Restore PostgreSQL Only
```bash
./scripts/restore_postgres.sh ./backups/postgres/lightrag_postgres_YYYYMMDD_HHMMSS.sql.gz
```

## 📁 What Gets Backed Up?

| Component | Method | Size Impact |
|-----------|--------|-------------|
| **PostgreSQL** | `pg_dump` (SQL) | Medium (compresses well) |
| **Neo4j** | Volume backup | Large |
| **MongoDB** | `mongodump` | Medium |
| **Redis** | Volume backup | Small |
| **Memgraph** | Volume backup | Medium |
| **RAG Storage** | File copy | Large |
| **Input Files** | File copy | Large |
| **Config** | File copy | Tiny |

## 🎯 Common Scenarios

### Before Updating/Upgrading
```bash
./quick_backup.sh
# ... perform updates ...
# If something breaks:
./scripts/restore_all_volumes.sh <latest_backup>
```

### Moving to New Server
```bash
# Old server:
./scripts/backup_all_volumes.sh
scp backups/lightrag_full_backup_*.tar.gz user@newserver:/tmp/

# New server:
cd LightRAG
mv /tmp/lightrag_full_backup_*.tar.gz backups/
./scripts/restore_all_volumes.sh lightrag_full_backup_YYYYMMDD_HHMMSS
docker-compose up -d
```

### Daily Automated Backup (Cron)
```bash
crontab -e
# Add:
0 2 * * * cd /path/to/LightRAG && ./scripts/backup_all_volumes.sh
```

### Test Recovery (Recommended Monthly)
```bash
# 1. Create test backup
./scripts/backup_all_volumes.sh

# 2. Note the backup name
ls -lh backups/

# 3. Verify it restores (in test environment)
./scripts/restore_all_volumes.sh lightrag_full_backup_20231224_120000
```

## 📊 Backup Locations

```
backups/
├── lightrag_full_backup_YYYYMMDD_HHMMSS.tar.gz  # Full system backups
└── postgres/
    └── lightrag_postgres_YYYYMMDD_HHMMSS.sql.gz  # PostgreSQL only
```

## ⏱️ Retention Policy

- **Full backups:** Last 5 kept automatically
- **PostgreSQL backups:** Last 7 kept automatically
- **Older backups:** Move to archive/cloud storage

## 🔒 Security Checklist

- [ ] Backup directory permissions: `chmod 700 backups`
- [ ] Encrypt before cloud upload: `gpg -c backup.tar.gz`
- [ ] Don't commit backups to Git (already in `.gitignore`)
- [ ] Secure transfer methods only (scp, sftp, encrypted S3)

## ⚡ Performance Tips

- Full backup takes: 2-10 minutes (depends on data size)
- PostgreSQL only: 30 seconds - 2 minutes
- Backups run online (no downtime needed)
- Schedule during low-traffic hours for best performance

## 🆘 Troubleshooting

### "Container not running"
```bash
docker-compose up -d
docker ps  # verify all containers running
```

### "No space left on device"
```bash
df -h  # check disk space
# Clean old backups manually if needed
rm backups/lightrag_full_backup_20230101_*.tar.gz
```

### Backup seems stuck
```bash
# Check Docker logs
docker-compose logs -f postgres
docker-compose logs -f mongodb
```

### Can't restore
```bash
# Verify backup integrity
tar tzf backups/lightrag_full_backup_*.tar.gz
gunzip -t backups/postgres/lightrag_postgres_*.sql.gz
```

## 📚 Full Documentation

See [docs/BackupGuide.md](docs/BackupGuide.md) for complete documentation.

## 🎓 Best Practices

1. **Test your backups regularly** - A backup you haven't tested is not a backup
2. **Multiple locations** - Keep copies on different physical locations
3. **3-2-1 Rule**: 3 copies, 2 different media, 1 offsite
4. **Before major changes** - Always backup before updates or config changes
5. **Monitor backup size** - Track growth trends to plan storage

## 🔧 Advanced: Cloud Sync

### AWS S3
```bash
# Install AWS CLI: apt install awscli
aws s3 sync ./backups/ s3://your-bucket/lightrag-backups/ --exclude "*" --include "*.tar.gz"
```

### Google Cloud
```bash
# Install gsutil: apt install google-cloud-sdk
gsutil -m rsync -r ./backups/ gs://your-bucket/lightrag-backups/
```

### Rsync to NAS
```bash
rsync -avz --delete ./backups/ nas.local:/volume1/backups/lightrag/
```

---

**Need help?** Check the full guide: [docs/BackupGuide.md](docs/BackupGuide.md)
