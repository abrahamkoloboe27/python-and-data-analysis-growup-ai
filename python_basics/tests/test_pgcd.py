"""
Tests unitaires pour le module pgcd.py

Ce fichier contient des tests pour valider l'algorithme d'Euclide
de calcul du PGCD (Plus Grand Commun Diviseur).

Pour exécuter les tests:
    pytest tests/test_pgcd.py
    pytest tests/test_pgcd.py -v  # Mode verbeux
"""

import pytest
import sys
from pathlib import Path

# Ajouter le dossier parent au path pour importer pgcd
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'algorithmique'))

from pgcd import pgcd, pgcd_recursif


# ============================================================================
# Tests de Base
# ============================================================================

def test_pgcd_nombres_premiers_entre_eux():
    """Test avec deux nombres premiers entre eux (PGCD = 1)."""
    assert pgcd(7, 3) == 1
    assert pgcd(13, 17) == 1
    assert pgcd(11, 19) == 1


def test_pgcd_multiples():
    """Test avec un nombre multiple de l'autre."""
    assert pgcd(12, 4) == 4
    assert pgcd(15, 5) == 5
    assert pgcd(100, 25) == 25


def test_pgcd_nombres_identiques():
    """Test avec deux nombres identiques."""
    assert pgcd(25, 25) == 25
    assert pgcd(100, 100) == 100
    assert pgcd(1, 1) == 1


def test_pgcd_avec_zero():
    """Test avec zéro (PGCD(a, 0) = a)."""
    assert pgcd(15, 0) == 15
    assert pgcd(0, 20) == 20
    assert pgcd(0, 0) == 0


def test_pgcd_ordre_parametres():
    """Test que l'ordre des paramètres n'affecte pas le résultat."""
    assert pgcd(48, 18) == pgcd(18, 48)
    assert pgcd(100, 35) == pgcd(35, 100)


# ============================================================================
# Tests avec Valeurs Spécifiques
# ============================================================================

def test_pgcd_exemple_classique():
    """Test avec les exemples de la documentation."""
    assert pgcd(48, 18) == 6
    assert pgcd(100, 35) == 5


def test_pgcd_nombres_premiers():
    """Test avec des nombres premiers."""
    assert pgcd(17, 19) == 1
    assert pgcd(23, 29) == 1


def test_pgcd_puissances_de_deux():
    """Test avec des puissances de 2."""
    assert pgcd(16, 8) == 8
    assert pgcd(32, 16) == 16
    assert pgcd(64, 32) == 32


# ============================================================================
# Tests de Validation d'Entrée
# ============================================================================

def test_pgcd_nombres_negatifs():
    """Test que les nombres négatifs lèvent une ValueError."""
    with pytest.raises(ValueError):
        pgcd(-5, 10)
    
    with pytest.raises(ValueError):
        pgcd(10, -5)
    
    with pytest.raises(ValueError):
        pgcd(-10, -5)


# ============================================================================
# Tests de la Version Récursive
# ============================================================================

def test_pgcd_recursif_base():
    """Test de base de la version récursive."""
    assert pgcd_recursif(48, 18) == 6
    assert pgcd_recursif(100, 35) == 5
    assert pgcd_recursif(7, 3) == 1


def test_pgcd_recursif_avec_zero():
    """Test de la version récursive avec zéro."""
    assert pgcd_recursif(15, 0) == 15
    assert pgcd_recursif(0, 20) == 20


def test_pgcd_recursif_coherence():
    """Vérifier que les deux versions donnent les mêmes résultats."""
    test_cases = [
        (48, 18),
        (100, 35),
        (7, 3),
        (15, 0),
        (25, 25),
        (12, 4)
    ]
    
    for a, b in test_cases:
        assert pgcd(a, b) == pgcd_recursif(a, b)


# ============================================================================
# Tests Paramétrés
# ============================================================================

@pytest.mark.parametrize("a, b, expected", [
    (48, 18, 6),
    (100, 35, 5),
    (7, 3, 1),
    (15, 0, 15),
    (25, 25, 25),
    (12, 4, 4),
    (1071, 462, 21),
    (270, 192, 6),
])
def test_pgcd_parametrise(a, b, expected):
    """Tests paramétrés avec plusieurs cas."""
    assert pgcd(a, b) == expected


@pytest.mark.parametrize("a, b", [
    (48, 18),
    (100, 35),
    (17, 19),
    (12, 4),
    (25, 25),
])
def test_pgcd_commutativite(a, b):
    """Teste la propriété de commutativité: PGCD(a,b) = PGCD(b,a)."""
    assert pgcd(a, b) == pgcd(b, a)


# ============================================================================
# Tests de Performance (optionnel)
# ============================================================================

def test_pgcd_grands_nombres():
    """Test avec de très grands nombres."""
    # Ces tests vérifient que l'algorithme fonctionne avec de grands nombres
    assert pgcd(123456, 789012) == 12
    assert pgcd(999999, 111111) == 111111


# ============================================================================
# Tests de Propriétés Mathématiques
# ============================================================================

def test_pgcd_divisibilite():
    """Vérifie que le PGCD divise bien les deux nombres."""
    a, b = 48, 18
    resultat = pgcd(a, b)
    assert a % resultat == 0
    assert b % resultat == 0


def test_pgcd_maximalite():
    """Vérifie que le PGCD est bien le PLUS GRAND diviseur commun."""
    a, b = 48, 18
    resultat = pgcd(a, b)
    
    # Tout diviseur commun doit diviser le PGCD
    for d in range(1, min(a, b) + 1):
        if a % d == 0 and b % d == 0:
            # d est un diviseur commun
            assert resultat % d == 0


# ============================================================================
# Tests de Documentation
# ============================================================================

def test_pgcd_docstring():
    """Vérifie que les fonctions ont une documentation."""
    assert pgcd.__doc__ is not None
    assert len(pgcd.__doc__) > 0
    assert pgcd_recursif.__doc__ is not None


# ============================================================================
# Fixture pour des données de test
# ============================================================================

@pytest.fixture
def paires_nombres():
    """Fixture fournissant des paires de nombres pour les tests."""
    return [
        (48, 18, 6),
        (100, 35, 5),
        (7, 3, 1),
        (15, 0, 15),
        (25, 25, 25),
    ]


def test_pgcd_avec_fixture(paires_nombres):
    """Test utilisant une fixture."""
    for a, b, expected in paires_nombres:
        assert pgcd(a, b) == expected


# ============================================================================
# Tests de Régression
# ============================================================================

def test_pgcd_bug_fix_zero():
    """Test de régression: vérifier que PGCD(0, 0) = 0."""
    # Ce test documente le comportement avec (0, 0)
    assert pgcd(0, 0) == 0


if __name__ == "__main__":
    # Permet d'exécuter les tests directement avec python
    pytest.main([__file__, "-v"])
