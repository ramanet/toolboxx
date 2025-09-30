## docker swarm Visual Studio Code

- Auf swarm manager zuerst das network dann den service erstellen, Daten und volume für config, beides NFS Shares.
- Das NFS Share muß auf allen nodes des swarm, manager sowie worker, in gleicher Weise unter dem selben Pfad angebunden sein. 
```bash
docker service create --name vscode \
  --hostname vscode \
  --env PUID=1000 \
  --env PGID=1000 \
  --env LANG=de_DE.UTF-8 \
  --env LANGUAGE=de_DE:de \
  --env LC_ALL=de_DE.UTF-8 \
  --env TZ=Europe/Berlin \
  --network swarm \
  --replicas 1 \
  --restart-condition any \
  --mount type=bind,src=/mnt/<nfsshare>/swarm/vscode/config,dst=/config \
  --mount type=bind,src=/mnt/<nfsshare>/<repository>,dst=/repo \
  --publish 8443:8443 \
  lscr.io/linuxserver/code-server:latest
```