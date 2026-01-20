# S9 — Tests, Environnements Virtuels et Style de Code

## Objectifs de la session

À la fin de cette session, vous serez capable de :
- Créer et gérer des environnements virtuels Python
- Écrire et exécuter des tests unitaires avec pytest
- Appliquer les conventions de style PEP 8
- Documenter votre code avec des docstrings
- Organiser un projet Python professionnel

---

## 1. Environnements Virtuels

### 1.1 Pourquoi des Environnements Virtuels ?

Un environnement virtuel est un espace isolé pour installer des packages Python sans affecter le système.

**Avantages :**
- 🔒 Isolation des dépendances par projet
- ✅ Reproduction facile de l'environnement
- 🧹 Évite les conflits de versions
- 📦 Gestion propre des packages

### 1.2 Création avec venv

```bash
# Créer un environnement virtuel
python -m venv venv

# Ou avec python3
python3 -m venv venv

# Structure créée:
# venv/
# ├── bin/ (ou Scripts/ sur Windows)
# ├── include/
# ├── lib/
# └── pyvenv.cfg
```

### 1.3 Activation

```bash
# Linux/macOS
source venv/bin/activate

# Windows (Command Prompt)
venv\Scripts\activate.bat

# Windows (PowerShell)
venv\Scripts\Activate.ps1

# Vérifier l'activation
which python  # Linux/macOS
where python  # Windows
```

### 1.4 Désactivation

```bash
deactivate
```

### 1.5 Gestion des Dépendances

```bash
# Installer un package
pip install pandas

# Installer plusieurs packages
pip install pandas numpy matplotlib

# Installer une version spécifique
pip install pandas==2.0.0

# Voir les packages installés
pip list

# Générer requirements.txt
pip freeze > requirements.txt

# Installer depuis requirements.txt
pip install -r requirements.txt

# Désinstaller un package
pip uninstall pandas

# Mettre à jour un package
pip install --upgrade pandas
```

---

## 2. Tests Unitaires avec pytest

### 2.1 Installation de pytest

```bash
pip install pytest
```

### 2.2 Structure d'un Test

```python
# fichier: test_example.py

def add(a, b):
    """Additionne deux nombres."""
    return a + b

def test_add():
    """Test de la fonction add."""
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0
```

### 2.3 Exécution des Tests

```bash
# Exécuter tous les tests
pytest

# Exécuter un fichier spécifique
pytest tests/test_example.py

# Exécuter avec verbosité
pytest -v

# Afficher les print()
pytest -s

# Exécuter un test spécifique
pytest tests/test_example.py::test_add

# Générer un rapport HTML
pytest --html=report.html
```

### 2.4 Assertions pytest

```python
import pytest

def test_assertions():
    # Égalité
    assert 2 + 2 == 4
    
    # Inégalité
    assert 5 != 3
    
    # Appartenance
    assert 3 in [1, 2, 3, 4]
    
    # Booléens
    assert True
    assert not False
    
    # None
    value = None
    assert value is None
    
    # Types
    assert isinstance(42, int)
    assert isinstance("hello", str)

def test_exceptions():
    # Vérifier qu'une exception est levée
    with pytest.raises(ValueError):
        int("abc")
    
    with pytest.raises(ZeroDivisionError):
        1 / 0
```

### 2.5 Fixtures

```python
import pytest

@pytest.fixture
def sample_data():
    """Fixture qui fournit des données de test."""
    return [1, 2, 3, 4, 5]

def test_with_fixture(sample_data):
    """Test utilisant une fixture."""
    assert len(sample_data) == 5
    assert sum(sample_data) == 15

@pytest.fixture
def temp_file(tmp_path):
    """Fixture créant un fichier temporaire."""
    file = tmp_path / "test.txt"
    file.write_text("Hello, World!")
    return file

def test_file_content(temp_file):
    """Test avec un fichier temporaire."""
    content = temp_file.read_text()
    assert content == "Hello, World!"
```

### 2.6 Paramétrage des Tests

```python
import pytest

@pytest.mark.parametrize("a, b, expected", [
    (2, 3, 5),
    (0, 0, 0),
    (-1, 1, 0),
    (10, 20, 30),
])
def test_add_parametrized(a, b, expected):
    """Test paramétré de l'addition."""
    assert a + b == expected

@pytest.mark.parametrize("nombre, est_pair", [
    (2, True),
    (3, False),
    (0, True),
    (17, False),
])
def test_est_pair(nombre, est_pair):
    """Test de parité."""
    assert (nombre % 2 == 0) == est_pair
```

---

## 3. Style de Code - PEP 8

### 3.1 Conventions de Nommage

```python
# ✅ Bon
# Variables et fonctions: snake_case
ma_variable = 10
def calculer_moyenne():
    pass

# Classes: PascalCase
class PersonneUtilisateur:
    pass

# Constantes: MAJUSCULES
PI = 3.14159
MAX_CONNECTIONS = 100

# Variables privées: préfixe _
class MaClasse:
    def __init__(self):
        self._variable_privee = 42

# ❌ Mauvais
maVariable = 10  # camelCase (pas Python)
def CalculerMoyenne():  # PascalCase pour fonction
    pass
```

### 3.2 Indentation et Espacement

```python
# ✅ Bon: 4 espaces d'indentation
def ma_fonction():
    if condition:
        faire_quelque_chose()
    return resultat

# Opérateurs
resultat = a + b
liste = [1, 2, 3, 4]

# Paramètres de fonction
def fonction(param1, param2, param3):
    pass

# ❌ Mauvais
def ma_fonction():
  if condition:  # 2 espaces
      faire_quelque_chose()  # Inconsistent
  return resultat

resultat=a+b  # Pas d'espaces
```

### 3.3 Longueur de Ligne

```python
# ✅ Bon: Maximum 79 caractères
long_texte = (
    "Ceci est un très long texte "
    "qui est divisé sur plusieurs lignes "
    "pour respecter la limite de 79 caractères"
)

# Listes et dictionnaires
ma_liste = [
    element1, element2, element3,
    element4, element5
]

# ❌ Mauvais: Ligne trop longue
long_texte = "Ceci est un très long texte qui dépasse largement la limite de 79 caractères recommandée par PEP 8"
```

### 3.4 Imports

```python
# ✅ Bon: Imports organisés
# 1. Bibliothèque standard
import os
import sys
from pathlib import Path

# 2. Bibliothèques tierces
import numpy as np
import pandas as pd

# 3. Modules locaux
from mon_module import ma_fonction

# ❌ Mauvais
from os import *  # Pas d'import *
import sys, os  # Un import par ligne
```

### 3.5 Lignes Vides

```python
# ✅ Bon
import os


class MaClasse:
    """Documentation de la classe."""
    
    def __init__(self):
        """Constructeur."""
        self.valeur = 0
    
    def methode1(self):
        """Première méthode."""
        pass
    
    def methode2(self):
        """Deuxième méthode."""
        pass


def fonction_independante():
    """Fonction au niveau module."""
    pass
```

### 3.6 Outils de Vérification

```bash
# Installer pylint
pip install pylint

# Vérifier un fichier
pylint mon_script.py

# Installer black (formateur automatique)
pip install black

# Formater un fichier
black mon_script.py

# Installer flake8
pip install flake8

# Vérifier le style
flake8 mon_script.py
```

---

## 4. Documentation avec Docstrings

### 4.1 Format de Base

```python
def calculer_moyenne(nombres):
    """
    Calcule la moyenne d'une liste de nombres.
    
    Args:
        nombres (list): Liste de nombres (int ou float)
    
    Returns:
        float: La moyenne des nombres
    
    Raises:
        ValueError: Si la liste est vide
    
    Examples:
        >>> calculer_moyenne([1, 2, 3, 4, 5])
        3.0
        >>> calculer_moyenne([10, 20])
        15.0
    """
    if not nombres:
        raise ValueError("La liste ne peut pas être vide")
    return sum(nombres) / len(nombres)
```

### 4.2 Documentation de Classe

```python
class Personne:
    """
    Représente une personne avec nom, prénom et âge.
    
    Attributes:
        nom (str): Nom de famille
        prenom (str): Prénom
        age (int): Âge en années
    
    Examples:
        >>> p = Personne("Dupont", "Alice", 25)
        >>> p.get_nom_complet()
        'Alice Dupont'
    """
    
    def __init__(self, nom, prenom, age):
        """
        Initialise une nouvelle personne.
        
        Args:
            nom (str): Nom de famille
            prenom (str): Prénom
            age (int): Âge (doit être positif)
        
        Raises:
            ValueError: Si l'âge est négatif
        """
        if age < 0:
            raise ValueError("L'âge doit être positif")
        self.nom = nom
        self.prenom = prenom
        self.age = age
    
    def get_nom_complet(self):
        """
        Retourne le nom complet de la personne.
        
        Returns:
            str: Nom complet (prénom + nom)
        """
        return f"{self.prenom} {self.nom}"
```

### 4.3 Documentation de Module

```python
"""
Module de calculs mathématiques.

Ce module fournit des fonctions pour effectuer des calculs mathématiques
de base sur des listes de nombres.

Functions:
    calculer_moyenne: Calcule la moyenne
    calculer_mediane: Calcule la médiane
    calculer_ecart_type: Calcule l'écart-type

Examples:
    >>> from mon_module import calculer_moyenne
    >>> calculer_moyenne([1, 2, 3])
    2.0

Author:
    Votre Nom

Date:
    2024-01-20

Version:
    1.0.0
"""

import statistics


def calculer_moyenne(nombres):
    """Documentation de la fonction."""
    pass
```

---

## 5. Organisation d'un Projet

### 5.1 Structure Recommandée

```
mon_projet/
├── README.md              # Documentation principale
├── requirements.txt       # Dépendances
├── setup.py              # Configuration du package (optionnel)
├── .gitignore            # Fichiers à ignorer par git
├── mon_package/          # Code source
│   ├── __init__.py
│   ├── module1.py
│   ├── module2.py
│   └── utils/
│       ├── __init__.py
│       └── helpers.py
├── tests/                # Tests
│   ├── __init__.py
│   ├── test_module1.py
│   └── test_module2.py
├── docs/                 # Documentation
│   └── guide.md
└── data/                 # Données (optionnel)
    ├── raw/
    └── processed/
```

### 5.2 Fichier README.md

```markdown
# Mon Projet

Description courte du projet.

## Installation

```bash
# Créer un environnement virtuel
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Installer les dépendances
pip install -r requirements.txt
```

## Utilisation

```python
from mon_package import ma_fonction

resultat = ma_fonction(42)
```

## Tests

```bash
pytest tests/
```

## Licence

MIT
```

### 5.3 Fichier .gitignore

```
# Environnements virtuels
venv/
env/
ENV/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python

# Tests
.pytest_cache/
.coverage
htmlcov/

# IDE
.vscode/
.idea/
*.swp

# Système
.DS_Store
Thumbs.db
```

---

## 6. Tests du Projet

### 6.1 Tests pour PGCD

Voir `python_basics/tests/test_pgcd.py`

### 6.2 Tests pour Merge

Voir `python_basics/tests/test_merge.py`

### 6.3 Tests pour Hangman

Voir `python_basics/tests/test_hangman.py`

---

## 7. Bonnes Pratiques

### 7.1 Tests

✅ **Faire :**
- Tester les cas normaux ET les cas limites
- Un test = une seule assertion si possible
- Noms de tests descriptifs
- Utiliser des fixtures pour le code réutilisable

❌ **Éviter :**
- Tests dépendants les uns des autres
- Tests trop complexes
- Tester l'implémentation au lieu du comportement

### 7.2 Code

✅ **Faire :**
- Code DRY (Don't Repeat Yourself)
- Fonctions courtes et focalisées
- Noms explicites
- Commentaires utiles

❌ **Éviter :**
- Fonctions trop longues (>50 lignes)
- Variables à une lettre (sauf i, j dans boucles)
- Code commenté (utiliser git)
- Magic numbers (utiliser des constantes)

---

## 8. Ressources

- [PEP 8 - Style Guide](https://www.python.org/dev/peps/pep-0008/)
- [pytest Documentation](https://docs.pytest.org/)
- [Python Packaging Guide](https://packaging.python.org/)
- [Real Python - Testing](https://realpython.com/pytest-python-testing/)

---

## Résumé

Dans cette session, vous avez appris :

✅ Créer et gérer des environnements virtuels  
✅ Écrire des tests unitaires avec pytest  
✅ Suivre les conventions PEP 8  
✅ Documenter le code avec docstrings  
✅ Organiser un projet Python professionnel  

**Félicitations !** Vous avez maintenant les bases pour développer des projets Python de qualité professionnelle.

---

## Guide Complet

Consultez `python_basics/README.md` pour un guide complet d'installation, de configuration et d'exécution des tests.
