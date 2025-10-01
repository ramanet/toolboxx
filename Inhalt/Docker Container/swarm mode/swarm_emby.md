### docker swarm emby

- Auf swarm manager zuerst das network dann den service erstellen, für Musik, Video und volume für config, alles auf NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
(if not exist):
docker network create --driver overlay --attachable swarm
```
```bash
docker service create --name emby \
  --hostname emby \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 8096:8096 \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/emby/config,dst=/config \
  --mount type=bind,src=/mnt/<nfsshare>/music,dst=/music \
  --mount type=bind,src=/mnt/<nfsshare>/video,dst=/video \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  lscr.io/linuxserver/emby:latest
  ```