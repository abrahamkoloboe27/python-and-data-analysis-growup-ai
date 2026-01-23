# Session 15 - Data Cleaning & Feature Engineering

## 🎯 Objectifs de la session
- Maîtriser les techniques de nettoyage de données
- Gérer les valeurs manquantes avec différentes stratégies
- Identifier et traiter les outliers
- Créer de nouvelles variables pertinentes (feature engineering)
- Normaliser et transformer les données

---

## 📚 Partie 1 : Comprendre les données sales

### Pourquoi nettoyer les données ?
**"Garbage in, garbage out"** - La qualité de vos analyses dépend de la qualité de vos données.

Les données réelles contiennent souvent :
- **Valeurs manquantes** : cellules vides, NaN, NULL
- **Doublons** : mêmes observations répétées
- **Outliers** : valeurs extrêmes ou aberrantes
- **Incohérences** : erreurs de saisie, formats différents
- **Types incorrects** : nombres stockés comme texte, etc.

### Impact des données sales
- **Biais dans les analyses** : résultats faussés
- **Modèles peu performants** : prédictions incorrectes
- **Erreurs de calcul** : statistiques invalides
- **Perte de temps** : debugging et corrections

---

## 🔍 Partie 2 : Diagnostic des données

### Exploration initiale
```python
import pandas as pd
import numpy as np

# Charger les données
df = pd.read_csv('data/titanic.csv')

# Vue d'ensemble
print(df.shape)              # Dimensions
print(df.head())             # Premières lignes
print(df.info())             # Types et valeurs non-null
print(df.describe())         # Statistiques descriptives
```

### Détection des valeurs manquantes
```python
# Compter les valeurs manquantes
missing_count = df.isnull().sum()
print(missing_count[missing_count > 0])

# Pourcentage de valeurs manquantes
missing_pct = (df.isnull().sum() / len(df) * 100).round(2)
print(missing_pct[missing_pct > 0])

# Visualiser les patterns de valeurs manquantes
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 6))
sns.heatmap(df.isnull(), cbar=False, cmap='viridis')
plt.title('Patterns de valeurs manquantes')
plt.show()
```

### Détection des doublons
```python
# Vérifier les doublons
duplicates = df.duplicated()
print(f"Nombre de doublons : {duplicates.sum()}")

# Voir les doublons
print(df[df.duplicated(keep=False)])  # keep=False pour voir tous les doublons

# Doublons sur certaines colonnes seulement
duplicates_subset = df.duplicated(subset=['Name', 'Age'])
print(f"Doublons sur Name et Age : {duplicates_subset.sum()}")
```

### Détection des outliers
```python
# Méthode 1 : Règle des 1.5*IQR (InterQuartile Range)
Q1 = df['Fare'].quantile(0.25)
Q3 = df['Fare'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

outliers = df[(df['Fare'] < lower_bound) | (df['Fare'] > upper_bound)]
print(f"Outliers détectés : {len(outliers)}")

# Méthode 2 : Z-score (pour distribution normale)
from scipy import stats
z_scores = np.abs(stats.zscore(df['Fare'].dropna()))
outliers_zscore = df[z_scores > 3]  # Au-delà de 3 écart-types
print(f"Outliers (Z-score > 3) : {len(outliers_zscore)}")

# Visualisation des outliers
plt.figure(figsize=(12, 4))
plt.subplot(1, 2, 1)
plt.boxplot(df['Fare'].dropna())
plt.title('Boxplot - Fare')
plt.subplot(1, 2, 2)
plt.hist(df['Fare'].dropna(), bins=50)
plt.title('Distribution - Fare')
plt.show()
```

---

## 🧹 Partie 3 : Traitement des valeurs manquantes

### Stratégie 1 : Suppression

**Supprimer les lignes** (quand peu de valeurs manquantes)
```python
# Supprimer les lignes avec au moins une valeur manquante
df_dropped = df.dropna()
print(f"Lignes restantes : {len(df_dropped)} / {len(df)}")

# Supprimer les lignes avec valeurs manquantes sur certaines colonnes
df_dropped_subset = df.dropna(subset=['Age', 'Embarked'])

# Supprimer si toutes les valeurs sont manquantes
df_dropped_all = df.dropna(how='all')
```

**Supprimer les colonnes** (si trop de valeurs manquantes)
```python
# Supprimer les colonnes avec > 50% de valeurs manquantes
threshold = 0.5
missing_pct = df.isnull().sum() / len(df)
cols_to_drop = missing_pct[missing_pct > threshold].index
df_cleaned = df.drop(columns=cols_to_drop)
```

### Stratégie 2 : Imputation simple

**Imputation par la moyenne/médiane** (variables numériques)
```python
# Moyenne
df['Age'].fillna(df['Age'].mean(), inplace=True)

# Médiane (plus robuste aux outliers)
df['Age'].fillna(df['Age'].median(), inplace=True)

# Mode (valeur la plus fréquente)
df['Embarked'].fillna(df['Embarked'].mode()[0], inplace=True)
```

**Imputation par une valeur constante**
```python
# Remplacer par 0
df['Cabin'].fillna('Unknown', inplace=True)

# Remplacer par une valeur spécifique
df['Age'].fillna(-1, inplace=True)  # -1 pour "non renseigné"
```

**Forward fill / Backward fill** (données temporelles)
```python
# Forward fill : propager la dernière valeur valide
df['Price'].fillna(method='ffill', inplace=True)

# Backward fill : propager la prochaine valeur valide
df['Price'].fillna(method='bfill', inplace=True)
```

### Stratégie 3 : Imputation avancée

**Imputation conditionnelle**
```python
# Exemple : Âge moyen selon la classe et le sexe
age_by_group = df.groupby(['Pclass', 'Sex'])['Age'].transform('median')
df['Age'] = df['Age'].fillna(age_by_group)
```

**Imputation par régression** (sklearn)
```python
from sklearn.impute import SimpleImputer, KNNImputer

# SimpleImputer (moyenne, médiane, mode)
imputer = SimpleImputer(strategy='median')
df[['Age']] = imputer.fit_transform(df[['Age']])

# KNNImputer (k plus proches voisins)
imputer = KNNImputer(n_neighbors=5)
df[['Age', 'Fare']] = imputer.fit_transform(df[['Age', 'Fare']])
```

### Stratégie 4 : Créer un indicateur de manque
```python
# Créer une colonne binaire indiquant si la valeur était manquante
df['Age_was_missing'] = df['Age'].isnull().astype(int)

# Puis imputer
df['Age'].fillna(df['Age'].median(), inplace=True)
```

---

## 🎯 Partie 4 : Traitement des outliers

### Méthode 1 : Suppression
```python
# Supprimer les outliers détectés par IQR
Q1 = df['Fare'].quantile(0.25)
Q3 = df['Fare'].quantile(0.75)
IQR = Q3 - Q1
df_no_outliers = df[
    (df['Fare'] >= Q1 - 1.5 * IQR) & 
    (df['Fare'] <= Q3 + 1.5 * IQR)
]
```

### Méthode 2 : Winsorization (capping)
```python
# Limiter les valeurs extrêmes
lower_percentile = df['Fare'].quantile(0.01)
upper_percentile = df['Fare'].quantile(0.99)

df['Fare_capped'] = df['Fare'].clip(lower=lower_percentile, 
                                     upper=upper_percentile)
```

### Méthode 3 : Transformation
```python
# Transformation logarithmique (réduire l'impact des outliers)
df['Fare_log'] = np.log1p(df['Fare'])  # log1p = log(1 + x)

# Transformation racine carrée
df['Fare_sqrt'] = np.sqrt(df['Fare'])
```

### Méthode 4 : Garder mais flaguer
```python
# Créer un indicateur d'outlier
Q1 = df['Fare'].quantile(0.25)
Q3 = df['Fare'].quantile(0.75)
IQR = Q3 - Q1
df['is_outlier'] = (
    (df['Fare'] < Q1 - 1.5 * IQR) | 
    (df['Fare'] > Q3 + 1.5 * IQR)
).astype(int)
```

---

## 🔄 Partie 5 : Transformation et normalisation

### Conversion de types
```python
# Convertir en numérique
df['Age'] = pd.to_numeric(df['Age'], errors='coerce')  # NaN si erreur

# Convertir en catégorique
df['Pclass'] = df['Pclass'].astype('category')

# Convertir en datetime
df['Date'] = pd.to_datetime(df['Date'], format='%Y-%m-%d', errors='coerce')

# Convertir True/False en 1/0
df['Survived'] = df['Survived'].astype(int)
```

### Encodage des variables catégorielles

**Label Encoding** (ordinales : ordre important)
```python
# Exemple : Pclass (1, 2, 3 ont un ordre)
df['Pclass_encoded'] = df['Pclass'].map({1: 1, 2: 2, 3: 3})

# Ou avec LabelEncoder
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
df['Sex_encoded'] = le.fit_transform(df['Sex'])  # male=1, female=0
```

**One-Hot Encoding** (nominales : pas d'ordre)
```python
# Méthode pandas
df_encoded = pd.get_dummies(df, columns=['Embarked'], prefix='Embarked')
# Crée : Embarked_C, Embarked_Q, Embarked_S

# Méthode sklearn
from sklearn.preprocessing import OneHotEncoder
encoder = OneHotEncoder(sparse=False, drop='first')  # drop pour éviter multicolinéarité
encoded = encoder.fit_transform(df[['Embarked']])
```

### Normalisation et standardisation

**Min-Max Scaling** (normalisation entre 0 et 1)
```python
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
df['Fare_normalized'] = scaler.fit_transform(df[['Fare']])
# Formule : (x - min) / (max - min)
```

**Standardisation** (Z-score : moyenne=0, écart-type=1)
```python
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
df['Fare_standardized'] = scaler.fit_transform(df[['Fare']])
# Formule : (x - mean) / std
```

**Robust Scaling** (utilise médiane et IQR, robuste aux outliers)
```python
from sklearn.preprocessing import RobustScaler

scaler = RobustScaler()
df['Fare_robust'] = scaler.fit_transform(df[['Fare']])
```

---

## ⚙️ Partie 6 : Feature Engineering

### Création de nouvelles variables

**À partir de variables existantes**
```python
# Taille de la famille
df['FamilySize'] = df['SibSp'] + df['Parch'] + 1

# Indicateur de voyage seul
df['IsAlone'] = (df['FamilySize'] == 1).astype(int)

# Catégories d'âge
df['AgeGroup'] = pd.cut(df['Age'], 
                        bins=[0, 12, 18, 60, 100], 
                        labels=['Enfant', 'Adolescent', 'Adulte', 'Senior'])

# Catégories de prix
df['FareRange'] = pd.qcut(df['Fare'], q=4, 
                          labels=['Bas', 'Moyen', 'Élevé', 'Très élevé'])
```

**Extraction d'informations**
```python
# Extraire le titre du nom
df['Title'] = df['Name'].str.extract(' ([A-Za-z]+)\.', expand=False)

# Simplifier les titres rares
title_mapping = {
    'Mr': 'Mr', 'Miss': 'Miss', 'Mrs': 'Mrs', 'Master': 'Master',
    'Dr': 'Rare', 'Rev': 'Rare', 'Col': 'Rare', 'Major': 'Rare',
    'Mlle': 'Miss', 'Mme': 'Mrs', 'Ms': 'Miss', 'Lady': 'Rare',
    'Countess': 'Rare', 'Capt': 'Rare', 'Jonkheer': 'Rare', 'Don': 'Rare',
    'Dona': 'Rare', 'Sir': 'Rare'
}
df['Title'] = df['Title'].map(title_mapping)

# Indicateur de cabine connue
df['HasCabin'] = df['Cabin'].notna().astype(int)
```

**Interactions entre variables**
```python
# Créer des interactions
df['Pclass_Sex'] = df['Pclass'].astype(str) + '_' + df['Sex']

# Produit de variables
df['Age_Fare_Interaction'] = df['Age'] * df['Fare']
```

**Variables basées sur des conditions**
```python
# Femme ou enfant
df['WomanOrChild'] = ((df['Sex'] == 'female') | (df['Age'] < 18)).astype(int)

# Classe supérieure
df['UpperClass'] = (df['Pclass'] <= 2).astype(int)
```

### Binning (discrétisation)
```python
# Binning avec intervalles égaux
df['Age_bins'] = pd.cut(df['Age'], bins=5)

# Binning avec quantiles (même nombre d'éléments par bin)
df['Fare_quantiles'] = pd.qcut(df['Fare'], q=4)

# Binning personnalisé
bins = [0, 18, 30, 50, 100]
labels = ['Jeune', 'Adulte', 'Mature', 'Senior']
df['AgeCategory'] = pd.cut(df['Age'], bins=bins, labels=labels)
```

---

## 📊 Partie 7 : Workflow complet de nettoyage

```python
import pandas as pd
import numpy as np

def clean_titanic_data(df):
    """
    Nettoie le dataset Titanic et crée de nouvelles features
    """
    # Copie pour ne pas modifier l'original
    df_clean = df.copy()
    
    # 1. Supprimer les colonnes inutiles
    df_clean = df_clean.drop(['PassengerId', 'Ticket', 'Cabin'], axis=1)
    
    # 2. Traiter les valeurs manquantes
    # Age : imputation par médiane selon classe et sexe
    df_clean['Age'] = df_clean.groupby(['Pclass', 'Sex'])['Age'].transform(
        lambda x: x.fillna(x.median())
    )
    
    # Embarked : mode (valeur la plus fréquente)
    df_clean['Embarked'].fillna(df_clean['Embarked'].mode()[0], inplace=True)
    
    # Fare : médiane
    df_clean['Fare'].fillna(df_clean['Fare'].median(), inplace=True)
    
    # 3. Créer de nouvelles features
    df_clean['FamilySize'] = df_clean['SibSp'] + df_clean['Parch'] + 1
    df_clean['IsAlone'] = (df_clean['FamilySize'] == 1).astype(int)
    
    # Extraire le titre
    df_clean['Title'] = df_clean['Name'].str.extract(' ([A-Za-z]+)\.', expand=False)
    title_mapping = {
        'Mr': 'Mr', 'Miss': 'Miss', 'Mrs': 'Mrs', 'Master': 'Master'
    }
    df_clean['Title'] = df_clean['Title'].map(lambda x: title_mapping.get(x, 'Other'))
    
    # Catégories d'âge
    df_clean['AgeGroup'] = pd.cut(df_clean['Age'], 
                                   bins=[0, 12, 18, 60, 100], 
                                   labels=['Child', 'Teen', 'Adult', 'Senior'])
    
    # 4. Encodage
    df_clean['Sex'] = df_clean['Sex'].map({'male': 0, 'female': 1})
    df_clean = pd.get_dummies(df_clean, columns=['Embarked', 'Title'], drop_first=True)
    
    # 5. Supprimer la colonne Name (plus nécessaire)
    df_clean = df_clean.drop('Name', axis=1)
    
    return df_clean

# Utilisation
df_original = pd.read_csv('data/titanic.csv')
df_cleaned = clean_titanic_data(df_original)

# Sauvegarder
df_cleaned.to_csv('data/titanic_clean.csv', index=False)
print("Données nettoyées et sauvegardées !")
```

---

## ✅ Checklist de nettoyage

Avant de commencer l'analyse, vérifiez :

- [ ] **Dimensions** : Nombre de lignes et colonnes cohérent ?
- [ ] **Types** : Chaque colonne a le bon type (int, float, str, datetime) ?
- [ ] **Valeurs manquantes** : Identifiées et traitées ?
- [ ] **Doublons** : Vérifiés et supprimés si nécessaire ?
- [ ] **Outliers** : Détectés et traités selon le contexte ?
- [ ] **Cohérence** : Valeurs dans les plages attendues ?
- [ ] **Encodage** : Variables catégorielles encodées correctement ?
- [ ] **Features** : Nouvelles variables créées si pertinent ?
- [ ] **Documentation** : Transformations documentées ?
- [ ] **Sauvegarde** : Données propres sauvegardées ?

---

## 🎓 Bonnes pratiques

### 1. Toujours travailler sur une copie
```python
df_clean = df.copy()  # Ne jamais modifier l'original directement
```

### 2. Documenter les décisions
```python
# Pourquoi cette transformation ?
# Age : Imputation par médiane car distribution asymétrique
# Embarked : Mode car seulement 2 valeurs manquantes
```

### 3. Créer des fonctions réutilisables
```python
def handle_missing_age(df):
    """Impute missing age values by median of Pclass and Sex"""
    return df.groupby(['Pclass', 'Sex'])['Age'].transform(
        lambda x: x.fillna(x.median())
    )
```

### 4. Valider les transformations
```python
# Avant
print(df['Age'].isnull().sum())  # 177
# Après
df['Age'] = handle_missing_age(df)
print(df['Age'].isnull().sum())  # 0
assert df['Age'].isnull().sum() == 0, "Des valeurs manquantes subsistent !"
```

### 5. Sauvegarder les étapes intermédiaires
```python
df.to_csv('data/titanic_step1_missing_handled.csv', index=False)
df.to_csv('data/titanic_step2_features_created.csv', index=False)
df.to_csv('data/titanic_final_clean.csv', index=False)
```

---

## 📖 Ressources

- [pandas Missing Data](https://pandas.pydata.org/docs/user_guide/missing_data.html)
- [scikit-learn Preprocessing](https://scikit-learn.org/stable/modules/preprocessing.html)
- [Feature Engineering Guide](https://www.kaggle.com/learn/feature-engineering)

---

## 🔑 Points clés

1. **Diagnostic d'abord** : Comprendre les données avant de les modifier
2. **Contexte métier** : Les décisions de nettoyage dépendent du domaine
3. **Valeurs manquantes** : Plusieurs stratégies selon le type et le volume
4. **Outliers** : Ne pas supprimer systématiquement, comprendre pourquoi
5. **Feature engineering** : Créer de la valeur à partir des données existantes
6. **Documentation** : Garder une trace de toutes les transformations
7. **Validation** : Vérifier chaque étape de nettoyage

---

## 📝 Préparation Session 16

Dans la **Session 16**, nous ferons :
- Une EDA (Exploratory Data Analysis) complète
- Des visualisations pour comprendre les relations
- Des analyses statistiques approfondies
- Des réponses à des questions métier complexes

**Préparation** :
- Terminez le nettoyage du dataset Titanic
- Installez matplotlib et seaborn : `pip install matplotlib seaborn`
