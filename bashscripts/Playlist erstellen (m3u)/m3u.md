## Erstellen einer M3U-Playlist

**create_combined_m3u.sh** (don't edit)
- Erstellt eine M3U-Playlist aus allen MP3-Dateien in beliebig vielen angegebenen Verzeichnissen (rekursiv).
- Die Playlist enthält Titelinfos und Dauer (falls ffprobe verfügbar).
- Dateinamen mit Sonderzeichen werden korrekt behandelt.
- Ausgabe erfolgt in der angegebenen m3u-Datei. In diesem Beispiel: "Genellins.m3u" im Ordner Playlists.

**do_create_combined_m3u.sh** (edit)
- Startet das obige Skript (create_combined_m3u.sh) mit variablen Verzeichnissen.
- hier: ('Genesis', 'Phil Collins') und erzeugt die Playlist 'Genellins.m3u' im Playlists-Ordner.
- Automatisiert die Playlist-Erstellung für diese Musikordner.

**cd /home/user/music/Rock**
```bash
sudo nano do_create_combined_m3u.sh # insert multiple artist-folders and name of playlist
```
```bash
./do_create_combined_m3u.sh
```

