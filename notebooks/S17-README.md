# Session 17 - Advanced Visualization & Storytelling

## 🎯 Objectifs de la session
- Créer des visualisations interactives avec Plotly
- Maîtriser les principes du storytelling avec les données
- Designer des visualisations efficaces et esthétiques
- Exporter des graphiques pour présentations et rapports

---

## 📚 Partie 1 : Introduction à Plotly

### Pourquoi Plotly ?
Plotly est une bibliothèque de visualisation interactive qui permet de créer :
- **Graphiques interactifs** : Zoom, pan, hover, sélection
- **Dashboards** : Interfaces riches pour explorer les données
- **Export HTML** : Visualisations partageables sans dépendances
- **Qualité professionnelle** : Designs modernes et esthétiques

### Installation
```bash
pip install plotly kaleido
```

### Deux APIs principales

**Plotly Express** - Simple et rapide
```python
import plotly.express as px

# Scatter plot en une ligne
fig = px.scatter(df, x='Age', y='Fare', color='Survived',
                 title='Relation Age-Prix selon survie')
fig.show()
```

**Plotly Graph Objects** - Plus de contrôle
```python
import plotly.graph_objects as go

fig = go.Figure()
fig.add_trace(go.Scatter(x=[1, 2, 3], y=[4, 5, 6], mode='lines+markers'))
fig.update_layout(title='Mon graphique')
fig.show()
```

---

## 🎨 Partie 2 : Types de visualisations Plotly

### 1. Scatter Plots (nuages de points)
```python
import plotly.express as px

# Scatter basique
fig = px.scatter(df, x='Age', y='Fare', 
                 title='Relation Age-Prix')
fig.show()

# Avec couleur et taille
fig = px.scatter(df, x='Age', y='Fare',
                 color='Survived',  # Couleur selon survie
                 size='Pclass',     # Taille selon classe
                 hover_data=['Name', 'Sex'],  # Infos au survol
                 title='Analyse interactive Titanic')
fig.show()

# Avec facets (sous-graphiques)
fig = px.scatter(df, x='Age', y='Fare',
                 color='Survived',
                 facet_col='Pclass',  # Une colonne par classe
                 title='Prix selon âge par classe')
fig.show()
```

### 2. Line Charts (courbes)
```python
# Courbe simple
fig = px.line(df_time, x='Date', y='Value',
              title='Évolution dans le temps')
fig.show()

# Plusieurs courbes
fig = px.line(df_multi, x='Date', y='Value', color='Category',
              title='Comparaison de plusieurs séries')
fig.show()
```

### 3. Bar Charts (barres)
```python
# Bar chart simple
survival_by_class = df.groupby('Pclass')['Survived'].mean().reset_index()
fig = px.bar(survival_by_class, x='Pclass', y='Survived',
             title='Taux de survie par classe',
             labels={'Survived': 'Taux de survie', 'Pclass': 'Classe'})
fig.show()

# Barres groupées
fig = px.bar(df, x='Pclass', y='Survived', color='Sex',
             barmode='group',  # ou 'stack' pour empilées
             title='Survie par classe et sexe')
fig.show()
```

### 4. Histogrammes et Distributions
```python
# Histogramme
fig = px.histogram(df, x='Age', nbins=30,
                   title='Distribution de l\'âge')
fig.show()

# Histogramme avec overlay
fig = px.histogram(df, x='Age', color='Survived',
                   barmode='overlay',  # Superposer
                   opacity=0.7,
                   title='Âge selon survie')
fig.show()

# Box plot
fig = px.box(df, x='Pclass', y='Fare', color='Survived',
             title='Distribution des prix par classe et survie')
fig.show()

# Violin plot
fig = px.violin(df, x='Pclass', y='Age', color='Survived',
                box=True,  # Ajouter boxplot
                title='Distribution d\'âge par classe')
fig.show()
```

### 5. Heatmaps (cartes de chaleur)
```python
# Matrice de corrélation
corr = df[['Age', 'Fare', 'Pclass', 'SibSp', 'Parch']].corr()

fig = px.imshow(corr,
                text_auto=True,  # Afficher les valeurs
                color_continuous_scale='RdBu_r',  # Palette
                title='Matrice de corrélation')
fig.show()

# Heatmap personnalisée avec Graph Objects
import plotly.graph_objects as go

fig = go.Figure(data=go.Heatmap(
    z=corr.values,
    x=corr.columns,
    y=corr.columns,
    colorscale='Viridis',
    text=corr.values.round(2),
    texttemplate='%{text}',
    textfont={"size": 10}
))
fig.update_layout(title='Corrélations')
fig.show()
```

### 6. Sunburst et Treemap (hiérarchies)
```python
# Sunburst (diagramme en soleil)
fig = px.sunburst(df, path=['Pclass', 'Sex', 'Survived'],
                  title='Hiérarchie Classe > Sexe > Survie')
fig.show()

# Treemap (carte arborescente)
fig = px.treemap(df, path=['Pclass', 'Sex', 'Survived'],
                 title='Répartition des passagers')
fig.show()
```

### 7. 3D Plots
```python
# Scatter 3D
fig = px.scatter_3d(df, x='Age', y='Fare', z='Pclass',
                    color='Survived',
                    title='Visualisation 3D')
fig.show()
```

---

## 🎯 Partie 3 : Personnalisation avancée

### Mise en forme du layout
```python
fig = px.scatter(df, x='Age', y='Fare', color='Survived')

fig.update_layout(
    title={
        'text': 'Relation Age-Prix selon survie',
        'x': 0.5,  # Centrer
        'xanchor': 'center',
        'font': {'size': 20, 'family': 'Arial', 'color': '#333'}
    },
    xaxis_title='Âge (années)',
    yaxis_title='Prix du billet (£)',
    font=dict(size=12),
    plot_bgcolor='#F8F9FA',
    paper_bgcolor='white',
    hovermode='closest',
    width=1000,
    height=600
)

fig.show()
```

### Customiser les axes
```python
fig.update_xaxes(
    range=[0, 80],
    showgrid=True,
    gridwidth=1,
    gridcolor='lightgray',
    zeroline=True,
    zerolinewidth=2,
    zerolinecolor='black'
)

fig.update_yaxes(
    type='log',  # Échelle logarithmique
    showgrid=True,
    title_font=dict(size=14, color='blue')
)
```

### Annotations et shapes
```python
# Ajouter des annotations
fig.add_annotation(
    x=30, y=100,
    text='Zone intéressante',
    showarrow=True,
    arrowhead=2,
    arrowcolor='red',
    font=dict(size=12, color='red')
)

# Ajouter des formes
fig.add_shape(
    type='rect',
    x0=20, x1=40, y0=50, y1=150,
    fillcolor='yellow',
    opacity=0.2,
    line=dict(color='orange', width=2)
)

# Ligne horizontale
fig.add_hline(y=50, line_dash='dash', line_color='green',
              annotation_text='Seuil')
```

### Thèmes prédéfinis
```python
# Appliquer un thème
templates = ['plotly', 'plotly_white', 'plotly_dark', 'ggplot2', 
             'seaborn', 'simple_white', 'presentation']

fig = px.scatter(df, x='Age', y='Fare', 
                 template='plotly_dark')  # Thème sombre
fig.show()
```

---

## 📖 Partie 4 : Storytelling avec les données

### Principes du data storytelling

**1. Connaître son audience**
- Qui va voir la visualisation ?
- Quel est leur niveau technique ?
- Quelles décisions doivent-ils prendre ?

**2. Avoir un message clair**
- Une visualisation = un message principal
- Titre explicite et actionnable
- Guider le regard vers l'insight clé

**3. Choisir la bonne visualisation**
```
Comparaison → Bar chart, Grouped bar
Évolution → Line chart, Area chart
Distribution → Histogram, Box plot, Violin plot
Relation → Scatter plot, Bubble chart
Proportion → Pie chart, Donut chart, Treemap
Hiérarchie → Sunburst, Treemap
```

**4. Simplifier**
- Retirer le superflu (gridlines inutiles, bordures, etc.)
- Limiter les couleurs (3-5 max)
- Utiliser des labels directs plutôt que des légendes

**5. Hiérarchie visuelle**
- Titre > Sous-titre > Annotations > Axes > Données
- Mettre en avant l'insight avec couleur/taille
- Griser les éléments secondaires

### Exemple de storytelling

**Mauvais exemple** :
```python
# Graphique générique sans message
fig = px.bar(df.groupby('Pclass')['Survived'].mean())
fig.show()
```

**Bon exemple** :
```python
# Message clair avec contexte
survival_by_class = df.groupby('Pclass')['Survived'].mean().reset_index()
survival_by_class['Survived'] = survival_by_class['Survived'] * 100

fig = px.bar(survival_by_class, x='Pclass', y='Survived',
             title='Les passagers de 1ère classe avaient 2.5x plus de chances de survivre',
             labels={'Survived': 'Taux de survie (%)', 'Pclass': 'Classe du billet'},
             color='Pclass',
             color_discrete_map={1: '#2ECC71', 2: '#F39C12', 3: '#E74C3C'})

# Ajouter une ligne de référence (moyenne)
avg_survival = df['Survived'].mean() * 100
fig.add_hline(y=avg_survival, line_dash='dash', line_color='gray',
              annotation_text=f'Moyenne globale: {avg_survival:.1f}%',
              annotation_position='right')

# Annotations pour expliquer
fig.add_annotation(x=1, y=survival_by_class[survival_by_class['Pclass']==1]['Survived'].values[0] + 5,
                   text='Accès prioritaire aux<br>canots de sauvetage',
                   showarrow=False, font=dict(size=10, color='green'))

fig.update_layout(showlegend=False)
fig.show()
```

### Structure d'une présentation de données

**1. Introduction** - Contexte
- Problème/question de départ
- Données utilisées
- Méthodologie

**2. Exploration** - Découvertes
- 3-5 visualisations clés
- Chaque viz = 1 insight
- Progression logique

**3. Conclusion** - Recommandations
- Résumé des insights
- Implications
- Actions recommandées

---

## 💾 Partie 5 : Export et partage

### Export en HTML (interactif)
```python
# Export simple
fig.write_html('mon_graphique.html')

# Export avec configuration
fig.write_html(
    'graphique.html',
    config={
        'displayModeBar': True,  # Barre d'outils
        'displaylogo': False,     # Pas de logo Plotly
        'toImageButtonOptions': {
            'format': 'png',
            'filename': 'mon_graphique',
            'height': 800,
            'width': 1200,
            'scale': 2  # Haute résolution
        }
    }
)
```

### Export en image statique
```python
# Nécessite kaleido: pip install kaleido

# PNG
fig.write_image('graphique.png', width=1200, height=800, scale=2)

# PDF (vectoriel)
fig.write_image('graphique.pdf')

# SVG (vectoriel)
fig.write_image('graphique.svg')

# JPEG
fig.write_image('graphique.jpg', width=1920, height=1080)
```

### Intégration dans Jupyter
```python
# Afficher inline
fig.show()

# Taille personnalisée
fig.show(config={'displayModeBar': False}, width=800, height=600)
```

### Dashboard simple avec Plotly
```python
from plotly.subplots import make_subplots
import plotly.graph_objects as go

# Créer des subplots
fig = make_subplots(
    rows=2, cols=2,
    subplot_titles=('Survie par classe', 'Distribution âge', 
                    'Prix par classe', 'Corrélations'),
    specs=[[{'type': 'bar'}, {'type': 'histogram'}],
           [{'type': 'box'}, {'type': 'heatmap'}]]
)

# Ajouter les graphiques
fig.add_trace(go.Bar(x=[1,2,3], y=[0.63, 0.47, 0.24], name='Survie'),
              row=1, col=1)

fig.add_trace(go.Histogram(x=df['Age'], name='Âge'),
              row=1, col=2)

fig.add_trace(go.Box(x=df['Pclass'], y=df['Fare'], name='Prix'),
              row=2, col=1)

corr = df[['Age', 'Fare', 'Pclass']].corr()
fig.add_trace(go.Heatmap(z=corr.values, x=corr.columns, y=corr.columns),
              row=2, col=2)

# Layout global
fig.update_layout(
    title_text='Dashboard Titanic',
    showlegend=False,
    height=800
)

fig.show()
```

---

## 🎨 Partie 6 : Design et esthétique

### Palette de couleurs

**Couleurs catégorielles** (distinctes)
```python
# Plotly built-in
color_sequences = ['Plotly', 'D3', 'G10', 'T10', 'Alphabet', 
                   'Dark24', 'Light24', 'Set1', 'Pastel', 'Safe']

# Personnalisée
custom_colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8']
fig = px.bar(df, x='Category', y='Value', color='Category',
             color_discrete_sequence=custom_colors)
```

**Échelles continues** (gradient)
```python
color_scales = ['Viridis', 'Plasma', 'Inferno', 'Magma', 'Cividis',
                'Blues', 'Reds', 'Greens', 'YlOrRd', 'RdBu', 'Spectral']

fig = px.scatter(df, x='Age', y='Fare', color='Survived',
                 color_continuous_scale='Viridis')
```

### Typographie
```python
fig.update_layout(
    font=dict(
        family='Arial, sans-serif',
        size=12,
        color='#333333'
    ),
    title_font=dict(
        family='Georgia, serif',
        size=20,
        color='#1a1a1a'
    )
)
```

### Marges et espacement
```python
fig.update_layout(
    margin=dict(l=50, r=50, t=100, b=50),  # left, right, top, bottom
    padding=dict(l=10, r=10, t=10, b=10)
)
```

---

## 🔑 Points clés

1. **Interactivité** : Plotly permet l'exploration des données
2. **Simplicité** : Express pour débuter, Graph Objects pour personnaliser
3. **Storytelling** : Une visualisation = un message clair
4. **Design** : Soigner l'esthétique pour la crédibilité
5. **Export** : HTML pour interactif, PNG/PDF pour statique
6. **Contexte** : Adapter aux besoins de l'audience

---

## 📖 Ressources

- [Plotly Documentation](https://plotly.com/python/)
- [Plotly Express](https://plotly.com/python/plotly-express/)
- [Plotly Figure Reference](https://plotly.com/python/reference/)
- [Color Scales](https://plotly.com/python/colorscales/)
- [Storytelling with Data](https://www.storytellingwithdata.com/)

---

## 📝 Préparation Session 18

Dans la **Session 18** (optionnelle), nous verrons :
- Comment structurer un portfolio data science
- Documenter vos projets efficacement
- Présenter votre travail sur GitHub
- Tips pour se démarquer

**Préparation** :
- Créez un compte GitHub si vous n'en avez pas
- Choisissez 2-3 projets à mettre en avant
- Réfléchissez à vos points forts
