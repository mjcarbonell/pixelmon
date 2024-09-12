#!/bin/sh

# Backup directory
BACKUP_DIR="/app/backups"
WORLD_DIR="/app/world"
BACKUP_NAME="world_backup_$(date +%F_%H-%M-%S).tar.gz"
UPLOAD_DIR="path_to_cloud_storage" # Dropbox or Google Drive folder

# Create backup directory if not exists
mkdir -p ${BACKUP_DIR}

# Compress the world directory
tar -czvf ${BACKUP_DIR}/${BACKUP_NAME} -C ${WORLD_DIR} .

# Upload to cloud storage (replace with actual upload command)
cp ${BACKUP_DIR}/${BACKUP_NAME} ${UPLOAD_DIR}

# Generate download link (depends on your cloud service)
DOWNLOAD_LINK="https://cloud-service.com/${BACKUP_NAME}"

# Log the download link (or send via email, API, etc.)
echo "Download link: ${DOWNLOAD_LINK}"
