#!/usr/bin/env bash

# This script creates a backup of a wiki database and uploads it to a cloud storage service.

# Set variables
config="/home/user/.config/rclone/rclone.conf"
backup_dir="/home/user/docker/wikijsbackup"
backup_file="${backup_dir}/backup_$(date +%d-%m-%Y"_"%H_%M_%S).sql"
storage_dest="nextcloud-linux-backup:Backup/Linux/wikijs"
max_age="168h"

# Create backup file
docker exec wiki_db_1 pg_dumpall -U wikijs > "$backup_file"

# Upload backup file to cloud storage
rclone --config "$config" moveto "$backup_dir/" "$storage_dest" --max-age "$max_age"

# Check for errors
if [ $? -eq 0 ]; then
  echo "Backup created and uploaded successfully."
else
  echo "Error creating or uploading backup."
fi
