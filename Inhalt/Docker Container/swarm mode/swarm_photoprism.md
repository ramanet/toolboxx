## copilot: docker stack deploy -c swarm_photoprism.md photoprism
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
      - /<nfsshare>/data/sda/clients/Bilder:/photoprism/originals
      - /<nfsshare>/swarm/photoprism/config:/photoprism/config
      - /<nfsshare>/swarm/photoprism/cache:/photoprism/cache
      - /<nfsshare>/swarm/photoprism/import:/photoprism/import
      - /<nfsshare>/swarm/photoprism/export:/photoprism/export
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