# Réponses aux questions de réflexion
## TP N° 2 – Linux & Scripting Bash

### Exercice 2.1 – Permissions Linux

La commande `chmod 644` attribue les permissions suivantes :
- Propriétaire : lecture et écriture.
- Groupe : lecture uniquement.
- Autres utilisateurs : lecture uniquement.

Le fichier ne possède pas de permission d'exécution. Pour rendre un script exécutable, on peut utiliser `chmod u+x script.sh`, ce qui autorise uniquement son propriétaire à l'exécuter.

### Exercice 2.2 – Vérification de l'espace disque

Les guillemets autour de `$UTILISATION` permettent de traiter sa valeur comme une seule chaîne de caractères. Ils évitent les problèmes liés à la séparation des mots et à l'expansion des caractères spéciaux. Ils rendent donc les comparaisons plus fiables.

### Exercice 2.3 – Sauvegarde automatique

L'instruction `set -Eeuo pipefail` permet de rendre le script Bash plus robuste :
- `-e` : arrête le script lorsqu'une commande échoue.
- `-E` : permet de transmettre le comportement du piège `ERR` aux fonctions et sous-shells.
- `-u` : signale l'utilisation d'une variable non définie.
- `-o pipefail` : considère un pipeline comme échoué si une de ses commandes échoue.

Sans ces options, certaines erreurs pourraient passer inaperçues et le script pourrait continuer alors que la sauvegarde a échoué.

### Exercice 2.4 – Planification avec Cron

Les chemins absolus sont importants dans les tâches cron parce que cron n'utilise pas nécessairement le même répertoire courant ni les mêmes variables d'environnement qu'un terminal interactif.

L'utilisation des chemins absolus garantit que cron trouve correctement le script, le dossier à sauvegarder et le fichier journal.

### Exercice 2.5 – Pipeline CI

Un véritable pipeline d'intégration continue peut contenir plusieurs étapes :
1. Récupération du code source depuis Git.
2. Installation des dépendances.
3. Vérification de la syntaxe et de la qualité du code.
4. Exécution des tests automatisés.
5. Construction de l'application.
6. Déploiement, si toutes les étapes précédentes réussissent.

Le pipeline peut échouer en cas de problème de connexion au dépôt, de dépendance manquante, d'erreur de syntaxe, de test non réussi ou d'échec de construction.

Le code de sortie `0` indique une exécution réussie, tandis qu'un code différent de `0` indique un échec.
