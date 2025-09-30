## docker swarm jellyfin

- Auf swarm manager zuerst das network dann den service erstellen, für Musik, Books und volume für config, alles auf NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker network create --driver overlay --attachable swarm
```
```bash
docker service create --name jellyfin \
  --hostname jellyfin \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 8097:8096 \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/jellyfin/config,dst=/config \
  --mount type=bind,src=/mnt/<nfsshare>/music,dst=/music \
  --mount type=bind,src=/mnt/<nfsshare>/books,dst=/books \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  lscr.io/linuxserver/jellyfin:latest
  ```