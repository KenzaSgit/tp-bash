#!/bin/bash

# Arrêter le script en cas d'erreur
set -Eeuo pipefail

# 1. Définir le fichier journal
LOG_FILE="$HOME/ci.log"

# 2. Fonction de journalisation
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# 3. Fonction pour exécuter les tests
run_tests() {
    log "Debut des tests..."

    # Test 1 : vérifier README.md
    if [ -f "$REPO_DIR/README.md" ]; then
        log "Test 1 REUSSI : README.md present."
    else
        log "Test 1 ECHOUE : README.md absent."
        return 1
    fi

    # Test 2 : vérifier backup.sh
    if [ -f "$REPO_DIR/backup.sh" ]; then
        log "Test 2 REUSSI : backup.sh present."
    else
        log "Test 2 ECHOUE : backup.sh absent."
        return 1
    fi

    # Test 3 : vérifier check_disk.sh
    if [ -f "$REPO_DIR/check_disk.sh" ]; then
        log "Test 3 REUSSI : check_disk.sh present."
    else
        log "Test 3 ECHOUE : check_disk.sh absent."
        return 1
    fi

    # Test 4 : vérifier la syntaxe des scripts
    for fichier in backup.sh check_disk.sh; do
        if bash -n "$REPO_DIR/$fichier"; then
            log "Test syntaxe REUSSI : $fichier"
        else
            log "Test syntaxe ECHOUE : $fichier"
            return 1
        fi
    done

    log "Tous les tests sont termines avec succes."
    return 0
}

# 4. Vérifier les arguments
if [ "$#" -lt 1 ] || [ -z "$1" ]; then
    echo "Usage : $0 <URL_DU_DEPOT_GIT> [DOSSIER_LOCAL]" >&2
    exit 1
fi

# 5. Récupérer les arguments
REPO_URL="$1"
REPO_DIR="${2:-$HOME/Desktop/ing5/DevOps/tp-bash/ci-tp-bash}"

# 6. Créer le fichier journal
touch "$LOG_FILE"

log "========================================"
log "Demarrage du pipeline CI."
log "Depot Git : $REPO_URL"
log "Dossier local : $REPO_DIR"

# 7. Cloner ou mettre à jour le dépôt
if [ -d "$REPO_DIR/.git" ]; then

    log "Depot deja present : mise a jour."

    if ! git -C "$REPO_DIR" pull; then
        log "ERREUR : impossible de mettre a jour le depot."
        exit 1
    fi

else

    if [ -e "$REPO_DIR" ]; then
        log "ERREUR : le dossier existe mais ne contient pas un depot Git."
        exit 1
    fi

    log "Clonage du depot Git..."

    if ! git clone "$REPO_URL" "$REPO_DIR"; then
        log "ERREUR : le clonage du depot a echoue."
        exit 1
    fi

fi

# 8. Exécuter les tests
if run_tests; then
    log "========================================"
    log "PIPELINE TERMINE AVEC SUCCES."
    exit 0
else
    log "========================================"
    log "PIPELINE TERMINE AVEC ECHEC."
    exit 1
fi
