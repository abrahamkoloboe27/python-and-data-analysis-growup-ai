"""
Fusion de deux listes triées (Merge Step)

Ce script implémente l'algorithme de fusion de deux listes déjà triées
en une seule liste triée. C'est une étape clé de l'algorithme de tri fusion.

Pseudo-code :
DEBUT
  Entrée : liste1 (triée), liste2 (triée)
  résultat ← []
  i ← 0  -- Index pour liste1
  j ← 0  -- Index pour liste2
  
  TANT QUE i < longueur(liste1) ET j < longueur(liste2) FAIRE
    SI liste1[i] <= liste2[j] ALORS
      AJOUTER liste1[i] À résultat
      i ← i + 1
    SINON
      AJOUTER liste2[j] À résultat
      j ← j + 1
    FIN SI
  FIN TANT QUE
  
  -- Ajouter les éléments restants de liste1
  TANT QUE i < longueur(liste1) FAIRE
    AJOUTER liste1[i] À résultat
    i ← i + 1
  FIN TANT QUE
  
  -- Ajouter les éléments restants de liste2
  TANT QUE j < longueur(liste2) FAIRE
    AJOUTER liste2[j] À résultat
    j ← j + 1
  FIN TANT QUE
  
  RETOURNER résultat
FIN
"""


def fusion(liste1, liste2):
    """
    Fusionne deux listes triées en une seule liste triée.
    
    Cette fonction prend deux listes déjà triées et les combine
    en une seule liste triée, sans utiliser de fonction de tri.
    L'algorithme compare les éléments des deux listes un par un
    et ajoute le plus petit à la liste résultat.
    
    Args:
        liste1 (list): première liste triée
        liste2 (list): seconde liste triée
    
    Returns:
        list: liste triée contenant tous les éléments des deux listes
    
    Examples:
        >>> fusion([1, 3, 5], [2, 4, 6])
        [1, 2, 3, 4, 5, 6]
        >>> fusion([1, 2, 3], [4, 5, 6])
        [1, 2, 3, 4, 5, 6]
        >>> fusion([1, 4, 7], [2, 3])
        [1, 2, 3, 4, 7]
    
    Complexity:
        Temps : O(n + m) où n et m sont les longueurs des listes
        Espace : O(n + m) pour la liste résultat
    """
    resultat = []
    i = 0  # Index pour liste1
    j = 0  # Index pour liste2
    
    # Comparaison et fusion tant qu'il reste des éléments dans les deux listes
    while i < len(liste1) and j < len(liste2):
        if liste1[i] <= liste2[j]:
            resultat.append(liste1[i])
            i += 1
        else:
            resultat.append(liste2[j])
            j += 1
    
    # Ajouter les éléments restants de liste1
    while i < len(liste1):
        resultat.append(liste1[i])
        i += 1
    
    # Ajouter les éléments restants de liste2
    while j < len(liste2):
        resultat.append(liste2[j])
        j += 1
    
    return resultat


def fusion_pythonic(liste1, liste2):
    """
    Version plus pythonique de la fusion utilisant des slices.
    
    Args:
        liste1 (list): première liste triée
        liste2 (list): seconde liste triée
    
    Returns:
        list: liste triée contenant tous les éléments
    """
    resultat = []
    i, j = 0, 0
    
    while i < len(liste1) and j < len(liste2):
        if liste1[i] <= liste2[j]:
            resultat.append(liste1[i])
            i += 1
        else:
            resultat.append(liste2[j])
            j += 1
    
    # Ajouter les éléments restants (une des deux listes sera vide)
    resultat.extend(liste1[i:])
    resultat.extend(liste2[j:])
    
    return resultat


# Tests basiques
def test_fusion():
    """
    Teste la fonction fusion avec différents cas.
    """
    # Test 1 : Listes entrelacées
    resultat1 = fusion([1, 3, 5], [2, 4, 6])
    attendu1 = [1, 2, 3, 4, 5, 6]
    assert resultat1 == attendu1, f"Test 1 échoué : {resultat1} != {attendu1}"
    print("✓ Test 1 passé : fusion([1, 3, 5], [2, 4, 6]) = [1, 2, 3, 4, 5, 6]")
    
    # Test 2 : Listes disjointes
    resultat2 = fusion([1, 2, 3], [4, 5, 6])
    attendu2 = [1, 2, 3, 4, 5, 6]
    assert resultat2 == attendu2, f"Test 2 échoué : {resultat2} != {attendu2}"
    print("✓ Test 2 passé : fusion([1, 2, 3], [4, 5, 6]) = [1, 2, 3, 4, 5, 6]")
    
    # Test 3 : Listes de longueurs différentes
    resultat3 = fusion([1, 4, 7], [2, 3])
    attendu3 = [1, 2, 3, 4, 7]
    assert resultat3 == attendu3, f"Test 3 échoué : {resultat3} != {attendu3}"
    print("✓ Test 3 passé : fusion([1, 4, 7], [2, 3]) = [1, 2, 3, 4, 7]")
    
    # Test 4 : Une liste vide
    resultat4 = fusion([1, 2, 3], [])
    attendu4 = [1, 2, 3]
    assert resultat4 == attendu4, f"Test 4 échoué : {resultat4} != {attendu4}"
    print("✓ Test 4 passé : fusion([1, 2, 3], []) = [1, 2, 3]")
    
    # Test 5 : Deux listes vides
    resultat5 = fusion([], [])
    attendu5 = []
    assert resultat5 == attendu5, f"Test 5 échoué : {resultat5} != {attendu5}"
    print("✓ Test 5 passé : fusion([], []) = []")
    
    # Test 6 : Listes avec doublons
    resultat6 = fusion([1, 3, 3], [2, 3, 4])
    attendu6 = [1, 2, 3, 3, 3, 4]
    assert resultat6 == attendu6, f"Test 6 échoué : {resultat6} != {attendu6}"
    print("✓ Test 6 passé : fusion([1, 3, 3], [2, 3, 4]) = [1, 2, 3, 3, 3, 4]")
    
    print("\n✓ Tous les tests sont passés !")


def test_fusion_pythonic():
    """
    Teste la version pythonique.
    """
    resultat = fusion_pythonic([1, 3, 5], [2, 4, 6])
    attendu = [1, 2, 3, 4, 5, 6]
    assert resultat == attendu, "Test pythonic échoué"
    print("✓ Test pythonic passé : fusion_pythonic([1, 3, 5], [2, 4, 6]) = [1, 2, 3, 4, 5, 6]")


if __name__ == "__main__":
    print("=== Tests de l'algorithme de fusion ===\n")
    test_fusion()
    print("\n=== Test version pythonic ===\n")
    test_fusion_pythonic()
    
    # Exemples d'utilisation
    print("\n=== Exemples d'utilisation ===\n")
    print(f"Fusion de [1, 3, 5] et [2, 4, 6] : {fusion([1, 3, 5], [2, 4, 6])}")
    print(f"Fusion de [10, 20, 30] et [5, 15, 25] : {fusion([10, 20, 30], [5, 15, 25])}")
    print(f"Fusion de [1] et [2, 3, 4] : {fusion([1], [2, 3, 4])}")
