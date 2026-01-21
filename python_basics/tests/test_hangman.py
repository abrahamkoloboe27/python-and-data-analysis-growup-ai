"""
Tests unitaires pour le module hangman.py

Ce fichier contient des tests pour valider le jeu du pendu.

Pour exécuter les tests:
    pytest tests/test_hangman.py
    pytest tests/test_hangman.py -v  # Mode verbeux
"""

import pytest
import sys
from pathlib import Path

# Ajouter le dossier parent au path pour importer hangman
sys.path.insert(0, str(Path(__file__).parent.parent))

from hangman import (
    choisir_mot, afficher_etat, tester_lettre,
    verifier_victoire, LISTE_MOTS
)


# ============================================================================
# Tests de choisir_mot()
# ============================================================================

def test_choisir_mot_retourne_mot_valide():
    """Test que choisir_mot() retourne un mot de la liste."""
    mot = choisir_mot()
    assert mot in LISTE_MOTS


def test_choisir_mot_retourne_string():
    """Test que choisir_mot() retourne une chaîne."""
    mot = choisir_mot()
    assert isinstance(mot, str)


def test_choisir_mot_minuscules():
    """Test que le mot retourné est en minuscules."""
    mot = choisir_mot()
    assert mot == mot.lower()


# ============================================================================
# Tests de afficher_etat()
# ============================================================================

def test_afficher_etat_aucune_lettre():
    """Test l'affichage quand aucune lettre n'est trouvée."""
    mot = "python"
    lettres_trouvees = set()
    resultat = afficher_etat(mot, lettres_trouvees)
    assert resultat == "_ _ _ _ _ _"


def test_afficher_etat_quelques_lettres():
    """Test l'affichage avec quelques lettres trouvées."""
    mot = "python"
    lettres_trouvees = {"p", "t", "h"}
    resultat = afficher_etat(mot, lettres_trouvees)
    assert resultat == "p _ t h _ _"


def test_afficher_etat_toutes_lettres():
    """Test l'affichage quand toutes les lettres sont trouvées."""
    mot = "python"
    lettres_trouvees = {"p", "y", "t", "h", "o", "n"}
    resultat = afficher_etat(mot, lettres_trouvees)
    assert resultat == "p y t h o n"


def test_afficher_etat_mot_court():
    """Test avec un mot court."""
    mot = "ab"
    lettres_trouvees = {"a"}
    resultat = afficher_etat(mot, lettres_trouvees)
    assert resultat == "a _"


def test_afficher_etat_lettres_doublons():
    """Test avec un mot contenant des lettres en double."""
    mot = "banane"
    lettres_trouvees = {"b", "n"}
    resultat = afficher_etat(mot, lettres_trouvees)
    assert resultat == "b _ n _ n _"


# ============================================================================
# Tests de tester_lettre()
# ============================================================================

def test_tester_lettre_presente():
    """Test quand la lettre est présente dans le mot."""
    mot = "python"
    lettres_trouvees = set()
    
    resultat = tester_lettre(mot, "p", lettres_trouvees)
    
    assert resultat == True
    assert "p" in lettres_trouvees


def test_tester_lettre_absente():
    """Test quand la lettre n'est pas dans le mot."""
    mot = "python"
    lettres_trouvees = set()
    
    resultat = tester_lettre(mot, "z", lettres_trouvees)
    
    assert resultat == False
    assert "z" not in lettres_trouvees


def test_tester_lettre_majuscule():
    """Test que les majuscules sont converties en minuscules."""
    mot = "python"
    lettres_trouvees = set()
    
    resultat = tester_lettre(mot, "P", lettres_trouvees)
    
    assert resultat == True
    assert "p" in lettres_trouvees


def test_tester_lettre_doublon():
    """Test avec une lettre qui apparaît plusieurs fois."""
    mot = "banane"
    lettres_trouvees = set()
    
    resultat = tester_lettre(mot, "a", lettres_trouvees)
    
    assert resultat == True
    assert "a" in lettres_trouvees
    # On teste juste que 'a' est dans le set


# ============================================================================
# Tests de verifier_victoire()
# ============================================================================

def test_verifier_victoire_gagne():
    """Test quand toutes les lettres sont trouvées."""
    mot = "python"
    lettres_trouvees = {"p", "y", "t", "h", "o", "n"}
    
    assert verifier_victoire(mot, lettres_trouvees) == True


def test_verifier_victoire_pas_gagne():
    """Test quand il manque des lettres."""
    mot = "python"
    lettres_trouvees = {"p", "t", "h"}
    
    assert verifier_victoire(mot, lettres_trouvees) == False


def test_verifier_victoire_aucune_lettre():
    """Test quand aucune lettre n'est trouvée."""
    mot = "python"
    lettres_trouvees = set()
    
    assert verifier_victoire(mot, lettres_trouvees) == False


def test_verifier_victoire_lettres_en_trop():
    """Test avec plus de lettres que nécessaire."""
    mot = "python"
    lettres_trouvees = {"p", "y", "t", "h", "o", "n", "z", "a"}
    
    assert verifier_victoire(mot, lettres_trouvees) == True


def test_verifier_victoire_mot_doublon():
    """Test avec un mot contenant des lettres en double."""
    mot = "banane"
    lettres_trouvees = {"b", "a", "n", "e"}
    
    assert verifier_victoire(mot, lettres_trouvees) == True


# ============================================================================
# Tests Paramétrés
# ============================================================================

@pytest.mark.parametrize("mot, lettres, expected_affichage", [
    ("python", set(), "_ _ _ _ _ _"),
    ("python", {"p"}, "p _ _ _ _ _"),
    ("python", {"p", "n"}, "p _ _ _ _ n"),
    ("python", {"p", "y", "t", "h", "o", "n"}, "p y t h o n"),
    ("code", {"c", "d", "e"}, "c _ d e"),
])
def test_afficher_etat_parametrise(mot, lettres, expected_affichage):
    """Tests paramétrés pour afficher_etat."""
    assert afficher_etat(mot, lettres) == expected_affichage


@pytest.mark.parametrize("mot, lettre, attendu", [
    ("python", "p", True),
    ("python", "y", True),
    ("python", "z", False),
    ("python", "a", False),
    ("banane", "a", True),
    ("banane", "x", False),
])
def test_tester_lettre_parametrise(mot, lettre, attendu):
    """Tests paramétrés pour tester_lettre."""
    lettres_trouvees = set()
    resultat = tester_lettre(mot, lettre, lettres_trouvees)
    assert resultat == attendu


# ============================================================================
# Tests d'Intégration
# ============================================================================

def test_scenario_victoire():
    """Test un scénario complet de victoire."""
    mot = "code"
    lettres_trouvees = set()
    lettres_essayees = set()
    
    # Tour 1: essayer 'c'
    assert tester_lettre(mot, "c", lettres_trouvees) == True
    lettres_essayees.add("c")
    assert verifier_victoire(mot, lettres_trouvees) == False
    
    # Tour 2: essayer 'o'
    assert tester_lettre(mot, "o", lettres_trouvees) == True
    lettres_essayees.add("o")
    assert verifier_victoire(mot, lettres_trouvees) == False
    
    # Tour 3: essayer 'd'
    assert tester_lettre(mot, "d", lettres_trouvees) == True
    lettres_essayees.add("d")
    assert verifier_victoire(mot, lettres_trouvees) == False
    
    # Tour 4: essayer 'e'
    assert tester_lettre(mot, "e", lettres_trouvees) == True
    lettres_essayees.add("e")
    assert verifier_victoire(mot, lettres_trouvees) == True


def test_scenario_avec_erreurs():
    """Test un scénario avec des lettres incorrectes."""
    mot = "code"
    lettres_trouvees = set()
    erreurs = 0
    
    # Essayer une lettre incorrecte
    if not tester_lettre(mot, "z", lettres_trouvees):
        erreurs += 1
    assert erreurs == 1
    
    # Essayer une lettre correcte
    tester_lettre(mot, "c", lettres_trouvees)
    assert erreurs == 1
    
    # Essayer une autre lettre incorrecte
    if not tester_lettre(mot, "x", lettres_trouvees):
        erreurs += 1
    assert erreurs == 2


# ============================================================================
# Tests de Cas Limites
# ============================================================================

def test_mot_une_lettre():
    """Test avec un mot d'une seule lettre."""
    mot = "a"
    lettres_trouvees = {"a"}
    
    assert afficher_etat(mot, lettres_trouvees) == "a"
    assert verifier_victoire(mot, lettres_trouvees) == True


def test_lettres_trouvees_vide():
    """Test avec un set vide de lettres trouvées."""
    mot = "python"
    lettres_trouvees = set()
    
    resultat = afficher_etat(mot, lettres_trouvees)
    assert "_" in resultat
    assert verifier_victoire(mot, lettres_trouvees) == False


# ============================================================================
# Tests de Documentation
# ============================================================================

def test_fonctions_ont_docstrings():
    """Vérifie que les fonctions ont une documentation."""
    assert choisir_mot.__doc__ is not None
    assert afficher_etat.__doc__ is not None
    assert tester_lettre.__doc__ is not None
    assert verifier_victoire.__doc__ is not None


# ============================================================================
# Fixtures
# ============================================================================

@pytest.fixture
def jeu_en_cours():
    """Fixture représentant un jeu en cours."""
    return {
        "mot": "python",
        "lettres_trouvees": {"p", "t"},
        "lettres_essayees": {"p", "t", "z"},
        "erreurs": 1
    }


def test_avec_fixture(jeu_en_cours):
    """Test utilisant une fixture de jeu en cours."""
    mot = jeu_en_cours["mot"]
    lettres_trouvees = jeu_en_cours["lettres_trouvees"]
    
    affichage = afficher_etat(mot, lettres_trouvees)
    assert "p" in affichage
    assert "t" in affichage
    assert verifier_victoire(mot, lettres_trouvees) == False


if __name__ == "__main__":
    # Permet d'exécuter les tests directement avec python
    pytest.main([__file__, "-v"])
