
## portainer create stack (as service) import
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
      - /<nfsshare>/swarm/ubooquity/config:/config
      - /<nfsshare>/data/sda/clients/ebooks/calibreExp-epub:/ubooks
      - /<nfsshare>/data/sda/clients/Texte:/material
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