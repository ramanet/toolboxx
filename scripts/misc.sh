#!/bin/bash
#
# Dieses Skript zeigt eine Menüoberfläche zum Ausführen und Bearbeiten von
# Bash-Skripten im angegebenen Verzeichnis.
#
# misc.sh
#
# ===== KONFIGURATION =====
BASE_DIR="/mnt/4000GB/data/sda/server/menus/bashscripts/misc"
EDITOR="nano"
# =========================

show_menu() {
    clear
    echo "---------------------—————-----------------------------"
    echo -e "\n=== Verfügbare bash Skripte (${#sh_files[@]}) ==="
    echo "------------------------------------————---------------"
    for i in "${!sh_files[@]}"; do
        printf "[%2d] %s\n" $((i+1)) "${sh_files[$i]}"
    done
    echo "---------------------------------————------------------"
}

# Verzeichnisprüfung
[ ! -d "$BASE_DIR" ] && { echo "Fehler: Verzeichnis '$BASE_DIR' existiert nicht!"; exit 1; }

# Dateien finden
sh_files=()
while IFS= read -r -d '' file; do
    sh_files+=("$file")
done < <(find "$BASE_DIR" -type f -name "*.sh" -printf "%P\0" | sort -z)

[ ${#sh_files[@]} -eq 0 ] && { echo "Keine .sh-Dateien gefunden!"; exit 1; }

# Hauptloop
while true; do
    show_menu
    read -p "Auswahl (1-${#sh_files[@]}, l=list, q=quit): " choice
    
    case "$choice" in
        [1-9]|[1-9][0-9])
            [ "$choice" -le "${#sh_files[@]}" ] || { 
                echo "Ungültige Nummer!"; sleep 1; continue; }
            
            relative_path="${sh_files[$((choice-1))]}"
            full_path="$BASE_DIR/$relative_path"
            script_dir=$(dirname "$full_path")
            
            while true; do
                echo -e "\nSkript: \033[1;33m$relative_path\033[0m"
                echo "Ort: $script_dir"
                read -p "Ausführen (a), Bearbeiten (e), Zurück (z): " action
                
                case "$action" in
                    [eE]*) 
                        $EDITOR "$full_path"
                        echo "Bearbeitung abgeschlossen. Liste neu laden? (j/n)"
                        read -n1 reload
                        [[ "$reload" == [jJ] ]] && break
                        ;;
                    [aA]*)
                        chmod +x "$full_path"
                        (cd "$script_dir" && bash "./$(basename "$full_path")")
echo
                        read -p "Enter drücken um fortzufahren..."
                        break
                        ;;
                    [zZ]*) break ;;
                    *) echo "Ungültige Eingabe!" ;;
                esac
            done
            ;;
        [lL]) continue ;;
        [qQ]) echo "Beendet."; exit 0 ;;
        *) echo "Ungültige Eingabe!"; sleep 1 ;;
    esac
done
