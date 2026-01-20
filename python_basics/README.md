# Python Basics - Guide Complet

Ce guide vous accompagne dans la configuration et l'utilisation des scripts et tests du cours **Python et Analyse de Données**.

---

## 📋 Table des Matières

1. [Prérequis](#prérequis)
2. [Installation](#installation)
3. [Structure du Projet](#structure-du-projet)
4. [Scripts Disponibles](#scripts-disponibles)
5. [Tests Unitaires](#tests-unitaires)
6. [Utilisation](#utilisation)
7. [Dépannage](#dépannage)

---

## 🔧 Prérequis

### Logiciels Requis

- **Python 3.8 ou supérieur**
- **pip** (gestionnaire de packages Python)
- **git** (pour cloner le dépôt)

### Vérification de l'Installation

```bash
# Vérifier Python
python --version
# ou
python3 --version

# Vérifier pip
pip --version
# ou
pip3 --version
```

---

## 📦 Installation

### 1. Cloner le Dépôt

```bash
git clone https://github.com/abrahamkoloboe27/python-and-data-analysis-growup-ai.git
cd python-and-data-analysis-growup-ai
```

### 2. Créer un Environnement Virtuel

```bash
# Linux/macOS
python3 -m venv venv
source venv/bin/activate

# Windows (Command Prompt)
python -m venv venv
venv\Scripts\activate.bat

# Windows (PowerShell)
python -m venv venv
venv\Scripts\Activate.ps1
```

Vous devriez voir `(venv)` apparaître au début de votre ligne de commande.

### 3. Installer les Dépendances

```bash
pip install -r requirements.txt
```

Cette commande installe :
- `pytest` pour les tests
- `pandas` et `numpy` pour l'analyse de données
- `jupyter` pour les notebooks
- Outils de qualité de code (`pylint`, `black`, `flake8`)

---

## 📁 Structure du Projet

```
python-and-data-analysis-growup-ai/
│
├── algorithmique/             # Algorithmes de base
│   ├── pgcd.py               # PGCD (algorithme d'Euclide)
│   ├── merge.py              # Fusion de listes triées
│   └── hangman_design.md     # Conception du jeu du pendu
│
├── python_basics/            # Scripts Python de base
│   ├── calc_stats.py         # Calcul de statistiques
│   ├── numbers.csv           # Données d'exemple
│   ├── hangman.py            # Jeu du pendu complet
│   ├── log_analyzer.py       # Analyseur de logs web
│   ├── sample.log            # Logs d'exemple
│   ├── sales_data.csv        # Données de ventes
│   ├── README_calc_stats.md  # Guide calc_stats.py
│   ├── README.md             # Ce fichier
│   │
│   └── tests/                # Tests unitaires
│       ├── test_pgcd.py      # Tests pour pgcd.py
│       ├── test_merge.py     # Tests pour merge.py
│       └── test_hangman.py   # Tests pour hangman.py
│
├── notebooks/                # Notebooks Jupyter
│   ├── S5-README.md          # Session 5: Syntaxe Python
│   ├── S6-README.md          # Session 6: Contrôles et boucles
│   ├── S7-README.md          # Session 7: Collections
│   ├── S8-README.md          # Session 8: Fichiers et pandas
│   ├── S9-README.md          # Session 9: Tests et qualité
│   ├── collections_s7.ipynb  # Notebook collections
│   └── csv_json_s8.ipynb     # Notebook CSV/JSON/pandas
│
├── requirements.txt          # Dépendances Python
└── Readme.md                 # README principal du projet
```

---

## 🚀 Scripts Disponibles

### 1. Calcul de Statistiques (`calc_stats.py`)

Calcule des statistiques descriptives à partir d'un fichier CSV.

```bash
cd python_basics
python calc_stats.py
```

**Fonctionnalités :**
- Moyenne, médiane, min, max
- Écart-type et variance
- Étendue des données

**Fichier utilisé :** `numbers.csv`

### 2. Jeu du Pendu (`hangman.py`)

Jeu interactif du pendu avec menu et sauvegarde des scores.

```bash
cd python_basics
python hangman.py
```

**Fonctionnalités :**
- Menu interactif
- Sauvegarde des scores en JSON
- Affichage ASCII du pendu
- Règles du jeu intégrées

### 3. Analyseur de Logs (`log_analyzer.py`)

Analyse des logs de serveur web avec statistiques détaillées.

```bash
cd python_basics
python log_analyzer.py
```

**Fonctionnalités :**
- Top 10 des IPs
- Top 5 des endpoints
- Distribution des méthodes HTTP
- Détection des erreurs (4xx, 5xx)
- Génération de rapports Markdown

**Fichier utilisé :** `sample.log`

---

## 🧪 Tests Unitaires

### Exécuter Tous les Tests

```bash
# Depuis la racine du projet
pytest python_basics/tests/

# Avec verbosité
pytest python_basics/tests/ -v

# Avec rapport de couverture
pytest python_basics/tests/ --cov=python_basics

# Générer un rapport HTML
pytest python_basics/tests/ --html=report.html
```

### Exécuter des Tests Spécifiques

```bash
# Tests pour PGCD
pytest python_basics/tests/test_pgcd.py

# Tests pour Merge
pytest python_basics/tests/test_merge.py

# Tests pour Hangman
pytest python_basics/tests/test_hangman.py

# Un test particulier
pytest python_basics/tests/test_pgcd.py::test_pgcd_exemple_classique
```

### Résultats Attendus

```
============================== test session starts ===============================
collected 87 items

python_basics/tests/test_pgcd.py ............................  [ 32%]
python_basics/tests/test_merge.py .....................................  [ 73%]
python_basics/tests/test_hangman.py .......................  [100%]

============================== 87 passed in 2.45s ================================
```

---

## 💡 Utilisation

### Utilisation Basique

1. **Activer l'environnement virtuel**

```bash
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
```

2. **Naviguer vers le dossier python_basics**

```bash
cd python_basics
```

3. **Exécuter un script**

```bash
python calc_stats.py
python hangman.py
python log_analyzer.py
```

### Utilisation Avancée

#### Modifier les Données

Pour tester avec vos propres données :

1. **calc_stats.py** : Remplacez `numbers.csv` par votre fichier
2. **log_analyzer.py** : Remplacez `sample.log` par vos logs
3. **Notebooks** : Utilisez `sales_data.csv` ou vos données

#### Ajouter de Nouveaux Tests

```python
# Dans tests/test_mon_module.py
import pytest

def test_ma_fonction():
    """Description du test."""
    assert ma_fonction(42) == attendu
```

#### Lancer Jupyter

```bash
jupyter notebook
```

Ouvrez ensuite :
- `notebooks/collections_s7.ipynb`
- `notebooks/csv_json_s8.ipynb`

---

## 🔍 Qualité de Code

### Vérifier le Style (PEP 8)

```bash
# Avec flake8
flake8 python_basics/*.py

# Avec pylint
pylint python_basics/*.py
```

### Formater Automatiquement

```bash
# Avec black
black python_basics/*.py
```

---

## 🐛 Dépannage

### Problème : Module introuvable

**Erreur :**
```
ModuleNotFoundError: No module named 'pandas'
```

**Solution :**
```bash
pip install -r requirements.txt
```

### Problème : Environnement virtuel non activé

**Symptôme :** Les packages installés ne sont pas trouvés.

**Solution :**
```bash
# Vérifier si l'environnement est activé (doit afficher (venv))
# Sinon, l'activer :
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
```

### Problème : pytest non trouvé

**Solution :**
```bash
pip install pytest
```

### Problème : Permissions sous Linux/macOS

**Solution :**
```bash
chmod +x python_basics/*.py
```

### Problème : Encodage de fichiers

**Erreur :**
```
UnicodeDecodeError: 'charmap' codec can't decode...
```

**Solution :** Les fichiers sont encodés en UTF-8. Assurez-vous que votre éditeur/IDE est configuré pour UTF-8.

---

## 📚 Ressources

### Documentation des Sessions

- **S5** : Bases de la syntaxe Python
- **S6** : Structures de contrôle et boucles
- **S7** : Collections avancées (listes, dicts, sets)
- **S8** : Fichiers, CSV, JSON et pandas
- **S9** : Tests, virtualenv et qualité de code

### Liens Utiles

- [Documentation Python](https://docs.python.org/fr/3/)
- [Documentation pytest](https://docs.pytest.org/)
- [Documentation pandas](https://pandas.pydata.org/docs/)
- [PEP 8 Style Guide](https://www.python.org/dev/peps/pep-0008/)

---

## 🤝 Contribution

Pour contribuer au projet :

1. Forkez le dépôt
2. Créez une branche (`git checkout -b feature/ma-fonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout de...'`)
4. Pushez la branche (`git push origin feature/ma-fonctionnalite`)
5. Ouvrez une Pull Request

---

## 📝 Licence

Ce projet est fourni à des fins éducatives dans le cadre du cours **Python et Analyse de Données**.

---

## 🆘 Support

En cas de problème :

1. Consultez la section [Dépannage](#dépannage)
2. Vérifiez les issues GitHub
3. Contactez l'instructeur du cours

---

**Bon apprentissage ! 🎓🐍**
