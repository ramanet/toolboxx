## docker swarm home-assistant

- Auf einem swarm manager zuerst das network dann den service erstellen mit volume für data auf NFS Share.
- Das NFS Share muß auf allen nodes des warm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker service create --name kuma \
  --hostname kuma \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/kuma/data,dst=/app/data \
  --publish 3001:3001 \
louislam/uptime-kuma:1
```