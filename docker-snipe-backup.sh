#!/usr/bin/env bash
docker exec snipeit php artisan snipeit:backup
docker cp snipeit:/var/www/html/storage/app/backups/ /home/user/docker/snipe-backup
rclone copy /home/user/docker/snipe-backup/backups nextcloud-linux-backup:Backup/Linux/snipeit
-backups/ --max-age 168h >/dev/null 2>&1
