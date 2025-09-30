## copilot sagt: /mnt/4000GB/data/sda/server/menus/gully/misc/compose/swarm: docker stack deploy -c swarm_photoprism.md photoprism

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
      - /mnt/4000GB/data/sda/clients/Bilder:/photoprism/originals
      - /mnt/4000GB/swarm/photoprism/config:/photoprism/config
      - /mnt/4000GB/swarm/photoprism/cache:/photoprism/cache
      - /mnt/4000GB/swarm/photoprism/import:/photoprism/import
      - /mnt/4000GB/swarm/photoprism/export:/photoprism/export
    networks:
      - swarm
    deploy:
      replicas: 1
      restart_policy:
        condition: any

networks:
  swarm:
    external: true