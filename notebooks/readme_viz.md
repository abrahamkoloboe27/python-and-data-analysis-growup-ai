# Insights des Visualisations Titanic

## 📊 Visualisation 1 : Taux de survie par classe et sexe

### Description
Heatmap interactive montrant le taux de survie en fonction de la classe du billet et du sexe du passager.

### Insights clés
- **Les femmes de 1ère classe** avaient le taux de survie le plus élevé : **~97%**
- **Les hommes de 3ème classe** avaient le taux le plus faible : **~13%**
- Il existe un **facteur x7** de différence entre ces deux groupes extrêmes
- Le sexe est le facteur le plus discriminant : les femmes ont globalement **~74% de survie** vs **~19% pour les hommes**
- La classe sociale amplifie cet effet : écart de survie entre classes plus marqué chez les hommes

### Implications
Le principe "femmes et enfants d'abord" a clairement été appliqué, mais avec un biais socio-économique important. Les passagers de 1ère classe, situés sur les ponts supérieurs, avaient un accès prioritaire et plus rapide aux canots de sauvetage.

---

## 📊 Visualisation 2 : Distribution d'âge et survie

### Description
Violin plot comparant la distribution d'âge des survivants et non-survivants par classe.

### Insights clés
- **Les enfants de moins de 10 ans** ont un taux de survie significativement plus élevé dans toutes les classes
- L'âge moyen des survivants est légèrement **inférieur** à celui des non-survivants
- En 3ème classe, on observe une concentration plus importante d'**adultes jeunes** (20-40 ans), probablement des immigrants
- Les **personnes âgées** (>60 ans) ont un taux de survie plus faible, particulièrement en 3ème classe
- La distribution d'âge est plus homogène en 1ère classe, suggérant une population plus aisée et mature

### Implications
Le protocole d'évacuation a priorisé les enfants après les femmes. Les passagers plus jeunes et mobiles avaient également un avantage pour se déplacer rapidement vers les canots.

---

## 📊 Visualisation 3 : Analyse multidimensionnelle

### Description
Bubble chart combinant âge moyen, prix moyen, et nombre de passagers par groupe (classe, sexe, survie).

### Insights clés
- **Corrélation prix-survie** : Dans chaque classe, les survivants ont payé en moyenne un prix légèrement plus élevé
- **Effet de la classe sur le prix** : Écart de prix énorme entre les classes (1ère : ~£80+, 3ème : ~£10-15)
- **Profils types** :
  - 1ère classe : Passagers plus âgés, prix élevés, fort taux de survie
  - 2ème classe : Passagers d'âge moyen, prix modérés, survie moyenne
  - 3ème classe : Passagers plus jeunes, prix bas, faible taux de survie
- Les **groupes les plus nombreux** (grandes bulles) sont en 3ème classe, qui malheureusement a le plus faible taux de survie

### Implications
Le prix du billet reflète non seulement le confort mais aussi l'emplacement de la cabine. Les cabines proches des ponts supérieurs (plus chères) offraient un avantage crucial lors de l'évacuation.

---

## 🎯 Synthèse globale

### Facteurs de survie hiérarchisés
1. **Sexe (femme)** → +55 points de %
2. **Classe (1ère vs 3ème)** → +39 points de %
3. **Âge (enfant)** → +20-30 points de %
4. **Taille de famille (2-4)** → +15-20 points de %

### Profil à risque maximum
- Homme adulte (25-45 ans)
- 3ème classe
- Voyageant seul ou en grande famille
- **Taux de survie estimé : 5-10%**

### Profil à risque minimum
- Femme ou enfant (< 10 ans)
- 1ère classe
- Famille de taille moyenne (2-4 personnes)
- **Taux de survie estimé : 90-100%**

---

## 💡 Conclusions et recommandations

### Pour la recherche historique
Ces visualisations confirment les témoignages historiques sur :
- L'application du protocole "femmes et enfants d'abord"
- Les inégalités socio-économiques dans l'accès aux canots
- L'impact de la localisation des cabines sur les chances de survie

### Pour l'analyse de données
Ce cas d'étude illustre :
- L'importance des **features catégorielles** (sexe, classe) dans la prédiction
- Les **interactions entre variables** (classe × sexe)
- La nécessité de **feature engineering** (âge → groupe d'âge, famille → taille)
- L'utilité des **visualisations interactives** pour explorer les données multidimensionnelles

### Pour la modélisation prédictive
Pour prédire la survie, privilégier :
- Sex et Pclass comme features principales
- Créer des interactions : Sex × Pclass
- Transformer Age en catégories ou polynômes
- Inclure FamilySize et son carré (effet non-linéaire)
- Encoder Title (extrait du nom) pour capturer le statut social

---

## 📁 Fichiers générés

| Fichier | Type | Description |
|---------|------|-------------|
| `viz1_survival_heatmap.html` | Heatmap | Taux de survie par classe et sexe |
| `viz2_age_distribution.html` | Violin plot | Distribution d'âge et survie |
| `viz3_multidimensional_analysis.html` | Bubble chart | Analyse âge-prix-survie |
| `dashboard_titanic.html` | Dashboard | Vue d'ensemble 4 graphiques |

Tous les fichiers sont **100% interactifs** et peuvent être ouverts dans n'importe quel navigateur web sans dépendances.

---

**Date de création** : Session 17 - Advanced Visualization & Storytelling  
**Dataset** : Titanic (cleaned)  
**Outils** : Python, pandas, Plotly
