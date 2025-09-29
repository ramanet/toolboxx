## docker swarm owntone

- Auf swarm manager zuerst das network dann den service erstellen, für Musik und volume für config, beides auf NFS Share.
- Das NFS Share muß auf allen nodes des warm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker service create --name daapd \
  --hostname daapd \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --publish 3689:3689 \
  --mount type=bind,src=/mnt/4000GB/swarm/daapd/config,dst=/config \
  --mount type=bind,src=/mnt/4000GB/data/sda/clients/music,dst=/music \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  lscr.io/linuxserver/daapd:28.10.20250118
  ```