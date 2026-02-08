# 📖 Guide d'Utilisation des Projets d'Analyse

## 🚀 Démarrage Rapide

### 1. Installation des Dépendances

```bash
# Depuis la racine du projet
pip install -r requirements.txt

# Ou installer uniquement les packages essentiels
pip install pandas numpy matplotlib seaborn plotly scikit-learn jupyter
```

### 2. Accéder aux Projets

```bash
cd projetcs/cliniques/projets/
```

---

## 📊 Utilisation des Notebooks

### Ouvrir un Notebook

```bash
# Exemple pour le Projet 2
cd 02-etude-marche-ia
jupyter notebook notebook_analyse.ipynb
```

### Exécuter le Notebook

1. **Méthode 1**: Bouton "Run All" dans Jupyter
2. **Méthode 2**: Cellule par cellule (Shift + Enter)
3. **Méthode 3**: Ligne de commande
   ```bash
   jupyter nbconvert --to notebook --execute notebook_analyse.ipynb
   ```

### Chemins des Données

Tous les notebooks utilisent le chemin relatif:
```python
df = pd.read_csv('../../donnees_cliniques_nettoyees.csv')
```

Assurez-vous que le fichier `donnees_cliniques_nettoyees.csv` est bien dans:
```
projetcs/cliniques/donnees_cliniques_nettoyees.csv
```

---

## 🎯 Utiliser le Moteur de Recommandation

### Import du Module

```python
# Depuis le dossier 05-systeme-recommandation
from recommendation_engine import ClinicRecommendationEngine

# Créer l'instance
engine = ClinicRecommendationEngine()
```

### Exemple 1: Recommandations pour une Clinique

```python
# Définir les données de la clinique
clinic_data = {
    'number_of_beds': 30,
    'number_of_healthcare_staff': 20,
    'has_informatic_management_system': False,
    'has_dedicated_digital_budget': True
}

# Obtenir les recommandations
recommendations = engine.recommend(clinic_data, top_n=5)

# Afficher
for reco in recommendations:
    print(f"{reco['solution']} - Score: {reco['score']}/100")
```

### Exemple 2: Bundle selon Budget

```python
# Recommander un bundle selon le budget disponible
bundle = engine.recommend_bundle(clinic_data, budget_max=200_000)

print(f"Solutions: {bundle['count']}")
print(f"Coût total: {bundle['total_monthly_cost']:,} FCFA/mois")

for solution in bundle['solutions']:
    print(f"  - {solution['solution']}")
```

### Exemple 3: Rapport Complet

```python
# Générer un rapport formaté
report = engine.generate_report("Ma Clinique", clinic_data)
print(report)
```

---

## 📁 Structure des Dossiers

### Après Exécution des Notebooks

```
02-etude-marche-ia/
├── README.md
├── notebook_analyse.ipynb
├── data/
│   ├── benefices_ia.csv           ← Généré par le notebook
│   ├── obstacles_ia.csv           ← Généré par le notebook
│   └── cliniques_score_ia.csv     ← Généré par le notebook
└── reports/
    ├── interet_ia.png             ← Généré par le notebook
    ├── benefices_ia.html          ← Généré par le notebook
    └── obstacles_ia.html          ← Généré par le notebook
```

---

## 🔍 Parcourir les Projets

### Projet 1: Dashboard Maturité Digitale
**Quand l'utiliser**: Évaluer le niveau digital d'une clinique
```bash
cd projets/01-dashboard-maturite-digitale
jupyter notebook notebook_analyse.ipynb
```

### Projet 2: Étude de Marché IA
**Quand l'utiliser**: Comprendre le potentiel de marché IA
```bash
cd projets/02-etude-marche-ia
jupyter notebook notebook_analyse.ipynb
```

### Projet 3: Analyse Automatisation
**Quand l'utiliser**: Identifier les processus à automatiser
```bash
cd projets/03-analyse-automatisation
jupyter notebook notebook_analyse.ipynb
```

### Projet 4: Stratégie Communication
**Quand l'utiliser**: Optimiser la communication digitale
```bash
cd projets/04-strategie-communication
jupyter notebook notebook_analyse.ipynb
```

### Projet 5: Système de Recommandation
**Quand l'utiliser**: Recommander des solutions adaptées
```bash
cd projets/05-systeme-recommandation

# Option 1: Notebook
jupyter notebook notebook_analyse.ipynb

# Option 2: Script Python
python recommendation_engine.py
```

### Projet 6: Analyse Coût-Bénéfice
**Quand l'utiliser**: Calculer le ROI d'une solution
```bash
cd projets/06-analyse-cout-benefice
jupyter notebook notebook_analyse.ipynb
```

---

## 🛠️ Personnalisation

### Modifier les Paramètres d'une Analyse

Dans chaque notebook, vous pouvez modifier:

```python
# Exemple: Changer le nombre de clusters
kmeans = KMeans(n_clusters=5, random_state=42)  # Au lieu de 4

# Exemple: Ajuster les prix
pricing = {
    'Early Adopters': 800_000,  # Au lieu de 750_000
    'Pragmatiques': 250_000,
    'Conservateurs': 100_000
}

# Exemple: Modifier les seuils de segmentation
def segment_ia(score):
    if score >= 75:  # Au lieu de 70
        return 'Early Adopters'
    # ...
```

### Ajouter de Nouvelles Visualisations

```python
# Ajouter un graphique personnalisé
import plotly.express as px

fig = px.scatter(df, x='number_of_beds', y='ia_score',
                 color='segment_ia', size='number_of_healthcare_staff',
                 title='Mon Graphique Personnalisé')
fig.show()
fig.write_html('reports/mon_graphique.html')
```

---

## 📊 Exporter les Résultats

### CSV
```python
# Tous les notebooks exportent automatiquement en CSV
df_results.to_csv('data/mes_resultats.csv', index=False)
```

### Images
```python
# Sauvegarder un graphique matplotlib
plt.savefig('reports/mon_graphique.png', dpi=300, bbox_inches='tight')

# Sauvegarder un graphique plotly
fig.write_html('reports/mon_graphique.html')
fig.write_image('reports/mon_graphique.png')  # Nécessite kaleido
```

### Excel
```python
# Si vous préférez Excel
df_results.to_excel('data/mes_resultats.xlsx', index=False, sheet_name='Résultats')
```

---

## 🐛 Dépannage

### Problème: Module non trouvé

```bash
# Solution
pip install nom_du_module

# Exemple
pip install pandas numpy matplotlib
```

### Problème: Fichier de données introuvable

```python
# Vérifier le chemin
import os
print(os.path.abspath('../../donnees_cliniques_nettoyees.csv'))

# Ou utiliser un chemin absolu
df = pd.read_csv('/chemin/complet/vers/donnees_cliniques_nettoyees.csv')
```

### Problème: Erreur de visualisation Plotly

```bash
# Installer les dépendances de visualisation
pip install plotly kaleido
```

### Problème: Notebook ne s'ouvre pas

```bash
# Réinstaller Jupyter
pip install --upgrade jupyter notebook

# Lancer Jupyter
jupyter notebook
```

---

## 💡 Bonnes Pratiques

### 1. Toujours Sauvegarder

Avant de modifier un notebook:
```bash
cp notebook_analyse.ipynb notebook_analyse_backup.ipynb
```

### 2. Exécuter Cellule par Cellule

Pour comprendre chaque étape, exécutez cellule par cellule au lieu de "Run All".

### 3. Commenter vos Modifications

```python
# Ma modification - Abraham, 08/02/2025
# Changé le nombre de clusters pour mieux segmenter
kmeans = KMeans(n_clusters=5)
```

### 4. Versionner vos Résultats

```bash
git add .
git commit -m "Ajout des résultats d'analyse pour février 2025"
```

---

## 📚 Ressources Complémentaires

### Documentation
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [Matplotlib Documentation](https://matplotlib.org/stable/contents.html)
- [Plotly Documentation](https://plotly.com/python/)
- [Scikit-learn Documentation](https://scikit-learn.org/stable/)

### Tutoriels
- [Jupyter Notebook Basics](https://jupyter-notebook.readthedocs.io/)
- [Pandas Cheat Sheet](https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf)

---

## 🆘 Support

En cas de problème:
1. Consulter le README de chaque projet
2. Vérifier les logs d'erreur
3. Rechercher l'erreur sur Stack Overflow
4. Contacter l'équipe de développement

---

## ✅ Checklist de Démarrage

- [ ] Installer Python 3.8+
- [ ] Installer les dépendances (`pip install -r requirements.txt`)
- [ ] Vérifier la présence du fichier de données
- [ ] Lancer Jupyter Notebook
- [ ] Ouvrir un notebook test
- [ ] Exécuter "Run All"
- [ ] Vérifier les exports dans data/ et reports/

---

**Bon travail d'analyse ! 📊✨**
