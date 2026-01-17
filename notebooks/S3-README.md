# S3 — Structures de données élémentaires & itération

## Objectifs pédagogiques

À l'issue de cette séance, l'apprenant doit être capable de :

* Comprendre et utiliser les listes (tableaux) et leurs opérations de base.
* Maîtriser l'accès, l'itération et le découpage (slicing) des listes.
* Utiliser les dictionnaires pour associer clés et valeurs.
* Comprendre le concept d'ensembles (sets) et leur utilité.
* Implémenter des accumulateurs et compteurs.
* Manipuler des structures de données pour résoudre des problèmes concrets.


## Introduction — Pourquoi les structures de données ?

Les **structures de données** permettent d'organiser et de stocker des informations de manière efficace.

Au lieu de manipuler des variables individuelles :

```
note1 ← 12
note2 ← 15
note3 ← 9
```

On peut regrouper les données dans une structure :

```
notes ← [12, 15, 9]
```

Cela facilite :

* La manipulation de grandes quantités de données
* L'application d'opérations sur des collections
* L'organisation logique des informations


## 1. Les listes (tableaux)

### 1.1 Définition

Une **liste** est une collection ordonnée d'éléments, accessibles par leur position (index).

**Caractéristiques :**

* Les éléments sont ordonnés (ils ont une position)
* On peut accéder à un élément par son index (position)
* Les éléments peuvent être de n'importe quel type
* Une liste peut contenir des doublons

**Notation :**

```
liste ← [élément1, élément2, élément3, ...]
```

**Exemples :**

```
nombres ← [1, 2, 3, 4, 5]
prénoms ← ["Alice", "Bob", "Charlie"]
mixte ← [10, "texte", 3.14, VRAI]
```


### 1.2 Accès aux éléments

Les éléments d'une liste sont numérotés à partir de 0.

```
liste ← ["a", "b", "c", "d"]
```

* Premier élément : `liste[0]` → `"a"`
* Deuxième élément : `liste[1]` → `"b"`
* Dernier élément : `liste[3]` → `"d"`

**Exemple d'accès :**

```
DEBUT
  fruits ← ["pomme", "banane", "orange"]
  
  premier_fruit ← fruits[0]
  AFFICHER premier_fruit  -- Affiche "pomme"
  
  fruits[1] ← "poire"  -- Remplace "banane" par "poire"
  AFFICHER fruits  -- Affiche ["pomme", "poire", "orange"]
FIN
```


### 1.3 Longueur d'une liste

La fonction `longueur()` retourne le nombre d'éléments dans la liste.

```
DEBUT
  nombres ← [10, 20, 30, 40]
  taille ← longueur(nombres)
  AFFICHER taille  -- Affiche 4
FIN
```


### 1.4 Itération sur une liste

On peut parcourir tous les éléments d'une liste avec une boucle.

**Parcours direct :**

```
DEBUT
  notes ← [12, 15, 9, 18]
  
  POUR chaque note dans notes FAIRE
    AFFICHER note
  FIN POUR
FIN
```

**Parcours par index :**

```
DEBUT
  notes ← [12, 15, 9, 18]
  
  POUR i DE 0 À longueur(notes) - 1 FAIRE
    AFFICHER "Note", i, ":", notes[i]
  FIN POUR
FIN
```


### 1.5 Découpage (slicing)

Le découpage permet d'extraire une partie d'une liste.

**Notation générale :**

```
sous_liste ← liste[début:fin]
```

* `début` : index de départ (inclus)
* `fin` : index de fin (exclus)

**Exemples :**

```
DEBUT
  nombres ← [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  
  partie1 ← nombres[2:5]    -- [2, 3, 4]
  partie2 ← nombres[0:3]    -- [0, 1, 2]
  partie3 ← nombres[5:]     -- [5, 6, 7, 8, 9]
  partie4 ← nombres[:4]     -- [0, 1, 2, 3]
FIN
```


### 1.6 Opérations courantes sur les listes

**Ajouter un élément :**

```
AJOUTER élément À liste
```

**Supprimer un élément :**

```
SUPPRIMER élément DE liste
```

**Vérifier la présence d'un élément :**

```
SI élément DANS liste ALORS
  AFFICHER "Trouvé"
FIN SI
```

**Exemple — Construire une liste progressivement :**

```
DEBUT
  résultats ← []  -- Liste vide
  
  POUR i DE 1 À 5 FAIRE
    carré ← i * i
    AJOUTER carré À résultats
  FIN POUR
  
  AFFICHER résultats  -- [1, 4, 9, 16, 25]
FIN
```


## 2. Les dictionnaires (maps)

### 2.1 Définition

Un **dictionnaire** est une collection d'associations **clé → valeur**.

**Caractéristiques :**

* Chaque clé est unique
* On accède aux valeurs par leur clé (pas par un index numérique)
* L'ordre d'insertion est préservé (dans les versions récentes)

**Notation :**

```
dictionnaire ← {clé1: valeur1, clé2: valeur2, ...}
```

**Exemples :**

```
âges ← {"Alice": 25, "Bob": 30, "Charlie": 28}
scores ← {"joueur1": 100, "joueur2": 85, "joueur3": 92}
infos ← {"nom": "Dupont", "prénom": "Marie", "ville": "Paris"}
```


### 2.2 Accès aux valeurs

On accède à une valeur en utilisant sa clé :

```
DEBUT
  âges ← {"Alice": 25, "Bob": 30}
  
  âge_alice ← âges["Alice"]
  AFFICHER âge_alice  -- Affiche 25
  
  âges["Bob"] ← 31  -- Modifie l'âge de Bob
FIN
```


### 2.3 Itération sur un dictionnaire

**Parcourir les clés :**

```
DEBUT
  scores ← {"Alice": 100, "Bob": 85, "Charlie": 92}
  
  POUR chaque joueur dans clés(scores) FAIRE
    AFFICHER joueur
  FIN POUR
FIN
```

**Parcourir clés et valeurs :**

```
DEBUT
  scores ← {"Alice": 100, "Bob": 85, "Charlie": 92}
  
  POUR chaque (joueur, score) dans items(scores) FAIRE
    AFFICHER joueur, "a obtenu", score, "points"
  FIN POUR
FIN
```


### 2.4 Ajouter ou modifier une entrée

```
DEBUT
  scores ← {"Alice": 100}
  
  -- Ajouter une nouvelle entrée
  scores["Bob"] ← 85
  
  -- Modifier une entrée existante
  scores["Alice"] ← 105
  
  AFFICHER scores  -- {"Alice": 105, "Bob": 85}
FIN
```


### 2.5 Vérifier l'existence d'une clé

```
DEBUT
  âges ← {"Alice": 25, "Bob": 30}
  
  SI "Alice" DANS âges ALORS
    AFFICHER "Alice est dans le dictionnaire"
  FIN SI
FIN
```


## 3. Les ensembles (sets)

### 3.1 Définition

Un **ensemble** est une collection d'éléments **uniques** et **non ordonnés**.

**Caractéristiques :**

* Pas de doublons (chaque élément apparaît une seule fois)
* Pas d'ordre défini
* Opérations rapides pour vérifier la présence d'un élément

**Notation :**

```
ensemble ← {élément1, élément2, élément3}
```

**Exemples :**

```
nombres_uniques ← {1, 2, 3, 4, 5}
couleurs ← {"rouge", "vert", "bleu"}
```


### 3.2 Utilité des ensembles

Les ensembles sont utiles pour :

* Éliminer les doublons d'une liste
* Vérifier rapidement si un élément existe
* Effectuer des opérations mathématiques (union, intersection, différence)

**Exemple — Éliminer les doublons :**

```
DEBUT
  liste ← [1, 2, 2, 3, 3, 3, 4, 5]
  ensemble ← convertir_en_ensemble(liste)
  AFFICHER ensemble  -- {1, 2, 3, 4, 5}
FIN
```


## 4. Compteurs et accumulateurs

### 4.1 Accumulateur simple (somme)

Un **accumulateur** est une variable qui accumule des valeurs au fil des itérations.

**Exemple — Calculer la somme d'une liste :**

```
DEBUT
  nombres ← [10, 20, 30, 40]
  somme ← 0  -- Initialisation de l'accumulateur
  
  POUR chaque nombre dans nombres FAIRE
    somme ← somme + nombre
  FIN POUR
  
  AFFICHER somme  -- Affiche 100
FIN
```


### 4.2 Compteur

Un **compteur** est une variable qui compte le nombre d'occurrences.

**Exemple — Compter les nombres pairs :**

```
DEBUT
  nombres ← [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  compteur ← 0
  
  POUR chaque nombre dans nombres FAIRE
    SI nombre modulo 2 = 0 ALORS
      compteur ← compteur + 1
    FIN SI
  FIN POUR
  
  AFFICHER compteur  -- Affiche 5
FIN
```


### 4.3 Somme cumulative

La **somme cumulative** crée une nouvelle liste où chaque élément est la somme de tous les éléments précédents.

**Exemple :**

```
DEBUT
  nombres ← [1, 2, 3, 4, 5]
  cumulées ← []
  somme ← 0
  
  POUR chaque nombre dans nombres FAIRE
    somme ← somme + nombre
    AJOUTER somme À cumulées
  FIN POUR
  
  AFFICHER cumulées  -- [1, 3, 6, 10, 15]
FIN
```


### 4.4 Compteur avec dictionnaire

On peut utiliser un dictionnaire pour compter les occurrences de différents éléments.

**Exemple — Compter la fréquence des lettres :**

```
DEBUT
  texte ← "bonjour"
  fréquences ← {}
  
  POUR chaque lettre dans texte FAIRE
    SI lettre DANS fréquences ALORS
      fréquences[lettre] ← fréquences[lettre] + 1
    SINON
      fréquences[lettre] ← 1
    FIN SI
  FIN POUR
  
  AFFICHER fréquences  -- {"b":1, "o":2, "n":1, "j":1, "u":1, "r":1}
FIN
```


## 5. Concepts de piles et queues

### 5.1 Pile (Stack) — LIFO

Une **pile** fonctionne selon le principe **LIFO** (Last In, First Out : dernier entré, premier sorti).

**Analogie :** Une pile d'assiettes.

**Opérations principales :**

* **EMPILER** (push) : ajouter un élément au sommet
* **DÉPILER** (pop) : retirer l'élément du sommet

**Exemple conceptuel :**

```
DEBUT
  pile ← []
  
  EMPILER 10 dans pile   -- pile = [10]
  EMPILER 20 dans pile   -- pile = [10, 20]
  EMPILER 30 dans pile   -- pile = [10, 20, 30]
  
  élément ← DÉPILER de pile  -- élément = 30, pile = [10, 20]
FIN
```


### 5.2 Queue (File) — FIFO

Une **queue** fonctionne selon le principe **FIFO** (First In, First Out : premier entré, premier sorti).

**Analogie :** Une file d'attente au guichet.

**Opérations principales :**

* **ENFILER** (enqueue) : ajouter un élément à la fin
* **DÉFILER** (dequeue) : retirer l'élément du début

**Exemple conceptuel :**

```
DEBUT
  queue ← []
  
  ENFILER 10 dans queue   -- queue = [10]
  ENFILER 20 dans queue   -- queue = [10, 20]
  ENFILER 30 dans queue   -- queue = [10, 20, 30]
  
  élément ← DÉFILER de queue  -- élément = 10, queue = [20, 30]
FIN
```


## Exercices — Travail à rendre

### Consignes générales

Vous devez créer :

1. Deux fichiers Python avec les implémentations demandées
2. Un notebook **data_structs_s3.ipynb** avec des exemples et mini-exercices


### Exercice 1 — Fusion de deux listes triées (merge step)

**Objectif** : fusionner deux listes déjà triées en une seule liste triée.

**Spécification :**

* **Entrée** : deux listes triées `liste1` et `liste2`
* **Sortie** : une liste triée contenant tous les éléments des deux listes
* **Contrainte** : ne pas utiliser de fonction de tri, faire la fusion directement

**Principe de l'algorithme :**

On compare les premiers éléments de chaque liste et on ajoute le plus petit à la liste résultat, puis on avance dans la liste correspondante.

**Exemple de pseudo-code :**

```
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
```

**Tests à réaliser :**

1. `fusion([1, 3, 5], [2, 4, 6])` → `[1, 2, 3, 4, 5, 6]`
2. `fusion([1, 2, 3], [4, 5, 6])` → `[1, 2, 3, 4, 5, 6]`
3. `fusion([1, 4, 7], [2, 3])` → `[1, 2, 3, 4, 7]`


### Exercice 2 — Détecter les doublons et calculer les fréquences

**Objectif** : identifier les éléments qui apparaissent plusieurs fois dans une liste et retourner leurs fréquences.

**Spécification :**

* **Entrée** : une liste d'éléments
* **Sortie** : un dictionnaire où les clés sont les éléments qui apparaissent plus d'une fois, et les valeurs sont leurs fréquences

**Principe de l'algorithme :**

1. Parcourir la liste et compter les occurrences de chaque élément (utiliser un dictionnaire)
2. Filtrer pour ne garder que les éléments avec une fréquence > 1

**Exemple de pseudo-code :**

```
DEBUT
  Entrée : liste
  compteur ← {}  -- Dictionnaire vide
  
  -- Compter les occurrences
  POUR chaque élément dans liste FAIRE
    SI élément DANS compteur ALORS
      compteur[élément] ← compteur[élément] + 1
    SINON
      compteur[élément] ← 1
    FIN SI
  FIN POUR
  
  -- Filtrer les doublons (fréquence > 1)
  doublons ← {}
  POUR chaque (élément, fréquence) dans items(compteur) FAIRE
    SI fréquence > 1 ALORS
      doublons[élément] ← fréquence
    FIN SI
  FIN POUR
  
  RETOURNER doublons
FIN
```

**Tests à réaliser :**

1. `detecter_doublons([1, 2, 3, 2, 4, 3])` → `{2: 2, 3: 2}`
2. `detecter_doublons(["a", "b", "a", "c", "b", "a"])` → `{"a": 3, "b": 2}`
3. `detecter_doublons([1, 2, 3, 4, 5])` → `{}` (pas de doublons)


## Notebook data_structs_s3.ipynb

### Contenu attendu

Le notebook doit contenir :

1. **Section 1 : Exemples de listes**
   * Création de listes
   * Accès aux éléments
   * Slicing
   * Itération

2. **Section 2 : Exemples de dictionnaires**
   * Création de dictionnaires
   * Accès et modification
   * Parcours

3. **Section 3 : Ensembles**
   * Création d'ensembles
   * Élimination de doublons
   * Opérations de base

4. **Section 4 : Accumulateurs**
   * Somme cumulative
   * Compteurs
   * Compteur avec dictionnaire

5. **Section 5 : Mini-exercices pratiques**
   * Exercice 1 : Calculer la moyenne d'une liste
   * Exercice 2 : Trouver le maximum d'une liste
   * Exercice 3 : Inverser une liste
   * Exercice 4 : Compter les voyelles dans un texte


## Livrables attendus

### Structure des fichiers

```
notebooks/
  S3-README.md                (ce fichier)
  exercices_s3/
    fusion_listes.py
    detecter_doublons.py
  data_structs_s3.ipynb
```


### Format du rendu

Chaque fichier Python doit contenir :

1. Le pseudo-code en commentaire
2. L'implémentation de la fonction
3. Les tests unitaires

**Exemple de structure attendue (fusion_listes.py) :**

```python
"""
Fusion de deux listes triées

Pseudo-code :
DEBUT
  Entrée : liste1, liste2
  résultat ← []
  i ← 0
  j ← 0
  
  TANT QUE i < longueur(liste1) ET j < longueur(liste2) FAIRE
    SI liste1[i] <= liste2[j] ALORS
      AJOUTER liste1[i] À résultat
      i ← i + 1
    SINON
      AJOUTER liste2[j] À résultat
      j ← j + 1
    FIN SI
  FIN TANT QUE
  
  -- Ajouter les éléments restants
  ...
  
  RETOURNER résultat
FIN
"""

def fusion(liste1, liste2):
    # Implémentation ici
    pass

# Tests
def test_fusion():
    assert fusion([1, 3, 5], [2, 4, 6]) == [1, 2, 3, 4, 5, 6]
    assert fusion([1, 2, 3], [4, 5, 6]) == [1, 2, 3, 4, 5, 6]
    assert fusion([1, 4, 7], [2, 3]) == [1, 2, 3, 4, 7]
    print("Tous les tests sont passés !")

if __name__ == "__main__":
    test_fusion()
```


## Critères d'évaluation

* **Exactitude logique** : les algorithmes produisent les résultats attendus
* **Pseudo-code clair** : respect des conventions, lisibilité
* **Utilisation appropriée des structures** : listes, dictionnaires, ensembles
* **Gestion des accumulateurs** : initialisation correcte, mise à jour appropriée
* **Tests complets** : couverture de différents cas
* **Notebook pédagogique** : exemples clairs, progression logique


## Conclusion de la séance

Les structures de données sont des outils fondamentaux en programmation.

Points clés à retenir :

* Les **listes** permettent de stocker des collections ordonnées
* Les **dictionnaires** associent des clés à des valeurs
* Les **ensembles** garantissent l'unicité des éléments
* Les **accumulateurs et compteurs** sont des patterns essentiels
* Les **piles et queues** sont des concepts importants pour organiser les données

La maîtrise de ces structures est essentielle pour résoudre efficacement des problèmes algorithmiques plus complexes.
