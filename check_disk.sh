#!/bin/bash

# Seuil par defaut : 80 %
SEUIL=${1:-80}

# Recuperer le pourcentage d'utilisation de la partition /
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# Afficher les informations
echo "Utilisation du disque : ${UTILISATION}%"
echo "Seuil defini : ${SEUIL}%"

# Comparer l'utilisation au seuil
if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : l'espace disque utilise a atteint ou depasse le seuil !"
    exit 1
else
    echo "OK : l'utilisation du disque est normale."
    exit 0
fi
