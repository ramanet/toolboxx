
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
      - /mnt/4000GB/swarm/ubooquity/config:/config
      - /mnt/4000GB/data/sda/clients/ebooks/calibreExp-epub:/ubooks
      - /mnt/4000GB/data/sda/clients/Texte:/material
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