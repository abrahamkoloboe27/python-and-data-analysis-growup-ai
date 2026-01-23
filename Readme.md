# 🐍 Python et Analyse de Données - Grow Up AI

## 📚 Description

Ce dépôt contient l'ensemble des supports pédagogiques pour le cours **"Python et Analyse de Données"** organisé par Grow Up AI. Les sessions couvrent les fondamentaux de la programmation en Python, de l'algorithmique aux bonnes pratiques, les bases de données SQL, et l'analyse de données complète avec pandas et visualisations.

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
├── 📁 sql/                    # S10-S13 - SQL et Bases de données
│   ├── schema_sales.sql       # Schéma de base de données
│   ├── insert_sample_data.sql # Données de test
│   ├── queries_s11.sql        # Requêtes SELECT, filtres
│   ├── queries_s12.sql        # JOINs, GROUP BY, HAVING
│   ├── report_s12_template.md # Template de rapport
│   ├── sales.db               # Base de données SQLite
│   └── README.md              # Documentation SQL
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
│   ├── S10-README.md          # Concepts SGBD & modélisation
│   ├── S11-README.md          # SQL SELECT, filtres, ORDER BY
│   ├── S12-README.md          # JOINs, GROUP BY, HAVING
│   ├── S13-README.md          # SQL depuis Python
│   ├── S14-README.md          # NumPy & pandas
│   ├── S15-README.md          # Data Cleaning
│   ├── S16-README.md          # EDA approfondie
│   ├── S17-README.md          # Visualisation avancée
│   ├── S18-README.md          # Portfolio structure
│   ├── collections_s7.ipynb   # Exemples collections
│   ├── csv_json_s8.ipynb      # Manipulation CSV/JSON
│   ├── sql_python_s13.ipynb   # SQL avec Python
│   ├── pandas_s14.ipynb       # Introduction pandas
│   ├── cleaning_s15.ipynb     # Nettoyage de données
│   ├── eda_titanic.ipynb      # EDA complète Titanic
│   └── visualization_s17.ipynb # Visualisations interactives
│
├── 📁 data/                   # Datasets pour l'analyse
│   ├── titanic.csv            # Dataset Titanic original
│   └── titanic_clean.csv      # Dataset Titanic nettoyé
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

---

## 🗄️ Phase 3 : Bases de Données & SQL (S10-S13)

### 📊 **S10 — Concepts SGBD & Modélisation Simple**
- SGBDR vs NoSQL (concepts)
- Clés primaires et étrangères
- Normalisation basique (1NF, 2NF, 3NF)
- Schéma de base de données
- Outils : SQLite, DBeaver, pgAdmin
- **Livrable:** schema_sales.sql (système de ventes e-commerce)

### 📊 **S11 — SQL SELECT, Filtres, ORDER BY**
- Requêtes SELECT, projections, alias
- Clauses WHERE, filtres (>, <, LIKE, IN)
- Tri avec ORDER BY, LIMIT
- Agrégations : COUNT, SUM, AVG, MIN, MAX
- **Livrables:** queries_s11.sql + exports CSV

### 📊 **S12 — JOINs, GROUP BY, HAVING**
- INNER JOIN, LEFT JOIN, RIGHT JOIN
- Jointures multiples
- GROUP BY pour agrégations
- HAVING pour filtrer les groupes
- Index et optimisation
- **Livrables:** queries_s12.sql, report_s12.md (avec graphiques)

### 📊 **S13 — SQL depuis Python (pandas + SQL)**
- Connexion Python à SQLite/PostgreSQL
- sqlalchemy, sqlite3, psycopg2
- pandas.read_sql_query(), to_sql()
- Traitement des résultats avec pandas
- **Livrable:** sql_python_s13.ipynb + requirements.txt

**Portfolio SQL** : Dossier sql/ avec schéma, requêtes, notebooks, rapports

---

## 📈 Phase 4 : Analyse de Données & EDA (S14-S18)

### 📉 **S14 — Introduction NumPy & pandas**
- NumPy arrays et opérations vectorisées
- pandas : Series, DataFrame
- Indexation, sélection, filtres
- groupby et agrégations
- **Livrable:** pandas_s14.ipynb (analyse Titanic basique)

### 🧹 **S15 — Nettoyage et Transformation de Données**
- Détection et traitement des valeurs manquantes
- Imputations (mean, median, mode)
- Gestion des types de données
- Détection d'outliers
- Feature engineering (création de variables)
- **Livrables:** cleaning_s15.ipynb, titanic_clean.csv

### 📊 **S16 — EDA Approfondie & Visualisations**
- Statistiques descriptives complètes
- Matrices de corrélation
- Visualisations : histogrammes, boxplots, heatmaps
- matplotlib, seaborn
- Questions métier et insights
- **Livrable:** eda_titanic.ipynb (EDA complète commentée)

### 🎨 **S17 — Visualisation Avancée & Storytelling**
- Principes de visualisation de données
- Design de graphiques professionnels
- Plotly pour graphiques interactifs
- Dashboards simples
- Storytelling avec les données
- **Livrables:** visualization_s17.ipynb, titanic_viz.html, readme_viz.md

### 📁 **S18 — Structure de Portfolio Data Science**
- Organisation d'un portfolio GitHub
- Documentation et README professionnels
- Présentation de projets
- Bonnes pratiques Git
- **Livrable:** Portfolio complet organisé

---

## 🎯 Sessions de Formation Détaillées

### Phase 1-2 : Fondamentaux (S2-S9)

### 📘 **S2 — Structures de Contrôle**
- Conditionnelles (SI/ALORS/SINON)
- Boucles (POUR, TANT QUE)
- Instructions BREAK et CONTINUE
- **Livrables:** pgcd.py, compter_mots.py

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

- **📝 Fichiers README:** 17+ documents pédagogiques complets (S2-S18)
- **🐍 Scripts Python:** 6 programmes fonctionnels
- **🧪 Tests unitaires:** 96+ tests (31 pour PGCD, 36 pour merge, 29 pour hangman)
- **📓 Notebooks Jupyter:** 10+ notebooks interactifs
- **📄 Fichiers de données:** 5+ datasets (CSV, logs, SQLite, Titanic)
- **🗄️ Base de données:** 1 base SQLite complète (40 commandes, 20 clients, 30 produits)
- **📊 Requêtes SQL:** 50+ requêtes SQL documentées
- **✅ Couverture tests:** 100% des fonctions principales
- **🔒 Sécurité:** 0 vulnérabilité (CodeQL vérifié)

## 🛠️ Technologies Utilisées

### Phase 1-2 : Fondamentaux Python
- **Python 3.8+**
- **pytest** - Tests unitaires
- **pylint, black, flake8** - Qualité de code

### Phase 3 : SQL et Bases de Données
- **SQLite** - Base de données locale
- **SQLAlchemy** - ORM et connexions DB
- **DBeaver / pgAdmin** - Interfaces graphiques

### Phase 4 : Data Analysis & Visualisation
- **pandas** - Manipulation de données
- **numpy** - Calculs numériques
- **matplotlib, seaborn** - Visualisations statiques
- **plotly** - Visualisations interactives
- **jupyter** - Notebooks interactifs

## 📖 Documentation

### Phase 1-2 : Fondamentaux (S2-S9)

- [S2-README.md](notebooks/S2-README.md) - Structures de contrôle
- [S3-README.md](notebooks/S3-README.md) - Structures de données
- [S4-README.md](notebooks/S4-README.md) - Fonctions et modularité
- [S5-README.md](notebooks/S5-README.md) - Syntaxe Python
- [S6-README.md](notebooks/S6-README.md) - Contrôles et boucles
- [S7-README.md](notebooks/S7-README.md) - Collections avancées
- [S8-README.md](notebooks/S8-README.md) - Fichiers et pandas
- [S9-README.md](notebooks/S9-README.md) - Tests et bonnes pratiques

### Phase 3 : SQL et Bases de Données (S10-S13)

- [S10-README.md](notebooks/S10-README.md) - Concepts SGBD & modélisation
- [S11-README.md](notebooks/S11-README.md) - SQL SELECT, filtres, ORDER BY
- [S12-README.md](notebooks/S12-README.md) - JOINs, GROUP BY, HAVING
- [S13-README.md](notebooks/S13-README.md) - SQL depuis Python
- [SQL README](sql/README.md) - Documentation complète SQL

### Phase 4 : Data Analysis & EDA (S14-S18)

- [S14-README.md](notebooks/S14-README.md) - Introduction NumPy & pandas
- [S15-README.md](notebooks/S15-README.md) - Data Cleaning & transformation
- [S16-README.md](notebooks/S16-README.md) - EDA approfondie & visualisations
- [S17-README.md](notebooks/S17-README.md) - Visualisation avancée & storytelling
- [S18-README.md](notebooks/S18-README.md) - Structure de portfolio

Documentation détaillée des scripts dans [python_basics/README.md](python_basics/README.md)

## 🎓 Objectifs Pédagogiques

Ce cours vise à former les apprenants à :

### Phase 1-2 : Fondamentaux Python
- ✅ Maîtriser les fondamentaux de Python
- ✅ Comprendre l'algorithmique et les structures de données
- ✅ Écrire du code propre et maintenable
- ✅ Tester et documenter son code
- ✅ Manipuler des fichiers (CSV, JSON)
- ✅ Suivre les bonnes pratiques (PEP 8, docstrings)

### Phase 3 : SQL et Bases de Données
- ✅ Comprendre les concepts des bases de données relationnelles
- ✅ Maîtriser SQL (SELECT, JOIN, GROUP BY, sous-requêtes)
- ✅ Concevoir et normaliser des schémas de bases de données
- ✅ Connecter Python aux bases de données
- ✅ Analyser des données avec SQL et pandas

### Phase 4 : Data Analysis & Visualisation
- ✅ Manipuler et nettoyer des données avec pandas
- ✅ Réaliser des analyses exploratoires complètes (EDA)
- ✅ Créer des visualisations professionnelles
- ✅ Utiliser des outils interactifs (Plotly)
- ✅ Communiquer des insights avec storytelling
- ✅ Construire un portfolio data science professionnel

## 👥 Contribution

Ce projet est développé dans le cadre du programme **Grow Up AI**. Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue.

## 📜 Licence

Ce projet est destiné à des fins éducatives dans le cadre de la formation Grow Up AI.

---

**Grow Up AI** - Formation Python et Analyse de Données
*Dernière mise à jour : Janvier 2026*
