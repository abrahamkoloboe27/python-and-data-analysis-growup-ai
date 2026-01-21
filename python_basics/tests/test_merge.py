"""
Tests unitaires pour le module merge.py

Ce fichier contient des tests pour valider l'algorithme de fusion
de deux listes triées.

Pour exécuter les tests:
    pytest tests/test_merge.py
    pytest tests/test_merge.py -v  # Mode verbeux
"""

import pytest
import sys
from pathlib import Path

# Ajouter le dossier parent au path pour importer merge
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'algorithmique'))

from merge import fusion, fusion_pythonic


# ============================================================================
# Tests de Base
# ============================================================================

def test_fusion_listes_entrelacees():
    """Test avec deux listes dont les éléments s'entrelacent."""
    resultat = fusion([1, 3, 5], [2, 4, 6])
    assert resultat == [1, 2, 3, 4, 5, 6]


def test_fusion_listes_disjointes():
    """Test avec deux listes complètement disjointes."""
    resultat = fusion([1, 2, 3], [4, 5, 6])
    assert resultat == [1, 2, 3, 4, 5, 6]
    
    resultat2 = fusion([10, 20, 30], [1, 2, 3])
    assert resultat2 == [1, 2, 3, 10, 20, 30]


def test_fusion_avec_liste_vide():
    """Test avec une liste vide."""
    resultat = fusion([1, 2, 3], [])
    assert resultat == [1, 2, 3]
    
    resultat2 = fusion([], [4, 5, 6])
    assert resultat2 == [4, 5, 6]


def test_fusion_deux_listes_vides():
    """Test avec deux listes vides."""
    resultat = fusion([], [])
    assert resultat == []


def test_fusion_longueurs_differentes():
    """Test avec des listes de longueurs différentes."""
    resultat = fusion([1, 4, 7], [2, 3])
    assert resultat == [1, 2, 3, 4, 7]
    
    resultat2 = fusion([1], [2, 3, 4, 5, 6])
    assert resultat2 == [1, 2, 3, 4, 5, 6]


# ============================================================================
# Tests avec Doublons
# ============================================================================

def test_fusion_avec_doublons():
    """Test avec des éléments dupliqués."""
    resultat = fusion([1, 3, 3], [2, 3, 4])
    assert resultat == [1, 2, 3, 3, 3, 4]


def test_fusion_tous_identiques():
    """Test avec toutes les mêmes valeurs."""
    resultat = fusion([5, 5, 5], [5, 5])
    assert resultat == [5, 5, 5, 5, 5]


# ============================================================================
# Tests avec Nombres Négatifs
# ============================================================================

def test_fusion_nombres_negatifs():
    """Test avec des nombres négatifs."""
    resultat = fusion([-5, -3, -1], [-4, -2, 0])
    assert resultat == [-5, -4, -3, -2, -1, 0]


def test_fusion_mixte_positifs_negatifs():
    """Test avec un mélange de nombres positifs et négatifs."""
    resultat = fusion([-3, 0, 5], [-2, 3, 7])
    assert resultat == [-3, -2, 0, 3, 5, 7]


# ============================================================================
# Tests de la Version Pythonic
# ============================================================================

def test_fusion_pythonic_base():
    """Test de base de la version pythonique."""
    resultat = fusion_pythonic([1, 3, 5], [2, 4, 6])
    assert resultat == [1, 2, 3, 4, 5, 6]


def test_fusion_pythonic_liste_vide():
    """Test de la version pythonique avec liste vide."""
    resultat = fusion_pythonic([1, 2, 3], [])
    assert resultat == [1, 2, 3]


def test_fusion_pythonic_coherence():
    """Vérifier que les deux versions donnent les mêmes résultats."""
    test_cases = [
        ([1, 3, 5], [2, 4, 6]),
        ([1, 2, 3], [4, 5, 6]),
        ([1, 4, 7], [2, 3]),
        ([], [1, 2, 3]),
        ([1, 3, 3], [2, 3, 4]),
    ]
    
    for liste1, liste2 in test_cases:
        assert fusion(liste1, liste2) == fusion_pythonic(liste1, liste2)


# ============================================================================
# Tests Paramétrés
# ============================================================================

@pytest.mark.parametrize("liste1, liste2, expected", [
    ([1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]),
    ([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6]),
    ([1, 4, 7], [2, 3], [1, 2, 3, 4, 7]),
    ([], [1, 2, 3], [1, 2, 3]),
    ([1, 2, 3], [], [1, 2, 3]),
    ([], [], []),
    ([1, 3, 3], [2, 3, 4], [1, 2, 3, 3, 3, 4]),
])
def test_fusion_parametrise(liste1, liste2, expected):
    """Tests paramétrés avec plusieurs cas."""
    assert fusion(liste1, liste2) == expected


# ============================================================================
# Tests de Propriétés
# ============================================================================

def test_fusion_longueur():
    """Vérifie que la longueur du résultat est correcte."""
    liste1 = [1, 3, 5]
    liste2 = [2, 4, 6]
    resultat = fusion(liste1, liste2)
    assert len(resultat) == len(liste1) + len(liste2)


def test_fusion_tous_elements_presents():
    """Vérifie que tous les éléments sont présents dans le résultat."""
    liste1 = [1, 3, 5]
    liste2 = [2, 4, 6]
    resultat = fusion(liste1, liste2)
    
    # Vérifier que tous les éléments de liste1 sont dans resultat
    for element in liste1:
        assert element in resultat
    
    # Vérifier que tous les éléments de liste2 sont dans resultat
    for element in liste2:
        assert element in resultat


def test_fusion_est_triee():
    """Vérifie que le résultat est bien trié."""
    liste1 = [1, 3, 5]
    liste2 = [2, 4, 6]
    resultat = fusion(liste1, liste2)
    
    # Vérifier que le résultat est trié
    assert resultat == sorted(resultat)


def test_fusion_preserve_ordre():
    """Vérifie que l'ordre relatif des éléments est préservé."""
    liste1 = [1, 3, 5]
    liste2 = [2, 4, 6]
    resultat = fusion(liste1, liste2)
    
    # Les éléments de liste1 doivent apparaître dans le même ordre
    indices_liste1 = [resultat.index(x) for x in liste1]
    assert indices_liste1 == sorted(indices_liste1)
    
    # Les éléments de liste2 doivent apparaître dans le même ordre
    indices_liste2 = [resultat.index(x) for x in liste2]
    assert indices_liste2 == sorted(indices_liste2)


# ============================================================================
# Tests avec Différents Types
# ============================================================================

def test_fusion_floats():
    """Test avec des nombres à virgule flottante."""
    resultat = fusion([1.5, 3.7, 5.2], [2.1, 4.9])
    assert resultat == [1.5, 2.1, 3.7, 4.9, 5.2]


def test_fusion_strings():
    """Test avec des chaînes de caractères."""
    resultat = fusion(["a", "c", "e"], ["b", "d", "f"])
    assert resultat == ["a", "b", "c", "d", "e", "f"]


# ============================================================================
# Tests de Documentation
# ============================================================================

def test_fusion_docstring():
    """Vérifie que les fonctions ont une documentation."""
    assert fusion.__doc__ is not None
    assert len(fusion.__doc__) > 0
    assert fusion_pythonic.__doc__ is not None


# ============================================================================
# Fixtures
# ============================================================================

@pytest.fixture
def listes_test():
    """Fixture fournissant des listes de test."""
    return {
        "liste1": [1, 3, 5, 7, 9],
        "liste2": [2, 4, 6, 8, 10],
        "expected": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }


def test_fusion_avec_fixture(listes_test):
    """Test utilisant une fixture."""
    resultat = fusion(listes_test["liste1"], listes_test["liste2"])
    assert resultat == listes_test["expected"]


# ============================================================================
# Tests de Performance
# ============================================================================

def test_fusion_grandes_listes():
    """Test avec de grandes listes."""
    liste1 = list(range(0, 1000, 2))  # Nombres pairs
    liste2 = list(range(1, 1000, 2))  # Nombres impairs
    resultat = fusion(liste1, liste2)
    
    assert len(resultat) == 1000
    assert resultat == list(range(1000))


# ============================================================================
# Tests de Cas Limites
# ============================================================================

def test_fusion_un_seul_element():
    """Test avec des listes à un seul élément."""
    resultat = fusion([1], [2])
    assert resultat == [1, 2]


def test_fusion_element_unique_identique():
    """Test avec le même élément dans les deux listes."""
    resultat = fusion([5], [5])
    assert resultat == [5, 5]


# ============================================================================
# Tests de Non-Modification
# ============================================================================

def test_fusion_ne_modifie_pas_entrees():
    """Vérifie que les listes d'entrée ne sont pas modifiées."""
    liste1 = [1, 3, 5]
    liste2 = [2, 4, 6]
    liste1_copie = liste1.copy()
    liste2_copie = liste2.copy()
    
    fusion(liste1, liste2)
    
    assert liste1 == liste1_copie
    assert liste2 == liste2_copie


if __name__ == "__main__":
    # Permet d'exécuter les tests directement avec python
    pytest.main([__file__, "-v"])
