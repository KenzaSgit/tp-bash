#!/bin/bash

# Arreter le script en cas d'erreur
set -Eeuo pipefail

# Recuperer le repertoire du projet
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "       DEBUT DES TESTS"
echo "======================================"

# Test 1 : verifier README.md
if [ -f "$SCRIPT_DIR/README.md" ]; then
    echo "[OK] README.md existe."
else
    echo "[ERREUR] README.md est absent."
    exit 1
fi

# Test 2 : verifier backup.sh
if [ -f "$SCRIPT_DIR/backup.sh" ]; then
    echo "[OK] backup.sh existe."
else
    echo "[ERREUR] backup.sh est absent."
    exit 1
fi

# Test 3 : verifier check_disk.sh
if [ -f "$SCRIPT_DIR/check_disk.sh" ]; then
    echo "[OK] check_disk.sh existe."
else
    echo "[ERREUR] check_disk.sh est absent."
    exit 1
fi

# Test 4 : verifier la syntaxe Bash
for fichier in backup.sh check_disk.sh; do

    if bash -n "$SCRIPT_DIR/$fichier"; then
        echo "[OK] Syntaxe correcte : $fichier"
    else
        echo "[ERREUR] Syntaxe incorrecte : $fichier"
        exit 1
    fi

done

# Test 5 : verifier les permissions
for fichier in backup.sh check_disk.sh; do

    if [ -x "$SCRIPT_DIR/$fichier" ]; then
        echo "[OK] $fichier est executable."
    else
        echo "[ERREUR] $fichier n'est pas executable."
        exit 1
    fi

done

echo "======================================"
echo " TOUS LES TESTS SONT REUSSIS !"
echo "======================================"

exit 0
