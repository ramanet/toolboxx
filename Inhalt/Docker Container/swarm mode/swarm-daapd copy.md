## yaml vorlage für daapd
```yaml
daapd:
    image: lscr.io/linuxserver/daapd:28.10.20250118
    container_name: daapd
    hostname: owntone
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin   
    ports:
      - 3689:3689
    volumes:
      - /mnt/docker/owntone/config:/config
      - /mnt/4000GB/data/sda/clients/music:/music
    restart: unless-stopped
    ```

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