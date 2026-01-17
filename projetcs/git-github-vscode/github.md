# GitHub : Guide Complet

## Table des matières
1. [Introduction à GitHub](#introduction-à-github)
2. [Fonctionnalités Principales](#fonctionnalités-principales)
3. [Collaboration sur GitHub](#collaboration-sur-github)
4. [Fonctionnalités Avancées](#fonctionnalités-avancées)
5. [Bonnes Pratiques](#bonnes-pratiques)

## Introduction à GitHub

GitHub est une plateforme d'hébergement de code source basée sur Git. Créée en 2008 et rachetée par Microsoft en 2018, c'est aujourd'hui la plus grande plateforme de développement collaboratif au monde avec plus de 100 millions de développeurs.

### Qu'est-ce que GitHub ?

GitHub est bien plus qu'un simple hébergeur de repositories Git. C'est une plateforme complète qui offre :
- **Hébergement de code** : Stockage illimité de repositories publics et privés
- **Collaboration** : Outils pour travailler en équipe
- **Gestion de projet** : Issues, Projects, Milestones
- **CI/CD** : GitHub Actions pour l'automatisation
- **Social coding** : Réseau social pour développeurs
- **Documentation** : GitHub Pages, Wiki
- **Sécurité** : Scanning de vulnérabilités, Dependabot

### GitHub vs Git

- **Git** : Système de contrôle de version (outil local)
- **GitHub** : Plateforme web hébergeant des repositories Git (service en ligne)

Analogie : Git est comme Word, GitHub est comme OneDrive/Google Drive pour Word.

## Fonctionnalités Principales

### 1. Repositories

Un repository sur GitHub contient :
- Le code source
- L'historique Git complet
- Les branches
- Les issues et pull requests
- La documentation (README, Wiki)
- Les releases

#### Créer un repository

**Via l'interface web :**
1. Cliquer sur le bouton "New" ou "+"
2. Remplir le nom du repository
3. Choisir public ou privé
4. Optionnel : Ajouter un README, .gitignore, licence

**Via ligne de commande :**
```bash
# Créer un nouveau repository localement
mkdir mon-projet
cd mon-projet
git init
echo "# Mon Projet" >> README.md
git add README.md
git commit -m "Premier commit"

# Ajouter le repository distant GitHub
git remote add origin https://github.com/username/mon-projet.git
git branch -M main
git push -u origin main
```

### 2. README.md

Le fichier README est la vitrine de votre projet. Il doit contenir :
- Titre et description du projet
- Installation et prérequis
- Utilisation et exemples
- Contribution guidelines
- Licence
- Contact

Exemple de structure :
```markdown
# Nom du Projet

Description courte du projet

## Installation

\`\`\`bash
pip install mon-package
\`\`\`

## Utilisation

\`\`\`python
import mon_package
mon_package.faire_quelque_chose()
\`\`\`

## Contribution

Les contributions sont les bienvenues !

## Licence

MIT License
```

### 3. Issues (Problèmes)

Les issues permettent de :
- Signaler des bugs
- Proposer de nouvelles fonctionnalités
- Poser des questions
- Organiser le travail

**Créer une issue :**
1. Onglet "Issues"
2. Cliquer sur "New issue"
3. Donner un titre clair
4. Décrire le problème avec détails
5. Ajouter des labels (bug, enhancement, etc.)
6. Assigner à un développeur

**Bonnes pratiques pour les issues :**
- Titre descriptif et concis
- Description détaillée avec étapes de reproduction (pour les bugs)
- Screenshots ou logs si pertinent
- Labels appropriés
- Templates d'issues pour standardiser

### 4. Pull Requests (PR)

Une Pull Request propose d'intégrer vos modifications dans une branche du projet.

**Créer une Pull Request :**

```bash
# 1. Créer une branche
git checkout -b feature/nouvelle-fonctionnalite

# 2. Faire vos modifications et commiter
git add .
git commit -m "Ajout de la nouvelle fonctionnalité"

# 3. Pousser la branche
git push -u origin feature/nouvelle-fonctionnalite

# 4. Sur GitHub, cliquer sur "Compare & pull request"
```

**Éléments d'une bonne PR :**
- Titre clair et descriptif
- Description détaillée des changements
- Référence aux issues liées (ex: "Fixes #42")
- Tests ajoutés ou mis à jour
- Documentation mise à jour si nécessaire

**Review Process :**
1. Un ou plusieurs reviewers examinent le code
2. Ils ajoutent des commentaires et suggestions
3. Vous répondez et faites les modifications demandées
4. Une fois approuvée, la PR est mergée

### 5. Branches

**Stratégies de branches courantes :**

**Git Flow :**
- `main` : Code en production
- `develop` : Branche de développement
- `feature/*` : Nouvelles fonctionnalités
- `hotfix/*` : Corrections urgentes
- `release/*` : Préparation des releases

**GitHub Flow (plus simple) :**
- `main` : Code déployable à tout moment
- `feature/*` : Branches de fonctionnalités
- Pull Requests pour merger dans main

### 6. Actions (CI/CD)

GitHub Actions permet d'automatiser des workflows :
- Tests automatiques
- Déploiement continu
- Génération de documentation
- Notifications

**Exemple de workflow simple (.github/workflows/test.yml) :**
```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
    - name: Run tests
      run: |
        pytest
```

### 7. GitHub Pages

Hébergement gratuit de sites web statiques directement depuis un repository.

**Utilisation :**
1. Créer une branche `gh-pages` ou utiliser `/docs` dans `main`
2. Aller dans Settings > Pages
3. Sélectionner la source
4. Votre site sera disponible à `https://username.github.io/repository`

**Cas d'usage :**
- Documentation de projet
- Portfolio personnel
- Blog technique
- Landing pages

### 8. Wiki

Espace de documentation collaboratif intégré au repository.

**Quand utiliser le Wiki :**
- Documentation technique détaillée
- Guides d'architecture
- Tutoriels pas à pas
- FAQ

## Collaboration sur GitHub

### 1. Fork

Un fork est une copie d'un repository sur votre compte GitHub.

**Workflow de contribution :**
```bash
# 1. Forker le projet sur GitHub (bouton Fork)

# 2. Cloner votre fork
git clone https://github.com/votre-username/projet.git

# 3. Ajouter le repository original comme upstream
git remote add upstream https://github.com/username-original/projet.git

# 4. Créer une branche
git checkout -b ma-contribution

# 5. Faire vos modifications et commiter
git add .
git commit -m "Ma contribution"

# 6. Pousser vers votre fork
git push origin ma-contribution

# 7. Créer une Pull Request depuis votre fork vers le repo original
```

**Garder votre fork à jour :**
```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### 2. Code Review

**Rôles :**
- **Auteur** : Crée la PR et répond aux commentaires
- **Reviewer** : Examine le code et donne des feedbacks

**Types de commentaires :**
- **Comment** : Question ou remarque générale
- **Approve** : Le code est prêt à être mergé
- **Request changes** : Des modifications sont nécessaires

**Bonnes pratiques de review :**
- Être constructif et respectueux
- Pointer les problèmes mais aussi les bonnes pratiques
- Suggérer des solutions, pas seulement critiquer
- Expliquer le "pourquoi" de vos commentaires

### 3. Project Management

**GitHub Projects :**
- Tableaux Kanban (To Do, In Progress, Done)
- Automatisation avec les issues et PR
- Vue d'ensemble du projet

**Milestones :**
- Regrouper des issues par objectif
- Suivre la progression vers une release
- Date limite et pourcentage de complétion

**Labels :**
- Catégoriser les issues (bug, enhancement, documentation)
- Priorités (high, medium, low)
- Status (help wanted, good first issue)

### 4. Notifications

**Gérer les notifications :**
- Watch : Recevoir toutes les notifications d'un repo
- Unwatch : Ne plus recevoir de notifications
- Custom : Choisir les types de notifications

**Mentions :**
- `@username` : Mentionner un utilisateur
- `@team` : Mentionner une équipe
- `#123` : Référencer une issue ou PR

## Fonctionnalités Avancées

### 1. GitHub CLI (`gh`)

Outil en ligne de commande pour interagir avec GitHub.

```bash
# Installation
# macOS
brew install gh

# Linux
sudo apt install gh

# Authentification
gh auth login

# Exemples d'utilisation
gh repo create mon-projet --public
gh pr create --title "Nouvelle fonctionnalité" --body "Description"
gh pr list
gh pr checkout 42
gh issue create --title "Bug trouvé" --body "Description du bug"
gh repo clone username/repository
```

### 2. Gists

Snippets de code à partager rapidement.

**Types :**
- **Public** : Visible par tous, indexé par les moteurs de recherche
- **Secret** : Accessible uniquement via l'URL

**Utilisation :**
- Partager du code rapidement
- Exemples de code
- Configuration files
- Notes techniques

### 3. GitHub Sponsors

Programme permettant de financer des développeurs open source.

### 4. Security Features

**Dependabot :**
- Alerte sur les dépendances vulnérables
- Créé automatiquement des PR pour les mises à jour

**Code Scanning :**
- Analyse automatique du code pour détecter les vulnérabilités
- Intégration avec CodeQL

**Secret Scanning :**
- Détecte les secrets (API keys, tokens) commitées par erreur
- Alerte en cas de détection

### 5. GitHub Packages

Registry pour héberger vos packages :
- npm
- Maven
- NuGet
- Docker
- RubyGems

### 6. Discussions

Forum de discussion intégré au repository pour :
- Questions et réponses
- Annonces
- Idées et brainstorming
- Support communautaire

## Bonnes Pratiques

### 1. Structure du Repository

```
mon-projet/
├── .github/
│   ├── workflows/        # GitHub Actions
│   ├── ISSUE_TEMPLATE/   # Templates d'issues
│   └── PULL_REQUEST_TEMPLATE.md
├── src/                  # Code source
├── tests/                # Tests
├── docs/                 # Documentation
├── .gitignore
├── README.md
├── LICENSE
├── CONTRIBUTING.md       # Guide de contribution
└── CODE_OF_CONDUCT.md    # Code de conduite
```

### 2. README de qualité

- Badge de statut des tests
- Badge de couverture de code
- Badge de version
- Instructions claires
- Screenshots si applicable

Exemple de badges :
```markdown
![Tests](https://github.com/username/repo/workflows/Tests/badge.svg)
![Coverage](https://codecov.io/gh/username/repo/branch/main/graph/badge.svg)
![Version](https://img.shields.io/github/v/release/username/repo)
```

### 3. Commits sémantiques

Convention pour les messages de commit :
```
type(scope): description

feat: Nouvelle fonctionnalité
fix: Correction de bug
docs: Documentation
style: Formatage
refactor: Refactoring
test: Tests
chore: Maintenance
```

### 4. Protéger la branche main

**Dans Settings > Branches :**
- Require pull request reviews
- Require status checks to pass
- Require branches to be up to date
- Include administrators

### 5. Templates

**Issue Template (.github/ISSUE_TEMPLATE/bug_report.md) :**
```markdown
---
name: Bug Report
about: Signaler un bug
---

## Description du bug
[Description claire du problème]

## Étapes de reproduction
1. 
2. 
3. 

## Comportement attendu
[Ce qui devrait se passer]

## Comportement actuel
[Ce qui se passe réellement]

## Environnement
- OS: 
- Version: 
```

### 6. Licence

Choisir une licence appropriée :
- **MIT** : Très permissive
- **Apache 2.0** : Permissive avec protection de brevet
- **GPL** : Copyleft, code dérivé doit être open source
- **Proprietary** : Tous droits réservés

### 7. .gitignore

Fichiers à ignorer couramment :
```gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Builds
dist/
build/
*.egg-info/
```

## Ressources et Apprentissage

### Documentation officielle
- [GitHub Docs](https://docs.github.com)
- [GitHub Skills](https://skills.github.com/) - Cours interactifs
- [GitHub Blog](https://github.blog/)

### Communauté
- [GitHub Community Forum](https://github.community/)
- [GitHub Education](https://education.github.com/)
- [Open Source Guides](https://opensource.guide/)

### Outils complémentaires
- **GitKraken** : Client Git graphique
- **Sourcetree** : Autre client Git graphique
- **GitHub Desktop** : Client officiel simplifié
- **VS Code** : Excellente intégration GitHub

## Conclusion

GitHub est devenu un outil indispensable pour tout développeur moderne. Maîtriser GitHub, c'est :
- Faciliter la collaboration
- Améliorer la qualité du code
- Gagner en visibilité professionnelle
- Contribuer à l'open source
- Automatiser les workflows

L'investissement dans l'apprentissage de GitHub est rapidement rentabilisé par la productivité et les opportunités qu'il offre.
