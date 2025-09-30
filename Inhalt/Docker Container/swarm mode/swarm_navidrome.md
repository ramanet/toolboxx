## docker swarm navidrome

- Auf swarm manager zuerst das network dann den service erstellen, für Musik und volume für data, beides beides NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker network create --driver overlay --attachable swarm
```
```bash
docker service create --name navidrome \
  --hostname navidrome \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 4533:4533 \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/navidrome/data,dst=/data \
  --mount type=bind,src=/mnt/<nfsshare>/music,dst=/music \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  deluan/navidrome:latest
  ```