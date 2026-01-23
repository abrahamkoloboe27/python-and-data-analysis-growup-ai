# Session 14 - Introduction à NumPy & pandas

## 🎯 Objectifs de la session
- Maîtriser les bases de NumPy et les arrays multidimensionnels
- Comprendre les structures pandas : Series et DataFrame
- Apprendre l'indexation, le filtrage et les groupements de données
- Effectuer des calculs et analyses simples sur des datasets réels

---

## 📚 Partie 1 : NumPy - La base du calcul scientifique

### Pourquoi NumPy ?
NumPy (Numerical Python) est la bibliothèque fondamentale pour le calcul scientifique en Python :
- **Performance** : 10-100x plus rapide que les listes Python natives
- **Vectorisation** : Opérations sur des tableaux entiers sans boucles
- **Base** : Utilisé par pandas, scikit-learn, TensorFlow, etc.

### Installation et import
```python
# Installation
pip install numpy

# Import conventionnel
import numpy as np
```

### Les Arrays NumPy

#### Création d'arrays
```python
# À partir d'une liste
arr = np.array([1, 2, 3, 4, 5])
print(arr)  # [1 2 3 4 5]

# Array 2D (matrice)
matrix = np.array([[1, 2, 3], 
                   [4, 5, 6]])
print(matrix.shape)  # (2, 3) - 2 lignes, 3 colonnes

# Fonctions de création utiles
zeros = np.zeros((3, 4))        # Matrice de zéros
ones = np.ones((2, 3))          # Matrice de uns
arange = np.arange(0, 10, 2)    # [0, 2, 4, 6, 8]
linspace = np.linspace(0, 1, 5) # 5 valeurs entre 0 et 1
random = np.random.rand(3, 3)   # Valeurs aléatoires [0, 1)
```

#### Attributs importants
```python
arr = np.array([[1, 2, 3], [4, 5, 6]])

arr.shape      # (2, 3) - dimensions
arr.ndim       # 2 - nombre de dimensions
arr.size       # 6 - nombre total d'éléments
arr.dtype      # dtype('int64') - type des données
```

#### Indexation et slicing
```python
arr = np.array([10, 20, 30, 40, 50])

# Indexation simple
arr[0]      # 10
arr[-1]     # 50

# Slicing
arr[1:4]    # [20, 30, 40]
arr[::2]    # [10, 30, 50] - un élément sur deux

# Array 2D
matrix = np.array([[1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9]])

matrix[0, 1]      # 2 - ligne 0, colonne 1
matrix[1, :]      # [4, 5, 6] - toute la ligne 1
matrix[:, 2]      # [3, 6, 9] - toute la colonne 2
matrix[0:2, 1:3]  # [[2, 3], [5, 6]] - sous-matrice
```

#### Opérations vectorisées
```python
arr = np.array([1, 2, 3, 4, 5])

# Opérations arithmétiques (élément par élément)
arr + 10         # [11, 12, 13, 14, 15]
arr * 2          # [2, 4, 6, 8, 10]
arr ** 2         # [1, 4, 9, 16, 25]
np.sqrt(arr)     # [1., 1.41, 1.73, 2., 2.24]

# Opérations entre arrays
arr1 = np.array([1, 2, 3])
arr2 = np.array([10, 20, 30])
arr1 + arr2      # [11, 22, 33]
arr1 * arr2      # [10, 40, 90]

# Fonctions d'agrégation
arr.sum()        # 15
arr.mean()       # 3.0
arr.std()        # 1.41 (écart-type)
arr.min()        # 1
arr.max()        # 5
```

#### Filtrage booléen
```python
arr = np.array([10, 25, 30, 15, 40])

# Condition booléenne
mask = arr > 20
print(mask)          # [False, True, True, False, True]

# Filtrage
arr[arr > 20]        # [25, 30, 40]
arr[(arr > 15) & (arr < 35)]  # [25, 30]
```

---

## 📊 Partie 2 : pandas - L'analyse de données

### Pourquoi pandas ?
pandas est LA bibliothèque pour l'analyse de données en Python :
- **DataFrames** : Tables de données comme Excel/SQL
- **Manipulation facile** : Filtrage, groupement, jointures
- **Gestion des données manquantes**
- **Import/Export** : CSV, Excel, SQL, JSON, etc.

### Installation et import
```python
# Installation
pip install pandas

# Import conventionnel
import pandas as pd
```

### Series - Vecteur de données 1D

Une Series est un array 1D avec un index :

```python
# Création d'une Series
s = pd.Series([10, 20, 30, 40, 50])
print(s)
# 0    10
# 1    20
# 2    30
# 3    40
# 4    50
# dtype: int64

# Series avec index personnalisé
s = pd.Series([10, 20, 30], index=['a', 'b', 'c'])
print(s['b'])  # 20

# À partir d'un dictionnaire
data = {'Paris': 2165000, 'Lyon': 513000, 'Marseille': 869000}
population = pd.Series(data)
print(population['Lyon'])  # 513000

# Opérations sur Series
population * 2               # Double chaque valeur
population[population > 600000]  # Filtrage
population.mean()            # Moyenne
population.sort_values()     # Tri par valeurs
```

### DataFrame - Table de données 2D

Un DataFrame est une table avec lignes et colonnes :

```python
# Création à partir d'un dictionnaire
data = {
    'nom': ['Alice', 'Bob', 'Charlie', 'Diana'],
    'age': [25, 30, 35, 28],
    'ville': ['Paris', 'Lyon', 'Paris', 'Marseille'],
    'salaire': [35000, 42000, 48000, 40000]
}
df = pd.DataFrame(data)
print(df)
#       nom  age      ville  salaire
# 0   Alice   25      Paris    35000
# 1     Bob   30       Lyon    42000
# 2 Charlie   35      Paris    48000
# 3   Diana   28  Marseille    40000
```

#### Exploration basique
```python
# Informations générales
df.shape            # (4, 4) - 4 lignes, 4 colonnes
df.columns          # ['nom', 'age', 'ville', 'salaire']
df.index            # RangeIndex(start=0, stop=4, step=1)
df.dtypes           # Types de chaque colonne
df.info()           # Résumé complet

# Aperçu des données
df.head()           # 5 premières lignes
df.head(2)          # 2 premières lignes
df.tail()           # 5 dernières lignes
df.sample(2)        # 2 lignes aléatoires

# Statistiques descriptives
df.describe()       # Stats sur colonnes numériques
df['age'].mean()    # Âge moyen
df['salaire'].median()  # Salaire médian
```

#### Sélection de colonnes
```python
# Une colonne (retourne une Series)
df['nom']
df.nom              # Notation avec point (si pas d'espace)

# Plusieurs colonnes (retourne un DataFrame)
df[['nom', 'age']]

# Créer une nouvelle colonne
df['salaire_mensuel'] = df['salaire'] / 12
df['senior'] = df['age'] >= 30  # Colonne booléenne
```

#### Indexation : loc et iloc

**iloc** : Indexation par **position** (entiers)
```python
# Une cellule
df.iloc[0, 1]           # Ligne 0, colonne 1 → 25

# Lignes
df.iloc[0]              # Première ligne
df.iloc[1:3]            # Lignes 1 et 2

# Sous-ensemble
df.iloc[0:2, 0:2]       # 2 premières lignes, 2 premières colonnes
df.iloc[:, [0, 2]]      # Toutes lignes, colonnes 0 et 2
```

**loc** : Indexation par **labels** (noms)
```python
# Par nom de colonne
df.loc[0, 'nom']        # 'Alice'

# Lignes et colonnes
df.loc[0:2, 'nom':'ville']  # Lignes 0-2, colonnes nom à ville
df.loc[:, ['nom', 'salaire']]  # Toutes lignes, colonnes spécifiques
```

#### Filtrage (Boolean Indexing)
```python
# Condition simple
df[df['age'] > 28]                  # Personnes de plus de 28 ans

# Conditions multiples (& pour ET, | pour OU)
df[(df['age'] > 25) & (df['ville'] == 'Paris')]
df[(df['age'] < 30) | (df['salaire'] > 45000)]

# Méthode isin()
df[df['ville'].isin(['Paris', 'Lyon'])]

# Filtrage sur chaînes
df[df['nom'].str.startswith('A')]   # Noms commençant par A
df[df['nom'].str.contains('a')]     # Noms contenant 'a'
```

#### Tri
```python
# Tri par une colonne
df.sort_values('age')                      # Ordre croissant
df.sort_values('salaire', ascending=False) # Ordre décroissant

# Tri par plusieurs colonnes
df.sort_values(['ville', 'age'])

# Tri par index
df.sort_index()
```

### Groupement et agrégation

Le **groupby** est essentiel pour les analyses :

```python
# Grouper par une colonne et calculer des statistiques
df.groupby('ville')['salaire'].mean()
# ville
# Lyon         42000.0
# Marseille    40000.0
# Paris        41500.0

# Plusieurs agrégations
df.groupby('ville')['salaire'].agg(['mean', 'min', 'max', 'count'])

# Grouper par plusieurs colonnes
df.groupby(['ville', 'senior'])['salaire'].mean()

# Compter les occurrences
df['ville'].value_counts()
# Paris        2
# Lyon         1
# Marseille    1
```

---

## 🚀 Partie 3 : Charger et analyser des données réelles

### Lecture de fichiers CSV
```python
import pandas as pd

# Lire un CSV
df = pd.read_csv('data/titanic.csv')

# Options utiles
df = pd.read_csv('data/titanic.csv',
                 sep=',',           # Séparateur
                 encoding='utf-8',  # Encodage
                 na_values=['?', 'N/A'])  # Valeurs manquantes

# Autres formats
df = pd.read_excel('data.xlsx', sheet_name='Sheet1')
df = pd.read_json('data.json')
df = pd.read_sql_query('SELECT * FROM table', connection)
```

### Export de données
```python
# Sauvegarder en CSV
df.to_csv('output.csv', index=False)  # index=False pour ne pas sauver l'index

# Autres formats
df.to_excel('output.xlsx', sheet_name='Data', index=False)
df.to_json('output.json', orient='records')
df.to_html('output.html')
```

---

## 💡 Analyse du dataset Titanic

Le dataset Titanic contient des informations sur les passagers :

### Colonnes principales
- **PassengerId** : ID unique du passager
- **Survived** : Survie (0 = Non, 1 = Oui)
- **Pclass** : Classe du billet (1, 2, 3)
- **Name** : Nom du passager
- **Sex** : Sexe (male/female)
- **Age** : Âge en années
- **SibSp** : Nombre de frères/sœurs/conjoints à bord
- **Parch** : Nombre de parents/enfants à bord
- **Ticket** : Numéro de billet
- **Fare** : Prix du billet
- **Cabin** : Numéro de cabine
- **Embarked** : Port d'embarquement (C = Cherbourg, Q = Queenstown, S = Southampton)

### Questions d'analyse typiques
1. Quel est le taux de survie global ?
2. Quel est le taux de survie par classe ?
3. Les femmes ont-elles mieux survécu que les hommes ?
4. Quel est l'âge moyen des passagers ?
5. Y a-t-il une corrélation entre le prix du billet et la survie ?

### Exemple d'analyse rapide
```python
import pandas as pd

# Charger les données
df = pd.read_csv('data/titanic.csv')

# Exploration rapide
print(df.shape)          # Nombre de lignes et colonnes
print(df.head())         # Premières lignes
print(df.info())         # Types et valeurs manquantes
print(df.describe())     # Statistiques descriptives

# Analyses simples
survival_rate = df['Survived'].mean()
print(f"Taux de survie global : {survival_rate:.2%}")

# Survie par classe
survival_by_class = df.groupby('Pclass')['Survived'].mean()
print("\nTaux de survie par classe :")
print(survival_by_class)

# Survie par sexe
survival_by_sex = df.groupby('Sex')['Survived'].mean()
print("\nTaux de survie par sexe :")
print(survival_by_sex)

# Âge moyen
avg_age = df['Age'].mean()
print(f"\nÂge moyen : {avg_age:.1f} ans")
```

---

## 🎓 Exercices pratiques

### Exercice 1 : NumPy basics
```python
# Créer un array avec les nombres de 0 à 99
# Reshape en matrice 10x10
# Calculer la somme de chaque ligne
# Trouver le maximum de chaque colonne
```

### Exercice 2 : pandas Series
```python
# Créer une Series avec les populations de 5 villes françaises
# Trier par ordre décroissant
# Afficher les villes avec plus de 500 000 habitants
# Calculer la population totale
```

### Exercice 3 : DataFrame manipulation
```python
# Charger le dataset Titanic
# Afficher les 10 premières lignes
# Compter le nombre de valeurs manquantes par colonne
# Filtrer les passagers de première classe
# Calculer l'âge moyen par sexe
```

### Exercice 4 : Groupby
```python
# Grouper par classe et calculer le prix moyen du billet
# Grouper par port d'embarquement et compter les passagers
# Calculer le taux de survie par classe et par sexe
```

---

## 📖 Ressources complémentaires

### Documentation officielle
- [NumPy User Guide](https://numpy.org/doc/stable/user/)
- [pandas User Guide](https://pandas.pydata.org/docs/user_guide/)
- [pandas Cheat Sheet](https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf)

### Tutoriels recommandés
- [NumPy Quickstart](https://numpy.org/doc/stable/user/quickstart.html)
- [10 minutes to pandas](https://pandas.pydata.org/docs/user_guide/10min.html)

### Datasets pour pratiquer
- [Kaggle Datasets](https://www.kaggle.com/datasets)
- [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/)
- [Data.gouv.fr](https://www.data.gouv.fr/)

---

## 🔑 Points clés à retenir

1. **NumPy** : Arrays rapides, opérations vectorisées, base du calcul scientifique
2. **Series** : Vecteur 1D avec index, similaire à une colonne
3. **DataFrame** : Table 2D avec lignes et colonnes, cœur de pandas
4. **Indexation** : `iloc` (position) vs `loc` (labels)
5. **Filtrage** : Conditions booléennes avec `&` et `|`
6. **Groupby** : Grouper et agréger pour résumer les données
7. **Méthodes essentielles** : `head()`, `info()`, `describe()`, `value_counts()`

---

## 📝 Préparation pour la prochaine session

Dans la **Session 15**, nous verrons :
- Le nettoyage de données (valeurs manquantes, outliers)
- Les transformations de types
- La création de nouvelles variables (feature engineering)
- L'export de données propres

**Préparation** :
- Assurez-vous que pandas et NumPy sont installés
- Explorez le dataset Titanic avec les commandes de base
- Identifiez les colonnes avec des valeurs manquantes
