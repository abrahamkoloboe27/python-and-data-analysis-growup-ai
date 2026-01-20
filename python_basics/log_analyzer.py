"""
Analyseur de Logs Web
=====================

Ce script analyse un fichier de logs de serveur web et produit des statistiques :
- Top 10 des adresses IP les plus fréquentes
- Top 5 des endpoints les plus consultés
- Statistiques sur les codes de statut HTTP
- Détection des erreurs (codes 4xx et 5xx)

Format de log attendu (Apache Combined Log Format) :
IP - - [date] "METHOD /endpoint HTTP/version" status_code

Utilisation:
    python log_analyzer.py

Auteur: Cours Python et Analyse de Données
Session: S7 - Collections Avancées
"""

import re
from collections import Counter, defaultdict
from datetime import datetime
from pathlib import Path


def lire_logs(nom_fichier):
    """
    Lit un fichier de logs ligne par ligne.
    
    Args:
        nom_fichier (str): Chemin du fichier de logs
    
    Returns:
        list: Liste de lignes du fichier
    
    Raises:
        FileNotFoundError: Si le fichier n'existe pas
    """
    try:
        with open(nom_fichier, 'r', encoding='utf-8') as fichier:
            return fichier.readlines()
    except FileNotFoundError:
        print(f"❌ Erreur: Le fichier '{nom_fichier}' n'existe pas")
        return []


def parser_ligne_log(ligne):
    """
    Parse une ligne de log pour extraire les informations.
    
    Format: IP - - [date] "METHOD /endpoint HTTP/version" status
    
    Args:
        ligne (str): Une ligne de log
    
    Returns:
        dict: Dictionnaire contenant les informations parsées ou None si échec
    """
    # Pattern regex pour parser le log
    pattern = r'(\S+) - - \[(.*?)\] "(\S+) (\S+) HTTP/\d\.\d" (\d+)'
    match = re.match(pattern, ligne)
    
    if match:
        return {
            'ip': match.group(1),
            'date': match.group(2),
            'method': match.group(3),
            'endpoint': match.group(4),
            'status': int(match.group(5))
        }
    return None


def analyser_logs(lignes):
    """
    Analyse les lignes de logs et extrait des statistiques.
    
    Args:
        lignes (list): Liste de lignes de logs
    
    Returns:
        dict: Dictionnaire contenant les statistiques
    """
    # Structures pour collecter les données
    ips = []
    endpoints = []
    status_codes = []
    erreurs = []
    methodes = []
    
    lignes_parsees = 0
    lignes_ignorees = 0
    
    # Parser chaque ligne
    for ligne in lignes:
        data = parser_ligne_log(ligne.strip())
        
        if data:
            lignes_parsees += 1
            ips.append(data['ip'])
            endpoints.append(data['endpoint'])
            status_codes.append(data['status'])
            methodes.append(data['method'])
            
            # Détecter les erreurs (4xx et 5xx)
            if data['status'] >= 400:
                erreurs.append({
                    'ip': data['ip'],
                    'endpoint': data['endpoint'],
                    'status': data['status'],
                    'date': data['date']
                })
        else:
            lignes_ignorees += 1
    
    # Calculer les statistiques
    stats = {
        'total_lignes': len(lignes),
        'lignes_parsees': lignes_parsees,
        'lignes_ignorees': lignes_ignorees,
        'top_ips': Counter(ips).most_common(10),
        'top_endpoints': Counter(endpoints).most_common(5),
        'status_distribution': dict(Counter(status_codes)),
        'methodes_distribution': dict(Counter(methodes)),
        'total_erreurs': len(erreurs),
        'erreurs': erreurs[:10]  # Limiter à 10 erreurs
    }
    
    return stats


def afficher_statistiques(stats):
    """
    Affiche les statistiques de manière formatée.
    
    Args:
        stats (dict): Dictionnaire contenant les statistiques
    """
    print("\n" + "="*70)
    print("           📊 ANALYSE DE LOGS WEB 📊")
    print("="*70)
    print()
    
    # Résumé général
    print("📋 RÉSUMÉ GÉNÉRAL")
    print("-" * 70)
    print(f"Total de lignes           : {stats['total_lignes']}")
    print(f"Lignes parsées avec succès: {stats['lignes_parsees']}")
    print(f"Lignes ignorées           : {stats['lignes_ignorees']}")
    print()
    
    # Top IPs
    print("🌐 TOP 10 DES ADRESSES IP")
    print("-" * 70)
    print(f"{'Rang':<6} {'Adresse IP':<20} {'Nombre de requêtes':<20}")
    print("-" * 70)
    for i, (ip, count) in enumerate(stats['top_ips'], 1):
        print(f"{i:<6} {ip:<20} {count:<20}")
    print()
    
    # Top Endpoints
    print("🎯 TOP 5 DES ENDPOINTS")
    print("-" * 70)
    print(f"{'Rang':<6} {'Endpoint':<40} {'Visites':<10}")
    print("-" * 70)
    for i, (endpoint, count) in enumerate(stats['top_endpoints'], 1):
        print(f"{i:<6} {endpoint:<40} {count:<10}")
    print()
    
    # Distribution des méthodes HTTP
    print("📡 DISTRIBUTION DES MÉTHODES HTTP")
    print("-" * 70)
    for methode, count in sorted(stats['methodes_distribution'].items()):
        pourcentage = (count / stats['lignes_parsees']) * 100
        barre = "█" * int(pourcentage / 2)
        print(f"{methode:<10} {count:>6} ({pourcentage:>5.1f}%) {barre}")
    print()
    
    # Distribution des codes de statut
    print("📈 DISTRIBUTION DES CODES DE STATUT HTTP")
    print("-" * 70)
    
    # Grouper par catégorie
    categories = {
        '2xx (Succès)': [],
        '3xx (Redirection)': [],
        '4xx (Erreur Client)': [],
        '5xx (Erreur Serveur)': []
    }
    
    for status, count in stats['status_distribution'].items():
        if 200 <= status < 300:
            categories['2xx (Succès)'].append((status, count))
        elif 300 <= status < 400:
            categories['3xx (Redirection)'].append((status, count))
        elif 400 <= status < 500:
            categories['4xx (Erreur Client)'].append((status, count))
        elif 500 <= status < 600:
            categories['5xx (Erreur Serveur)'].append((status, count))
    
    for categorie, codes in categories.items():
        if codes:
            total = sum(count for _, count in codes)
            print(f"\n{categorie}: {total} requêtes")
            for status, count in sorted(codes):
                pourcentage = (count / stats['lignes_parsees']) * 100
                print(f"  {status}: {count:>6} ({pourcentage:>5.1f}%)")
    
    print()
    
    # Erreurs détectées
    if stats['total_erreurs'] > 0:
        print(f"⚠️  ERREURS DÉTECTÉES (4xx & 5xx): {stats['total_erreurs']} erreurs")
        print("-" * 70)
        print(f"{'IP':<20} {'Endpoint':<30} {'Status':<10} {'Date':<25}")
        print("-" * 70)
        for erreur in stats['erreurs']:
            print(f"{erreur['ip']:<20} {erreur['endpoint']:<30} {erreur['status']:<10} {erreur['date']:<25}")
        
        if stats['total_erreurs'] > 10:
            print(f"\n... et {stats['total_erreurs'] - 10} autres erreurs")
    else:
        print("✅ AUCUNE ERREUR DÉTECTÉE")
    
    print()
    print("="*70)
    print()


def generer_rapport_markdown(stats, fichier_sortie="rapport_logs.md"):
    """
    Génère un rapport au format Markdown.
    
    Args:
        stats (dict): Statistiques à inclure dans le rapport
        fichier_sortie (str): Nom du fichier de sortie
    """
    with open(fichier_sortie, 'w', encoding='utf-8') as f:
        f.write("# Rapport d'Analyse de Logs Web\n\n")
        f.write(f"Généré le : {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        f.write("## Résumé Général\n\n")
        f.write(f"- Total de lignes : {stats['total_lignes']}\n")
        f.write(f"- Lignes parsées : {stats['lignes_parsees']}\n")
        f.write(f"- Lignes ignorées : {stats['lignes_ignorees']}\n\n")
        
        f.write("## Top 10 des IPs\n\n")
        f.write("| Rang | Adresse IP | Nombre de requêtes |\n")
        f.write("|------|------------|--------------------|\n")
        for i, (ip, count) in enumerate(stats['top_ips'], 1):
            f.write(f"| {i} | {ip} | {count} |\n")
        
        f.write("\n## Top 5 des Endpoints\n\n")
        f.write("| Rang | Endpoint | Nombre de visites |\n")
        f.write("|------|----------|-------------------|\n")
        for i, (endpoint, count) in enumerate(stats['top_endpoints'], 1):
            f.write(f"| {i} | {endpoint} | {count} |\n")
        
        f.write(f"\n## Erreurs\n\n")
        f.write(f"Total d'erreurs détectées : {stats['total_erreurs']}\n\n")
    
    print(f"✅ Rapport Markdown généré : {fichier_sortie}")


def main():
    """
    Fonction principale du script.
    """
    # Nom du fichier de logs
    script_dir = Path(__file__).parent
    nom_fichier = script_dir / 'sample.log'
    
    print("📖 Analyseur de Logs Web")
    print(f"📁 Lecture du fichier : {nom_fichier}")
    print()
    
    # Lecture du fichier
    lignes = lire_logs(nom_fichier)
    
    if not lignes:
        return
    
    print(f"✅ {len(lignes)} lignes lues")
    print("🔍 Analyse en cours...")
    print()
    
    # Analyse
    stats = analyser_logs(lignes)
    
    # Affichage
    afficher_statistiques(stats)
    
    # Génération du rapport (optionnel)
    reponse = input("Voulez-vous générer un rapport Markdown ? (o/n) : ").strip().lower()
    if reponse == 'o':
        generer_rapport_markdown(stats)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  Analyse interrompue par l'utilisateur.\n")
    except Exception as e:
        print(f"\n❌ Erreur inattendue : {e}\n")
