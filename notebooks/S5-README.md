# S5 — Les Bases de la Syntaxe Python

## Objectifs de la session

À la fin de cette session, vous serez capable de :
- Installer Python et configurer un environnement de développement
- Utiliser VS Code et Jupyter pour exécuter du code Python
- Comprendre et utiliser les types de données de base
- Effectuer des entrées/sorties simples
- Manipuler des chaînes de caractères avec les f-strings

---

## 1. Installation et Configuration

### 1.1 Installation de Python

**Windows :**
```bash
# Télécharger depuis python.org (version 3.10+)
# Cocher "Add Python to PATH" pendant l'installation
```

**macOS :**
```bash
brew install python3
```

**Linux (Ubuntu/Debian) :**
```bash
sudo apt update
sudo apt install python3 python3-pip
```

**Vérification :**
```bash
python --version
# ou
python3 --version
```

### 1.2 Installation de VS Code

1. Télécharger VS Code depuis [code.visualstudio.com](https://code.visualstudio.com/)
2. Installer l'extension Python (Microsoft)
3. Installer l'extension Jupyter (Microsoft)

### 1.3 Premier Script Python

**Créer un fichier `hello.py` :**
```python
print("Bonjour, Python !")
```

**Exécuter dans le terminal :**
```bash
python hello.py
# ou
python3 hello.py
```

**Exécuter dans VS Code :**
- Ouvrir le fichier
- Cliquer sur le bouton "Run" (▶) en haut à droite
- Ou utiliser `Ctrl+Alt+N` (Windows/Linux) / `Cmd+Alt+N` (macOS)

### 1.4 Jupyter Notebook

**Installation :**
```bash
pip install jupyter notebook
# ou
pip3 install jupyter notebook
```

**Lancement :**
```bash
jupyter notebook
```

Un navigateur s'ouvrira automatiquement. Vous pouvez créer un nouveau notebook Python 3.

**Dans VS Code :**
- Créer un fichier `.ipynb`
- VS Code ouvrira automatiquement l'interface Jupyter intégrée

---

## 2. Types de Données de Base

### 2.1 Les Entiers (int)

Les entiers sont des nombres sans partie décimale.

```python
age = 25
nombre_etudiants = 150
temperature = -10

print(type(age))  # <class 'int'>

# Opérations
a = 10
b = 3

print(a + b)   # Addition : 13
print(a - b)   # Soustraction : 7
print(a * b)   # Multiplication : 30
print(a / b)   # Division : 3.333...
print(a // b)  # Division entière : 3
print(a % b)   # Modulo (reste) : 1
print(a ** b)  # Puissance : 1000
```

### 2.2 Les Flottants (float)

Les flottants sont des nombres à virgule flottante (décimaux).

```python
prix = 19.99
temperature = -3.5
pi = 3.14159

print(type(prix))  # <class 'float'>

# Opérations
x = 5.5
y = 2.0

print(x + y)   # 7.5
print(x * y)   # 11.0
print(x / y)   # 2.75
print(x ** y)  # 30.25
```

**Attention aux approximations :**
```python
print(0.1 + 0.2)  # 0.30000000000000004 (pas exactement 0.3)

# Solution : utiliser round()
resultat = round(0.1 + 0.2, 2)
print(resultat)  # 0.3
```

### 2.3 Les Chaînes de Caractères (str)

Les chaînes (strings) représentent du texte.

```python
nom = "Alice"
prenom = 'Bob'
message = """Ceci est un message
sur plusieurs lignes"""

print(type(nom))  # <class 'str'>

# Concaténation
prenom = "Alice"
nom = "Dupont"
nom_complet = prenom + " " + nom
print(nom_complet)  # Alice Dupont

# Répétition
separator = "-" * 20
print(separator)  # --------------------

# Longueur
texte = "Python"
print(len(texte))  # 6

# Accès aux caractères (indexation)
mot = "Python"
print(mot[0])   # P (premier caractère)
print(mot[-1])  # n (dernier caractère)
print(mot[1:4]) # yth (slicing)

# Méthodes utiles
texte = "  hello world  "
print(texte.upper())      # "  HELLO WORLD  "
print(texte.lower())      # "  hello world  "
print(texte.strip())      # "hello world" (retire espaces)
print(texte.replace("world", "Python"))  # "  hello Python  "
print(texte.split())      # ['hello', 'world']
```

### 2.4 Les Booléens (bool)

Les booléens représentent des valeurs logiques : vrai ou faux.

```python
est_majeur = True
est_connecte = False

print(type(est_majeur))  # <class 'bool'>

# Opérateurs de comparaison
age = 18
print(age == 18)  # True (égal à)
print(age != 20)  # True (différent de)
print(age > 16)   # True (supérieur à)
print(age < 21)   # True (inférieur à)
print(age >= 18)  # True (supérieur ou égal)
print(age <= 18)  # True (inférieur ou égal)

# Opérateurs logiques
a = True
b = False
print(a and b)  # False (ET logique)
print(a or b)   # True (OU logique)
print(not a)    # False (NON logique)

# Valeurs "fausses" en Python
print(bool(0))         # False
print(bool(""))        # False (chaîne vide)
print(bool([]))        # False (liste vide)
print(bool(None))      # False

# Valeurs "vraies"
print(bool(1))         # True
print(bool("texte"))   # True
print(bool([1, 2]))    # True
```

---

## 3. Conversions de Types (Casting)

Python permet de convertir un type en un autre.

```python
# Conversion vers int
nombre_str = "42"
nombre_int = int(nombre_str)
print(nombre_int + 8)  # 50

flottant = 3.14
entier = int(flottant)
print(entier)  # 3 (troncature, pas d'arrondi)

# Conversion vers float
entier = 10
flottant = float(entier)
print(flottant)  # 10.0

texte = "3.14"
nombre = float(texte)
print(nombre)  # 3.14

# Conversion vers str
age = 25
texte = "J'ai " + str(age) + " ans"
print(texte)  # J'ai 25 ans

# Conversion vers bool
print(bool(0))     # False
print(bool(1))     # True
print(bool(""))    # False
print(bool("abc")) # True

# Attention aux erreurs de conversion
try:
    nombre = int("abc")  # Erreur !
except ValueError:
    print("Impossible de convertir 'abc' en entier")
```

---

## 4. Entrées et Sorties (I/O)

### 4.1 Sortie avec print()

```python
# Affichage simple
print("Bonjour")

# Affichage de plusieurs valeurs
nom = "Alice"
age = 25
print("Nom:", nom, "Age:", age)

# Séparateur personnalisé
print("A", "B", "C", sep="-")  # A-B-C

# Fin de ligne personnalisée
print("Ligne 1", end=" | ")
print("Ligne 2")  # Ligne 1 | Ligne 2

# Formatage avec format()
nom = "Alice"
age = 25
print("Je m'appelle {} et j'ai {} ans".format(nom, age))

# Formatage avec indices
print("Je m'appelle {0} et j'ai {1} ans".format(nom, age))
print("Age: {1}, Nom: {0}".format(nom, age))
```

### 4.2 Entrée avec input()

```python
# Lecture d'une chaîne
nom = input("Entrez votre nom : ")
print("Bonjour", nom)

# input() retourne toujours une chaîne !
age_str = input("Entrez votre âge : ")
age = int(age_str)  # Conversion nécessaire
print("Dans 5 ans, vous aurez", age + 5, "ans")

# En une ligne
age = int(input("Entrez votre âge : "))

# Lecture de plusieurs valeurs
prenom = input("Prénom : ")
nom = input("Nom : ")
age = int(input("Âge : "))
print(f"{prenom} {nom}, {age} ans")
```

---

## 5. Les f-strings (Formatted String Literals)

Les f-strings (Python 3.6+) sont la méthode moderne et recommandée pour formater des chaînes.

```python
# Syntaxe de base
nom = "Alice"
age = 25
message = f"Je m'appelle {nom} et j'ai {age} ans"
print(message)

# Expressions dans les f-strings
a = 10
b = 20
print(f"La somme de {a} et {b} est {a + b}")

# Formatage de nombres
prix = 19.99
print(f"Prix: {prix:.2f} €")  # Prix: 19.99 €

pi = 3.14159265359
print(f"Pi ≈ {pi:.2f}")  # Pi ≈ 3.14
print(f"Pi ≈ {pi:.4f}")  # Pi ≈ 3.1416

# Largeur et alignement
nom = "Alice"
print(f"Nom: {nom:>10}")   # Aligné à droite (10 caractères)
print(f"Nom: {nom:<10}")   # Aligné à gauche
print(f"Nom: {nom:^10}")   # Centré

# Nombres avec séparateurs
grand_nombre = 1000000
print(f"Population: {grand_nombre:,}")  # 1,000,000
print(f"Population: {grand_nombre:_}")  # 1_000_000

# Pourcentages
taux = 0.156
print(f"Taux: {taux:.1%}")  # Taux: 15.6%

# Notation scientifique
tres_grand = 123456789
print(f"Nombre: {tres_grand:e}")  # 1.234568e+08

# Debug avec =
valeur = 42
print(f"{valeur=}")  # valeur=42

# Expressions complexes
notes = [15, 18, 12]
print(f"Moyenne: {sum(notes) / len(notes):.2f}")

# Multilignes
nom = "Alice"
age = 25
ville = "Paris"
carte = f"""
╔════════════════════════╗
║  Nom: {nom:<16} ║
║  Âge: {age:<16} ║
║  Ville: {ville:<13} ║
╚════════════════════════╝
"""
print(carte)
```

---

## 6. Commentaires et Documentation

### 6.1 Commentaires

```python
# Ceci est un commentaire sur une ligne

"""
Ceci est un commentaire
sur plusieurs lignes
"""

x = 10  # Commentaire en fin de ligne

# Les commentaires sont ignorés par Python
# print("Ce code ne s'exécutera pas")
```

### 6.2 Documentation (Docstrings)

```python
def calculer_moyenne(notes):
    """
    Calcule la moyenne d'une liste de notes.
    
    Args:
        notes (list): Liste de nombres
    
    Returns:
        float: La moyenne des notes
    """
    return sum(notes) / len(notes)

# Accès à la documentation
print(calculer_moyenne.__doc__)
```

---

## 7. Exemple Pratique : Script de Statistiques

Voir le fichier `python_basics/calc_stats.py` pour un exemple complet qui lit un fichier CSV et calcule des statistiques de base.

**Fichier : `calc_stats.py`**
```python
import csv
import statistics

# Lecture du fichier CSV
with open('numbers.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader)  # Sauter l'en-tête
    numbers = [float(row[0]) for row in reader]

# Calcul des statistiques
moyenne = statistics.mean(numbers)
mediane = statistics.median(numbers)
minimum = min(numbers)
maximum = max(numbers)

# Affichage des résultats
print(f"Statistiques pour {len(numbers)} nombres:")
print(f"Moyenne: {moyenne:.2f}")
print(f"Médiane: {mediane:.2f}")
print(f"Minimum: {minimum:.2f}")
print(f"Maximum: {maximum:.2f}")
```

---

## 8. Exercices Pratiques

### Exercice 1 : Calculatrice Simple

Créez un programme qui demande deux nombres à l'utilisateur et affiche les résultats de toutes les opérations de base.

```python
# Votre code ici
a = float(input("Premier nombre: "))
b = float(input("Deuxième nombre: "))

print(f"{a} + {b} = {a + b}")
print(f"{a} - {b} = {a - b}")
print(f"{a} × {b} = {a * b}")
if b != 0:
    print(f"{a} ÷ {b} = {a / b:.2f}")
```

### Exercice 2 : Convertisseur de Température

Convertissez des températures de Celsius en Fahrenheit et Kelvin.

```python
celsius = float(input("Température en Celsius: "))
fahrenheit = (celsius * 9/5) + 32
kelvin = celsius + 273.15

print(f"{celsius}°C = {fahrenheit}°F = {kelvin}K")
```

### Exercice 3 : Carte d'Identité

Créez un programme qui demande des informations personnelles et affiche une carte formatée.

```python
nom = input("Nom: ")
prenom = input("Prénom: ")
age = int(input("Âge: "))
ville = input("Ville: ")

print(f"""
╔══════════════════════════════╗
║     CARTE D'IDENTITÉ         ║
╠══════════════════════════════╣
║ Nom:     {nom:<18} ║
║ Prénom:  {prenom:<18} ║
║ Âge:     {age:<18} ║
║ Ville:   {ville:<18} ║
╚══════════════════════════════╝
""")
```

---

## 9. Bonnes Pratiques

### 9.1 Nommage des Variables

```python
# ✅ Bon
age_utilisateur = 25
nombre_etudiants = 150
prix_total = 99.99

# ❌ Mauvais
a = 25  # Trop court, pas descriptif
ageUtilisateur = 25  # camelCase (pas Python)
NombreEtudiants = 150  # PascalCase (réservé aux classes)
```

### 9.2 Constantes

```python
# Constantes en MAJUSCULES
PI = 3.14159
TVA = 0.20
MAX_TENTATIVES = 3
```

### 9.3 Lisibilité

```python
# ✅ Bon : espacé et lisible
resultat = (a + b) * (c - d)

# ❌ Mauvais : condensé
resultat=(a+b)*(c-d)

# ✅ Bon : lignes pas trop longues
message = (
    "Ceci est un très long message "
    "qui est divisé sur plusieurs lignes "
    "pour améliorer la lisibilité"
)
```

---

## 10. Ressources Complémentaires

### Documentation Officielle
- [Python.org - Tutorial](https://docs.python.org/fr/3/tutorial/)
- [Python.org - Library Reference](https://docs.python.org/fr/3/library/)

### Outils
- [Python Tutor](http://pythontutor.com/) - Visualisation du code
- [Real Python](https://realpython.com/) - Tutoriels avancés

### Livres
- "Python Crash Course" de Eric Matthes
- "Automate the Boring Stuff with Python" de Al Sweigart

---

## Résumé

Dans cette session, vous avez appris :

✅ Installation de Python et configuration de VS Code  
✅ Les types de base : `int`, `float`, `str`, `bool`  
✅ Les conversions de types (casting)  
✅ Entrées/sorties avec `input()` et `print()`  
✅ Formatage moderne avec les f-strings  
✅ Bonnes pratiques de nommage et de style  

**Prochaine session (S6)** : Structures de contrôle et boucles en Python

---

## Projet Pratique

Consultez le dossier `python_basics/` pour un projet complet :
- `calc_stats.py` : Script de calcul de statistiques
- `numbers.csv` : Fichier de données exemple
- `README_calc_stats.md` : Guide d'utilisation

**Exercice** : Modifiez le script pour ajouter le calcul de l'écart-type et de la variance.
