### Docker Swarm Spickzettel

- Swarm initialisieren (auf dem ersten manager)
```bash
docker swarm init
```
- find token to add a worker
```bash
docker swarm join-token worker
```
- Swarm einem Cluster beitreten (Worker)
```bash
docker swarm join --token <worker-token> <manager-ip>:2377
```
- find token to add a manager
```bash
docker swarm join-token manager
```

- Swarm einem Cluster beitreten (Manager)
```bash
docker swarm join --token <manager-token> <manager-ip>:2377
```

- Swarm-Status anzeigen
```bash
docker info
```

- Swarm Nodes anzeigen
```bash
docker node ls
```
- To avoid interference with manager node operation, you can drain manager nodes to make them unavailable as worker nodes:
```bash
 docker node update --availability drain NODE
```

- docker swarm - restart all services
```bash
docker service ls -q | xargs -t -n1 docker service update --force
```

- Swarm Services anzeigen
```bash
docker service ls
```

- Swarm Service erstellen
```bash
docker service create --name <service-name> <image>
```

- Swarm Service entfernen
```bash
docker service rm <service-name>
```

- Swarm Service aktualisieren
```bash
docker service update <optionen> <service-name>
```
- einen service auf einen anderen node verlegen
```bash

docker service update --force <service>
```

- Swarm Stack deployen
```bash
docker stack deploy -c <compose-file.yml> <stack-name>
```

- Swarm Stack entfernen
```bash
docker stack rm <stack-name>
```
### Service-Beispiele (Swarm Mode)

- Visual Studio Code
[swarm_vscode.md](swarm_vscode.md)

- Navidrome
[swarm_navidrome.md](swarm_navidrome.md)

- Home Assistant
[swarm_hass.md](swarm_hass.md)

- Audiobookshelf
[swarm_bookshelf.md](swarm_bookshelf.md)

- Owntone (daapd)
[swarm_daapd.md](swarm_daapd.md)

- Emby
[swarm_emby.md](swarm_emby.md)

- Uptime Kuma
[swarm_kuma.md](swarm_kuma.md)

- Photoprism
[swarm_photoprism.md](swarm_photoprism.md)

- Calibre
[swarm_calibre.md](swarm_calibre.md)

- Ubooquity
[swarm_ubooquity.md](swarm_ubooquity.md)