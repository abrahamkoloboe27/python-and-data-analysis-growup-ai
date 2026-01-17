# Visual Studio Code (VSCode) : Guide Complet

## Table des matières
1. [Introduction à VSCode](#introduction-à-vscode)
2. [Installation et Configuration](#installation-et-configuration)
3. [Interface et Navigation](#interface-et-navigation)
4. [Fonctionnalités Essentielles](#fonctionnalités-essentielles)
5. [Extensions Indispensables](#extensions-indispensables)
6. [Raccourcis Clavier](#raccourcis-clavier)
7. [Travailler avec Différents Langages](#travailler-avec-différents-langages)
8. [Intégration Git](#intégration-git)
9. [Débogage](#débogage)
10. [Productivité Avancée](#productivité-avancée)

## Introduction à VSCode

Visual Studio Code (VSCode) est un éditeur de code source gratuit et open source développé par Microsoft. Lancé en 2015, il est devenu l'un des éditeurs les plus populaires au monde grâce à sa légèreté, sa flexibilité et son écosystème d'extensions.

### Pourquoi VSCode ?

**Avantages :**
- ✅ **Gratuit et Open Source**
- ✅ **Multi-plateforme** (Windows, macOS, Linux)
- ✅ **Léger et rapide**
- ✅ **Riche écosystème d'extensions**
- ✅ **IntelliSense** (autocomplétion intelligente)
- ✅ **Intégration Git native**
- ✅ **Terminal intégré**
- ✅ **Débogueur intégré**
- ✅ **Support de nombreux langages**
- ✅ **Personnalisable à l'infini**

**VSCode vs autres éditeurs :**
- **Sublime Text** : VSCode a plus de fonctionnalités natives
- **Atom** : VSCode est plus rapide
- **Vim/Emacs** : VSCode est plus accessible aux débutants
- **Visual Studio** : VSCode est plus léger (mais moins de fonctionnalités pour C#/.NET)
- **PyCharm/WebStorm** : VSCode est gratuit et plus léger (mais moins spécialisé)

## Installation et Configuration

### Installation

**Windows :**
```bash
# Via winget
winget install Microsoft.VisualStudioCode

# Ou télécharger depuis https://code.visualstudio.com/
```

**macOS :**
```bash
# Via Homebrew
brew install --cask visual-studio-code

# Ou télécharger depuis https://code.visualstudio.com/
```

**Linux (Debian/Ubuntu) :**
```bash
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code
```

### Configuration Initiale

**Ouvrir les paramètres :**
- Menu : `File` > `Preferences` > `Settings`
- Raccourci : `Ctrl+,` (Windows/Linux) ou `Cmd+,` (macOS)

**Paramètres essentiels à configurer :**

```json
{
    // Apparence
    "workbench.colorTheme": "Dark+ (default dark)",
    "editor.fontSize": 14,
    "editor.fontFamily": "Fira Code, Consolas, 'Courier New'",
    "editor.fontLigatures": true,
    
    // Comportement de l'éditeur
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.wordWrap": "on",
    "editor.minimap.enabled": true,
    "editor.formatOnSave": true,
    
    // Fichiers
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "files.trimTrailingWhitespace": true,
    
    // Terminal
    "terminal.integrated.fontSize": 13,
    "terminal.integrated.cursorBlinking": true,
    
    // Git
    "git.enableSmartCommit": true,
    "git.confirmSync": false,
    
    // Autres
    "explorer.confirmDelete": false,
    "explorer.confirmDragAndDrop": false
}
```

### Command Palette

La Command Palette est l'outil le plus puissant de VSCode.

**Ouvrir :** `Ctrl+Shift+P` (Windows/Linux) ou `Cmd+Shift+P` (macOS)

Permet d'accéder à toutes les commandes disponibles :
- `> Preferences: Open Settings (JSON)`
- `> Extensions: Install Extensions`
- `> Git: Clone`
- `> Format Document`
- etc.

## Interface et Navigation

### Layout de l'Interface

```
┌─────────────────────────────────────────────────────┐
│  Barre de Titre                                     │
├──┬──────────────────────────────────────────────────┤
│  │  Éditeur Principal                               │
│A │  ┌─────────────────┐ ┌─────────────────┐       │
│c │  │   Onglet 1      │ │   Onglet 2      │       │
│t │  └─────────────────┘ └─────────────────┘       │
│i │                                                  │
│v │  Code ici...                                     │
│i │                                                  │
│t │                                                  │
│y │                                                  │
├──┼──────────────────────────────────────────────────┤
│  │  Terminal / Panneau de Sortie                    │
└──┴──────────────────────────────────────────────────┘
```

**Activity Bar (Barre d'activité) - À gauche :**
- 📁 **Explorer** : Navigation dans les fichiers
- 🔍 **Search** : Recherche dans les fichiers
- 🌿 **Source Control** : Gestion Git
- 🐛 **Run and Debug** : Débogage
- 📦 **Extensions** : Marketplace d'extensions

### Navigation dans les Fichiers

**Explorer :**
- `Ctrl+B` : Afficher/masquer la barre latérale
- `Ctrl+Shift+E` : Focus sur l'explorateur

**Quick Open :**
- `Ctrl+P` : Ouvrir rapidement un fichier
- Taper le nom du fichier et `Enter`

**Navigation dans le code :**
- `Ctrl+G` : Aller à une ligne
- `Ctrl+Shift+O` : Aller à un symbole dans le fichier
- `Ctrl+T` : Aller à un symbole dans l'espace de travail
- `F12` : Aller à la définition
- `Alt+F12` : Aperçu de la définition
- `Shift+F12` : Trouver toutes les références

**Breadcrumbs :**
- Navigation hiérarchique en haut de l'éditeur
- `Ctrl+Shift+.` : Focus sur breadcrumbs

## Fonctionnalités Essentielles

### 1. IntelliSense

Autocomplétion intelligente basée sur :
- Types de variables
- Définitions de fonctions
- Modules importés

**Déclenchement :**
- Automatique pendant la frappe
- `Ctrl+Space` : Déclencher manuellement

### 2. Multi-Curseur

Éditer à plusieurs endroits simultanément.

**Utilisation :**
- `Alt+Click` : Ajouter un curseur
- `Ctrl+Alt+↑/↓` : Ajouter curseur au-dessus/en-dessous
- `Ctrl+D` : Sélectionner la prochaine occurrence
- `Ctrl+Shift+L` : Sélectionner toutes les occurrences
- `Alt+Shift+I` : Curseur à la fin de chaque ligne sélectionnée

### 3. Recherche et Remplacement

**Recherche simple :**
- `Ctrl+F` : Rechercher dans le fichier
- `Ctrl+H` : Rechercher et remplacer

**Recherche globale :**
- `Ctrl+Shift+F` : Rechercher dans tous les fichiers
- `Ctrl+Shift+H` : Rechercher et remplacer dans tous les fichiers

**Options :**
- `Alt+C` : Respecter la casse
- `Alt+W` : Mot entier
- `Alt+R` : Expression régulière

### 4. Snippets

Modèles de code réutilisables.

**Utilisation :**
- Taper l'abréviation
- `Tab` pour développer

**Créer un snippet personnalisé :**
```json
// File > Preferences > User Snippets
{
    "Print to console": {
        "prefix": "log",
        "body": [
            "console.log('$1');",
            "$2"
        ],
        "description": "Log output to console"
    }
}
```

### 5. Emmet

Outil pour écrire du HTML/CSS rapidement.

**Exemples :**
```html
<!-- Taper : div.container>ul>li*3>a -->
<!-- Résultat : -->
<div class="container">
    <ul>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
    </ul>
</div>
```

### 6. Terminal Intégré

- `Ctrl+`` : Ouvrir/fermer le terminal
- `Ctrl+Shift+`` : Nouveau terminal
- Support de multiples shells (bash, PowerShell, zsh, etc.)

**Configuration du shell par défaut :**
```json
{
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "terminal.integrated.defaultProfile.linux": "bash",
    "terminal.integrated.defaultProfile.osx": "zsh"
}
```

### 7. Split Editor

Éditer plusieurs fichiers côte à côte.

- `Ctrl+\` : Diviser l'éditeur
- `Ctrl+1/2/3` : Focus sur le groupe 1/2/3
- Drag & drop d'onglets

## Extensions Indispensables

### Installation d'Extensions

- `Ctrl+Shift+X` : Ouvrir le marketplace
- Rechercher et cliquer sur "Install"

### Extensions par Catégorie

**Général :**
- **Prettier** : Formatage de code
- **ESLint** : Linter JavaScript/TypeScript
- **GitLens** : Supercharge Git
- **Path Intellisense** : Autocomplétion des chemins de fichiers
- **Bracket Pair Colorizer 2** : Colorie les paires de parenthèses
- **Todo Tree** : Surligne les TODO/FIXME
- **Better Comments** : Commentaires colorés

**Python :**
- **Python** (Microsoft) : Support Python complet
- **Pylance** : Language server Python
- **Python Docstring Generator** : Génère les docstrings
- **autoDocstring** : Documentation automatique
- **Jupyter** : Notebooks Jupyter

**Web Development :**
- **Live Server** : Serveur de développement avec live reload
- **Auto Rename Tag** : Renomme automatiquement les balises HTML
- **HTML CSS Support** : Autocomplétion CSS dans HTML
- **JavaScript (ES6) code snippets** : Snippets JS modernes

**Markdown :**
- **Markdown All in One** : Support Markdown complet
- **Markdown Preview Enhanced** : Prévisualisation avancée

**Thèmes :**
- **One Dark Pro** : Thème populaire
- **Material Theme** : Design Material
- **Dracula Official** : Thème Dracula
- **Night Owl** : Thème pour la nuit

**Icônes :**
- **Material Icon Theme** : Icônes Material
- **VSCode Icons** : Pack d'icônes

**Productivité :**
- **Project Manager** : Gestion de projets multiples
- **Bookmarks** : Marque-pages dans le code
- **Code Spell Checker** : Vérificateur d'orthographe

## Raccourcis Clavier

### Essentiels (Windows/Linux | macOS)

**Général :**
- `Ctrl+P | Cmd+P` : Quick Open
- `Ctrl+Shift+P | Cmd+Shift+P` : Command Palette
- `Ctrl+S | Cmd+S` : Sauvegarder
- `Ctrl+W | Cmd+W` : Fermer l'onglet
- `Ctrl+K Ctrl+S | Cmd+K Cmd+S` : Raccourcis clavier

**Édition :**
- `Ctrl+X | Cmd+X` : Couper la ligne
- `Ctrl+C | Cmd+C` : Copier la ligne
- `Ctrl+V | Cmd+V` : Coller
- `Ctrl+Z | Cmd+Z` : Annuler
- `Ctrl+Shift+Z | Cmd+Shift+Z` : Refaire
- `Ctrl+/ | Cmd+/` : Commenter/décommenter
- `Alt+↑/↓ | Option+↑/↓` : Déplacer la ligne
- `Shift+Alt+↑/↓ | Shift+Option+↑/↓` : Dupliquer la ligne
- `Ctrl+Shift+K | Cmd+Shift+K` : Supprimer la ligne

**Navigation :**
- `Ctrl+Tab | Ctrl+Tab` : Changer d'onglet
- `Ctrl+PageUp/PageDown | Cmd+Option+←/→` : Onglet précédent/suivant
- `Ctrl+Home/End | Cmd+↑/↓` : Début/fin du fichier
- `Ctrl+G | Ctrl+G` : Aller à la ligne

**Recherche :**
- `Ctrl+F | Cmd+F` : Rechercher
- `Ctrl+H | Cmd+H` : Remplacer
- `Ctrl+Shift+F | Cmd+Shift+F` : Rechercher dans les fichiers
- `F3 / Shift+F3 | Cmd+G / Shift+Cmd+G` : Résultat suivant/précédent

**Affichage :**
- `Ctrl+B | Cmd+B` : Barre latérale
- `Ctrl+J | Cmd+J` : Panneau (terminal, problèmes, etc.)
- `Ctrl+` | Cmd+`` : Terminal
- `F11 | Cmd+Ctrl+F` : Plein écran
- `Ctrl+= / Ctrl+- | Cmd+= / Cmd+-` : Zoom in/out

**Multi-curseur :**
- `Alt+Click | Option+Click` : Ajouter curseur
- `Ctrl+Alt+↑/↓ | Cmd+Option+↑/↓` : Curseur au-dessus/en-dessous
- `Ctrl+D | Cmd+D` : Sélectionner la prochaine occurrence
- `Ctrl+Shift+L | Cmd+Shift+L` : Sélectionner toutes les occurrences

## Travailler avec Différents Langages

### Python

**Configuration :**
```json
{
    "python.defaultInterpreterPath": "/usr/bin/python3",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "black",
    "python.formatting.blackPath": "black",
    "[python]": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "ms-python.python"
    }
}
```

**Fonctionnalités :**
- Sélection d'environnement virtuel
- Exécution de code (`Ctrl+Alt+N` avec Code Runner)
- IntelliSense
- Linting (pylint, flake8)
- Formatting (black, autopep8)
- Tests (pytest, unittest)
- Notebooks Jupyter intégrés

### JavaScript/TypeScript

**Configuration :**
```json
{
    "javascript.updateImportsOnFileMove.enabled": "always",
    "typescript.updateImportsOnFileMove.enabled": "always",
    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    }
}
```

### HTML/CSS

**Fonctionnalités :**
- Emmet intégré
- Autocomplétion CSS
- Prévisualisation en direct avec Live Server
- Formatage avec Prettier

### Markdown

- Prévisualisation : `Ctrl+Shift+V`
- Prévisualisation côte à côte : `Ctrl+K V`
- Support des tableaux, listes, etc.

## Intégration Git

### Interface Git Native

**Panneau Source Control :**
- `Ctrl+Shift+G` : Ouvrir le panneau Git
- Vue des changements
- Stage/unstage de fichiers
- Commit avec message
- Push/pull
- Gestion des branches

**Opérations courantes :**

**Stage et Commit :**
1. Voir les fichiers modifiés (icône `M`)
2. Cliquer sur `+` pour stage
3. Écrire le message de commit
4. `Ctrl+Enter` pour commiter

**Branches :**
- Coin inférieur gauche : Nom de la branche actuelle
- Cliquer pour changer de branche
- Créer une nouvelle branche

**Diff :**
- Cliquer sur un fichier modifié pour voir les différences
- Navigation dans les changements

### GitLens Extension

Extension avancée pour Git :
- Git blame inline
- Historique des fichiers
- Comparaison de commits
- Exploration de repositories

## Débogage

### Configuration du Débogueur

**Créer une configuration (.vscode/launch.json) :**

**Python :**
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        }
    ]
}
```

**Node.js :**
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Launch Program",
            "program": "${workspaceFolder}/app.js"
        }
    ]
}
```

### Utilisation du Débogueur

**Points d'arrêt (Breakpoints) :**
- Cliquer dans la marge gauche (ou `F9`)
- Point rouge apparaît

**Contrôles de débogage :**
- `F5` : Démarrer le débogage
- `F10` : Step over (ligne suivante)
- `F11` : Step into (entrer dans la fonction)
- `Shift+F11` : Step out (sortir de la fonction)
- `F5` : Continue
- `Shift+F5` : Stop

**Panneaux de débogage :**
- **Variables** : Valeurs des variables
- **Watch** : Expressions à surveiller
- **Call Stack** : Pile d'appels
- **Breakpoints** : Liste des points d'arrêt

## Productivité Avancée

### 1. Workspaces

Sauvegarder la configuration d'un projet.

**Créer un workspace :**
- `File` > `Save Workspace As...`
- Fichier `.code-workspace` créé

**Avantages :**
- Paramètres spécifiques au projet
- Dossiers multiples
- Extensions recommandées

### 2. Tasks

Automatiser des tâches répétitives.

**Créer une task (.vscode/tasks.json) :**
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Run Tests",
            "type": "shell",
            "command": "pytest",
            "group": {
                "kind": "test",
                "isDefault": true
            }
        }
    ]
}
```

**Exécuter :**
- `Ctrl+Shift+B` : Run build task
- `Ctrl+Shift+P` > `Tasks: Run Task`

### 3. Remote Development

Travailler sur du code distant.

**Extensions :**
- **Remote - SSH** : Connexion SSH
- **Remote - Containers** : Développement dans Docker
- **Remote - WSL** : Windows Subsystem for Linux

**Utilisation Remote SSH :**
1. Installer l'extension
2. `Ctrl+Shift+P` > `Remote-SSH: Connect to Host`
3. Entrer l'adresse SSH
4. VSCode se connecte et ouvre un éditeur distant

### 4. Live Share

Collaboration en temps réel.

1. Installer **Live Share**
2. `Ctrl+Shift+P` > `Live Share: Start Collaboration Session`
3. Partager le lien avec collaborateurs
4. Co-édition, débogage partagé, terminal partagé

### 5. Settings Sync

Synchroniser les paramètres entre machines.

- Intégré nativement
- Se connecter avec compte Microsoft ou GitHub
- Synchronise : paramètres, extensions, raccourcis, snippets

### 6. Zen Mode

Mode d'édition sans distraction.

- `Ctrl+K Z` : Activer Zen Mode
- Interface minimale, code au centre
- `Esc Esc` : Sortir

## Astuces et Tips

### 1. Configurer un Formatage Automatique

```json
{
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

### 2. Utiliser les Ligatures de Code

```json
{
    "editor.fontFamily": "Fira Code",
    "editor.fontLigatures": true
}
```

### 3. Auto-import

```json
{
    "javascript.suggest.autoImports": true,
    "typescript.suggest.autoImports": true,
    "python.analysis.autoImportCompletions": true
}
```

### 4. Exclure des Fichiers

```json
{
    "files.exclude": {
        "**/.git": true,
        "**/__pycache__": true,
        "**/node_modules": true
    }
}
```

### 5. Comparaison de Fichiers

- `Ctrl+Shift+P` > `File: Compare Active File With...`
- Sélectionner le fichier à comparer

### 6. Profiles

Créer des profils pour différents contextes (Python dev, Web dev, etc.)

- `Ctrl+Shift+P` > `Preferences: Create Profile`

## Ressources et Apprentissage

### Documentation
- [Documentation officielle VSCode](https://code.visualstudio.com/docs)
- [Tips and Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)

### Vidéos
- [VSCode YouTube Channel](https://www.youtube.com/c/Code)
- Tutoriels communautaires

### Extensions populaires
- [VSCode Marketplace](https://marketplace.visualstudio.com/)

## Conclusion

VSCode est un outil extrêmement puissant et personnalisable qui s'adapte à tous les types de développement. La clé pour en tirer le meilleur parti est de :

1. **Apprendre progressivement** : Commencer par les bases et ajouter des fonctionnalités au fur et à mesure
2. **Personnaliser** : Adapter l'éditeur à vos besoins spécifiques
3. **Utiliser les extensions** : Installer uniquement ce dont vous avez besoin
4. **Maîtriser les raccourcis** : Gagner en productivité
5. **Explorer** : Tester de nouvelles fonctionnalités régulièrement

Avec de la pratique, VSCode devient un allié indispensable pour votre productivité de développeur !
