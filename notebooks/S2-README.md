# S2 — Structures de contrôle (conditions & boucles)

## Objectifs pédagogiques

À l'issue de cette séance, l'apprenant doit être capable de :

* Maîtriser les structures séquentielles d'un algorithme.
* Utiliser les conditionnelles pour orienter le flux d'exécution.
* Écrire des boucles avec critères d'arrêt appropriés.
* Identifier et éviter les pièges courants (boucles infinies).
* Implémenter des algorithmes classiques utilisant des boucles.


## Introduction — Les structures de contrôle

Les **structures de contrôle** permettent de modifier l'ordre d'exécution des instructions d'un algorithme.

Sans structures de contrôle, un algorithme s'exécuterait toujours de manière linéaire, de la première à la dernière instruction.

Les structures de contrôle permettent de :

* **Choisir** entre plusieurs chemins possibles (conditionnelles)
* **Répéter** des instructions plusieurs fois (boucles)
* **Interrompre** ou **continuer** l'exécution selon des critères


## 1. Les conditionnelles

### 1.1 Structure SI ... ALORS ... FIN SI

La structure conditionnelle la plus simple permet d'exécuter des instructions uniquement si une condition est vraie.

**Forme générale :**

```
SI condition ALORS
  instructions
FIN SI
```

**Exemple — Vérifier si un nombre est positif :**

```
DEBUT
  Entrée : nombre
  
  SI nombre > 0 ALORS
    AFFICHER "Le nombre est positif"
  FIN SI
FIN
```


### 1.2 Structure SI ... ALORS ... SINON ... FIN SI

Cette structure permet de traiter deux cas : quand la condition est vraie et quand elle est fausse.

**Forme générale :**

```
SI condition ALORS
  instructions si vrai
SINON
  instructions si faux
FIN SI
```

**Exemple — Déterminer si un nombre est pair ou impair :**

```
DEBUT
  Entrée : nombre
  reste ← nombre modulo 2
  
  SI reste = 0 ALORS
    AFFICHER "Le nombre est pair"
  SINON
    AFFICHER "Le nombre est impair"
  FIN SI
FIN
```


### 1.3 Structure SI ... ALORS ... SINON SI ... FIN SI

Pour gérer plusieurs cas mutuellement exclusifs, on utilise SINON SI.

**Forme générale :**

```
SI condition1 ALORS
  instructions cas 1
SINON SI condition2 ALORS
  instructions cas 2
SINON SI condition3 ALORS
  instructions cas 3
SINON
  instructions cas par défaut
FIN SI
```

**Exemple — Attribuer une mention selon une note :**

```
DEBUT
  Entrée : note
  
  SI note >= 16 ALORS
    mention ← "Très bien"
  SINON SI note >= 14 ALORS
    mention ← "Bien"
  SINON SI note >= 12 ALORS
    mention ← "Assez bien"
  SINON SI note >= 10 ALORS
    mention ← "Passable"
  SINON
    mention ← "Insuffisant"
  FIN SI
  
  AFFICHER mention
FIN
```


### 1.4 Logique booléenne

Les conditions peuvent être simples ou composées.

**Opérateurs de comparaison :**

* `=` : égal à
* `≠` : différent de
* `<` : strictement inférieur
* `>` : strictement supérieur
* `≤` : inférieur ou égal
* `≥` : supérieur ou égal

**Opérateurs logiques :**

* `ET` : les deux conditions doivent être vraies
* `OU` : au moins une condition doit être vraie
* `NON` : inverse la valeur de la condition

**Exemple — Vérifier si un nombre est dans un intervalle :**

```
DEBUT
  Entrée : nombre
  
  SI nombre >= 10 ET nombre <= 20 ALORS
    AFFICHER "Le nombre est entre 10 et 20"
  FIN SI
FIN
```


## 2. Les boucles

### 2.1 Boucle POUR

La boucle POUR est utilisée quand on connaît à l'avance le nombre d'itérations.

**Forme générale :**

```
POUR variable DE valeur_début À valeur_fin FAIRE
  instructions
FIN POUR
```

**Exemple — Afficher les nombres de 1 à 10 :**

```
DEBUT
  POUR i DE 1 À 10 FAIRE
    AFFICHER i
  FIN POUR
FIN
```

**Exemple — Calculer la somme des nombres de 1 à N :**

```
DEBUT
  Entrée : N
  somme ← 0
  
  POUR i DE 1 À N FAIRE
    somme ← somme + i
  FIN POUR
  
  AFFICHER somme
FIN
```


### 2.2 Boucle TANT QUE

La boucle TANT QUE est utilisée quand on ne connaît pas à l'avance le nombre d'itérations, mais qu'on a un critère d'arrêt.

**Forme générale :**

```
TANT QUE condition FAIRE
  instructions
FIN TANT QUE
```

**Exemple — Diviser un nombre par 2 jusqu'à ce qu'il soit inférieur à 1 :**

```
DEBUT
  Entrée : nombre
  
  TANT QUE nombre >= 1 FAIRE
    AFFICHER nombre
    nombre ← nombre / 2
  FIN TANT QUE
FIN
```

**Exemple — Demander un mot de passe jusqu'à ce qu'il soit correct :**

```
DEBUT
  mot_de_passe_correct ← "secret123"
  tentative ← ""
  
  TANT QUE tentative ≠ mot_de_passe_correct FAIRE
    AFFICHER "Entrez le mot de passe :"
    LIRE tentative
  FIN TANT QUE
  
  AFFICHER "Accès autorisé"
FIN
```


### 2.3 Instructions BREAK et CONTINUE

#### BREAK (SORTIR)

L'instruction BREAK permet de sortir immédiatement d'une boucle, même si la condition n'est pas encore fausse.

**Exemple — Chercher un élément dans une liste :**

```
DEBUT
  Entrée : liste, element_recherché
  trouvé ← FAUX
  
  POUR chaque élément dans liste FAIRE
    SI élément = element_recherché ALORS
      trouvé ← VRAI
      SORTIR de la boucle
    FIN SI
  FIN POUR
  
  SI trouvé ALORS
    AFFICHER "Élément trouvé"
  SINON
    AFFICHER "Élément non trouvé"
  FIN SI
FIN
```


#### CONTINUE (PASSER)

L'instruction CONTINUE permet de passer immédiatement à l'itération suivante, en ignorant le reste des instructions de la boucle actuelle.

**Exemple — Afficher uniquement les nombres pairs de 1 à 10 :**

```
DEBUT
  POUR i DE 1 À 10 FAIRE
    SI i modulo 2 ≠ 0 ALORS
      PASSER à l'itération suivante
    FIN SI
    AFFICHER i
  FIN POUR
FIN
```


## 3. Pièges courants

### 3.1 Boucle infinie

Une boucle infinie se produit quand la condition d'arrêt n'est jamais atteinte.

**Exemple de piège :**

```
DEBUT
  compteur ← 1
  
  TANT QUE compteur > 0 FAIRE
    AFFICHER compteur
    compteur ← compteur + 1
  FIN TANT QUE
FIN
```

> La condition `compteur > 0` reste toujours vraie car on incrémente le compteur !


### 3.2 Condition jamais vraie

```
DEBUT
  compteur ← 0
  
  TANT QUE compteur = 10 FAIRE
    AFFICHER compteur
    compteur ← compteur + 1
  FIN TANT QUE
FIN
```

> La boucle ne s'exécute jamais car compteur vaut 0 au départ.


### 3.3 Erreur d'initialisation

```
DEBUT
  somme ← 10  -- Erreur : devrait être 0
  
  POUR i DE 1 À 5 FAIRE
    somme ← somme + i
  FIN POUR
  
  AFFICHER somme  -- Résultat incorrect !
FIN
```


## Exercices — Travail à rendre

### Consignes générales

Vous devez créer deux fichiers :

1. **pgcd.py** : algorithme d'Euclide pour calculer le PGCD
2. **compter_mots.py** : compter les occurrences d'un mot dans une phrase

Pour chaque exercice, vous devez fournir :

* Le **pseudo-code** de l'algorithme
* L'**implémentation en Python** (script)
* **Trois tests unitaires** simples


### Exercice 1 — Calculer le PGCD (algorithme d'Euclide)

**Objectif** : calculer le Plus Grand Commun Diviseur de deux entiers positifs.

**Spécification :**

* **Entrée** : deux entiers positifs `a` et `b`
* **Sortie** : le PGCD de `a` et `b`
* **Règle** : utiliser l'algorithme d'Euclide par divisions successives

**Principe de l'algorithme d'Euclide :**

L'algorithme repose sur le principe suivant :

* Si `b = 0`, alors `PGCD(a, b) = a`
* Sinon, `PGCD(a, b) = PGCD(b, a modulo b)`

On répète jusqu'à ce que le reste soit nul.

**Exemple de pseudo-code attendu :**

```
DEBUT
  Entrée : a, b
  
  TANT QUE b ≠ 0 FAIRE
    reste ← a modulo b
    a ← b
    b ← reste
  FIN TANT QUE
  
  RETOURNER a
FIN
```

**Tests à réaliser :**

1. `PGCD(48, 18)` devrait retourner `6`
2. `PGCD(100, 35)` devrait retourner `5`
3. `PGCD(7, 3)` devrait retourner `1`


### Exercice 2 — Compter les occurrences d'un mot dans une phrase

**Objectif** : compter combien de fois un mot apparaît dans une phrase.

**Spécification :**

* **Entrée** : une phrase (texte), un mot à rechercher
* **Sortie** : le nombre d'occurrences du mot dans la phrase
* **Règle** : ignorer la casse (majuscules/minuscules)

**Indications :**

* Diviser la phrase en mots
* Retirer la ponctuation si nécessaire (points, virgules, etc.)
* Parcourir chaque mot
* Comparer avec le mot recherché (en ignorant la casse)
* Compter les correspondances

**Exemple de pseudo-code attendu :**

```
DEBUT
  Entrée : phrase, mot_recherché
  compteur ← 0
  
  -- Convertir la phrase et le mot en minuscules
  phrase_min ← mettre_en_minuscules(phrase)
  mot_min ← mettre_en_minuscules(mot_recherché)
  
  -- Retirer la ponctuation de la phrase
  phrase_nettoyée ← retirer_ponctuation(phrase_min)
  
  -- Diviser la phrase en liste de mots
  liste_mots ← séparer(phrase_nettoyée, " ")
  
  -- Parcourir chaque mot
  POUR chaque mot dans liste_mots FAIRE
    SI mot = mot_min ALORS
      compteur ← compteur + 1
    FIN SI
  FIN POUR
  
  RETOURNER compteur
FIN
```

**Tests à réaliser :**

1. `compter("Le chat mange. Le chat dort.", "chat")` devrait retourner `2`
2. `compter("Python est génial. Python est puissant.", "Python")` devrait retourner `2`
3. `compter("Bonjour le monde", "code")` devrait retourner `0`


## Livrables attendus

### Structure des fichiers

```
notebooks/
  S2-README.md          (ce fichier)
  exercices_s2/
    pgcd.py
    compter_mots.py
    tests_pgcd.py       (optionnel mais recommandé)
    tests_compter.py    (optionnel mais recommandé)
```


### Format du rendu

Chaque fichier Python doit contenir :

1. Un commentaire en en-tête avec le pseudo-code
2. L'implémentation de la fonction
3. Les trois tests sous forme de fonction ou d'assertions


**Exemple de structure attendue (pgcd.py) :**

```python
"""
Algorithme d'Euclide - Calcul du PGCD

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
    # Implémentation ici
    pass

# Tests
def test_pgcd():
    # Test 1
    assert pgcd(48, 18) == 6
    # Test 2
    assert pgcd(100, 35) == 5
    # Test 3
    assert pgcd(7, 3) == 1
    print("Tous les tests sont passés !")

if __name__ == "__main__":
    test_pgcd()
```


## Critères d'évaluation

* **Exactitude logique** : l'algorithme produit les résultats attendus
* **Pseudo-code clair** : respect des conventions, lisibilité
* **Implémentation correcte** : le code Python suit le pseudo-code
* **Tests complets** : les trois tests couvrent différents cas
* **Gestion des boucles** : critères d'arrêt appropriés, pas de boucle infinie


## Conclusion de la séance

Les structures de contrôle sont essentielles en algorithmique.

Points clés à retenir :

* Les **conditionnelles** permettent de prendre des décisions
* Les **boucles** permettent de répéter des actions
* Il faut toujours vérifier que les boucles ont un **critère d'arrêt clair**
* Les instructions BREAK et CONTINUE offrent plus de flexibilité
* Attention aux **pièges** : boucles infinies, mauvaise initialisation

La prochaine séance portera sur les structures de données qui permettent d'organiser et de manipuler des collections d'informations.
