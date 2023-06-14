#! /bin/bash
backupdir=/home/user/docker/netbox-docker/backup
docker exec -i netbox-docker_postgres_1 /bin/bash -c "PGPASSWORD=J5brHrAXFLQSif0K pg_dump --username netbox netbox" | gzip > $backupdir/netbox_$(date +%Y-%m-%d).psql.gz

find $backupdir ! -name '*01.psql.gz' ! -name 'backup.sh' -mmin +$((7*60*24)) -exec rm -f {} \;

rclone copy $backupdir nextcloud-linux-backup:/Backup/netbox
