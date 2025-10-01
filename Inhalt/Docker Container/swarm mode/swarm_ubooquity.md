
### docker swarm ubooquity

- Auf swarm manager zuerst das network dann den service erstellen, für Musik und volume für data, beides beides NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
(if not exist):
docker network create --driver overlay --attachable swarm
```
```yaml
version: "3.6"
services:
  ubooquity:
    image: lscr.io/linuxserver/ubooquity:latest
    hostname: ubooquity
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - /mnt/<nfsshare>/swarm/ubooquity/config:/config
      - /mnt/<nfsshare>/data/sda/clients/ebooks/calibreExp-epub:/ubooks
      - /mnt/<nfsshare>/data/sda/clients/Texte:/material
    ports:
      - 2202:2202
      - 2203:2203
    networks:
      - swarm
    deploy:
      replicas: 1
      restart_policy:
        condition: any

networks:
  swarm:
    external: true
```