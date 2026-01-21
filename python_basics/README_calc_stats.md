# Guide d'Utilisation - calc_stats.py

## Description

`calc_stats.py` est un script Python qui lit un fichier CSV contenant une colonne de nombres et calcule automatiquement plusieurs statistiques descriptives :

- **Nombre de valeurs** : Nombre total de données
- **Moyenne** : Valeur moyenne des données
- **Médiane** : Valeur centrale des données ordonnées
- **Minimum** : Plus petite valeur
- **Maximum** : Plus grande valeur
- **Étendue** : Différence entre max et min
- **Écart-type** : Mesure de la dispersion des données
- **Variance** : Carré de l'écart-type

## Prérequis

- Python 3.6 ou supérieur
- Module `statistics` (inclus dans la bibliothèque standard de Python)

## Structure des Fichiers

```
python_basics/
├── calc_stats.py       # Script principal
├── numbers.csv         # Fichier de données d'exemple
└── README_calc_stats.md # Ce fichier
```

## Format du Fichier CSV

Le fichier CSV doit avoir la structure suivante :

```csv
valeur
42.5
38.2
45.7
...
```

- **Première ligne** : En-tête (sera ignorée)
- **Lignes suivantes** : Une valeur numérique par ligne

## Installation

Aucune installation supplémentaire n'est nécessaire. Le script utilise uniquement des modules de la bibliothèque standard de Python.

## Utilisation

### Méthode 1 : Ligne de commande

```bash
# Naviguez vers le dossier python_basics
cd python_basics

# Exécutez le script
python calc_stats.py
```

### Méthode 2 : Dans VS Code

1. Ouvrez le fichier `calc_stats.py` dans VS Code
2. Cliquez sur le bouton "Run" (▶) en haut à droite
3. Ou utilisez le raccourci `Ctrl+Alt+N` (Windows/Linux) ou `Cmd+Alt+N` (macOS)

### Méthode 3 : Depuis un autre dossier

```bash
# Depuis la racine du projet
python python_basics/calc_stats.py
```

## Exemple de Sortie

```
🔢 Calcul de Statistiques
📁 Lecture du fichier: python_basics/numbers.csv
✅ 25 valeurs chargées avec succès

==================================================
           STATISTIQUES DESCRIPTIVES
==================================================

Nombre de valeurs  : 25

Tendance centrale:
  • Moyenne        : 44.91
  • Médiane        : 44.20

Dispersion:
  • Minimum        : 36.40
  • Maximum        : 53.40
  • Étendue        : 17.00
  • Écart-type     : 5.12
  • Variance       : 26.25

==================================================

📊 Aperçu des données:
  Premières valeurs: [42.5, 38.2, 45.7, 51.3, 39.8]
  Dernières valeurs: [47.3, 39.5, 51.8, 43.2]

```

## Utilisation avec Vos Propres Données

### Option 1 : Modifier numbers.csv

Remplacez le contenu de `numbers.csv` par vos propres données en respectant le format :

```csv
valeur
12.5
15.3
18.7
...
```

### Option 2 : Créer un nouveau fichier CSV

1. Créez un nouveau fichier CSV avec vos données
2. Modifiez le script `calc_stats.py` :

```python
# Ligne 109 - Changez le nom du fichier
nom_fichier = script_dir / 'mon_fichier.csv'
```

### Option 3 : Passer le nom du fichier en argument

Vous pouvez modifier le script pour accepter un argument :

```python
import sys

def main():
    if len(sys.argv) > 1:
        nom_fichier = sys.argv[1]
    else:
        nom_fichier = 'numbers.csv'
    
    # ... reste du code
```

Puis l'utiliser ainsi :

```bash
python calc_stats.py mes_donnees.csv
```

## Gestion des Erreurs

Le script gère automatiquement plusieurs types d'erreurs :

- **Fichier inexistant** : Message d'erreur clair
- **Valeurs invalides** : Avertissement avec le numéro de ligne
- **Fichier vide** : Message d'erreur approprié

## Personnalisation

### Ajouter d'autres statistiques

Vous pouvez facilement ajouter d'autres calculs dans la fonction `calculer_statistiques()` :

```python
def calculer_statistiques(nombres):
    # ... code existant ...
    
    # Ajouter le mode (valeur la plus fréquente)
    try:
        stats['mode'] = statistics.mode(nombres)
    except statistics.StatisticsError:
        stats['mode'] = None  # Pas de mode unique
    
    # Ajouter les quartiles
    stats['q1'] = statistics.quantiles(nombres, n=4)[0]
    stats['q3'] = statistics.quantiles(nombres, n=4)[2]
    
    return stats
```

### Modifier l'affichage

Personnalisez la fonction `afficher_statistiques()` pour changer le format de sortie :

```python
def afficher_statistiques(stats):
    # Format simple
    print(f"Moyenne: {stats['mean']:.2f}")
    print(f"Médiane: {stats['median']:.2f}")
    
    # Ou format JSON
    import json
    print(json.dumps(stats, indent=2))
```

## Exercices Pratiques

### Exercice 1 : Ajouter des statistiques

Modifiez le script pour calculer et afficher :
- Le mode (valeur la plus fréquente)
- Les quartiles (Q1, Q2, Q3)
- Le coefficient de variation

### Exercice 2 : Sauvegarder les résultats

Ajoutez une fonction pour sauvegarder les statistiques dans un fichier texte :

```python
def sauvegarder_resultats(stats, nom_fichier_sortie):
    with open(nom_fichier_sortie, 'w') as f:
        f.write("Statistiques Descriptives\n")
        f.write("="*40 + "\n")
        f.write(f"Moyenne: {stats['mean']:.2f}\n")
        # ... etc.
```

### Exercice 3 : Créer un graphique

Utilisez `matplotlib` pour créer un histogramme des données :

```python
import matplotlib.pyplot as plt

def afficher_histogramme(nombres):
    plt.hist(nombres, bins=10, edgecolor='black')
    plt.title('Distribution des Valeurs')
    plt.xlabel('Valeur')
    plt.ylabel('Fréquence')
    plt.show()
```

## Débug et Tests

Pour débugger le script :

```python
# Ajouter des print() pour vérifier les valeurs
print(f"DEBUG: nombres = {nombres}")
print(f"DEBUG: stats = {stats}")

# Utiliser le mode interactif Python
python -i calc_stats.py
>>> nombres  # Inspecter la variable
>>> stats    # Voir les résultats
```

## Ressources Complémentaires

- [Module statistics - Documentation Python](https://docs.python.org/fr/3/library/statistics.html)
- [Module csv - Documentation Python](https://docs.python.org/fr/3/library/csv.html)
- [Statistiques descriptives - Wikipédia](https://fr.wikipedia.org/wiki/Statistique_descriptive)

## Aide et Support

En cas de problème :

1. Vérifiez que Python est correctement installé : `python --version`
2. Vérifiez que le fichier `numbers.csv` existe dans le même dossier
3. Vérifiez le format du fichier CSV
4. Lisez les messages d'erreur attentivement

## Licence

Ce script est fourni à des fins éducatives dans le cadre du cours "Python et Analyse de Données".
