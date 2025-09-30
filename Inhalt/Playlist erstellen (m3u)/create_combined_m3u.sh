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