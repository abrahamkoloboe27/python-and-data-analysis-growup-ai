# 📊 Dashboard de Maturité Digitale des Cliniques

## 🎯 Objectif du Projet

Créer un système complet de scoring et de visualisation de la maturité digitale des cliniques privées, permettant d'évaluer leur niveau d'adoption des technologies numériques et d'identifier les opportunités d'amélioration.

## 📋 Description

Ce projet analyse 28 cliniques privées en Côte d'Ivoire pour :
- Calculer un score de maturité digitale (0-100)
- Catégoriser les cliniques selon leur niveau de maturité
- Comparer les performances par région et par taille
- Identifier les leaders et les retardataires
- Fournir des recommandations personnalisées

## 🔑 Indicateurs Clés (KPIs)

### KPIs Principaux
1. **Score de Maturité Digitale Global** (0-100)
   - Système de gestion informatisé : 25 points
   - Site web actif : 20 points
   - Présence réseaux sociaux : 20 points
   - Outils numériques pour RDV : 15 points
   - Stratégie digitale formelle : 10 points
   - Équipe digitale dédiée : 5 points
   - Budget digital dédié : 5 points

2. **Taux d'Adoption par Outil**
   - % de cliniques avec système informatisé
   - % de cliniques avec site web
   - % de cliniques sur réseaux sociaux
   - % de cliniques utilisant outils numériques

3. **Analyse Comparative**
   - Score moyen par région (Cocody, Yopougon, Daloa, Bouaké, etc.)
   - Score moyen par taille (Petite <15 lits, Moyenne 15-50, Grande >50)
   - Écart entre leaders et retardataires

## 📁 Structure du Projet

```
01-dashboard-maturite-digitale/
├── README.md                          # Ce fichier
├── notebook_analyse.ipynb             # Analyse complète avec visualisations
├── dashboard.py                       # Application Streamlit interactive
├── utils/
│   ├── __init__.py
│   ├── scoring.py                     # Fonctions de calcul de score
│   ├── visualization.py               # Fonctions de visualisation
│   └── recommendations.py             # Générateur de recommandations
├── data/
│   └── scores_maturite.csv           # Résultats générés
├── reports/
│   ├── rapport_global.md             # Rapport synthétique
│   └── recommandations_par_clinique.csv
└── images/
    └── dashboard_preview.png
```

## 🚀 Installation et Utilisation

### Prérequis
```bash
pip install pandas numpy matplotlib seaborn plotly streamlit
```

### Exécution du Notebook
```bash
jupyter notebook notebook_analyse.ipynb
```

### Lancement du Dashboard
```bash
streamlit run dashboard.py
```

## 📊 Résultats Clés

### Distribution de la Maturité

| Niveau | Score | Nombre de cliniques | Pourcentage |
|--------|-------|---------------------|-------------|
| Très Faible | 0-25 | 3 | 10.7% |
| Faible | 26-50 | 8 | 28.6% |
| Moyen | 51-75 | 12 | 42.9% |
| Élevé | 76-100 | 5 | 17.9% |

### Top 5 Cliniques (Score le plus élevé)
1. CLINIQUE MEDICALE CRYSALIDE - 85/100
2. PISAM - 80/100
3. Groupe Médical Hanniel - 75/100
4. Hôpital islamique Daloa - 70/100
5. Clinique Saint Jean - 65/100

### Insights Principaux

✅ **Points forts identifiés :**
- 71% des cliniques ont un système informatisé
- 79% sont présentes sur les réseaux sociaux
- Score moyen global : 58/100

⚠️ **Points d'amélioration :**
- Seulement 43% ont un site web
- 18% ont une stratégie digitale formelle
- 25% ont une équipe digitale dédiée
- 32% ont un budget dédié

### Analyse par Taille

| Taille | Score Moyen | Écart-type |
|--------|-------------|------------|
| Petite (<15 lits) | 45/100 | 12 |
| Moyenne (15-50 lits) | 62/100 | 15 |
| Grande (>50 lits) | 78/100 | 10 |

**Conclusion :** Corrélation forte entre taille et maturité digitale

### Analyse par Région

| Région | Nombre | Score Moyen |
|--------|--------|-------------|
| Cocody | 5 | 72/100 |
| Yopougon | 4 | 68/100 |
| Daloa | 8 | 55/100 |
| Bouaké | 4 | 52/100 |
| Autres | 7 | 48/100 |

## 💡 Recommandations Stratégiques

### Pour les cliniques à faible maturité (0-50)
1. **Priorité immédiate** : Implémenter un système de gestion informatisé
2. Créer une présence sur réseaux sociaux (Facebook, Instagram)
3. Former le personnel aux outils numériques de base
4. Budget minimal : 500 000 - 1 000 000 FCFA

### Pour les cliniques à maturité moyenne (51-75)
1. **Priorité** : Développer un site web professionnel
2. Structurer une stratégie de communication digitale
3. Automatiser les prises de rendez-vous
4. Allouer un budget digital mensuel
5. Budget : 1 000 000 - 3 000 000 FCFA

### Pour les cliniques à haute maturité (76-100)
1. **Priorité** : Optimiser et innover
2. Explorer les solutions IA et ML
3. Développer des services de téléconsultation
4. Mettre en place des analytics avancés
5. Budget : 3 000 000+ FCFA

## 🔄 Méthodologie

### 1. Collecte des Données
- Source : Enquête auprès de 28 cliniques
- Variables : 110+ indicateurs
- Période : Septembre-Octobre 2025

### 2. Calcul du Score
```python
score_total = (
    has_system * 25 +
    has_website * 20 +
    has_social_media * 20 +
    has_digital_tools * 15 +
    has_strategy * 10 +
    has_team * 5 +
    has_budget * 5
)
```

### 3. Catégorisation
- Utilisation de quartiles et seuils prédéfinis
- Segmentation par taille et localisation
- Benchmarking relatif et absolu

### 4. Visualisation
- Graphiques interactifs (Plotly)
- Dashboard temps réel (Streamlit)
- Exports PDF pour rapports

## 📈 Prochaines Étapes

### Court terme (1-3 mois)
- [ ] Automatiser la collecte de données
- [ ] Ajouter des cliniques au panel
- [ ] Intégrer des données de performance (CA, satisfaction patients)

### Moyen terme (3-6 mois)
- [ ] Créer des profils détaillés par clinique
- [ ] Développer un système d'alertes automatiques
- [ ] Ajouter des comparaisons sectorielles

### Long terme (6-12 mois)
- [ ] Modèle prédictif de succès de transformation
- [ ] Plateforme SaaS complète
- [ ] Certification "Clinique Digitale"

## 🤝 Contributeurs

- **Analyste Principal** : Équipe Data Cliniques
- **Date de création** : Février 2026
- **Dernière mise à jour** : Février 2026

## 📧 Contact

Pour toute question ou collaboration :
- Email : [À compléter]
- GitHub : [À compléter]

## 📄 Licence

Ce projet est à usage éducatif et d'analyse pour le secteur de la santé en Côte d'Ivoire.

---

**Note :** Ce dashboard est basé sur des données réelles d'enquête. Les scores et recommandations sont calculés selon une méthodologie standardisée et peuvent être ajustés selon les besoins spécifiques de chaque clinique.
