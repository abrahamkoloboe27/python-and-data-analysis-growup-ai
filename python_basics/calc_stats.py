"""
Script de Calcul de Statistiques
=================================

Ce script lit un fichier CSV contenant une colonne de nombres
et calcule plusieurs statistiques descriptives de base.

Utilisation:
    python calc_stats.py

Dépendances:
    - Module statistics (inclus dans Python standard library)
"""

import csv
import statistics
import sys
from pathlib import Path


def lire_nombres_csv(nom_fichier):
    """
    Lit les nombres depuis un fichier CSV.
    
    Args:
        nom_fichier (str): Chemin du fichier CSV à lire
    
    Returns:
        list: Liste de nombres (float)
    
    Raises:
        FileNotFoundError: Si le fichier n'existe pas
        ValueError: Si les données ne peuvent pas être converties en nombres
    """
    nombres = []
    
    try:
        with open(nom_fichier, 'r', encoding='utf-8') as fichier:
            lecteur = csv.reader(fichier)
            
            # Sauter l'en-tête
            next(lecteur)
            
            # Lire chaque ligne et convertir en nombre
            for numero_ligne, ligne in enumerate(lecteur, start=2):
                if ligne:  # Ignorer les lignes vides
                    try:
                        nombre = float(ligne[0])
                        nombres.append(nombre)
                    except (ValueError, IndexError) as e:
                        print(f"⚠ Avertissement ligne {numero_ligne}: {e}")
    
    except FileNotFoundError:
        print(f"❌ Erreur: Le fichier '{nom_fichier}' n'existe pas")
        sys.exit(1)
    
    return nombres


def calculer_statistiques(nombres):
    """
    Calcule les statistiques descriptives d'une liste de nombres.
    
    Args:
        nombres (list): Liste de nombres
    
    Returns:
        dict: Dictionnaire contenant les statistiques calculées
    """
    if not nombres:
        raise ValueError("La liste de nombres est vide")
    
    stats = {
        'count': len(nombres),
        'mean': statistics.mean(nombres),
        'median': statistics.median(nombres),
        'min': min(nombres),
        'max': max(nombres),
    }
    
    # Calcul de l'écart-type et variance (si au moins 2 valeurs)
    if len(nombres) >= 2:
        stats['stdev'] = statistics.stdev(nombres)
        stats['variance'] = statistics.variance(nombres)
    else:
        stats['stdev'] = 0
        stats['variance'] = 0
    
    # Calcul de l'étendue (range)
    stats['range'] = stats['max'] - stats['min']
    
    return stats


def afficher_statistiques(stats):
    """
    Affiche les statistiques de manière formatée.
    
    Args:
        stats (dict): Dictionnaire contenant les statistiques
    """
    print("\n" + "="*50)
    print("           STATISTIQUES DESCRIPTIVES")
    print("="*50)
    print()
    print(f"Nombre de valeurs  : {stats['count']}")
    print()
    print("Tendance centrale:")
    print(f"  • Moyenne        : {stats['mean']:.2f}")
    print(f"  • Médiane        : {stats['median']:.2f}")
    print()
    print("Dispersion:")
    print(f"  • Minimum        : {stats['min']:.2f}")
    print(f"  • Maximum        : {stats['max']:.2f}")
    print(f"  • Étendue        : {stats['range']:.2f}")
    print(f"  • Écart-type     : {stats['stdev']:.2f}")
    print(f"  • Variance       : {stats['variance']:.2f}")
    print()
    print("="*50)
    print()


def main():
    """
    Fonction principale du script.
    """
    # Nom du fichier (dans le même dossier que le script)
    script_dir = Path(__file__).parent
    nom_fichier = script_dir / 'numbers.csv'
    
    print("🔢 Calcul de Statistiques")
    print(f"📁 Lecture du fichier: {nom_fichier}")
    
    # Lecture des données
    nombres = lire_nombres_csv(nom_fichier)
    
    if not nombres:
        print("❌ Aucune donnée valide trouvée dans le fichier")
        sys.exit(1)
    
    print(f"✅ {len(nombres)} valeurs chargées avec succès")
    
    # Calcul des statistiques
    stats = calculer_statistiques(nombres)
    
    # Affichage des résultats
    afficher_statistiques(stats)
    
    # Affichage des 5 premières et dernières valeurs
    print("📊 Aperçu des données:")
    print(f"  Premières valeurs: {nombres[:5]}")
    if len(nombres) > 5:
        print(f"  Dernières valeurs: {nombres[-5:]}")
    print()


if __name__ == "__main__":
    main()
