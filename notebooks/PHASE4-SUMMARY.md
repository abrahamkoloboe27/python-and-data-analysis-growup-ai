# Phase 4 - Data Analysis & EDA (Sessions 14-18)

## 📚 Vue d'ensemble

Cette phase couvre l'analyse de données avec NumPy, pandas, et la visualisation, en utilisant le célèbre dataset Titanic comme cas pratique.

---

## 📂 Contenu créé

### Session 14 - NumPy & pandas Introduction
**Fichiers** :
- `notebooks/S14-README.md` - Guide complet sur NumPy et pandas
- `notebooks/pandas_s14.ipynb` - Exercices pratiques avec le Titanic
- `data/titanic.csv` - Dataset Titanic téléchargé

**Concepts couverts** :
- Arrays NumPy et opérations vectorisées
- Series et DataFrame pandas
- Indexation (loc vs iloc)
- Filtrage booléen
- Groupby et agrégations
- Analyses descriptives

**Exercices** :
- Manipulation d'arrays NumPy
- Création et manipulation de DataFrames
- Analyse du Titanic : taux de survie, âges, prix, etc.
- Questions métier avec groupby

---

### Session 15 - Data Cleaning
**Fichiers** :
- `notebooks/S15-README.md` - Guide complet du nettoyage de données
- `notebooks/cleaning_s15.ipynb` - Nettoyage du Titanic pas à pas
- `data/titanic_clean.csv` - Dataset nettoyé (généré par le notebook)

**Concepts couverts** :
- Diagnostic des données (valeurs manquantes, doublons, outliers)
- Stratégies d'imputation
- Détection et traitement des outliers
- Feature engineering
- Encodage des variables catégorielles
- Normalisation et standardisation

**Features créées** :
- `FamilySize` - Taille de la famille
- `IsAlone` - Indicateur de voyage seul
- `FamilyCategory` - Catégorie de taille de famille
- `Title` - Titre extrait du nom (Mr, Mrs, Miss, etc.)
- `AgeGroup` - Catégories d'âge
- `FareCategory` - Catégories de prix
- `WomanOrChild` - Indicateur femme ou enfant
- `UpperClass` - Indicateur classe supérieure
- `HasCabin` - Indicateur de cabine connue

---

### Session 16 - Deep EDA & Visualizations
**Fichiers** :
- `notebooks/S16-README.md` - Guide EDA et visualisations
- `notebooks/eda_titanic.ipynb` - EDA complète du Titanic

**Concepts couverts** :
- Processus d'EDA
- Bibliothèques : matplotlib, seaborn
- Types de visualisations (histogrammes, boxplots, heatmaps, etc.)
- Analyses statistiques
- Tests statistiques (t-test, chi2, corrélations)
- Questions métier complexes

**Visualisations créées** :
- Distributions d'âge et prix
- Taux de survie par classe et sexe
- Heatmap de corrélations
- Boxplots et violin plots
- Analyses multidimensionnelles

**Insights clés** :
1. Sexe : Facteur le plus important (femmes 74% vs hommes 19%)
2. Classe : Impact majeur (1ère 63%, 2ème 47%, 3ème 24%)
3. Âge : Enfants prioritaires
4. Famille : Effet non-linéaire (2-4 personnes optimal)
5. Prix : Corrélé à la survie

---

### Session 17 - Advanced Visualization & Storytelling
**Fichiers** :
- `notebooks/S17-README.md` - Guide Plotly et storytelling
- `notebooks/visualization_s17.ipynb` - 3 visualisations interactives
- `notebooks/readme_viz.md` - Template d'explication des insights

**Concepts couverts** :
- Plotly Express et Graph Objects
- Visualisations interactives
- Storytelling avec les données
- Principes de design
- Export HTML et images

**Visualisations interactives** :
1. **Heatmap** - Taux de survie par classe et sexe
2. **Violin plot** - Distribution d'âge avec survie
3. **Bubble chart** - Analyse multidimensionnelle
4. **Dashboard** - Vue d'ensemble complète

**Fichiers HTML générés** :
- `viz1_survival_heatmap.html`
- `viz2_age_distribution.html`
- `viz3_multidimensional_analysis.html`
- `dashboard_titanic.html`

---

### Session 18 - Portfolio Structure (Optionnel)
**Fichiers** :
- `notebooks/S18-README.md` - Guide du portfolio data science

**Concepts couverts** :
- Structure d'un projet portfolio
- Écrire un excellent README
- Présentation sur GitHub
- Documentation du code
- Bonnes pratiques
- Se démarquer auprès des recruteurs

**Templates fournis** :
- Structure de projet type
- README parfait
- Profile GitHub
- Checklist portfolio

---

## 🛠️ Technologies et bibliothèques

### Ajoutées à requirements.txt
```
# Analyse de données
pandas>=2.0.0
numpy>=1.24.0
scipy>=1.10.0

# Visualisation
matplotlib>=3.7.0
seaborn>=0.12.0
plotly>=5.14.0
kaleido>=0.2.1
```

---

## 🚀 Comment utiliser ces matériaux

### Installation des dépendances
```bash
pip install -r requirements.txt
```

### Parcours recommandé

**Session 14** - Introduction (2-3 heures)
1. Lire `S14-README.md` pour la théorie
2. Ouvrir et exécuter `pandas_s14.ipynb`
3. Pratiquer avec les exercices

**Session 15** - Nettoyage (2-3 heures)
1. Lire `S15-README.md` pour les techniques
2. Exécuter `cleaning_s15.ipynb` cellule par cellule
3. Comprendre chaque décision de nettoyage
4. Générer `titanic_clean.csv`

**Session 16** - EDA (2-3 heures)
1. Lire `S16-README.md` pour les concepts
2. Exécuter `eda_titanic.ipynb`
3. Analyser les visualisations
4. Noter les insights découverts

**Session 17** - Visualisation avancée (2-3 heures)
1. Lire `S17-README.md` pour Plotly
2. Exécuter `visualization_s17.ipynb`
3. Explorer les graphiques interactifs HTML
4. Lire `readme_viz.md` pour les insights

**Session 18** - Portfolio (1-2 heures)
1. Lire `S18-README.md`
2. Planifier votre portfolio
3. Appliquer les bonnes pratiques

---

## 📊 Dataset Titanic

### Source
Dataset téléchargé depuis : https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv

### Description
- **891 passagers** du Titanic
- **12 colonnes** : PassengerId, Survived, Pclass, Name, Sex, Age, SibSp, Parch, Ticket, Fare, Cabin, Embarked

### Colonnes
| Colonne | Type | Description |
|---------|------|-------------|
| PassengerId | int | ID unique |
| Survived | int | 0 = Non, 1 = Oui |
| Pclass | int | Classe (1, 2, 3) |
| Name | str | Nom complet |
| Sex | str | male/female |
| Age | float | Âge en années |
| SibSp | int | Frères/sœurs/conjoints |
| Parch | int | Parents/enfants |
| Ticket | str | Numéro de billet |
| Fare | float | Prix du billet |
| Cabin | str | Numéro de cabine |
| Embarked | str | Port (C/Q/S) |

---

## 🎯 Objectifs pédagogiques atteints

### Compétences techniques
✅ Manipulation de données avec pandas  
✅ Calculs vectorisés avec NumPy  
✅ Nettoyage et préparation de données  
✅ Feature engineering  
✅ Analyse exploratoire (EDA)  
✅ Visualisation avec matplotlib/seaborn  
✅ Visualisations interactives avec Plotly  
✅ Storytelling avec les données  
✅ Documentation de projets  

### Compétences métier
✅ Poser les bonnes questions  
✅ Interpréter des résultats  
✅ Communiquer des insights  
✅ Prendre des décisions data-driven  

---

## 📈 Prochaines étapes

Après cette phase, les apprenants peuvent :

1. **Approfondir le Machine Learning**
   - Classification supervisée (Logistic Regression, Random Forest, XGBoost)
   - Validation croisée et tuning d'hyperparamètres
   - Métriques de performance (accuracy, precision, recall, F1)

2. **Explorer d'autres datasets**
   - Kaggle competitions
   - UCI Machine Learning Repository
   - Data.gouv.fr

3. **Construire un portfolio**
   - Appliquer les conseils de S18
   - Publier sur GitHub
   - Créer 2-3 projets de qualité

4. **Déployer des modèles**
   - Streamlit pour des apps interactives
   - Flask/FastAPI pour des APIs
   - Docker pour la containerisation

---

## 🔗 Ressources complémentaires

### Documentation officielle
- [NumPy](https://numpy.org/doc/)
- [pandas](https://pandas.pydata.org/docs/)
- [matplotlib](https://matplotlib.org/)
- [seaborn](https://seaborn.pydata.org/)
- [Plotly](https://plotly.com/python/)

### Tutoriels
- [10 minutes to pandas](https://pandas.pydata.org/docs/user_guide/10min.html)
- [Kaggle Learn](https://www.kaggle.com/learn)
- [DataCamp](https://www.datacamp.com/)

### Livres recommandés
- **Python for Data Analysis** - Wes McKinney
- **Hands-On Machine Learning** - Aurélien Géron
- **Storytelling with Data** - Cole Nussbaumer Knaflic

---

## ✅ Checklist d'apprentissage

### Session 14
- [ ] Comprendre les arrays NumPy
- [ ] Maîtriser Series et DataFrame
- [ ] Utiliser loc et iloc
- [ ] Effectuer des groupby
- [ ] Charger et explorer le Titanic

### Session 15
- [ ] Diagnostiquer les problèmes de données
- [ ] Imputer les valeurs manquantes
- [ ] Traiter les outliers
- [ ] Créer de nouvelles features
- [ ] Exporter des données propres

### Session 16
- [ ] Créer des visualisations matplotlib/seaborn
- [ ] Analyser les corrélations
- [ ] Effectuer des tests statistiques
- [ ] Répondre à des questions métier
- [ ] Identifier des insights

### Session 17
- [ ] Créer des graphiques Plotly
- [ ] Rendre les visualisations interactives
- [ ] Appliquer le storytelling
- [ ] Exporter en HTML
- [ ] Concevoir un dashboard

### Session 18
- [ ] Structurer un projet portfolio
- [ ] Rédiger un README professionnel
- [ ] Optimiser son profil GitHub
- [ ] Documenter son code
- [ ] Planifier son portfolio

---

**Créé le** : 22 Janvier 2024  
**Auteur** : Équipe pédagogique GrowUp AI  
**Phase** : 4 - Data Analysis & EDA  
**Sessions** : 14-18
