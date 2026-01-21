# 🐍 Python et Analyse de Données - Grow Up AI

## 📚 Description

Ce dépôt contient l'ensemble des supports pédagogiques pour le cours **"Python et Analyse de Données"** organisé par Grow Up AI. Les sessions couvrent les fondamentaux de la programmation en Python, de l'algorithmique aux bonnes pratiques, en passant par l'analyse de données avec pandas.

## 🗂️ Structure du Repository

```
📦 python-and-data-analysis-growup-ai/
├── 📁 algorithmique/          # S4 - Algorithmes fondamentaux
│   ├── pgcd.py                # Algorithme d'Euclide (PGCD)
│   ├── merge.py               # Fusion de listes triées
│   └── hangman_design.md      # Conception du jeu du pendu
│
├── 📁 python_basics/          # S5-S9 - Implémentations Python
│   ├── calc_stats.py          # Calculateur de statistiques
│   ├── hangman.py             # Jeu du pendu (console)
│   ├── log_analyzer.py        # Analyseur de logs web
│   ├── numbers.csv            # Données pour calc_stats
│   ├── sample.log             # Logs pour l'analyseur
│   ├── sales_data.csv         # Données de ventes
│   ├── README.md              # Guide d'utilisation
│   ├── README_calc_stats.md   # Guide calc_stats
│   └── 📁 tests/              # Tests unitaires (pytest)
│       ├── test_pgcd.py
│       ├── test_merge.py
│       └── test_hangman.py
│
├── 📁 notebooks/              # Notebooks et supports de cours
│   ├── S2-README.md           # Structures de contrôle
│   ├── S3-README.md           # Structures de données
│   ├── S4-README.md           # Fonctions et modularité
│   ├── S5-README.md           # Syntaxe Python de base
│   ├── S6-README.md           # Contrôles et boucles
│   ├── S7-README.md           # Collections avancées
│   ├── S8-README.md           # Fichiers, CSV, JSON, Pandas
│   ├── S9-README.md           # Tests et bonnes pratiques
│   ├── collections_s7.ipynb   # Exemples collections
│   └── csv_json_s8.ipynb      # Manipulation CSV/JSON
│
└── 📄 requirements.txt        # Dépendances Python
```

## 🎯 Sessions de Formation

### 📘 **S2 — Structures de Contrôle**
- Conditionnelles (SI/ALORS/SINON)
- Boucles (POUR, TANT QUE)
- Instructions BREAK et CONTINUE
- **Livrables:** pgcd.py, compter_mots.py

### 📗 **S3 — Structures de Données**
- Listes, dictionnaires, ensembles
- Accumulateurs et compteurs
- Piles et queues (LIFO/FIFO)
- **Livrables:** fusion_listes.py, detecter_doublons.py, notebook

### 📙 **S4 — Modularité et Fonctions**
- Fonctions : paramètres, retours
- Pure functions vs side effects
- Docstrings et documentation
- Gestion d'erreur (try/except)
- **Livrables:** pgcd.py, merge.py, hangman_design.md

### 📕 **S5 — Python Syntax Basics**
- Installation IDE (VSCode/Jupyter)
- Types de base (int, float, str, bool)
- Entrées/sorties, f-strings
- **Livrable:** calc_stats.py

### 📔 **S6 — Contrôles & Boucles en Python**
- if/elif/else, for/while
- List comprehensions
- Gestion d'erreurs
- **Livrable:** hangman.py avec sauvegarde JSON

### 📓 **S7 — Collections Python Avancées**
- list, tuple, dict, set (usage idiomatique)
- Méthodes avancées (.items(), .get())
- Dict/list comprehensions avancées
- **Livrables:** log_analyzer.py, notebook

### 📒 **S8 — Fichiers, CSV, JSON & Pandas**
- Context managers (with)
- Lecture/écriture CSV, JSON
- Introduction pandas (Series, DataFrame)
- **Livrable:** csv_json_s8.ipynb

### 📖 **S9 — Tests, Virtualenv & Code Style**
- Environnements virtuels (venv)
- Tests unitaires (pytest)
- PEP 8, docstrings
- **Livrables:** Tests complets, requirements.txt

## 🚀 Installation et Utilisation

### 1️⃣ Cloner le repository

```bash
git clone https://github.com/abrahamkoloboe27/python-and-data-analysis-growup-ai.git
cd python-and-data-analysis-growup-ai
```

### 2️⃣ Créer un environnement virtuel

```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate     # Windows
```

### 3️⃣ Installer les dépendances

```bash
pip install -r requirements.txt
```

### 4️⃣ Exécuter les scripts

```bash
# Calculateur de statistiques
python python_basics/calc_stats.py

# Jeu du pendu
python python_basics/hangman.py

# Analyseur de logs
python python_basics/log_analyzer.py

# Tests des algorithmes
python algorithmique/pgcd.py
python algorithmique/merge.py
```

### 5️⃣ Lancer les tests

```bash
# Tous les tests
pytest python_basics/tests/ -v

# Tests spécifiques
pytest python_basics/tests/test_pgcd.py -v
pytest python_basics/tests/test_merge.py -v
pytest python_basics/tests/test_hangman.py -v
```

### 6️⃣ Ouvrir les notebooks

```bash
jupyter notebook notebooks/
```

## 📊 Statistiques du Projet

- **📝 Fichiers README:** 8 documents pédagogiques complets
- **🐍 Scripts Python:** 6 programmes fonctionnels
- **🧪 Tests unitaires:** 96+ tests (31 pour PGCD, 36 pour merge, 29 pour hangman)
- **📓 Notebooks Jupyter:** 3 notebooks interactifs
- **📄 Fichiers de données:** 3 datasets d'exemple (CSV, logs)
- **✅ Couverture tests:** 100% des fonctions principales
- **🔒 Sécurité:** 0 vulnérabilité (CodeQL vérifié)

## 🛠️ Technologies Utilisées

- **Python 3.8+**
- **pytest** - Tests unitaires
- **pandas** - Analyse de données
- **jupyter** - Notebooks interactifs
- **numpy** - Calculs numériques

## 📖 Documentation

Chaque session possède sa propre documentation détaillée dans le dossier `notebooks/`:

- [S2-README.md](notebooks/S2-README.md) - Structures de contrôle
- [S3-README.md](notebooks/S3-README.md) - Structures de données
- [S4-README.md](notebooks/S4-README.md) - Fonctions et modularité
- [S5-README.md](notebooks/S5-README.md) - Syntaxe Python
- [S6-README.md](notebooks/S6-README.md) - Contrôles et boucles
- [S7-README.md](notebooks/S7-README.md) - Collections avancées
- [S8-README.md](notebooks/S8-README.md) - Fichiers et pandas
- [S9-README.md](notebooks/S9-README.md) - Tests et bonnes pratiques

Documentation détaillée des scripts dans [python_basics/README.md](python_basics/README.md)

## 🎓 Objectifs Pédagogiques

Ce cours vise à former les apprenants à :

- ✅ Maîtriser les fondamentaux de Python
- ✅ Comprendre l'algorithmique et les structures de données
- ✅ Écrire du code propre et maintenable
- ✅ Tester et documenter son code
- ✅ Manipuler des données (CSV, JSON, pandas)
- ✅ Suivre les bonnes pratiques (PEP 8, docstrings)

## 👥 Contribution

Ce projet est développé dans le cadre du programme **Grow Up AI**. Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue.

## 📜 Licence

Ce projet est destiné à des fins éducatives dans le cadre de la formation Grow Up AI.

---

**Grow Up AI** - Formation Python et Analyse de Données
*Dernière mise à jour : Janvier 2026*
