docker service update --image portainer/portainer-ce:latest --publish-add 9443:9443 --force portainer_portainer
docker service update --image portainer/agent:latest --force portainer_agent 

