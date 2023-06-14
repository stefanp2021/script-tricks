docker stop snipeit
docker pull snipe/snipe-it
docker rm snipeit
docker run -d -p 8082:80 --name="snipeit" --link snipe-mysql:mysql --env-file=/home/user/docker/snipeit-prod/.env --mount source=snipe-vol,dst=/var/lib/snipeit snipe/snipe-it:latest