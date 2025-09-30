## docker swarm audiobookshelf

- Auf swarm manager zuerst das network dann den service erstellen, für Books und volume für config, beides auf NFS Share.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker network create --driver overlay --attachable swarm
```
```bash
docker service create --name bookshelf \
  --hostname booksshelf \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 13378:80 \
  --mount type=bind,src=/<nfsshare>/swarm/bookshelf/config,dst=/config \
  --mount type=bind,src=/<nfsshare>/books,dst=/books \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  ghcr.io/advplyr/audiobookshelf:latest
  ```