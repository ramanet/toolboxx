## docker swarm home-assistant

- Auf swarm manager zuerst das network dann den service erstellen, mit volume für config, auf NFS Share.
- Das NFS Share muß auf allen nodes des warm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker service create --name hass  \
  --hostname hass \
  --env PUID=1000 \
  --env PGID=1000 \
  --env TZ=Europe/Berlin \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/hass/config,dst=/config \
  --mount type=bind,src=/run/dbus,dst=/run/dbus \
  --publish 8123:8123 \
  ghcr.io/home-assistant/home-assistant:stable
```