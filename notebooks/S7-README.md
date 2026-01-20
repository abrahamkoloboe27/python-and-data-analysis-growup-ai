# S7 — Collections Avancées en Python

## Objectifs de la session

À la fin de cette session, vous serez capable de :
- Maîtriser les collections Python : listes, tuples, dictionnaires, sets
- Choisir la collection appropriée selon le besoin
- Utiliser les méthodes et opérations avancées
- Créer des comprehensions complexes
- Manipuler des structures de données imbriquées

---

## 1. Les Listes (list)

### 1.1 Caractéristiques

- **Ordonnée** : Les éléments gardent leur ordre d'insertion
- **Modifiable** : On peut ajouter, supprimer, modifier des éléments
- **Permet les doublons** : Un même élément peut apparaître plusieurs fois
- **Indexable** : Accès par index (positif ou négatif)

```python
# Création
fruits = ["pomme", "banane", "orange"]
nombres = [1, 2, 3, 4, 5]
mixte = [1, "hello", 3.14, True]
vide = []

# Création avec list()
lettres = list("Python")  # ['P', 'y', 't', 'h', 'o', 'n']
nombres = list(range(5))  # [0, 1, 2, 3, 4]
```

### 1.2 Opérations de Base

```python
fruits = ["pomme", "banane", "orange"]

# Accès
print(fruits[0])      # pomme
print(fruits[-1])     # orange (dernier élément)
print(fruits[1:3])    # ['banane', 'orange'] (slicing)

# Modification
fruits[0] = "poire"
print(fruits)  # ['poire', 'banane', 'orange']

# Longueur
print(len(fruits))  # 3

# Vérification d'appartenance
if "banane" in fruits:
    print("Banane disponible")
```

### 1.3 Méthodes Importantes

```python
# Ajout
fruits = ["pomme", "banane"]
fruits.append("orange")       # Ajoute à la fin
fruits.insert(1, "kiwi")      # Insère à l'index 1
fruits.extend(["mangue", "papaye"])  # Ajoute plusieurs éléments

# Suppression
fruits.remove("kiwi")         # Supprime la première occurrence
element = fruits.pop()        # Retire et retourne le dernier élément
element = fruits.pop(0)       # Retire et retourne l'élément à l'index 0
fruits.clear()                # Vide la liste

# Recherche
fruits = ["pomme", "banane", "orange", "banane"]
index = fruits.index("banane")     # Retourne l'index de la première occurrence
count = fruits.count("banane")     # Compte les occurrences

# Tri
nombres = [3, 1, 4, 1, 5, 9, 2, 6]
nombres.sort()                # Tri en place (modifie la liste)
print(nombres)                # [1, 1, 2, 3, 4, 5, 6, 9]

nombres.sort(reverse=True)    # Tri décroissant
print(nombres)                # [9, 6, 5, 4, 3, 2, 1, 1]

# sorted() : retourne une nouvelle liste triée
nombres = [3, 1, 4, 1, 5]
nouveaux = sorted(nombres)    # [1, 1, 3, 4, 5]
print(nombres)                # [3, 1, 4, 1, 5] (inchangée)

# Tri personnalisé
mots = ["python", "java", "c", "javascript"]
mots.sort(key=len)            # Tri par longueur
print(mots)                   # ['c', 'java', 'python', 'javascript']

# Inversion
nombres = [1, 2, 3, 4, 5]
nombres.reverse()
print(nombres)  # [5, 4, 3, 2, 1]
```

### 1.4 Copie de Listes

```python
# ⚠ Attention : simple assignation = référence
liste1 = [1, 2, 3]
liste2 = liste1
liste2.append(4)
print(liste1)  # [1, 2, 3, 4] - modifiée aussi!

# ✅ Copie superficielle (shallow copy)
liste1 = [1, 2, 3]
liste2 = liste1.copy()  # ou liste2 = liste1[:]
liste2.append(4)
print(liste1)  # [1, 2, 3] - inchangée

# Copie profonde (pour listes imbriquées)
import copy
liste1 = [[1, 2], [3, 4]]
liste2 = copy.deepcopy(liste1)
liste2[0][0] = 999
print(liste1)  # [[1, 2], [3, 4]] - inchangée
```

---

## 2. Les Tuples (tuple)

### 2.1 Caractéristiques

- **Ordonnés** : Comme les listes
- **Immutables** : On ne peut pas modifier après création
- **Permettent les doublons**
- **Plus rapides** que les listes
- **Peuvent être des clés de dictionnaire**

```python
# Création
coordonnees = (10, 20)
couleurs = ("rouge", "vert", "bleu")
singleton = (42,)  # ⚠ Virgule obligatoire pour un seul élément
vide = ()

# Sans parenthèses (packing)
point = 10, 20, 30
print(type(point))  # <class 'tuple'>
```

### 2.2 Opérations

```python
coordonnees = (10, 20, 30)

# Accès (comme les listes)
print(coordonnees[0])    # 10
print(coordonnees[-1])   # 30
print(coordonnees[1:3])  # (20, 30)

# Longueur
print(len(coordonnees))  # 3

# Vérification
if 20 in coordonnees:
    print("20 est présent")

# Méthodes
nombres = (1, 2, 3, 2, 2, 4)
print(nombres.count(2))  # 3
print(nombres.index(3))  # 2
```

### 2.3 Unpacking

```python
# Unpacking simple
point = (10, 20)
x, y = point
print(x, y)  # 10 20

# Unpacking avec *
nombres = (1, 2, 3, 4, 5)
premier, *milieu, dernier = nombres
print(premier)   # 1
print(milieu)    # [2, 3, 4]
print(dernier)   # 5

# Échange de variables
a, b = 10, 20
a, b = b, a  # Échange élégant
print(a, b)  # 20 10
```

### 2.4 Cas d'Usage

```python
# Retourner plusieurs valeurs
def get_coordinates():
    return (10, 20, 30)

x, y, z = get_coordinates()

# Clés de dictionnaire
positions = {
    (0, 0): "origine",
    (1, 0): "droite",
    (0, 1): "haut"
}

# Constantes
COULEURS_RGB = (
    (255, 0, 0),    # Rouge
    (0, 255, 0),    # Vert
    (0, 0, 255)     # Bleu
)
```

---

## 3. Les Dictionnaires (dict)

### 3.1 Caractéristiques

- **Non ordonnés** (avant Python 3.7) / **Ordonnés** (Python 3.7+)
- **Modifiables**
- **Clés uniques** : Pas de doublons de clés
- **Clés immutables** : str, int, tuple (pas list)
- **Valeurs de tout type**

```python
# Création
personne = {
    "nom": "Dupont",
    "prenom": "Alice",
    "age": 25
}

# Création avec dict()
personne = dict(nom="Dupont", prenom="Alice", age=25)

# Dictionnaire vide
vide = {}
vide = dict()
```

### 3.2 Opérations de Base

```python
personne = {"nom": "Dupont", "age": 25, "ville": "Paris"}

# Accès
print(personne["nom"])          # Dupont
print(personne.get("age"))      # 25
print(personne.get("pays", "France"))  # France (valeur par défaut)

# Modification et ajout
personne["age"] = 26            # Modification
personne["email"] = "a@b.com"   # Ajout

# Suppression
del personne["ville"]           # Supprime la clé
email = personne.pop("email")   # Supprime et retourne la valeur
personne.clear()                # Vide le dictionnaire

# Vérification
personne = {"nom": "Dupont", "age": 25}
if "nom" in personne:
    print("Clé 'nom' existe")

# Longueur
print(len(personne))  # 2
```

### 3.3 Méthodes Importantes

```python
personne = {"nom": "Dupont", "prenom": "Alice", "age": 25}

# keys(), values(), items()
print(personne.keys())    # dict_keys(['nom', 'prenom', 'age'])
print(personne.values())  # dict_values(['Dupont', 'Alice', 25])
print(personne.items())   # dict_items([('nom', 'Dupont'), ('prenom', 'Alice'), ('age', 25)])

# Itération
for cle in personne:
    print(cle, personne[cle])

for cle, valeur in personne.items():
    print(f"{cle}: {valeur}")

# update() : fusion de dictionnaires
personne.update({"ville": "Paris", "age": 26})
print(personne)  # age modifié, ville ajoutée

# setdefault() : retourne la valeur ou l'ajoute si absente
age = personne.setdefault("age", 30)     # Retourne 26 (existe déjà)
pays = personne.setdefault("pays", "France")  # Ajoute et retourne "France"

# fromkeys() : créer dict avec valeurs par défaut
cles = ["a", "b", "c"]
dico = dict.fromkeys(cles, 0)
print(dico)  # {'a': 0, 'b': 0, 'c': 0}
```

### 3.4 Dictionnaires Imbriqués

```python
# Structure complexe
employes = {
    "emp001": {
        "nom": "Dupont",
        "prenom": "Alice",
        "poste": "Développeuse",
        "competences": ["Python", "SQL", "Docker"]
    },
    "emp002": {
        "nom": "Martin",
        "prenom": "Bob",
        "poste": "Data Analyst",
        "competences": ["Python", "R", "Tableau"]
    }
}

# Accès
print(employes["emp001"]["nom"])  # Dupont
print(employes["emp001"]["competences"][0])  # Python

# Parcours
for emp_id, infos in employes.items():
    print(f"{emp_id}: {infos['nom']} - {infos['poste']}")
```

---

## 4. Les Sets (set)

### 4.1 Caractéristiques

- **Non ordonnés** : Pas d'indexation
- **Modifiables**
- **Éléments uniques** : Pas de doublons
- **Éléments immutables** : str, int, tuple (pas list, dict)
- **Très rapides** pour tests d'appartenance

```python
# Création
fruits = {"pomme", "banane", "orange"}
nombres = {1, 2, 3, 4, 5}
vide = set()  # ⚠ {} crée un dictionnaire vide

# Création depuis une liste (supprime doublons)
nombres = [1, 2, 2, 3, 3, 3, 4]
uniques = set(nombres)
print(uniques)  # {1, 2, 3, 4}
```

### 4.2 Opérations de Base

```python
fruits = {"pomme", "banane", "orange"}

# Ajout
fruits.add("kiwi")
fruits.update(["mangue", "papaye"])  # Ajoute plusieurs

# Suppression
fruits.remove("kiwi")        # Erreur si absent
fruits.discard("kiwi")       # Pas d'erreur si absent
element = fruits.pop()       # Retire un élément aléatoire
fruits.clear()               # Vide le set

# Vérification
fruits = {"pomme", "banane"}
if "pomme" in fruits:
    print("Pomme disponible")

# Longueur
print(len(fruits))  # 2
```

### 4.3 Opérations Mathématiques (Ensembles)

```python
a = {1, 2, 3, 4, 5}
b = {4, 5, 6, 7, 8}

# Union (tous les éléments)
print(a | b)  # {1, 2, 3, 4, 5, 6, 7, 8}
print(a.union(b))

# Intersection (éléments communs)
print(a & b)  # {4, 5}
print(a.intersection(b))

# Différence (éléments dans a mais pas dans b)
print(a - b)  # {1, 2, 3}
print(a.difference(b))

# Différence symétrique (éléments dans a ou b, mais pas les deux)
print(a ^ b)  # {1, 2, 3, 6, 7, 8}
print(a.symmetric_difference(b))

# Sous-ensemble
c = {2, 3}
print(c.issubset(a))    # True
print(a.issuperset(c))  # True

# Disjoints (aucun élément en commun)
d = {10, 11}
print(a.isdisjoint(d))  # True
```

### 4.4 Cas d'Usage

```python
# Supprimer les doublons
nombres = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
uniques = list(set(nombres))
print(uniques)  # [1, 2, 3, 4]

# Test d'appartenance rapide
emails_valides = {"alice@exemple.com", "bob@exemple.com", "charlie@exemple.com"}
email = "alice@exemple.com"
if email in emails_valides:  # Très rapide
    print("Email valide")

# Trouver éléments communs
cours_alice = {"Python", "SQL", "Docker"}
cours_bob = {"Python", "Java", "Docker"}
communs = cours_alice & cours_bob
print(communs)  # {'Python', 'Docker'}
```

---

## 5. Comprehensions Avancées

### 5.1 List Comprehensions Complexes

```python
# Filtrage avec conditions multiples
nombres = range(1, 21)
resultat = [n for n in nombres if n % 2 == 0 and n % 3 == 0]
print(resultat)  # [6, 12, 18]

# Transformation conditionnelle
nombres = range(1, 11)
resultat = [n**2 if n % 2 == 0 else n**3 for n in nombres]
print(resultat)  # [1, 4, 27, 16, 125, 36, 343, 64, 729, 100]

# Imbrication
matrice = [[j for j in range(1, 4)] for i in range(3)]
print(matrice)  # [[1, 2, 3], [1, 2, 3], [1, 2, 3]]

# Aplatissement
matrice = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
aplatie = [x for ligne in matrice for x in ligne]
print(aplatie)  # [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### 5.2 Dict Comprehensions

```python
# Carré des nombres
carres = {n: n**2 for n in range(1, 6)}
print(carres)  # {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# Inverser un dictionnaire
original = {"a": 1, "b": 2, "c": 3}
inverse = {v: k for k, v in original.items()}
print(inverse)  # {1: 'a', 2: 'b', 3: 'c'}

# Avec condition
nombres = {"a": 1, "b": 2, "c": 3, "d": 4}
pairs = {k: v for k, v in nombres.items() if v % 2 == 0}
print(pairs)  # {'b': 2, 'd': 4}

# À partir de deux listes
noms = ["Alice", "Bob", "Charlie"]
ages = [25, 30, 35]
personnes = {nom: age for nom, age in zip(noms, ages)}
print(personnes)  # {'Alice': 25, 'Bob': 30, 'Charlie': 35}
```

### 5.3 Set Comprehensions

```python
# Carrés uniques
nombres = [1, 2, 2, 3, 3, 3, 4]
carres = {n**2 for n in nombres}
print(carres)  # {1, 4, 9, 16}

# Longueurs uniques de mots
mots = ["python", "java", "c", "javascript", "go", "rust"]
longueurs = {len(mot) for mot in mots}
print(longueurs)  # {1, 2, 4, 6, 10}

# Lettres uniques
texte = "hello world"
lettres = {c for c in texte if c.isalpha()}
print(lettres)  # {'h', 'e', 'l', 'o', 'w', 'r', 'd'}
```

---

## 6. Choisir la Bonne Collection

| Collection | Ordonnée | Modifiable | Doublons | Indexable | Usage Principal |
|------------|----------|------------|----------|-----------|-----------------|
| **list**   | ✅       | ✅         | ✅       | ✅        | Séquence générale, données ordonnées |
| **tuple**  | ✅       | ❌         | ✅       | ✅        | Données immutables, retours multiples |
| **dict**   | ✅ (3.7+)| ✅         | Clés: ❌ | Par clé   | Paires clé-valeur, recherches rapides |
| **set**    | ❌       | ✅         | ❌       | ❌        | Éléments uniques, opérations d'ensemble |

### 6.1 Quand Utiliser Quoi ?

```python
# Liste : ordre important, modifications fréquentes
temperatures = [20.5, 21.3, 19.8, 22.1]
temperatures.append(20.9)

# Tuple : données fixes, retour de fonction
def get_user_info():
    return ("Alice", 25, "Paris")

nom, age, ville = get_user_info()

# Dictionnaire : recherche par clé
contacts = {
    "Alice": "alice@example.com",
    "Bob": "bob@example.com"
}
print(contacts["Alice"])

# Set : éliminer doublons, tests d'appartenance
visiteurs_uniques = {"user1", "user2", "user1", "user3"}
# Automatiquement : {'user1', 'user2', 'user3'}
```

---

## 7. Projet Pratique : Analyseur de Logs

Voir `python_basics/log_analyzer.py` pour un exemple complet d'utilisation des collections.

### 7.1 Objectifs

- Lire un fichier de logs
- Identifier les IPs les plus fréquentes
- Trouver les endpoints les plus consultés
- Détecter les erreurs

### 7.2 Structure du Log

```
192.168.1.1 - - [01/Jan/2024:10:23:45 +0000] "GET /index.html HTTP/1.1" 200
192.168.1.2 - - [01/Jan/2024:10:24:12 +0000] "POST /api/login HTTP/1.1" 200
```

---

## 8. Exercices Pratiques

### Exercice 1 : Gestion d'Inventaire

```python
# Utilisez un dictionnaire pour gérer un inventaire
inventaire = {
    "pommes": 50,
    "bananes": 30,
    "oranges": 25
}

# Ajouter un produit
inventaire["kiwis"] = 15

# Vendre des produits
inventaire["pommes"] -= 5

# Vérifier stock
if inventaire["bananes"] < 10:
    print("Stock faible pour les bananes")
```

### Exercice 2 : Analyse de Texte

```python
texte = "Python est un langage de programmation Python est populaire"

# Compter les mots
mots = texte.lower().split()
compteur = {}
for mot in mots:
    compteur[mot] = compteur.get(mot, 0) + 1

# Ou avec dict comprehension
from collections import Counter
compteur = Counter(mots)
print(compteur.most_common(3))
```

### Exercice 3 : Réseau Social

```python
# Graph avec dictionnaire de sets
amis = {
    "Alice": {"Bob", "Charlie", "David"},
    "Bob": {"Alice", "Charlie"},
    "Charlie": {"Alice", "Bob", "Eve"},
    "David": {"Alice"},
    "Eve": {"Charlie"}
}

# Trouver amis communs
communs = amis["Alice"] & amis["Charlie"]
print(communs)  # {'Bob'}

# Suggérer de nouveaux amis
suggestions = (amis["Charlie"] - amis["Alice"]) - {"Alice"}
print(suggestions)  # {'Eve'}
```

---

## 9. Bonnes Pratiques

### 9.1 Performance

```python
# ✅ Bon : Utiliser set pour recherches
mots_interdits = {"spam", "viagra", "casino"}
if "spam" in mots_interdits:  # O(1) - très rapide
    pass

# ❌ Mauvais : Utiliser list pour recherches
mots_interdits = ["spam", "viagra", "casino"]
if "spam" in mots_interdits:  # O(n) - plus lent
    pass

# ✅ Bon : dict.get() avec valeur par défaut
compteur = {}
compteur[mot] = compteur.get(mot, 0) + 1

# ✅ Bon : Comprehension au lieu de boucle
carres = [x**2 for x in range(10)]
```

### 9.2 Lisibilité

```python
# ✅ Bon : Noms descriptifs
utilisateurs_actifs = {"alice", "bob", "charlie"}

# ❌ Mauvais : Noms cryptiques
u = {"alice", "bob", "charlie"}

# ✅ Bon : Unpacking clair
nom, age, ville = ("Alice", 25, "Paris")

# ✅ Bon : items() pour dictionnaires
for cle, valeur in dico.items():
    print(cle, valeur)
```

---

## 10. Ressources Complémentaires

- [Python Collections - Documentation](https://docs.python.org/fr/3/library/collections.html)
- [Python Tutorial - Data Structures](https://docs.python.org/fr/3/tutorial/datastructures.html)

---

## Résumé

Dans cette session, vous avez appris :

✅ Listes : séquences modifiables ordonnées  
✅ Tuples : séquences immutables  
✅ Dictionnaires : paires clé-valeur  
✅ Sets : collections d'éléments uniques  
✅ Comprehensions avancées  
✅ Choix de la collection appropriée  

**Prochaine session (S8)** : Fichiers, CSV, JSON et Pandas

---

## Projets

- `python_basics/log_analyzer.py` : Analyseur de logs web
- `notebooks/collections_s7.ipynb` : Notebook avec exemples interactifs
