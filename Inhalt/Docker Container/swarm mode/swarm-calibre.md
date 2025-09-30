## portainer create stack (as service) import
- stack (service) mit portainer erstellen
  ```yaml
version: "3.6"
services:
  calibre-web:
    image: linuxserver/calibre-web:latest
    hostname: calibre-web 
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - /<nfsshare>/swarm/calibre/config:/config
      - /<nfsshare>/data/sda/server/Calibre-Bibliothek:/books
    ports:
      - 8083:8083 
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