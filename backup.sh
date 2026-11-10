#!/bin/bash

# Arreter le script en cas d'erreur
set -Eeuo pipefail

# 1. Verifier que l'utilisateur fournit un argument
if [ "$#" -ne 1 ]; then
    echo "Usage : $0 <dossier_a_sauvegarder>" >&2
    exit 1
fi

# 2. Recuperer le chemin du dossier a sauvegarder
DOSSIER="$1"

# 3. Verifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas." >&2
    exit 1
fi

# 4. Definir le repertoire de destination
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINATION="$SCRIPT_DIR/backups"

# 5. Creer le repertoire de destination s'il n'existe pas
mkdir -p "$DESTINATION"

# 6. Generer une date et une heure pour le nom de l'archive
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# 7. Definir le nom de l'archive
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

# 8. Creer l'archive compressee
echo "Debut de la sauvegarde de : $DOSSIER"

tar -czf "$ARCHIVE" -C "$(dirname "$DOSSIER")" "$(basename "$DOSSIER")"

echo "Sauvegarde creee : $ARCHIVE"

# 9. Supprimer les anciennes sauvegardes de plus de 7 jours
echo "Verification des anciennes sauvegardes..."

for fichier in "$DESTINATION"/backup_*.tar.gz
do
    # Ignorer le cas ou aucune archive n'existe
    [ -f "$fichier" ] || continue

    # Verifier si le fichier date de plus de 7 jours
    if [ -n "$(find "$fichier" -maxdepth 0 -type f -mtime +7 -print)" ]; then
        echo "Suppression de l'ancienne sauvegarde : $fichier"
        rm "$fichier"
    fi
done

# 10. Afficher la fin de l'operation
echo "Nettoyage des anciennes sauvegardes termine."
echo "Sauvegarde terminee avec succes."

exit 0
