# TP N° 2 – Linux & Scripting Bash

## Présentation

Ce projet a été réalisé dans le cadre du module DevOps.

L'objectif est de pratiquer l'administration Linux, le scripting Bash, l'automatisation des tâches et l'intégration continue.

## Structure du projet

- `check_disk.sh` : vérification de l'espace disque.
- `backup.sh` : sauvegarde compressée d'un dossier.
- `test.sh` : exécution des tests automatisés.
- `ci.sh` : simulation d'un pipeline d'intégration continue.
- `backup.log` : journal des sauvegardes.

## Fonctionnalités

1. Navigation et manipulation des fichiers Linux.
2. Gestion des permissions.
3. Surveillance de l'espace disque.
4. Sauvegarde automatique avec horodatage.
5. Suppression des sauvegardes de plus de 7 jours.
6. Planification des sauvegardes avec cron.
7. Intégration continue avec Git et des tests automatisés.

## Exécution

Pour vérifier l'espace disque :

```bash
./check_disk.sh
