# Session 18 - Portfolio Structure & Best Practices

## 🎯 Objectifs de la session
- Structurer un portfolio data science professionnel
- Documenter efficacement vos projets
- Présenter votre travail sur GitHub
- Se démarquer auprès des recruteurs

---

## 📁 Partie 1 : Structure d'un portfolio data science

### Pourquoi un portfolio ?
- **Prouver vos compétences** : Montrer, ne pas juste dire
- **Se différencier** : Aller au-delà du CV
- **Démontrer la passion** : Projets personnels montrent l'engagement
- **Raconter une histoire** : Vos projets racontent qui vous êtes

### Qu'inclure dans votre portfolio ?

**2-5 projets de qualité > 10 projets moyens**

#### Types de projets recommandés
1. **Projet de bout en bout** - De la collecte à la prédiction
2. **Analyse exploratoire approfondie** - Storytelling avec les données
3. **Projet d'impact** - Résolvant un problème réel
4. **Projet technique** - Montrant vos compétences avancées
5. **Contribution open-source** - Collaboration et qualité du code

#### Structure d'un projet portfolio

```
mon-projet-data/
├── README.md                    # Documentation principale ⭐
├── requirements.txt             # Dépendances Python
├── .gitignore                   # Fichiers à ignorer
├── data/
│   ├── raw/                     # Données brutes (si petites)
│   ├── processed/               # Données nettoyées
│   └── README.md                # Description des données
├── notebooks/
│   ├── 01_data_collection.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_eda.ipynb
│   ├── 04_modeling.ipynb
│   └── 05_results.ipynb
├── src/                         # Code Python réutilisable
│   ├── __init__.py
│   ├── data_processing.py
│   ├── features.py
│   ├── models.py
│   └── visualization.py
├── tests/                       # Tests unitaires
│   ├── test_data_processing.py
│   └── test_features.py
├── models/                      # Modèles entraînés
│   └── model_v1.pkl
├── reports/                     # Rapports et visualisations
│   ├── figures/
│   └── final_report.pdf
└── LICENSE                      # Licence du projet
```

---

## 📝 Partie 2 : Écrire un excellent README

### Anatomie d'un README parfait

```markdown
# Titre du Projet

## 🎯 Objectif
Phrase d'accroche décrivant le problème résolu et l'impact.

## 📊 Dataset
- **Source** : Lien vers le dataset
- **Taille** : X lignes, Y colonnes
- **Description** : Nature des données

## 🔍 Méthodologie
1. **Data Collection** : Comment les données ont été obtenues
2. **Data Cleaning** : Traitement des valeurs manquantes, outliers
3. **EDA** : Insights clés découverts
4. **Feature Engineering** : Variables créées
5. **Modeling** : Algorithmes testés
6. **Evaluation** : Métriques et résultats

## 🚀 Résultats clés
- **Métrique principale** : 95% accuracy
- **Insight 1** : Description
- **Insight 2** : Description
- **Insight 3** : Description

## 🛠️ Technologies utilisées
- **Python 3.11**
- pandas, numpy, scikit-learn
- matplotlib, seaborn, plotly
- Jupyter Notebook

## 📁 Structure du projet
```
Arborescence avec brève description
```

## 🚦 Installation et utilisation
```bash
# Cloner le repo
git clone https://github.com/username/project.git

# Installer les dépendances
pip install -r requirements.txt

# Lancer le notebook
jupyter notebook notebooks/main_analysis.ipynb
```

## 📈 Visualisations
![Viz 1](reports/figures/viz1.png)
*Description de la visualisation*

## 🏆 Performance du modèle
| Modèle | Accuracy | Precision | Recall | F1-Score |
|--------|----------|-----------|--------|----------|
| Logistic Regression | 0.82 | 0.79 | 0.85 | 0.82 |
| Random Forest | **0.87** | 0.84 | 0.89 | 0.86 |
| XGBoost | 0.85 | 0.83 | 0.87 | 0.85 |

## 🔮 Améliorations futures
- [ ] Tester des modèles deep learning
- [ ] Déployer en production avec Flask
- [ ] Créer une API REST

## 👤 Auteur
**Votre Nom**
- LinkedIn : [lien]
- Portfolio : [lien]
- Email : votre@email.com

## 📄 Licence
MIT License
```

### Conseils pour un README efficace

**✅ À faire** :
- Commencer par l'objectif et l'impact
- Utiliser des emojis pour la structure (avec modération)
- Inclure des visualisations
- Montrer les résultats concrets
- Faciliter la reproductibilité
- Soigner l'orthographe et la grammaire

**❌ À éviter** :
- README trop long (> 2 pages)
- Jargon sans explication
- Pas de contexte sur le projet
- Liens morts
- Code sans documentation

---

## 🎨 Partie 3 : Présentation sur GitHub

### Profil GitHub professionnel

#### 1. Photo et bio
```
🎓 Data Scientist | Python | Machine Learning
📊 Passionné par l'analyse de données et la visualisation
🌍 Paris, France
📫 contact@email.com
```

#### 2. README de profil (optionnel mais recommandé)
Créer un repo `username/username` avec un README.md :

```markdown
# Salut, je suis [Votre Nom] 👋

## 🔭 Ce sur quoi je travaille
- Analyse prédictive avec scikit-learn
- Visualisation de données avec Plotly
- Projets de NLP avec transformers

## 🌱 Ce que j'apprends actuellement
- Deep Learning avec PyTorch
- MLOps et déploiement de modèles
- SQL avancé pour Big Data

## 💼 Projets récents
[![Projet 1](https://github-readme-stats.vercel.app/api/pin/?username=username&repo=projet1)](https://github.com/username/projet1)

## 📊 Statistiques GitHub
![Stats](https://github-readme-stats.vercel.app/api?username=username&show_icons=true&theme=radical)

## 🛠️ Compétences techniques
![Python](https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/-Pandas-150458?style=flat-square&logo=pandas&logoColor=white)
![Scikit-learn](https://img.shields.io/badge/-Scikit--learn-F7931E?style=flat-square&logo=scikit-learn&logoColor=white)

## 📫 Contact
- LinkedIn : [lien]
- Email : [email]
- Portfolio : [lien]
```

#### 3. Épingler vos meilleurs projets
- Sélectionnez 6 projets maximum
- Variez les types (ML, EDA, viz, etc.)
- Mettez à jour régulièrement

#### 4. Contributions
- Contribuez à des projets open-source
- Répondez aux issues
- Participez aux discussions

---

## 💡 Partie 4 : Documenter un projet data

### Documentation du code

#### Docstrings Python (Google Style)
```python
def prepare_titanic_data(df, impute_age=True):
    """
    Nettoie et prépare le dataset Titanic pour la modélisation.
    
    Args:
        df (pd.DataFrame): Dataset Titanic brut
        impute_age (bool): Si True, impute les âges manquants
        
    Returns:
        pd.DataFrame: Dataset nettoyé et avec features engineering
        
    Example:
        >>> df_raw = pd.read_csv('titanic.csv')
        >>> df_clean = prepare_titanic_data(df_raw)
        >>> print(df_clean.shape)
        (891, 15)
        
    Notes:
        - Impute Age avec médiane par groupe (Pclass, Sex)
        - Crée FamilySize = SibSp + Parch + 1
        - Encode les variables catégorielles
    """
    df_clean = df.copy()
    
    if impute_age:
        df_clean['Age'] = df_clean.groupby(['Pclass', 'Sex'])['Age'].transform(
            lambda x: x.fillna(x.median())
        )
    
    df_clean['FamilySize'] = df_clean['SibSp'] + df_clean['Parch'] + 1
    
    return df_clean
```

#### Commentaires dans les notebooks
```python
# =============================================================================
# 1. DATA LOADING AND INITIAL EXPLORATION
# =============================================================================
# Objectif : Charger les données et effectuer une première exploration

# Charger le dataset
df = pd.read_csv('data/titanic.csv')

# Vérifier la forme et les types
print(f"Dataset : {df.shape[0]} lignes, {df.shape[1]} colonnes")
df.info()

# =============================================================================
# 2. DATA CLEANING
# =============================================================================
# Objectif : Traiter les valeurs manquantes et les outliers

# 2.1. Valeurs manquantes
missing = df.isnull().sum()
print(f"Colonnes avec valeurs manquantes : {missing[missing > 0]}")

# 2.2. Imputation de l'âge
# Stratégie : Médiane par groupe (Pclass + Sex)
# Justification : L'âge varie selon la classe sociale et le sexe
df['Age'] = df.groupby(['Pclass', 'Sex'])['Age'].transform(
    lambda x: x.fillna(x.median())
)
```

### Versioning sémantique

Pour vos modèles et pipelines :

```
v1.0.0 → v1.1.0 → v2.0.0
 │  │  │    │  │      │
 │  │  │    │  │      └─ Breaking changes (API modifiée)
 │  │  │    │  └─ Nouvelles features (rétrocompatible)
 │  │  │    └─ Patch/bugfix
 │  │  └─ Patch
 │  └─ Minor
 └─ Major
```

### Changelog
```markdown
# Changelog

## [1.2.0] - 2024-01-20
### Added
- Ajout de feature engineering : Title extraction
- Nouveau modèle XGBoost avec hyperparameter tuning

### Changed
- Amélioration de l'imputation d'âge (par groupe)
- Mise à jour de la visualisation des résultats

### Fixed
- Correction du bug dans le calcul de FamilySize

## [1.1.0] - 2024-01-15
### Added
- Première version du pipeline de preprocessing
- Modèle Random Forest baseline
```

---

## 🎯 Partie 5 : Se démarquer

### Conseils pour impressionner les recruteurs

#### 1. Montrer le processus, pas juste le résultat
- Expliquez vos choix méthodologiques
- Documentez les échecs et ce que vous avez appris
- Montrez les itérations et améliorations

#### 2. Qualité > Quantité
- 3 projets excellents > 20 projets moyens
- Code propre et documenté
- Notebooks bien structurés avec storytelling

#### 3. Prouver l'impact métier
- Parlez en termes de valeur business
- Quantifiez les résultats : "Amélioration de 15% du chiffre d'affaires"
- Reliez les métriques techniques aux objectifs métier

#### 4. Démontrer l'autonomie
- Projets end-to-end : De l'idée au déploiement
- Collecte de données (web scraping, APIs)
- Déploiement (Streamlit, Flask, Docker)

#### 5. Collaboration et communication
- README clairs et complets
- Visualisations commentées
- Contributions open-source
- Articles de blog techniques

### Exemples de projets qui se démarquent

**🌟 Excellent** :
- Titre : "Prédiction du churn clients : Réduction de 25% de l'attrition"
- Dataset personnalisé (web scraping)
- EDA approfondie avec insights métier
- Comparaison de 5+ modèles
- Déploiement avec API Flask
- Dashboard interactif Plotly
- Tests unitaires et CI/CD
- Documentation complète

**⭐ Bon** :
- Titre : "Analyse du Titanic : Facteurs de survie"
- Dataset Kaggle
- Data cleaning bien documenté
- Feature engineering créatif
- Visualisations professionnelles
- Modèle ML avec tuning
- README détaillé

**📝 Basique** :
- Titre : "Titanic"
- Dataset Kaggle
- Notebook unique sans structure
- Code minimal
- Pas de README
- Pas de visualisations

---

## 🛠️ Partie 6 : Outils et ressources

### Plateformes pour héberger votre portfolio

1. **GitHub** (essentiel)
   - Code source
   - Notebooks
   - Documentation

2. **GitHub Pages** (gratuit)
   - Site web statique
   - Portfolio visuel
   - Blog technique

3. **Kaggle** (compétitions et datasets)
   - Kernels publics
   - Compétitions pour se challenger
   - Communauté active

4. **Medium / Dev.to** (articles)
   - Expliquer vos projets
   - Tutoriels
   - Partager votre expertise

5. **LinkedIn** (réseau professionnel)
   - Posts sur vos projets
   - Articles longs
   - Networking

### Outils pour améliorer votre portfolio

**Documentation** :
- MkDocs : Documentation statique
- Sphinx : Documentation Python automatique
- Jupyter Book : Notebooks en livre

**Déploiement** :
- Streamlit : Apps interactives en Python
- Flask / FastAPI : APIs REST
- Heroku / Railway : Hébergement gratuit

**Visualisation** :
- Plotly : Graphiques interactifs
- Tableau Public : Dashboards
- DataPane : Rapports interactifs

**Qualité du code** :
- Black : Formateur de code
- Pylint / Flake8 : Linters
- pytest : Tests unitaires

---

## 📊 Partie 7 : Exemples de portfolios inspirants

### Portfolios data science de référence

1. **Chris Albon** (https://chrisalbon.com)
   - Notes techniques concises
   - Snippets de code réutilisables
   - Design épuré

2. **Kaggle Grandmasters**
   - Notebooks publics bien documentés
   - Solutions de compétitions expliquées
   - Code reproductible

3. **Towards Data Science** (auteurs réguliers)
   - Articles détaillés sur des projets
   - Vulgarisation de concepts complexes
   - Visualisations professionnelles

### Template de portfolio personnel

```
mon-portfolio/
├── index.html              # Page d'accueil
├── projets/
│   ├── titanic/
│   │   ├── index.html
│   │   ├── notebook.html
│   │   └── images/
│   ├── nlp-sentiment/
│   └── time-series/
├── blog/
│   ├── article1.html
│   └── article2.html
├── about.html              # À propos
├── contact.html            # Contact
└── assets/
    ├── css/
    ├── js/
    └── images/
```

---

## ✅ Checklist portfolio data science

### Avant de publier un projet

- [ ] README complet et clair
- [ ] Code commenté et structuré
- [ ] Notebooks avec storytelling
- [ ] Visualisations de qualité
- [ ] requirements.txt à jour
- [ ] .gitignore configuré
- [ ] Licence ajoutée
- [ ] Résultats quantifiés
- [ ] Liens fonctionnels
- [ ] Orthographe vérifiée

### Profil GitHub

- [ ] Photo professionnelle
- [ ] Bio descriptive
- [ ] Email de contact
- [ ] LinkedIn lié
- [ ] README de profil
- [ ] 4-6 projets épinglés
- [ ] Projets récents (< 6 mois)
- [ ] Commits réguliers

### Présence en ligne

- [ ] Portfolio web (optionnel)
- [ ] LinkedIn à jour
- [ ] 1-2 articles techniques (optionnel)
- [ ] Profil Kaggle (pour ML)
- [ ] Stack Overflow (contributions)

---

## 🚀 Plan d'action

### Semaine 1-2 : Fondations
1. Créer/nettoyer votre profil GitHub
2. Sélectionner 2-3 projets existants à améliorer
3. Rédiger un README détaillé pour chaque projet

### Semaine 3-4 : Développement
1. Structurer correctement vos projets
2. Ajouter de la documentation
3. Créer des visualisations professionnelles
4. Ajouter des tests et validation

### Semaine 5-6 : Présentation
1. Créer un README de profil GitHub
2. Épingler vos meilleurs projets
3. Rédiger 1 article technique (optionnel)
4. Mettre à jour LinkedIn

### Entretien continu
- Ajouter 1 nouveau projet tous les 2-3 mois
- Mettre à jour les projets existants
- Contribuer à l'open-source
- Partager votre travail (LinkedIn, Twitter)

---

## 🔑 Points clés à retenir

1. **Qualité avant quantité** : 3 excellents projets > 20 moyens
2. **Documentation** : Un projet sans README n'existe pas
3. **Storytelling** : Racontez l'histoire de vos données
4. **Impact métier** : Montrez la valeur business
5. **Code propre** : Structuré, commenté, testé
6. **Régularité** : Commits fréquents, projets récents
7. **Communication** : Expliquez clairement vos choix
8. **Amélioration continue** : Mettez à jour vos projets

---

## 📖 Ressources complémentaires

### Guides
- [GitHub README Guide](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
- [Data Science Portfolio Guide](https://www.dataquest.io/blog/career-guide-data-science-projects-portfolio/)
- [How to Build a Data Science Portfolio](https://towardsdatascience.com/how-to-build-a-data-science-portfolio-5f566517c79c)

### Inspiration
- [Awesome Data Science](https://github.com/academic/awesome-datascience)
- [Awesome Machine Learning](https://github.com/josephmisiti/awesome-machine-learning)
- [Best of ML Python](https://github.com/ml-tooling/best-of-ml-python)

### Outils
- [Shields.io](https://shields.io/) - Badges pour README
- [GitHub Stats](https://github.com/anuraghazra/github-readme-stats) - Statistiques
- [Awesome README](https://github.com/matiassingers/awesome-readme) - Exemples

---

**Bonne chance pour la construction de votre portfolio ! 🚀**
