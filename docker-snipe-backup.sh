#!/usr/bin/env bash

# Define backup source and destination
BACKUP_SRC="/var/www/html/storage/app/backups/"
BACKUP_LOCAL="/home/user/docker/snipe-backup/backups"
RCLONE_DEST="nextcloud-linux-backup:Backup/Linux/snipeit-backups/"

# Create a new backup using Snipe-IT's artisan command
docker exec snipeit php artisan snipeit:backup || {
    echo "Error during backup creation. Exiting."
    exit 1
}

# Copy the backups from the Snipe-IT container to the host
docker cp snipeit:"$BACKUP_SRC" "$BACKUP_LOCAL" || {
    echo "Error during copying backup to local host. Exiting."
    exit 1
}

# Use rclone to copy backups to the remote destination, keeping only the last 168 hours (7 days)
rclone copy "$BACKUP_LOCAL" "$RCLONE_DEST" --max-age 168h || {
    echo "Error during copying backup to remote host. Exiting."
    exit 1
}

# Optionally, you can add a line to remove backups older than 7 days on the local system
find "$BACKUP_LOCAL" -type f -mtime +7 -delete

echo "Backup completed successfully."