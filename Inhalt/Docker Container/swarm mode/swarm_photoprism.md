### docker swarm navidrome

- Auf swarm manager zuerst das network dann den service erstellen, für Musik und volume für data, beides beides NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
(if not exist):
docker network create --driver overlay --attachable swarm
```
```yaml
version: "3.0"
services:
  photoprism:
    image: photoprism/photoprism:latest
    hostname: photoprism
    environment:
      - PHOTOPRISM_ADMIN_USER=admin
      - PHOTOPRISM_ADMIN_PASSWORD=insecure   
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin   
    ports:
      - 2342:2342
    volumes:
      - /mnt/<nfsshare>/swarm/photoprism/storage:/photoprism/storage:rw
      - /mnt/<nfsshare>/data/sda/clients/Bilder:/photoprism/originals:rw
    networks:
      - swarm
    deploy:
      replicas: 1
      restart_policy:
        condition: any

networks:
  swarm:
    external: true

networks:
  swarm:
    external: true
```