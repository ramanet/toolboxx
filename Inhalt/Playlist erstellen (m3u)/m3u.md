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

### create_mombinde_m3u.sh
```bash
#!/usr/bin/env bash
#=============================================================================
#  create_m3u.sh – erzeugt eine .m3u-Playlist aus allen *.mp3-Dateien
#  in mehreren angegebenen Verzeichnissen (rekursiv).
#
#  Aufruf:
#  ./create_combined_m3u.sh  <Verzeichnis1> <Verzeichnis2> ... <VerzeichnisN> <Ausgabedatei>
#
#  Beispiel:
#      ./create_combined_m3u.sh ~/Music/Rock ~/Music/Jazz genres.m3u
#
#  Hinweis:
#      * Leerzeichen und Sonderzeichen in Dateinamen werden korrekt behandelt.
#      * Optional kann nach Dateinamen sortiert werden (Standard: alphabetisch).
#      * Das Skript bricht bei Fehlern ab (set -euo pipefail).
#=============================================================================

set -euo pipefail

usage() {
    cat <<EOF
Verwendung: $(basename "$0") <Verzeichnis1> <Verzeichnis2> ... <VerzeichnisN> <Ausgabedatei>

  <VerzeichnisX>   Pfad, der rekursiv nach *.mp3 durchsucht wird.
  <Ausgabedatei>   Name der zu erstellenden M3U-Datei.

Beispiel:
  $(basename "$0") ~/Music/Rock ~/Music/Jazz genres.m3u
EOF
    exit 1
}

#--------------------------  Argumente prüfen --------------------------------
if [[ $# -lt 2 ]]; then
    usage
fi

# Letztes Argument = Playlist-Datei
OUT_FILE="${!#}"
# Alle vorherigen Argumente = Quellverzeichnisse
SRC_DIRS=("${@:1:$#-1}")

#--------------------------  Playlist erzeugen -------------------------------
TMP=$(mktemp) || { echo "Konnte keine temporäre Datei anlegen." >&2; exit 3; }
printf "#EXTM3U\n" >"$TMP"

for SRC_DIR in "${SRC_DIRS[@]}"; do
    if [[ ! -d "$SRC_DIR" ]]; then
        echo "Warnung: '$SRC_DIR' ist kein Verzeichnis, wird übersprungen." >&2
        continue
    fi

    while IFS= read -r -d '' file; do
        if command -v ffprobe >/dev/null 2>&1; then
            dur=$(ffprobe -v error -show_entries format=duration \
                         -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null \
                         | cut -d. -f1 || echo "0")
            title=$(basename "${file%.*}")
            printf "#EXTINF:%s,%s\n" "$dur" "$title" >>"$TMP"
        fi

        rel_path="${file#$SRC_DIR/}"
        printf "%s\n" "$rel_path" >>"$TMP"
    done < <(find "$SRC_DIR" -type f -iname "*.mp3" -print0 | sort -z)
done

#--------------------------  Ergebnis sichern --------------------------------
mv "$TMP" "$OUT_FILE"
echo "Playlist erstellt: $OUT_FILE"
echo "Enthält $(grep -c '^#EXTINF' "$OUT_FILE" || true) Titel."
exit 0
```
### do_create_combined.sh
```bash
#!/bin/bash
#
# cd /home/user/music/Rock
#
create_combined_m3u.sh 'Genesis' 'Phil Collins' ../Playlists/Genellins.m3u
```
