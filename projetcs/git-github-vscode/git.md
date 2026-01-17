# Git : Guide Complet

## Table des matières
1. [Introduction à Git](#introduction-à-git)
2. [Concepts de Base](#concepts-de-base)
3. [Commandes de Base](#commandes-de-base)
4. [Utilité et Avantages](#utilité-et-avantages)

## Introduction à Git

Git est un système de contrôle de version distribué créé par Linus Torvalds en 2005. Il permet de suivre les modifications apportées aux fichiers de votre projet au fil du temps, de collaborer efficacement avec d'autres développeurs, et de gérer plusieurs versions de votre code simultanément.

### Pourquoi Git ?

- **Historique complet** : Chaque modification est enregistrée avec son auteur et sa date
- **Travail collaboratif** : Plusieurs développeurs peuvent travailler sur le même projet
- **Branches** : Possibilité de créer des versions parallèles du projet
- **Sécurité** : Sauvegarde et récupération facile des versions précédentes

## Concepts de Base

### Repository (Dépôt)
Un repository (ou dépôt) est un espace de stockage où Git conserve tous les fichiers de votre projet ainsi que l'historique complet de toutes les modifications.

- **Repository local** : Stocké sur votre machine
- **Repository distant** : Hébergé sur un serveur (GitHub, GitLab, etc.)

### Commit
Un commit est un instantané de votre projet à un moment précis. C'est comme une photo de l'état de tous vos fichiers à un instant T.

### Branch (Branche)
Une branche est une ligne de développement indépendante. La branche principale s'appelle généralement `main` ou `master`.

### Working Directory, Staging Area et Repository

1. **Working Directory** : Votre espace de travail où vous modifiez les fichiers
2. **Staging Area** (Index) : Zone intermédiaire où vous préparez les fichiers avant le commit
3. **Repository** : Base de données Git contenant l'historique des commits

### Merge (Fusion)
Le merge permet de fusionner les modifications de deux branches différentes.

### Clone
Créer une copie locale d'un repository distant.

### Pull et Push
- **Pull** : Récupérer les modifications du repository distant vers le local
- **Push** : Envoyer vos commits locaux vers le repository distant

## Commandes de Base

### Configuration initiale

```bash
# Configurer votre nom
git config --global user.name "Votre Nom"

# Configurer votre email
git config --global user.email "votre.email@example.com"

# Vérifier la configuration
git config --list
```

### Créer un nouveau repository

```bash
# Initialiser un nouveau repository
git init

# Initialiser avec une branche main
git init -b main
```

### Cloner un repository existant

```bash
# Cloner un repository distant
git clone https://github.com/username/repository.git

# Cloner dans un dossier spécifique
git clone https://github.com/username/repository.git nom-dossier
```

### Gérer les fichiers

```bash
# Vérifier le statut des fichiers
git status

# Ajouter un fichier à la staging area
git add fichier.txt

# Ajouter tous les fichiers modifiés
git add .

# Ajouter tous les fichiers d'un type spécifique
git add *.py
```

### Créer des commits

```bash
# Créer un commit avec un message
git commit -m "Message décrivant la modification"

# Ajouter et commiter en une seule commande
git commit -am "Message du commit"

# Modifier le dernier commit
git commit --amend
```

### Consulter l'historique

```bash
# Afficher l'historique des commits
git log

# Afficher l'historique de manière condensée
git log --oneline

# Afficher l'historique avec un graphique
git log --graph --oneline --all

# Afficher les modifications d'un commit
git show <commit-hash>
```

### Gérer les branches

```bash
# Lister les branches
git branch

# Créer une nouvelle branche
git branch nom-branche

# Changer de branche
git checkout nom-branche

# Créer et basculer sur une nouvelle branche
git checkout -b nom-branche

# Avec Git 2.23+
git switch nom-branche
git switch -c nom-branche

# Supprimer une branche
git branch -d nom-branche

# Supprimer une branche (force)
git branch -D nom-branche
```

### Fusionner des branches

```bash
# Fusionner une branche dans la branche actuelle
git merge nom-branche

# Fusionner avec message de commit personnalisé
git merge nom-branche -m "Message de fusion"
```

### Travailler avec un repository distant

```bash
# Ajouter un repository distant
git remote add origin https://github.com/username/repository.git

# Lister les repositories distants
git remote -v

# Récupérer les modifications du distant
git fetch origin

# Récupérer et fusionner les modifications
git pull origin main

# Envoyer vos commits vers le distant
git push origin main

# Envoyer et définir la branche upstream
git push -u origin main
```

### Annuler des modifications

```bash
# Annuler les modifications d'un fichier (non stagé)
git checkout -- fichier.txt
# ou avec Git 2.23+
git restore fichier.txt

# Retirer un fichier de la staging area
git reset HEAD fichier.txt
# ou avec Git 2.23+
git restore --staged fichier.txt

# Annuler le dernier commit (en gardant les modifications)
git reset --soft HEAD~1

# Annuler le dernier commit (en supprimant les modifications)
git reset --hard HEAD~1

# Revenir à un commit spécifique
git reset --hard <commit-hash>
```

### Autres commandes utiles

```bash
# Afficher les différences
git diff

# Afficher les différences des fichiers stagés
git diff --staged

# Sauvegarder temporairement des modifications
git stash

# Récupérer les modifications sauvegardées
git stash pop

# Lister les stashes
git stash list

# Supprimer un fichier et le stager
git rm fichier.txt

# Renommer un fichier
git mv ancien-nom.txt nouveau-nom.txt

# Ignorer des fichiers
# Créer un fichier .gitignore et y ajouter les patterns
echo "*.log" >> .gitignore
```

## Utilité et Avantages

### 1. Gestion de l'historique
- **Traçabilité** : Savoir qui a fait quoi et quand
- **Restauration** : Revenir à n'importe quelle version antérieure
- **Audit** : Analyser l'évolution du projet

### 2. Collaboration efficace
- **Travail simultané** : Plusieurs développeurs sur le même projet
- **Isolation des fonctionnalités** : Chaque développeur travaille sur sa branche
- **Revue de code** : Facilite la relecture et l'approbation des modifications

### 3. Expérimentation sans risque
- **Branches de test** : Tester de nouvelles idées sans affecter le code principal
- **Retour en arrière** : Annuler facilement les changements qui ne fonctionnent pas

### 4. Sauvegarde distribuée
- **Pas de point de défaillance unique** : Chaque développeur a une copie complète
- **Travail hors ligne** : Possibilité de commiter sans connexion internet

### 5. Workflow professionnel
- **CI/CD** : Intégration avec des outils d'intégration continue
- **Déploiement** : Automatisation des déploiements basés sur les branches
- **Versioning** : Gestion des versions et releases du logiciel

### 6. Standards de l'industrie
- **Employabilité** : Compétence essentielle pour tout développeur
- **Open Source** : Quasi-totalité des projets open source utilisent Git
- **Documentation** : Grande communauté et ressources abondantes

## Bonnes Pratiques

1. **Commits atomiques** : Un commit = une modification logique
2. **Messages clairs** : Décrire précisément ce que le commit fait
3. **Commits fréquents** : Ne pas attendre d'avoir trop de modifications
4. **Branches pour les fonctionnalités** : Isoler chaque nouvelle fonctionnalité
5. **Pull réguliers** : Rester synchronisé avec l'équipe
6. **Fichier .gitignore** : Ne pas versionner les fichiers générés ou sensibles
7. **Pas de secrets** : Ne jamais commiter de mots de passe ou clés API

## Workflow Git typique

```bash
# 1. Cloner le projet
git clone https://github.com/username/projet.git
cd projet

# 2. Créer une branche pour votre fonctionnalité
git checkout -b feature/ma-nouvelle-fonctionnalite

# 3. Faire vos modifications et les commiter
git add .
git commit -m "Ajout de la nouvelle fonctionnalité"

# 4. Récupérer les dernières modifications
git checkout main
git pull origin main

# 5. Fusionner les modifications dans votre branche
git checkout feature/ma-nouvelle-fonctionnalite
git merge main

# 6. Résoudre les conflits si nécessaire

# 7. Pousser votre branche
git push -u origin feature/ma-nouvelle-fonctionnalite

# 8. Créer une Pull Request sur GitHub
```

## Ressources complémentaires

- [Documentation officielle Git](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book/fr/v2)
- [GitHub Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Learn Git Branching](https://learngitbranching.js.org/?locale=fr_FR) - Tutoriel interactif
