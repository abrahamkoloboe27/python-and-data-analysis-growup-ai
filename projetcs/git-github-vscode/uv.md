# uv : Guide Complet pour le Packaging Python

## Table des matières
1. [Introduction à uv](#introduction-à-uv)
2. [Origines et Histoire](#origines-et-histoire)
3. [Installation](#installation)
4. [Concepts de Base](#concepts-de-base)
5. [Commandes de Base](#commandes-de-base)
6. [Bonnes Pratiques](#bonnes-pratiques)
7. [Utilités et Avantages](#utilités-et-avantages)
8. [Cas d'Usage Avancés](#cas-dusage-avancés)
9. [Migration depuis pip/poetry](#migration-depuis-pippoetry)

## Introduction à uv

**uv** est un gestionnaire de paquets et d'environnements Python ultra-rapide, écrit en Rust, développé par Astral (les créateurs de Ruff). Il se positionne comme un remplaçant moderne et performant de pip, pip-tools, poetry, pipenv et virtualenv.

### Pourquoi uv ?

**Performances :**
- ⚡ **10-100x plus rapide** que pip
- Installation en parallèle
- Cache intelligent
- Résolution de dépendances optimisée

**Simplicité :**
- Une seule commande pour tout faire
- Interface intuitive
- Compatible avec les standards Python (pyproject.toml, requirements.txt)

**Fiabilité :**
- Résolution déterministe des dépendances
- Lockfiles pour la reproductibilité
- Gestion des versions stricte

## Origines et Histoire

### Contexte

L'écosystème Python a longtemps souffert de la fragmentation des outils de gestion de paquets :
- **pip** : Standard mais lent
- **pipenv** : Lockfiles mais complexe et lent
- **poetry** : Moderne mais lent et parfois peu fiable
- **conda** : Puissant mais lourd

### Naissance de uv (2024)

**Astral**, déjà connu pour **Ruff** (linter Python ultra-rapide en Rust), lance uv en février 2024 avec l'objectif de :
1. Unifier les outils de packaging Python
2. Apporter les performances de Rust
3. Simplifier le workflow de développement
4. Rester compatible avec l'écosystème existant

### Philosophy

uv suit la philosophie d'Astral :
- **Performance d'abord** : Optimisation extrême
- **Standards Python** : Respect des PEPs
- **Expérience développeur** : Interface claire et intuitive
- **Open Source** : Code ouvert et communauté active

## Installation

### Via pip (méthode simple)

```bash
pip install uv
```

### Via curl (recommandé)

**macOS et Linux :**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**Windows (PowerShell) :**
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### Via gestionnaires de paquets

**macOS (Homebrew) :**
```bash
brew install uv
```

**Linux (cargo) :**
```bash
cargo install --git https://github.com/astral-sh/uv uv
```

### Vérification

```bash
uv --version
```

### Mise à jour

```bash
# Via uv lui-même
uv self update

# Via pip
pip install --upgrade uv
```

## Concepts de Base

### Environnements Virtuels

Comme virtualenv, uv crée des environnements isolés pour vos projets.

**Pourquoi des environnements virtuels ?**
- Isoler les dépendances par projet
- Éviter les conflits de versions
- Reproduire facilement les environnements

### Lockfiles

Un lockfile (`uv.lock`) capture les versions exactes de toutes les dépendances (directes et transitives).

**Avantages :**
- Builds reproductibles
- Déploiements cohérents
- Détection de changements non intentionnels

### Cache Global

uv maintient un cache global des paquets téléchargés pour accélérer les installations futures.

**Localisation du cache :**
- Linux/macOS : `~/.cache/uv`
- Windows : `%LOCALAPPDATA%\uv\cache`

### Résolution de Dépendances

uv utilise un resolver moderne qui :
- Résout les contraintes de versions
- Détecte les conflits
- Trouve la meilleure combinaison de versions

## Commandes de Base

### Créer un Environnement Virtuel

```bash
# Créer un venv avec Python par défaut
uv venv

# Créer avec une version Python spécifique
uv venv --python 3.11
uv venv --python python3.11

# Créer dans un dossier spécifique
uv venv myenv

# Créer avec un nom personnalisé
uv venv .venv
```

### Activer l'Environnement

```bash
# Linux/macOS
source .venv/bin/activate

# Windows (PowerShell)
.venv\Scripts\Activate.ps1

# Windows (cmd)
.venv\Scripts\activate.bat
```

### Installer des Paquets

```bash
# Installer un paquet
uv pip install requests

# Installer plusieurs paquets
uv pip install requests pandas numpy

# Installer une version spécifique
uv pip install requests==2.31.0

# Installer avec contraintes de version
uv pip install "requests>=2.30.0,<3.0.0"

# Installer depuis requirements.txt
uv pip install -r requirements.txt

# Installer en mode éditable (développement)
uv pip install -e .

# Installer des extras
uv pip install "fastapi[all]"
```

### Désinstaller des Paquets

```bash
# Désinstaller un paquet
uv pip uninstall requests

# Désinstaller plusieurs paquets
uv pip uninstall requests pandas

# Désinstaller tout
uv pip freeze | xargs uv pip uninstall
```

### Lister les Paquets Installés

```bash
# Lister tous les paquets
uv pip list

# Format freeze (pour requirements.txt)
uv pip freeze

# Exporter vers un fichier
uv pip freeze > requirements.txt
```

### Générer un Lockfile

```bash
# Compiler requirements.txt en requirements.lock
uv pip compile requirements.in -o requirements.txt

# Avec contraintes
uv pip compile requirements.in --constraint constraints.txt

# Pour une plateforme spécifique
uv pip compile requirements.in --python-platform linux
```

### Synchroniser l'Environnement

```bash
# Synchroniser avec requirements.txt (installe/désinstalle pour matcher exactement)
uv pip sync requirements.txt

# Utile pour garantir que l'environnement correspond exactement au lockfile
```

### Rechercher des Paquets

```bash
# Rechercher un paquet (via PyPI)
uv pip search django

# Note : Désactivé sur PyPI depuis 2021, mais uv offre une alternative
```

### Afficher les Informations d'un Paquet

```bash
# Infos sur un paquet installé
uv pip show requests

# Dépendances d'un paquet
uv pip show requests --verbose
```

### Gérer le Cache

```bash
# Afficher la taille du cache
uv cache size

# Nettoyer le cache
uv cache clean

# Nettoyer un paquet spécifique
uv cache clean requests
```

## Bonnes Pratiques

### 1. Structure de Projet

```
mon-projet/
├── .venv/                  # Environnement virtuel (dans .gitignore)
├── src/
│   └── mon_package/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
├── pyproject.toml          # Configuration du projet
├── requirements.in         # Dépendances abstraites
├── requirements.txt        # Dépendances lockées (généré par uv)
├── requirements-dev.txt    # Dépendances de développement
├── README.md
└── .gitignore
```

### 2. Fichiers de Dépendances

**requirements.in (dépendances abstraites) :**
```txt
# Production
requests>=2.30.0
pandas>=2.0.0
fastapi>=0.100.0
```

**requirements-dev.in (développement) :**
```txt
-c requirements.txt  # Contraintes de prod

# Testing
pytest>=7.0.0
pytest-cov>=4.0.0

# Linting
ruff>=0.1.0

# Type checking
mypy>=1.0.0
```

**Générer les lockfiles :**
```bash
# Production
uv pip compile requirements.in -o requirements.txt

# Développement
uv pip compile requirements-dev.in -o requirements-dev.txt
```

### 3. pyproject.toml

Configuration moderne du projet :

```toml
[project]
name = "mon-projet"
version = "0.1.0"
description = "Description de mon projet"
authors = [
    {name = "Votre Nom", email = "email@example.com"}
]
requires-python = ">=3.9"
dependencies = [
    "requests>=2.30.0",
    "pandas>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "ruff>=0.1.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv]
dev-dependencies = [
    "pytest>=7.0.0",
    "ruff>=0.1.0",
]
```

### 4. .gitignore

```gitignore
# Environnements virtuels
.venv/
venv/
env/

# Cache Python
__pycache__/
*.py[cod]
*$py.class

# Distribution
dist/
build/
*.egg-info/

# Cache uv
.uv/

# IDE
.vscode/
.idea/

# Tests
.pytest_cache/
.coverage
htmlcov/
```

### 5. Workflow de Développement

**Nouveau projet :**
```bash
# 1. Créer le dossier
mkdir mon-projet
cd mon-projet

# 2. Créer l'environnement virtuel
uv venv

# 3. Activer l'environnement
source .venv/bin/activate  # Linux/macOS

# 4. Créer pyproject.toml ou requirements.in

# 5. Installer les dépendances
uv pip install -e ".[dev]"  # Depuis pyproject.toml
# ou
uv pip install -r requirements-dev.txt

# 6. Développer...

# 7. Mettre à jour les dépendances
uv pip compile requirements.in -o requirements.txt
uv pip sync requirements.txt
```

**Cloner un projet existant :**
```bash
# 1. Cloner
git clone https://github.com/user/projet.git
cd projet

# 2. Créer l'environnement
uv venv

# 3. Activer
source .venv/bin/activate

# 4. Installer les dépendances exactes
uv pip sync requirements.txt

# 5. Installer en mode dev
uv pip install -e ".[dev]"
```

### 6. CI/CD avec uv

**GitHub Actions :**
```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install uv
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Create venv
        run: uv venv
      
      - name: Install dependencies
        run: |
          source .venv/bin/activate
          uv pip sync requirements.txt
          uv pip install -e ".[dev]"
      
      - name: Run tests
        run: |
          source .venv/bin/activate
          pytest
```

### 7. Gestion des Versions

**Contraintes de version recommandées :**
```txt
# ✅ Bon : Contraintes raisonnables
requests>=2.30.0,<3.0.0
pandas>=2.0.0,<3.0.0

# ⚠️ Acceptable : Major version
requests>=2.30.0

# ❌ Éviter : Trop strict
requests==2.31.0

# ❌ Éviter : Trop lâche
requests
```

### 8. Environnements Multiples

```bash
# Développement
uv venv .venv-dev
source .venv-dev/bin/activate
uv pip sync requirements-dev.txt

# Production
uv venv .venv-prod
source .venv-prod/bin/activate
uv pip sync requirements.txt

# Tests Python 3.9
uv venv .venv-py39 --python 3.9
source .venv-py39/bin/activate
uv pip sync requirements.txt
```

## Utilités et Avantages

### 1. Vitesse Extrême

**Benchmarks typiques :**
- Installation de Django + dépendances : **10x plus rapide** que pip
- Résolution de dépendances complexes : **50x plus rapide** que poetry
- Création d'environnement virtuel : **Instantané**

**Pourquoi si rapide ?**
- Écrit en Rust (pas Python)
- Téléchargements parallèles
- Cache intelligent
- Résolution optimisée

### 2. Fiabilité

- Résolution déterministe des dépendances
- Lockfiles pour garantir la reproductibilité
- Détection des conflits avant installation
- Validation des checksums

### 3. Compatibilité

- Compatible avec pip (même commandes)
- Lit requirements.txt, pyproject.toml
- Fonctionne avec PyPI et indexes privés
- Interopérable avec l'écosystème existant

### 4. Simplicité

```bash
# Avec pip/virtualenv (traditionnel)
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Avec uv (moderne)
uv venv && source .venv/bin/activate && uv pip sync requirements.txt
```

### 5. Fonctionnalités Modernes

- Support Python 3.7+
- Multi-plateforme (Linux, macOS, Windows)
- Gestion du cache sophistiquée
- Résolution de dépendances de nouvelle génération

## Cas d'Usage Avancés

### 1. Index PyPI Privé

```bash
# Définir un index alternatif
uv pip install --index-url https://pypi.mycompany.com/simple requests

# Index supplémentaire
uv pip install --extra-index-url https://pypi.mycompany.com/simple requests

# Via variable d'environnement
export UV_INDEX_URL=https://pypi.mycompany.com/simple
uv pip install requests
```

### 2. Installation Offline

```bash
# 1. Télécharger les wheels
uv pip download -r requirements.txt -d ./wheels

# 2. Installer offline
uv pip install --no-index --find-links ./wheels -r requirements.txt
```

### 3. Builds Multi-plateformes

```bash
# Compiler pour Linux
uv pip compile requirements.in --python-platform linux -o requirements-linux.txt

# Compiler pour macOS
uv pip compile requirements.in --python-platform darwin -o requirements-macos.txt

# Compiler pour Windows
uv pip compile requirements.in --python-platform windows -o requirements-windows.txt
```

### 4. Constraints Files

```txt
# constraints.txt : Contraintes globales
numpy<2.0.0
pandas>=2.0.0,<3.0.0
```

```bash
# Compiler avec contraintes
uv pip compile requirements.in --constraint constraints.txt

# Installer avec contraintes
uv pip install -r requirements.txt --constraint constraints.txt
```

### 5. Résolution de Conflits

```bash
# Voir l'arbre de dépendances
uv pip tree

# Forcer une version spécifique
uv pip install "package==1.2.3" --force-reinstall

# Voir les conflits potentiels
uv pip check
```

### 6. Monorepos

```
monorepo/
├── services/
│   ├── api/
│   │   ├── pyproject.toml
│   │   └── src/
│   └── worker/
│       ├── pyproject.toml
│       └── src/
└── shared/
    ├── pyproject.toml
    └── src/
```

```bash
# Installer avec dépendances locales
cd services/api
uv pip install -e . -e ../../shared
```

## Migration depuis pip/poetry

### Depuis pip

**Avant (pip) :**
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

**Après (uv) :**
```bash
uv venv
source .venv/bin/activate
uv pip sync requirements.txt
```

**Migration complète :**
1. Installer uv
2. Remplacer `pip` par `uv pip` dans vos scripts
3. Régénérer vos lockfiles : `uv pip compile requirements.in`
4. Mettre à jour la CI/CD

### Depuis poetry

**poetry.lock → requirements.txt :**
```bash
# Exporter depuis poetry
poetry export -f requirements.txt -o requirements.txt --without-hashes

# Puis utiliser avec uv
uv pip sync requirements.txt
```

**pyproject.toml :**
Poetry et uv utilisent tous deux `pyproject.toml`, mais avec des sections différentes.

```toml
# Poetry
[tool.poetry.dependencies]
python = "^3.9"
requests = "^2.30.0"

# uv (standard PEP 621)
[project]
requires-python = ">=3.9"
dependencies = [
    "requests>=2.30.0",
]
```

## Comparaison avec Autres Outils

| Fonctionnalité | pip | poetry | pipenv | uv |
|----------------|-----|--------|--------|-----|
| Vitesse | Lent | Lent | Très lent | **Ultra rapide** |
| Lockfile | ❌ | ✅ | ✅ | ✅ |
| Résolution deps | Basique | Bonne | Bonne | **Excellente** |
| Compatibilité | ✅ | Limitée | Limitée | ✅ |
| Installation | Inclu Python | pip install | pip install | curl / pip |
| Gestion venv | ❌ | ✅ | ✅ | ✅ |
| Cache | Basique | Bon | Bon | **Excellent** |

## Ressources et Documentation

### Documentation Officielle
- [Site officiel uv](https://astral.sh/uv/)
- [Documentation uv](https://docs.astral.sh/uv/)
- [GitHub uv](https://github.com/astral-sh/uv)

### Blog et Annonces
- [Blog Astral](https://astral.sh/blog)
- [Annonce de lancement](https://astral.sh/blog/uv)

### Communauté
- [Discord Astral](https://discord.gg/astral)
- [GitHub Discussions](https://github.com/astral-sh/uv/discussions)
- [Issues GitHub](https://github.com/astral-sh/uv/issues)

### Comparaisons et Benchmarks
- [uv vs pip benchmarks](https://astral.sh/blog/uv#performance)
- [Articles de la communauté](https://www.google.com/search?q=uv+python+package+manager+review)

## Dépannage

### Problèmes Courants

**1. uv: command not found**
```bash
# Vérifier l'installation
which uv

# Ajouter au PATH (si nécessaire)
export PATH="$HOME/.cargo/bin:$PATH"  # Linux/macOS
```

**2. Erreur de résolution de dépendances**
```bash
# Nettoyer le cache
uv cache clean

# Réessayer
uv pip install -r requirements.txt
```

**3. Paquet non trouvé**
```bash
# Vérifier l'index PyPI
uv pip install --index-url https://pypi.org/simple package-name

# Vérifier la version
uv pip install "package-name>=1.0.0"
```

**4. Conflits de versions**
```bash
# Voir l'arbre de dépendances
uv pip tree

# Identifier le conflit et ajuster requirements.in
```

## Conclusion

**uv** représente une évolution majeure dans l'écosystème Python :

✅ **Performance** : Gain de temps significatif quotidien
✅ **Fiabilité** : Builds reproductibles garantis
✅ **Simplicité** : Interface intuitive et moderne
✅ **Compatibilité** : S'intègre sans friction
✅ **Futur** : Standards modernes et développement actif

### Quand utiliser uv ?

**✅ Recommandé pour :**
- Tous les nouveaux projets Python
- Projets nécessitant des builds rapides
- CI/CD avec besoin de performance
- Projets avec dépendances complexes
- Équipes cherchant la reproductibilité

**⚠️ À considérer si :**
- Projet legacy avec setup.py complexe
- Dépendances de packages non-PyPI
- Contraintes organisationnelles strictes sur les outils

### Prochaines Étapes

1. **Installer uv** : `curl -LsSf https://astral.sh/uv/install.sh | sh`
2. **Essayer sur un petit projet** : Migrer un projet simple
3. **Mesurer les gains** : Comparer les temps d'installation
4. **Adopter progressivement** : Étendre à d'autres projets
5. **Former l'équipe** : Partager les bonnes pratiques

uv est encore jeune (2024) mais progresse rapidement. C'est le futur de la gestion de paquets Python ! 🚀
