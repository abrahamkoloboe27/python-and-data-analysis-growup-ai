# 📖 Guide d'Utilisation - Portfolio d'Analyses Cliniques

## 🎯 Bienvenue!

Ce guide vous aidera à naviguer et utiliser efficacement les 6 projets d'analyse de données des cliniques privées en Côte d'Ivoire.

---

## 🚀 Démarrage Rapide

### Étape 1: Installation des Dépendances

```bash
# Se placer dans le répertoire du projet
cd /home/runner/work/python-and-data-analysis-growup-ai/python-and-data-analysis-growup-ai/projetcs/cliniques

# Installer les dépendances
pip install pandas numpy matplotlib seaborn plotly scikit-learn jupyter streamlit openpyxl
```

### Étape 2: Vérifier les Données

```bash
# Vérifier que les données sont présentes
ls -lh donnees_cliniques_nettoyees.csv

# Aperçu des données
head -5 donnees_cliniques_nettoyees.csv
```

### Étape 3: Choisir un Projet

Consultez le [README des projets](projets/README.md) pour choisir par où commencer.

**Recommandé pour débuter**: Projet 1 - Dashboard de Maturité Digitale

---

## 📚 Utilisation par Profil

### 👨‍💼 Pour les Décideurs / Business

**Objectif**: Comprendre rapidement les insights et opportunités

#### Parcours Recommandé:
1. **Lire les READMEs** de chaque projet (5-10 min chacun)
2. **Consulter le [SUMMARY.md](projets/SUMMARY.md)** pour une vue synthétique
3. **Voir les visualisations** dans les notebooks (sans exécuter le code)

#### Actions Rapides:
```bash
# Ouvrir le résumé global
cat projets/SUMMARY.md

# Lire le README du projet 1
cat projets/01-dashboard-maturite-digitale/README.md
```

#### Points Clés à Retenir:
- ✅ 6 opportunités de marché identifiées
- ✅ ROI moyen de 150-200% sur 12 mois
- ✅ 75%+ des cliniques intéressées par l'IA
- ✅ Budget d'entrée: 500K-1M FCFA

---

### 👨‍💻 Pour les Data Scientists / Analystes

**Objectif**: Reproduire, adapter et étendre les analyses

#### Parcours Recommandé:
1. **Comprendre la structure** des données
2. **Exécuter les notebooks** dans l'ordre
3. **Adapter les analyses** à vos besoins
4. **Créer de nouvelles analyses**

#### Workflow Type:

##### 1. Explorer les Données
```bash
# Lancer Jupyter
jupyter notebook

# Ouvrir un notebook pour exploration
# Exemple: projets/01-dashboard-maturite-digitale/notebook_analyse.ipynb
```

##### 2. Exécuter un Notebook
```python
# Dans Jupyter, exécuter cellule par cellule
# OU exécuter tout le notebook: Cell > Run All

# Vérifier les résultats dans les dossiers data/ et reports/
```

##### 3. Adapter une Analyse
```python
# Exemple: modifier les poids du scoring de maturité
weights = {
    'has_informatic_management_system': 30,  # Augmenté de 25 à 30
    'uses_website': 15,                      # Réduit de 20 à 15
    # ... etc
}
```

##### 4. Créer une Nouvelle Analyse
```python
# Utiliser les fonctions existantes
import pandas as pd
import sys
sys.path.append('projets/01-dashboard-maturite-digitale')
from utils.scoring import calculate_maturity_score

# Créer votre analyse personnalisée
```

#### Fichiers Clés à Connaître:
- `donnees_cliniques_nettoyees.csv` - Données source
- `projets/*/notebook_analyse.ipynb` - Notebooks d'analyse
- `projets/*/utils/*.py` - Fonctions réutilisables (projet 1)
- `projets/05-systeme-recommandation/recommendation_engine.py` - Moteur ML

---

### 👨‍💼 Pour les Développeurs / Intégrateurs

**Objectif**: Intégrer les analyses dans des applications

#### Parcours Recommandé:
1. **Étudier le moteur de recommandation** (projet 5)
2. **Analyser le dashboard Streamlit** (projet 1)
3. **Extraire les fonctions utiles**
4. **Créer des APIs**

#### Exemples d'Intégration:

##### 1. Utiliser le Moteur de Recommandation
```python
from projets.05_systeme_recommandation.recommendation_engine import RecommendationEngine

# Initialiser le moteur
engine = RecommendationEngine('donnees_cliniques_nettoyees.csv')
engine.fit()

# Obtenir des recommandations
recommendations = engine.recommend(
    clinic_name='PISAM',
    top_n=5
)

print(recommendations)
```

##### 2. Créer une API REST (exemple avec Flask)
```python
from flask import Flask, jsonify
from recommendation_engine import RecommendationEngine

app = Flask(__name__)
engine = RecommendationEngine('data.csv')
engine.fit()

@app.route('/api/recommend/<clinic_name>')
def get_recommendations(clinic_name):
    recs = engine.recommend(clinic_name, top_n=5)
    return jsonify(recs.to_dict('records'))

if __name__ == '__main__':
    app.run(debug=True)
```

##### 3. Lancer le Dashboard Interactif
```bash
cd projets/01-dashboard-maturite-digitale
streamlit run dashboard.py
```

#### Architecture Suggérée:
```
Application Web
├── Backend (Python/FastAPI)
│   ├── recommendation_engine.py
│   ├── scoring.py
│   └── analytics.py
├── Frontend (React/Vue)
│   ├── Dashboard
│   ├── Recommandations
│   └── Rapports
└── Base de Données
    └── PostgreSQL/MongoDB
```

---

## 📁 Guide par Projet

### Projet 1: Dashboard de Maturité Digitale

**Quand l'utiliser**: Pour évaluer rapidement le niveau digital d'une clinique

```bash
cd projets/01-dashboard-maturite-digitale

# Voir le README
cat README.md

# Lancer le notebook
jupyter notebook notebook_analyse.ipynb

# Lancer le dashboard
streamlit run dashboard.py
```

**Résultats générés**:
- `data/scores_maturite.csv` - Scores de toutes les cliniques
- `reports/recommandations_par_clinique.csv` - Recommandations détaillées

---

### Projet 2: Étude de Marché IA

**Quand l'utiliser**: Pour préparer une offre commerciale IA

```bash
cd projets/02-etude-marche-ia
jupyter notebook notebook_analyse.ipynb
```

**Insights clés**:
- Segmentation du marché (Early Adopters, Pragmatiques, Conservateurs)
- Barrières à l'adoption et comment les surmonter
- Stratégie de pricing et de go-to-market

---

### Projet 3: Analyse Automatisation

**Quand l'utiliser**: Pour prioriser les développements de solutions

```bash
cd projets/03-analyse-automatisation
jupyter notebook notebook_analyse.ipynb
```

**Livrables**:
- Matrice Effort vs Impact
- Roadmap d'implémentation sur 18 mois
- Estimation des gains de productivité

---

### Projet 4: Stratégie Communication

**Quand l'utiliser**: Pour auditer la présence digitale d'une clinique

```bash
cd projets/04-strategie-communication
jupyter notebook notebook_analyse.ipynb
```

**Résultats**:
- Audit de la présence digitale actuelle
- Recommandations de contenu par canal
- Plan éditorial type

---

### Projet 5: Système de Recommandation

**Quand l'utiliser**: Pour matcher cliniques et solutions automatiquement

```bash
cd projets/05-systeme-recommandation

# Tester le moteur
python recommendation_engine.py

# Ou dans un notebook
jupyter notebook notebook_analyse.ipynb
```

**Fonctionnalités**:
- Clustering automatique des cliniques
- Calcul de scores de pertinence
- Recommandations personnalisées
- API utilisable en production

---

### Projet 6: Analyse Coût-Bénéfice

**Quand l'utiliser**: Pour justifier un investissement digital

```bash
cd projets/06-analyse-cout-benefice
jupyter notebook notebook_analyse.ipynb
```

**Outputs**:
- Modèle financier par scénario
- Calculs de ROI détaillés
- Période de payback
- Gains annuels estimés

---

## 🔧 Personnalisation et Extension

### Ajouter de Nouvelles Données

```python
import pandas as pd

# Charger les données existantes
df = pd.read_csv('donnees_cliniques_nettoyees.csv')

# Ajouter de nouvelles lignes (cliniques)
new_clinic = {
    'clinic_name': 'Nouvelle Clinique',
    'location': 'Abidjan',
    'number_of_beds': 20,
    # ... autres colonnes
}
df = df.append(new_clinic, ignore_index=True)

# Sauvegarder
df.to_csv('donnees_cliniques_nettoyees.csv', index=False)
```

### Modifier les Critères de Scoring

```python
# Dans projets/01-dashboard-maturite-digitale/notebook_analyse.ipynb

# Modifier les poids selon vos priorités
weights = {
    'has_informatic_management_system': 30,  # Plus important
    'uses_website': 25,
    'uses_social_media': 15,
    'uses_digital_tools_for_appointments': 15,
    'has_formal_digital_strategy': 10,
    'has_dedicated_digital_team': 3,
    'has_dedicated_digital_budget': 2
}
```

### Créer un Nouveau Projet

```bash
# Créer la structure
mkdir projets/07-mon-nouveau-projet
cd projets/07-mon-nouveau-projet

# Créer les fichiers de base
touch README.md
touch notebook_analyse.ipynb
mkdir data reports

# Suivre la structure des projets existants
```

---

## 🐛 Dépannage

### Problème: Module non trouvé

```bash
# Solution: Vérifier l'installation
pip list | grep pandas

# Réinstaller si nécessaire
pip install --upgrade pandas numpy matplotlib seaborn plotly
```

### Problème: Erreur de chemin vers les données

```python
# Dans les notebooks, vérifier le chemin relatif
df = pd.read_csv('../../donnees_cliniques_nettoyees.csv')  # Correct

# Ou utiliser un chemin absolu
import os
base_path = '/home/runner/work/python-and-data-analysis-growup-ai/python-and-data-analysis-growup-ai/projetcs/cliniques'
df = pd.read_csv(os.path.join(base_path, 'donnees_cliniques_nettoyees.csv'))
```

### Problème: Visualisations ne s'affichent pas

```python
# Pour Jupyter Notebook
%matplotlib inline

# Pour Plotly
import plotly.io as pio
pio.renderers.default = 'notebook'
```

---

## 📊 Exports et Rapports

### Exporter les Résultats en Excel

```python
import pandas as pd

# Charger les résultats
df = pd.read_csv('data/scores_maturite.csv')

# Exporter en Excel
df.to_excel('rapport_maturite.xlsx', index=False, sheet_name='Scores')
```

### Créer un Rapport PDF

```bash
# Installer nbconvert
pip install nbconvert

# Convertir un notebook en PDF
jupyter nbconvert --to pdf notebook_analyse.ipynb
```

### Générer des Graphiques Statiques

```python
# Dans un notebook
import plotly.io as pio

# Sauvegarder un graphique Plotly
fig.write_image('graphique.png', width=1200, height=800)
```

---

## 🎓 Ressources Complémentaires

### Documentation
- [README Principal](README.md)
- [Document d'Idées](PROJECT_IDEAS.md)
- [Synthèse des Projets](projets/SUMMARY.md)

### Tutoriels Recommandés
- **Pandas**: https://pandas.pydata.org/docs/user_guide/
- **Plotly**: https://plotly.com/python/
- **Scikit-learn**: https://scikit-learn.org/stable/tutorial/
- **Streamlit**: https://docs.streamlit.io/

### Datasets Similaires
- Enquêtes sanitaires nationales
- Données hospitalières publiques
- Benchmarks sectoriels internationaux

---

## 🤝 Support et Contributions

### Obtenir de l'Aide
1. Consulter ce guide
2. Lire les READMEs spécifiques
3. Examiner les exemples de code
4. Ouvrir une issue sur GitHub

### Contribuer
1. Fork le repository
2. Créer une branche pour votre feature
3. Commiter vos changements
4. Soumettre une pull request

---

## ✅ Checklist de Démarrage

- [ ] Dépendances installées
- [ ] Données vérifiées
- [ ] Jupyter lancé
- [ ] Projet 1 exploré
- [ ] Notebook exécuté avec succès
- [ ] Résultats compris
- [ ] Adapté à mes besoins
- [ ] Créé mes propres analyses

---

**Bon voyage dans l'analyse des données de santé! 🏥📊**

*Pour toute question, consultez les READMEs spécifiques de chaque projet ou le SUMMARY.md pour une vue d'ensemble.*
