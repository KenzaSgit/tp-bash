#!/bin/bash

set -Eeuo pipefail

LOG_FILE="$HOME/ci.log"

# Fonction de journalisation
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Fonction de test
run_tests() {
    log "Debut des tests automatises..."

    if [ ! -f "$REPO_DIR/test.sh" ]; then
        log "ERREUR : test.sh absent."
        return 1
    fi

    if bash "$REPO_DIR/test.sh"; then
        log "Tous les tests sont reussis."
        return 0
    else
        log "ERREUR : les tests ont echoue."
        return 1
    fi
}

# Verification des arguments
if [ "$#" -lt 1 ] || [ -z "$1" ]; then
    echo "Usage : $0 <URL_DU_DEPOT_GIT> [DOSSIER_LOCAL]" >&2
    exit 1
fi

# Recuperation des arguments
REPO_URL="$1"
REPO_DIR="${2:-$HOME/Desktop/ing5/DevOps/tp-bash/ci-tp-bash}"

touch "$LOG_FILE"

log "======================================"
log "Demarrage du pipeline CI."
log "Depot : $REPO_URL"

# Clonage ou mise a jour
if [ -d "$REPO_DIR/.git" ]; then

    log "Mise a jour du depot..."

    if ! git -C "$REPO_DIR" pull; then
        log "ERREUR : git pull a echoue."
        exit 1
    fi

else

    if [ -e "$REPO_DIR" ]; then
        log "ERREUR : dossier deja existant."
        exit 1
    fi

    log "Clonage du depot..."

    if ! git clone "$REPO_URL" "$REPO_DIR"; then
        log "ERREUR : git clone a echoue."
        exit 1
    fi

fi

# Execution des tests
if run_tests; then
    log "PIPELINE TERMINE AVEC SUCCES."
    exit 0
else
    log "PIPELINE TERMINE AVEC ECHEC."
    exit 1
fi
