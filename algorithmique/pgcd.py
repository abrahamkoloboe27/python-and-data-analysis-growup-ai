"""
Algorithme d'Euclide - Calcul du PGCD (Plus Grand Commun Diviseur)

Ce script implémente l'algorithme d'Euclide pour calculer le PGCD
de deux entiers positifs.

Pseudo-code :
DEBUT
  Entrée : a, b
  TANT QUE b ≠ 0 FAIRE
    reste ← a modulo b
    a ← b
    b ← reste
  FIN TANT QUE
  RETOURNER a
FIN
"""


def pgcd(a, b):
    """
    Calcule le Plus Grand Commun Diviseur de deux entiers positifs.
    
    Utilise l'algorithme d'Euclide par divisions successives.
    L'algorithme repose sur le principe :
    - Si b = 0, alors PGCD(a, b) = a
    - Sinon, PGCD(a, b) = PGCD(b, a modulo b)
    
    Args:
        a (int): premier entier positif
        b (int): second entier positif
    
    Returns:
        int: le PGCD de a et b
    
    Examples:
        >>> pgcd(48, 18)
        6
        >>> pgcd(100, 35)
        5
        >>> pgcd(7, 3)
        1
    
    Raises:
        ValueError: si a ou b est négatif
    """
    # Validation des entrées
    if a < 0 or b < 0:
        raise ValueError("Les nombres doivent être positifs")
    
    # Algorithme d'Euclide
    while b != 0:
        reste = a % b
        a = b
        b = reste
    
    return a


def pgcd_recursif(a, b):
    """
    Version récursive de l'algorithme d'Euclide.
    
    Args:
        a (int): premier entier positif
        b (int): second entier positif
    
    Returns:
        int: le PGCD de a et b
    
    Examples:
        >>> pgcd_recursif(48, 18)
        6
    """
    if b == 0:
        return a
    return pgcd_recursif(b, a % b)


# Tests basiques
def test_pgcd():
    """
    Teste la fonction pgcd avec différents cas.
    """
    # Test 1 : PGCD de 48 et 18
    assert pgcd(48, 18) == 6, "Test 1 échoué"
    print("✓ Test 1 passé : pgcd(48, 18) = 6")
    
    # Test 2 : PGCD de 100 et 35
    assert pgcd(100, 35) == 5, "Test 2 échoué"
    print("✓ Test 2 passé : pgcd(100, 35) = 5")
    
    # Test 3 : PGCD de 7 et 3 (nombres premiers entre eux)
    assert pgcd(7, 3) == 1, "Test 3 échoué"
    print("✓ Test 3 passé : pgcd(7, 3) = 1")
    
    # Test 4 : PGCD avec un nombre égal à 0
    assert pgcd(15, 0) == 15, "Test 4 échoué"
    print("✓ Test 4 passé : pgcd(15, 0) = 15")
    
    # Test 5 : PGCD de deux nombres identiques
    assert pgcd(25, 25) == 25, "Test 5 échoué"
    print("✓ Test 5 passé : pgcd(25, 25) = 25")
    
    print("\n✓ Tous les tests sont passés !")


def test_pgcd_recursif():
    """
    Teste la version récursive.
    """
    assert pgcd_recursif(48, 18) == 6, "Test récursif échoué"
    print("✓ Test récursif passé : pgcd_recursif(48, 18) = 6")


if __name__ == "__main__":
    print("=== Tests de l'algorithme d'Euclide ===\n")
    test_pgcd()
    print("\n=== Test version récursive ===\n")
    test_pgcd_recursif()
    
    # Exemples d'utilisation
    print("\n=== Exemples d'utilisation ===\n")
    print(f"PGCD de 48 et 18 : {pgcd(48, 18)}")
    print(f"PGCD de 100 et 35 : {pgcd(100, 35)}")
    print(f"PGCD de 17 et 19 : {pgcd(17, 19)}")
