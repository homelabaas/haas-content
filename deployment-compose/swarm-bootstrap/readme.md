# Great initial software for any Docker Swarm

This docker-compose is designed for Docker Swarm and provides a great starting point for a new swarm. It will set up a nice Web UI, a load balancer, and DNS integration.

## Notes to Running and Configuring

Note: This assumes your docker swarm master node's IP is 192.168.0.10. Substitute it with the correct IP of your master node for your docker swarm.

## Setup remote docker

Mac:

```bash
export DOCKER_HOST=tcp://192.168.0.10:2376
docker node ls
```

Windows:

```powershell
$env:DOCKER_HOST="tcp://192.168.0.10:2376"
docker node ls
```

## Installation

Run `docker stack deploy --compose-file .\docker-compose.yaml traefik`

Browse to http://192.168.0.10:8080 for the traefik dashboard and http://192.168.0.10:9000 for the portainer website.

## Containers

### Traefik

The will start Traefik in swarm mode, which automatically checks the labels of running services to populate the load balancer rules. Traefik will also present a Web UI on port 8080.

### traefik-powerdns-bridge

This is a container which will check Traefik for "Frontends" and populate PowerDNS with DNS entries. This container is called traefik-powerdns-bridge. Check the docker-compose file to make sure that the environment variables for the dns bridge will work with your installation of PowerDNS and Traefik.

### Portainer

Portainer is a great little web application that gives you a management user iterface across your swarm. It will also install agents on each node in the swarm to gather information.

## Deploy a new service with load balancing

To deploy the sample nginx service run `docker stack deploy --compose-file .\sample-app.yaml sample_web`
