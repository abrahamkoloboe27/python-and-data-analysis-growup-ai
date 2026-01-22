# Session 16 - Deep EDA & Visualizations

## 🎯 Objectifs de la session
- Maîtriser l'analyse exploratoire des données (EDA)
- Créer des visualisations informatives avec matplotlib et seaborn
- Analyser les corrélations et relations entre variables
- Répondre à des questions métier complexes

---

## 📚 Partie 1 : Qu'est-ce que l'EDA ?

### Définition
**EDA (Exploratory Data Analysis)** est le processus d'investigation des données pour :
- Découvrir des patterns et anomalies
- Tester des hypothèses
- Vérifier des ass

umptions
- Identifier les relations entre variables

### Objectifs de l'EDA
1. **Comprendre la structure** : Types, distributions, valeurs uniques
2. **Détecter les problèmes** : Valeurs manquantes, outliers, incohérences
3. **Identifier les patterns** : Tendances, groupes, corrélations
4. **Formuler des hypothèses** : Questions à approfondir
5. **Préparer la modélisation** : Features importantes, transformations nécessaires

### Processus EDA typique
```
1. Vue d'ensemble (shape, types, head/tail)
2. Statistiques descriptives (describe, value_counts)
3. Analyse univariée (distribution de chaque variable)
4. Analyse bivariée (relations entre 2 variables)
5. Analyse multivariée (relations entre 3+ variables)
6. Identification de patterns et insights
```

---

## 📊 Partie 2 : Bibliothèques de visualisation

### Matplotlib - La base
```python
import matplotlib.pyplot as plt

# Configuration globale
plt.style.use('seaborn-v0_8-darkgrid')
plt.rcParams['figure.figsize'] = (10, 6)
plt.rcParams['font.size'] = 12

# Plot simple
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

plt.plot(x, y, marker='o', color='blue', linewidth=2)
plt.title('Titre du graphique')
plt.xlabel('Axe X')
plt.ylabel('Axe Y')
plt.grid(True)
plt.show()

# Subplots (plusieurs graphiques)
fig, axes = plt.subplots(2, 2, figsize=(12, 10))
axes[0, 0].plot(x, y)
axes[0, 1].scatter(x, y)
axes[1, 0].bar(x, y)
axes[1, 1].hist(y)
plt.tight_layout()
plt.show()
```

### Seaborn - Visualisations statistiques
```python
import seaborn as sns

# Configuration
sns.set_style('whitegrid')
sns.set_palette('husl')

# Exemples de plots
sns.histplot(data=df, x='Age', bins=30)
sns.boxplot(data=df, x='Pclass', y='Fare')
sns.violinplot(data=df, x='Sex', y='Age', hue='Survived')
sns.scatterplot(data=df, x='Age', y='Fare', hue='Survived')
sns.heatmap(df.corr(), annot=True, cmap='coolwarm')
```

---

## 📈 Partie 3 : Types de visualisations

### 1. Distributions (variables continues)

**Histogramme** - Fréquence par intervalle
```python
plt.hist(df['Age'], bins=30, edgecolor='black', alpha=0.7)
plt.title('Distribution de l\'âge')
plt.xlabel('Âge')
plt.ylabel('Fréquence')
plt.show()

# Avec seaborn
sns.histplot(data=df, x='Age', bins=30, kde=True)  # kde = courbe de densité
plt.show()
```

**Density Plot** - Distribution continue lissée
```python
sns.kdeplot(data=df, x='Age', shade=True)
plt.title('Densité de l\'âge')
plt.show()

# Comparaison de groupes
sns.kdeplot(data=df[df['Survived']==0], x='Age', label='Non-survivants', shade=True)
sns.kdeplot(data=df[df['Survived']==1], x='Age', label='Survivants', shade=True)
plt.legend()
plt.show()
```

### 2. Comparaisons (variables catégorielles vs continues)

**Boxplot** - Distribution avec quartiles et outliers
```python
sns.boxplot(data=df, x='Pclass', y='Fare')
plt.title('Prix du billet par classe')
plt.show()

# Avec groupement
sns.boxplot(data=df, x='Pclass', y='Fare', hue='Survived')
plt.show()
```

**Violin Plot** - Boxplot + densité
```python
sns.violinplot(data=df, x='Pclass', y='Age', hue='Survived', split=True)
plt.title('Distribution de l\'âge par classe et survie')
plt.show()
```

**Bar Plot** - Moyennes par catégorie
```python
sns.barplot(data=df, x='Pclass', y='Survived', ci=95)  # ci = intervalle de confiance
plt.title('Taux de survie par classe')
plt.ylabel('Taux de survie moyen')
plt.show()
```

### 3. Catégories (comptages)

**Count Plot** - Fréquence des catégories
```python
sns.countplot(data=df, x='Embarked', hue='Survived')
plt.title('Nombre de passagers par port d\'embarquement')
plt.show()
```

**Pie Chart** - Proportions
```python
df['Pclass'].value_counts().plot(kind='pie', autopct='%1.1f%%')
plt.title('Répartition par classe')
plt.ylabel('')
plt.show()
```

### 4. Relations entre variables

**Scatter Plot** - Relation entre 2 variables continues
```python
sns.scatterplot(data=df, x='Age', y='Fare', hue='Survived', size='Pclass', alpha=0.6)
plt.title('Relation Age-Prix selon survie')
plt.show()
```

**Pairplot** - Toutes les relations 2 à 2
```python
# Attention : peut être long si beaucoup de colonnes
sns.pairplot(df[['Age', 'Fare', 'Pclass', 'Survived']], hue='Survived')
plt.show()
```

### 5. Corrélations

**Heatmap de corrélation**
```python
# Calculer la matrice de corrélation
corr = df[['Age', 'Fare', 'Pclass', 'SibSp', 'Parch', 'Survived']].corr()

# Visualiser
plt.figure(figsize=(10, 8))
sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm', center=0,
            square=True, linewidths=1, cbar_kws={'shrink': 0.8})
plt.title('Matrice de corrélation')
plt.show()
```

### 6. Distributions multiples

**Facet Grid** - Grille de graphiques
```python
g = sns.FacetGrid(df, col='Pclass', row='Sex', hue='Survived', height=4)
g.map(plt.hist, 'Age', bins=20, alpha=0.7)
g.add_legend()
plt.show()
```

---

## 🔍 Partie 4 : Analyses statistiques

### Statistiques descriptives
```python
# Pour toutes les colonnes numériques
df.describe()

# Pour une colonne spécifique
df['Age'].describe()

# Statistiques personnalisées
df['Age'].agg(['mean', 'median', 'std', 'min', 'max', 'skew', 'kurt'])
```

### Distributions et normalité
```python
from scipy import stats

# Test de normalité (Shapiro-Wilk)
stat, p_value = stats.shapiro(df['Age'].dropna())
print(f"P-value : {p_value:.4f}")
if p_value > 0.05:
    print("Distribution probablement normale")
else:
    print("Distribution non normale")

# Q-Q plot (comparaison avec distribution normale)
stats.probplot(df['Age'].dropna(), dist="norm", plot=plt)
plt.title('Q-Q Plot - Age')
plt.show()
```

### Tests statistiques

**Test t (comparaison de moyennes)**
```python
# Âge moyen : survivants vs non-survivants
survivors = df[df['Survived'] == 1]['Age'].dropna()
non_survivors = df[df['Survived'] == 0]['Age'].dropna()

t_stat, p_value = stats.ttest_ind(survivors, non_survivors)
print(f"T-statistic : {t_stat:.4f}")
print(f"P-value : {p_value:.4f}")

if p_value < 0.05:
    print("Différence significative entre les âges")
else:
    print("Pas de différence significative")
```

**Chi-carré (relation entre catégories)**
```python
# Relation entre Sexe et Survie
contingency_table = pd.crosstab(df['Sex'], df['Survived'])
chi2, p_value, dof, expected = stats.chi2_contingency(contingency_table)

print(f"Chi2 : {chi2:.4f}")
print(f"P-value : {p_value:.4f}")
if p_value < 0.05:
    print("Relation significative entre Sexe et Survie")
```

### Corrélations
```python
# Corrélation de Pearson (linéaire)
corr, p_value = stats.pearsonr(df['Age'].dropna(), df['Fare'].dropna())
print(f"Corrélation : {corr:.3f}, P-value : {p_value:.4f}")

# Corrélation de Spearman (monotone, robuste aux outliers)
corr, p_value = stats.spearmanr(df['Age'].dropna(), df['Fare'].dropna())
print(f"Corrélation : {corr:.3f}, P-value : {p_value:.4f}")

# Matrice de corrélation
corr_matrix = df[['Age', 'Fare', 'Pclass', 'SibSp', 'Parch']].corr()
print(corr_matrix)
```

---

## 💡 Partie 5 : Questions métier et analyses

### Question 1 : Qui a le plus de chances de survivre ?
```python
# Analyse par sexe
survival_by_sex = df.groupby('Sex')['Survived'].mean()
print(survival_by_sex)

# Analyse par classe
survival_by_class = df.groupby('Pclass')['Survived'].mean()
print(survival_by_class)

# Analyse croisée
survival_cross = df.groupby(['Pclass', 'Sex'])['Survived'].mean().unstack()
sns.heatmap(survival_cross, annot=True, fmt='.2%', cmap='RdYlGn')
plt.title('Taux de survie par classe et sexe')
plt.show()
```

### Question 2 : Impact de l'âge sur la survie
```python
# Distribution d'âge selon survie
plt.figure(figsize=(12, 5))
plt.subplot(1, 2, 1)
sns.histplot(data=df, x='Age', hue='Survived', bins=30, kde=True)
plt.title('Distribution de l\'âge selon survie')

plt.subplot(1, 2, 2)
sns.boxplot(data=df, x='Survived', y='Age')
plt.title('Âge selon survie (boxplot)')
plt.tight_layout()
plt.show()

# Taux de survie par tranche d'âge
age_bins = pd.cut(df['Age'], bins=[0, 12, 18, 35, 60, 100])
survival_by_age = df.groupby(age_bins)['Survived'].mean()
print(survival_by_age)
```

### Question 3 : Impact de la famille
```python
# Taux de survie selon taille de famille
family_survival = df.groupby('FamilySize')['Survived'].agg(['mean', 'count'])
print(family_survival)

# Visualisation
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

family_survival['mean'].plot(kind='bar', ax=axes[0], color='skyblue')
axes[0].set_title('Taux de survie selon taille de famille')
axes[0].set_ylabel('Taux de survie')
axes[0].set_xlabel('Taille de la famille')

family_survival['count'].plot(kind='bar', ax=axes[1], color='coral')
axes[1].set_title('Nombre de passagers par taille de famille')
axes[1].set_ylabel('Nombre de passagers')
axes[1].set_xlabel('Taille de la famille')

plt.tight_layout()
plt.show()
```

### Question 4 : Impact du prix du billet
```python
# Relation entre prix et survie
plt.figure(figsize=(12, 5))

plt.subplot(1, 2, 1)
sns.boxplot(data=df, x='Survived', y='Fare')
plt.title('Prix du billet selon survie')

plt.subplot(1, 2, 2)
sns.violinplot(data=df, x='Pclass', y='Fare', hue='Survived', split=True)
plt.title('Prix selon classe et survie')

plt.tight_layout()
plt.show()
```

---

## 🎨 Partie 6 : Bonnes pratiques de visualisation

### 1. Choisir le bon graphique
- **Distribution** → Histogramme, density plot
- **Comparaison de groupes** → Boxplot, violin plot, bar plot
- **Relation** → Scatter plot, line plot
- **Proportion** → Pie chart, donut chart
- **Évolution temporelle** → Line plot, area plot
- **Corrélation** → Heatmap, pairplot

### 2. Améliorer la lisibilité
```python
# Titres explicites
plt.title('Taux de survie par classe et sexe', fontsize=16, fontweight='bold')

# Labels des axes
plt.xlabel('Classe du billet', fontsize=12)
plt.ylabel('Taux de survie (%)', fontsize=12)

# Légende
plt.legend(title='Sexe', loc='best')

# Grille
plt.grid(True, alpha=0.3)

# Rotation des labels
plt.xticks(rotation=45, ha='right')

# Couleurs cohérentes
colors = ['#FF6B6B', '#4ECDC4', '#45B7D1']
```

### 3. Annotations
```python
# Ajouter du texte
plt.text(x=1, y=0.5, s='Point important', fontsize=12)

# Annoter un point
plt.annotate('Maximum', xy=(3, 8), xytext=(4, 9),
             arrowprops=dict(arrowstyle='->', color='red'))

# Valeurs sur barplot
ax = sns.barplot(data=df, x='Pclass', y='Survived')
for container in ax.containers:
    ax.bar_label(container, fmt='%.2f')
```

### 4. Exportation
```python
# Sauvegarder une figure
plt.savefig('survival_analysis.png', dpi=300, bbox_inches='tight')
plt.savefig('survival_analysis.pdf')  # Format vectoriel
```

---

## 🔑 Points clés

1. **EDA d'abord** : Toujours explorer avant de modéliser
2. **Visualiser** : Un graphique vaut mille chiffres
3. **Contexte** : Interpréter les résultats dans le contexte métier
4. **Statistiques** : Confirmer les observations visuelles avec des tests
5. **Itératif** : L'EDA est un processus de découverte progressive
6. **Documentation** : Annoter les insights et découvertes

---

## 📖 Ressources

- [Matplotlib Gallery](https://matplotlib.org/stable/gallery/)
- [Seaborn Gallery](https://seaborn.pydata.org/examples/index.html)
- [Data Visualization Guide](https://www.kaggle.com/learn/data-visualization)
- [From Data to Viz](https://www.data-to-viz.com/)

---

## 📝 Préparation Session 17

Dans la **Session 17**, nous verrons :
- Visualisations interactives avec Plotly
- Storytelling avec les données
- Création de dashboards
- Export de visualisations pour présentations

**Préparation** :
- Installez plotly : `pip install plotly kaleido`
- Terminez l'EDA du Titanic
- Identifiez 3 insights clés à communiquer
