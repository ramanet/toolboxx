# swarm navidrome

## auf osdietpi (nur auf manager) :
```bash
docker network create --driver overlay --attachable swarm
```
- Auf dem Docker-Manager: Docker-Volume anlegen (NFS durch Docker gemanagt

- So erzeugst du ein Swarm-Volume, das Docker automatisch mountet, egal auf welchem Node der Task läuft. Ersetze <NFS_SERVER_IP> durch 192.168.17.2

- Auf dem nfs-server (192.168.17.2) anzulegen nfs share für „data“ oder „config"
/mnt/4000GB/swarm/navidrome/data
```bash
OBSOLETE bei type=bind
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.17.2,rw,nfsvers=4 \
  --opt device=:/mnt/4000GB/swarm/navidrome/data \
  navidrome_data
```
- Auf manager den service erstellen, hier mit bind für Musik und volume für data:
```bash
docker service create --name jellyfin \
  --hostname jellyfin \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 8097:8096 \
  --mount type=bind,src=/mnt/4000GB/swarm/jellyfin/config,dst=/config \
  --mount type=bind,src=/mnt/4000GB/data/sda/clients/music,dst=/music \
  --mount type=bind,src=/mnt/4000GB/data/sda/clients/Speech,dst=/Speech \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  lscr.io/linuxserver/jellyfin:latest
  ```
 ## portainer create stack (as service) import
  ```yaml
  version: "3.8"
services:
  jellyfin:
    image: lscr.io/linuxserver/jellyfin:latest
    hostname: jellyfin
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    ports:
      - "8097:8096"
    volumes:
      - /mnt/4000GB/swarm/jellyfin/config:/config
      - /mnt/4000GB/data/sda/clients/music:/music
      - /mnt/4000GB/data/sda/clients/Speech:/Speech
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