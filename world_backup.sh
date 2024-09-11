#!/bin/bash

# Path to your Minecraft world folder
WORLD_DIR="/app/world"
BACKUP_FILE="/app/world_backup.zip"

# RCON details
RCON_HOST="localhost"
RCON_PORT=25575
RCON_PASSWORD="your_password_here"

# Zip the Minecraft world
zip -r $BACKUP_FILE $WORLD_DIR

# Upload the backup to a hosting service (e.g., file.io)
UPLOAD_URL=$(curl -F "file=@${BACKUP_FILE}" https://file.io | jq -r '.link')

# Send the download link to the Minecraft chat using RCON
echo "Sending download link to Minecraft server: $UPLOAD_URL"
echo "say World backup is available: $UPLOAD_URL" | nc $RCON_HOST $RCON_PORT