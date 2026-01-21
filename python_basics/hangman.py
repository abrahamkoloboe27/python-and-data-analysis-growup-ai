"""
Jeu du Pendu (Hangman Game)
============================

Implémentation complète du jeu du pendu en Python.
Basé sur la conception algorithmique de hangman_design.md.

Fonctionnalités:
- Choix aléatoire d'un mot
- Affichage graphique du pendu
- Gestion des erreurs
- Sauvegarde des scores en JSON
- Interface utilisateur interactive

Utilisation:
    python hangman.py

Auteur: Cours Python et Analyse de Données
Session: S6 - Structures de contrôle et boucles
"""

import random
import json
import os
from datetime import datetime


# ============================================================================
# CONFIGURATION
# ============================================================================

LISTE_MOTS = [
    "python", "algorithme", "fonction", "variable", "boucle",
    "condition", "iteration", "module", "liste", "dictionnaire",
    "programmation", "ordinateur", "donnees", "analyse", "projet"
]

ERREURS_MAX = 6
FICHIER_SCORES = "hangman_scores.json"


# ============================================================================
# DESSINS DU PENDU
# ============================================================================

DESSINS_PENDU = [
    # 0 erreur
    """
       ------
       |    |
       |
       |
       |
       |
    --------
    """,
    # 1 erreur (tête)
    """
       ------
       |    |
       |    O
       |
       |
       |
    --------
    """,
    # 2 erreurs (corps)
    """
       ------
       |    |
       |    O
       |    |
       |
       |
    --------
    """,
    # 3 erreurs (bras gauche)
    """
       ------
       |    |
       |    O
       |   /|
       |
       |
    --------
    """,
    # 4 erreurs (bras droit)
    """
       ------
       |    |
       |    O
       |   /|\\
       |
       |
    --------
    """,
    # 5 erreurs (jambe gauche)
    """
       ------
       |    |
       |    O
       |   /|\\
       |   /
       |
    --------
    """,
    # 6 erreurs (jambe droite - perdu)
    """
       ------
       |    |
       |    O
       |   /|\\
       |   / \\
       |
    --------
    """
]


# ============================================================================
# FONCTIONS PRINCIPALES
# ============================================================================

def choisir_mot():
    """
    Choisit un mot aléatoirement dans une liste prédéfinie.
    
    Returns:
        str: Le mot choisi en minuscules
    """
    return random.choice(LISTE_MOTS)


def initialiser_jeu():
    """
    Initialise l'état du jeu avec les valeurs de départ.
    
    Returns:
        dict: État initial du jeu contenant:
            - mot: le mot secret
            - lettres_trouvees: set vide
            - lettres_essayees: set vide
            - erreurs: 0
            - erreurs_max: 6
            - termine: False
            - victoire: False
    """
    return {
        "mot": choisir_mot(),
        "lettres_trouvees": set(),
        "lettres_essayees": set(),
        "erreurs": 0,
        "erreurs_max": ERREURS_MAX,
        "termine": False,
        "victoire": False
    }


def afficher_etat(mot, lettres_trouvees):
    """
    Affiche l'état actuel du mot avec les lettres trouvées et des tirets.
    
    Args:
        mot (str): Le mot secret
        lettres_trouvees (set): Lettres déjà trouvées
    
    Returns:
        str: Représentation du mot avec lettres et tirets
    
    Example:
        >>> afficher_etat("python", {"p", "t", "h"})
        'p _ t h _ _'
    """
    affichage = ""
    for lettre in mot:
        if lettre in lettres_trouvees:
            affichage += lettre + " "
        else:
            affichage += "_ "
    return affichage.strip()


def tester_lettre(mot, lettre, lettres_trouvees):
    """
    Teste si une lettre est présente dans le mot.
    Si oui, l'ajoute aux lettres trouvées.
    
    Args:
        mot (str): Le mot secret
        lettre (str): La lettre proposée par le joueur
        lettres_trouvees (set): Lettres déjà trouvées (modifié)
    
    Returns:
        bool: True si la lettre est dans le mot, False sinon
    """
    lettre = lettre.lower()
    
    if lettre in mot:
        lettres_trouvees.add(lettre)
        return True
    return False


def verifier_victoire(mot, lettres_trouvees):
    """
    Vérifie si le joueur a trouvé toutes les lettres du mot.
    
    Args:
        mot (str): Le mot secret
        lettres_trouvees (set): Lettres déjà trouvées
    
    Returns:
        bool: True si toutes les lettres sont trouvées, False sinon
    """
    lettres_uniques_mot = set(mot)
    return lettres_uniques_mot.issubset(lettres_trouvees)


def afficher_pendu(erreurs):
    """
    Affiche une représentation visuelle ASCII du pendu.
    
    Args:
        erreurs (int): Nombre d'erreurs commises (0 à 6)
    """
    print(DESSINS_PENDU[erreurs])


# ============================================================================
# GESTION DES SCORES
# ============================================================================

def charger_scores():
    """
    Charge les scores depuis le fichier JSON.
    
    Returns:
        list: Liste des scores ou liste vide si le fichier n'existe pas
    """
    if os.path.exists(FICHIER_SCORES):
        try:
            with open(FICHIER_SCORES, 'r', encoding='utf-8') as f:
                return json.load(f)
        except json.JSONDecodeError:
            return []
    return []


def sauvegarder_score(joueur, victoire, erreurs, mot):
    """
    Sauvegarde le score d'une partie dans le fichier JSON.
    
    Args:
        joueur (str): Nom du joueur
        victoire (bool): True si victoire, False sinon
        erreurs (int): Nombre d'erreurs commises
        mot (str): Le mot à deviner
    """
    scores = charger_scores()
    
    nouveau_score = {
        "joueur": joueur,
        "victoire": victoire,
        "erreurs": erreurs,
        "mot": mot,
        "date": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }
    
    scores.append(nouveau_score)
    
    with open(FICHIER_SCORES, 'w', encoding='utf-8') as f:
        json.dump(scores, f, indent=2, ensure_ascii=False)


def afficher_scores():
    """
    Affiche les 10 derniers scores enregistrés.
    """
    scores = charger_scores()
    
    if not scores:
        print("\nAucun score enregistré.")
        return
    
    print("\n" + "="*60)
    print("           TABLEAU DES SCORES (10 derniers)")
    print("="*60)
    print(f"{'Joueur':<15} {'Résultat':<10} {'Erreurs':<10} {'Mot':<15} {'Date':<20}")
    print("-"*60)
    
    for score in scores[-10:]:
        resultat = "✅ Victoire" if score['victoire'] else "❌ Défaite"
        print(f"{score['joueur']:<15} {resultat:<10} {score['erreurs']}/{ERREURS_MAX:<8} {score['mot']:<15} {score['date']:<20}")
    
    print("="*60 + "\n")


# ============================================================================
# FONCTION PRINCIPALE DU JEU
# ============================================================================

def jouer():
    """
    Fonction principale du jeu.
    Gère la boucle de jeu et coordonne toutes les autres fonctions.
    """
    # Initialisation
    etat = initialiser_jeu()
    mot = etat["mot"]
    lettres_trouvees = etat["lettres_trouvees"]
    lettres_essayees = etat["lettres_essayees"]
    erreurs = etat["erreurs"]
    erreurs_max = etat["erreurs_max"]
    
    # Demander le nom du joueur
    print("\n" + "="*60)
    print("           🎮 BIENVENUE AU JEU DU PENDU 🎮")
    print("="*60)
    joueur = input("\nEntrez votre nom: ").strip() or "Anonyme"
    
    print(f"\nBonjour {joueur}!")
    print(f"Vous avez {erreurs_max} essais pour deviner le mot.")
    print(f"Le mot contient {len(mot)} lettres.")
    print("\nBonne chance! 🍀\n")
    
    # Boucle principale du jeu
    while erreurs < erreurs_max:
        # Affichage de l'état
        print("-" * 60)
        afficher_pendu(erreurs)
        print()
        print(f"Mot à deviner : {afficher_etat(mot, lettres_trouvees)}")
        print(f"Erreurs       : {erreurs} / {erreurs_max}")
        
        if lettres_essayees:
            lettres_triees = sorted(list(lettres_essayees))
            print(f"Lettres essayées : {', '.join(lettres_triees)}")
        
        print()
        
        # Demander une lettre au joueur
        lettre = input("Proposez une lettre : ").strip().lower()
        
        # Validation de l'entrée
        if len(lettre) != 1 or not lettre.isalpha():
            print("⚠ Veuillez entrer une seule lettre valide.")
            continue
        
        # Vérifier si la lettre a déjà été essayée
        if lettre in lettres_essayees:
            print("⚠ Vous avez déjà essayé cette lettre.")
            continue
        
        # Ajouter la lettre aux lettres essayées
        lettres_essayees.add(lettre)
        
        # Tester la lettre
        if tester_lettre(mot, lettre, lettres_trouvees):
            print("✅ Bonne lettre !")
        else:
            erreurs += 1
            print("❌ Lettre incorrecte !")
        
        print()
        
        # Vérifier la condition de victoire
        if verifier_victoire(mot, lettres_trouvees):
            afficher_pendu(erreurs)
            print()
            print("="*60)
            print("           🎉 FÉLICITATIONS ! 🎉")
            print("           Vous avez gagné !")
            print("="*60)
            print()
            print(f"Le mot était : {mot.upper()}")
            print(f"Nombre d'erreurs : {erreurs} / {erreurs_max}")
            print()
            
            # Sauvegarder le score
            sauvegarder_score(joueur, True, erreurs, mot)
            return True
    
    # Défaite (sortie de boucle = trop d'erreurs)
    afficher_pendu(erreurs)
    print()
    print("="*60)
    print("           💀 PERDU ! 💀")
    print("="*60)
    print()
    print(f"Le mot était : {mot.upper()}")
    print(f"Vous avez fait {erreurs} erreurs.")
    print()
    
    # Sauvegarder le score
    sauvegarder_score(joueur, False, erreurs, mot)
    return False


# ============================================================================
# MENU PRINCIPAL
# ============================================================================

def menu_principal():
    """
    Affiche le menu principal et gère les choix de l'utilisateur.
    """
    while True:
        print("\n" + "="*60)
        print("           🎮 JEU DU PENDU - MENU PRINCIPAL 🎮")
        print("="*60)
        print("\n1. Jouer une partie")
        print("2. Voir les scores")
        print("3. Règles du jeu")
        print("0. Quitter")
        print()
        
        choix = input("Votre choix : ").strip()
        
        if choix == "1":
            jouer()
            input("\nAppuyez sur Entrée pour continuer...")
        elif choix == "2":
            afficher_scores()
            input("Appuyez sur Entrée pour continuer...")
        elif choix == "3":
            afficher_regles()
            input("\nAppuyez sur Entrée pour continuer...")
        elif choix == "0":
            print("\n👋 Merci d'avoir joué ! À bientôt !\n")
            break
        else:
            print("\n⚠ Choix invalide. Veuillez réessayer.")


def afficher_regles():
    """
    Affiche les règles du jeu.
    """
    print("\n" + "="*60)
    print("           📖 RÈGLES DU JEU DU PENDU")
    print("="*60)
    print("""
1. Un mot secret est choisi aléatoirement.

2. Le mot est affiché avec des tirets (_) pour chaque lettre.

3. Vous proposez une lettre à chaque tour.

4. Si la lettre est dans le mot, elle est révélée à toutes
   ses positions.

5. Si la lettre n'est pas dans le mot, vous perdez une vie
   (erreur).

6. Vous avez un maximum de 6 erreurs.

7. Vous gagnez si vous devinez toutes les lettres avant
   d'épuiser vos vies.

8. Vous perdez si vous faites 6 erreurs.

Bonne chance! 🍀
    """)
    print("="*60)


# ============================================================================
# POINT D'ENTRÉE
# ============================================================================

if __name__ == "__main__":
    try:
        menu_principal()
    except KeyboardInterrupt:
        print("\n\n👋 Jeu interrompu. À bientôt !\n")
    except Exception as e:
        print(f"\n❌ Erreur inattendue: {e}\n")
