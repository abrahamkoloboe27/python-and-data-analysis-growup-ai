# S6 — Structures de Contrôle et Boucles en Python

## Objectifs de la session

À la fin de cette session, vous serez capable de :
- Utiliser les structures conditionnelles (if/elif/else)
- Maîtriser les boucles for et while
- Comprendre et utiliser les list comprehensions
- Gérer les erreurs avec try/except
- Créer des programmes interactifs complexes

---

## 1. Structures Conditionnelles

### 1.1 L'instruction if

```python
age = 18

if age >= 18:
    print("Vous êtes majeur")

# Avec else
if age >= 18:
    print("Vous êtes majeur")
else:
    print("Vous êtes mineur")

# Avec elif (else if)
if age < 13:
    print("Enfant")
elif age < 18:
    print("Adolescent")
else:
    print("Adulte")
```

### 1.2 Conditions Multiples

```python
age = 25
permis = True

# Opérateur AND
if age >= 18 and permis:
    print("Vous pouvez conduire")

# Opérateur OR
jour = "samedi"
if jour == "samedi" or jour == "dimanche":
    print("C'est le week-end !")

# Opérateur NOT
pluie = False
if not pluie:
    print("Pas besoin de parapluie")

# Combinaison complexe
note = 15
if (note >= 10 and note < 12) or note == 20:
    print("Mention spéciale")
```

### 1.3 L'opérateur Ternaire

```python
# Syntaxe : valeur_si_vrai if condition else valeur_si_faux
age = 20
statut = "majeur" if age >= 18 else "mineur"
print(statut)  # majeur

# Exemple pratique
nombre = -5
absolu = nombre if nombre >= 0 else -nombre
print(absolu)  # 5
```

### 1.4 Conditions avec in

```python
# Vérifier si un élément est dans une liste
fruits = ["pomme", "banane", "orange"]
if "pomme" in fruits:
    print("Pomme disponible")

# Vérifier si une clé est dans un dictionnaire
personne = {"nom": "Alice", "age": 25}
if "age" in personne:
    print(f"Âge: {personne['age']}")

# Vérifier si un caractère est dans une chaîne
texte = "Python"
if "y" in texte:
    print("Contient 'y'")
```

---

## 2. Boucles for

### 2.1 Boucle for de Base

```python
# Itérer sur une liste
fruits = ["pomme", "banane", "orange"]
for fruit in fruits:
    print(fruit)

# Itérer sur une chaîne
for lettre in "Python":
    print(lettre)

# Itérer sur un range
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

# Range avec début et fin
for i in range(2, 7):
    print(i)  # 2, 3, 4, 5, 6

# Range avec pas
for i in range(0, 10, 2):
    print(i)  # 0, 2, 4, 6, 8
```

### 2.2 Boucle for avec enumerate()

```python
# Obtenir l'index et la valeur
fruits = ["pomme", "banane", "orange"]
for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")

# Commencer l'index à 1
for index, fruit in enumerate(fruits, start=1):
    print(f"{index}. {fruit}")
```

### 2.3 Boucle for avec zip()

```python
# Itérer sur deux listes simultanément
noms = ["Alice", "Bob", "Charlie"]
ages = [25, 30, 35]

for nom, age in zip(noms, ages):
    print(f"{nom} a {age} ans")

# Itérer sur trois listes
prenoms = ["Alice", "Bob", "Charlie"]
noms = ["Dupont", "Martin", "Durand"]
ages = [25, 30, 35]

for prenom, nom, age in zip(prenoms, noms, ages):
    print(f"{prenom} {nom}, {age} ans")
```

### 2.4 Boucle for avec items() (dictionnaires)

```python
personne = {"nom": "Alice", "age": 25, "ville": "Paris"}

# Itérer sur les clés
for cle in personne:
    print(cle)

# Itérer sur les valeurs
for valeur in personne.values():
    print(valeur)

# Itérer sur clés et valeurs
for cle, valeur in personne.items():
    print(f"{cle}: {valeur}")
```

---

## 3. Boucles while

### 3.1 Boucle while de Base

```python
# Boucle simple
compteur = 0
while compteur < 5:
    print(compteur)
    compteur += 1

# Boucle infinie (à éviter sauf intention)
# while True:
#     print("Boucle infinie!")
#     break  # Utiliser break pour sortir
```

### 3.2 while avec break et continue

```python
# break : sortir de la boucle
compteur = 0
while True:
    print(compteur)
    compteur += 1
    if compteur >= 5:
        break

# continue : passer à l'itération suivante
compteur = 0
while compteur < 10:
    compteur += 1
    if compteur % 2 == 0:
        continue  # Sauter les nombres pairs
    print(compteur)  # Affiche seulement les impairs
```

### 3.3 while avec else

```python
# else s'exécute si la boucle se termine normalement
compteur = 0
while compteur < 3:
    print(compteur)
    compteur += 1
else:
    print("Boucle terminée normalement")

# else ne s'exécute PAS si break est utilisé
compteur = 0
while compteur < 10:
    if compteur == 3:
        break
    compteur += 1
else:
    print("Ceci ne s'affichera pas")
```

---

## 4. List Comprehensions

### 4.1 Syntaxe de Base

```python
# Méthode traditionnelle
carres = []
for i in range(10):
    carres.append(i ** 2)

# Avec list comprehension
carres = [i ** 2 for i in range(10)]
print(carres)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# Transformer une liste
mots = ["python", "java", "c++"]
majuscules = [mot.upper() for mot in mots]
print(majuscules)  # ['PYTHON', 'JAVA', 'C++']
```

### 4.2 List Comprehensions avec Conditions

```python
# Filtrer avec if
nombres = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
pairs = [n for n in nombres if n % 2 == 0]
print(pairs)  # [2, 4, 6, 8, 10]

# Avec if-else
nombres = [1, 2, 3, 4, 5]
resultat = ["pair" if n % 2 == 0 else "impair" for n in nombres]
print(resultat)  # ['impair', 'pair', 'impair', 'pair', 'impair']
```

### 4.3 List Comprehensions Imbriquées

```python
# Matrice aplatie
matrice = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
aplatie = [element for ligne in matrice for element in ligne]
print(aplatie)  # [1, 2, 3, 4, 5, 6, 7, 8, 9]

# Combinaisons
couleurs = ["rouge", "vert", "bleu"]
objets = ["voiture", "maison"]
combinaisons = [f"{couleur} {objet}" for couleur in couleurs for objet in objets]
print(combinaisons)
# ['rouge voiture', 'rouge maison', 'vert voiture', 'vert maison', 'bleu voiture', 'bleu maison']
```

### 4.4 Dict et Set Comprehensions

```python
# Dict comprehension
nombres = [1, 2, 3, 4, 5]
carres_dict = {n: n**2 for n in nombres}
print(carres_dict)  # {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# Set comprehension
mots = ["python", "java", "python", "c++"]
longueurs = {len(mot) for mot in mots}
print(longueurs)  # {2, 4, 6}
```

---

## 5. Gestion des Erreurs

### 5.1 try/except de Base

```python
# Sans gestion d'erreur
# nombre = int("abc")  # Erreur: ValueError

# Avec gestion d'erreur
try:
    nombre = int("abc")
    print(nombre)
except ValueError:
    print("Erreur: impossible de convertir en entier")

# Exemple pratique
try:
    age = int(input("Entrez votre âge: "))
    print(f"Vous avez {age} ans")
except ValueError:
    print("Erreur: veuillez entrer un nombre")
```

### 5.2 Plusieurs Exceptions

```python
try:
    nombre = int(input("Entrez un nombre: "))
    resultat = 10 / nombre
    print(f"Résultat: {resultat}")
except ValueError:
    print("Erreur: ce n'est pas un nombre valide")
except ZeroDivisionError:
    print("Erreur: division par zéro impossible")

# Capturer plusieurs exceptions ensemble
try:
    # Code qui peut lever différentes exceptions
    pass
except (ValueError, TypeError, ZeroDivisionError) as e:
    print(f"Erreur: {e}")
```

### 5.3 try/except/else/finally

```python
try:
    fichier = open("donnees.txt", "r")
    contenu = fichier.read()
except FileNotFoundError:
    print("Fichier non trouvé")
else:
    # S'exécute si aucune exception n'est levée
    print("Fichier lu avec succès")
    print(contenu)
finally:
    # S'exécute toujours (avec ou sans exception)
    try:
        fichier.close()
        print("Fichier fermé")
    except:
        pass
```

### 5.4 Lever des Exceptions

```python
def calculer_moyenne(notes):
    if not notes:
        raise ValueError("La liste de notes ne peut pas être vide")
    
    if any(note < 0 or note > 20 for note in notes):
        raise ValueError("Les notes doivent être entre 0 et 20")
    
    return sum(notes) / len(notes)

# Utilisation
try:
    moyenne = calculer_moyenne([])
except ValueError as e:
    print(f"Erreur: {e}")
```

---

## 6. Patterns et Idiomes Python

### 6.1 Boucle avec Drapeau (Flag)

```python
# Recherche avec drapeau
nombres = [1, 3, 5, 7, 9, 10, 11]
trouve = False

for nombre in nombres:
    if nombre % 2 == 0:
        print(f"Premier pair trouvé: {nombre}")
        trouve = True
        break

if not trouve:
    print("Aucun nombre pair trouvé")
```

### 6.2 Validation d'Entrée

```python
# Validation robuste
while True:
    try:
        age = int(input("Entrez votre âge: "))
        if age < 0 or age > 150:
            print("Âge invalide. Réessayez.")
            continue
        break
    except ValueError:
        print("Veuillez entrer un nombre entier.")

print(f"Âge enregistré: {age}")
```

### 6.3 Menu Interactif

```python
def afficher_menu():
    print("\n=== MENU ===")
    print("1. Option 1")
    print("2. Option 2")
    print("3. Option 3")
    print("0. Quitter")

while True:
    afficher_menu()
    choix = input("\nVotre choix: ")
    
    if choix == "1":
        print("Option 1 sélectionnée")
    elif choix == "2":
        print("Option 2 sélectionnée")
    elif choix == "3":
        print("Option 3 sélectionnée")
    elif choix == "0":
        print("Au revoir!")
        break
    else:
        print("Choix invalide")
```

---

## 7. Projet Pratique : Jeu du Pendu

Un jeu complet du pendu est implémenté dans `python_basics/hangman.py`.

### 7.1 Aperçu des Fonctionnalités

- Choix aléatoire d'un mot
- Affichage de l'état du jeu
- Gestion des erreurs
- Sauvegarde des scores en JSON
- Interface utilisateur claire

### 7.2 Fonctions Principales

```python
def choisir_mot():
    """Choisit un mot aléatoirement"""
    pass

def afficher_etat(mot, lettres_trouvees):
    """Affiche le mot avec lettres trouvées"""
    pass

def tester_lettre(mot, lettre, lettres_trouvees):
    """Teste si une lettre est dans le mot"""
    pass

def verifier_victoire(mot, lettres_trouvees):
    """Vérifie si le joueur a gagné"""
    pass

def jouer():
    """Fonction principale du jeu"""
    pass
```

### 7.3 Exécution

```bash
cd python_basics
python hangman.py
```

---

## 8. Exercices Pratiques

### Exercice 1 : FizzBuzz

Affichez les nombres de 1 à 100, mais :
- Pour les multiples de 3, affichez "Fizz"
- Pour les multiples de 5, affichez "Buzz"
- Pour les multiples de 3 et 5, affichez "FizzBuzz"

```python
for i in range(1, 101):
    if i % 3 == 0 and i % 5 == 0:
        print("FizzBuzz")
    elif i % 3 == 0:
        print("Fizz")
    elif i % 5 == 0:
        print("Buzz")
    else:
        print(i)
```

### Exercice 2 : Nombre Mystère

Créez un jeu où l'ordinateur choisit un nombre entre 1 et 100, et le joueur doit le deviner.

```python
import random

nombre_mystere = random.randint(1, 100)
tentatives = 0

while True:
    try:
        proposition = int(input("Devinez le nombre (1-100): "))
        tentatives += 1
        
        if proposition < nombre_mystere:
            print("Plus grand!")
        elif proposition > nombre_mystere:
            print("Plus petit!")
        else:
            print(f"Bravo! Trouvé en {tentatives} tentatives!")
            break
    except ValueError:
        print("Veuillez entrer un nombre valide")
```

### Exercice 3 : Filtrage de Liste

Créez une liste de nombres et filtrez :
- Les nombres pairs
- Les nombres supérieurs à 50
- Les nombres pairs ET supérieurs à 50

```python
nombres = [12, 45, 67, 23, 89, 34, 56, 78, 90, 15]

pairs = [n for n in nombres if n % 2 == 0]
superieurs_50 = [n for n in nombres if n > 50]
pairs_et_sup_50 = [n for n in nombres if n % 2 == 0 and n > 50]

print(f"Pairs: {pairs}")
print(f"Supérieurs à 50: {superieurs_50}")
print(f"Pairs ET > 50: {pairs_et_sup_50}")
```

### Exercice 4 : Table de Multiplication

Affichez une table de multiplication formatée.

```python
print("TABLE DE MULTIPLICATION")
print("=" * 40)

for i in range(1, 11):
    for j in range(1, 11):
        print(f"{i*j:4}", end="")
    print()  # Nouvelle ligne
```

---

## 9. Bonnes Pratiques

### 9.1 Éviter les Boucles Inutiles

```python
# ❌ Mauvais : boucle inutile
resultat = []
for i in range(10):
    resultat.append(i * 2)

# ✅ Bon : list comprehension
resultat = [i * 2 for i in range(10)]
```

### 9.2 Conditions Claires

```python
# ❌ Mauvais : condition complexe
if not (age < 18 or not permis):
    print("Peut conduire")

# ✅ Bon : condition claire
if age >= 18 and permis:
    print("Peut conduire")
```

### 9.3 Éviter les Magic Numbers

```python
# ❌ Mauvais
if age >= 18:
    print("Majeur")

# ✅ Bon
AGE_MAJORITE = 18
if age >= AGE_MAJORITE:
    print("Majeur")
```

---

## 10. Résumé

Dans cette session, vous avez appris :

✅ Structures conditionnelles (if/elif/else)  
✅ Boucles for et while  
✅ Break, continue, else dans les boucles  
✅ List comprehensions (list, dict, set)  
✅ Gestion des erreurs avec try/except  
✅ Création de programmes interactifs  
✅ Patterns et idiomes Python  

**Prochaine session (S7)** : Collections avancées en Python (listes, tuples, dictionnaires, sets)

---

## Projet

Consultez `python_basics/hangman.py` pour un projet complet intégrant tous les concepts de cette session.
