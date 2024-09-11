#!/bin/bash

# Create a backup of the Minecraft server
BACKUP_NAME="minecraft-backup-$(date +%Y-%m-%d).zip"
zip -r /minecraft/backups/${BACKUP_NAME} /minecraft/server

# Use rclone to upload the backup to the specific Google Drive folder
rclone copy /minecraft/backups/${BACKUP_NAME} mygdrive:1P09f94y5HeLVI2o3_XtZzt9NEbwvpq5B
