# S8 — Fichiers, CSV, JSON et Pandas

## Objectifs de la session

À la fin de cette session, vous serez capable de :
- Lire et écrire des fichiers texte avec gestion de contexte
- Manipuler des fichiers CSV avec le module csv et pandas
- Lire et écrire des données JSON
- Utiliser pandas pour l'analyse de données
- Transformer des données entre différents formats

---

## 1. Manipulation de Fichiers

### 1.1 Ouverture et Fermeture de Fichiers

```python
# ❌ Mauvaise pratique (risque de ne pas fermer le fichier)
fichier = open("data.txt", "r")
contenu = fichier.read()
fichier.close()

# ✅ Bonne pratique : Context Manager (with)
with open("data.txt", "r") as fichier:
    contenu = fichier.read()
# Le fichier est automatiquement fermé ici
```

### 1.2 Modes d'Ouverture

| Mode | Description | Crée si absent | Écrase |
|------|-------------|----------------|--------|
| `'r'` | Lecture seule | Non | - |
| `'w'` | Écriture | Oui | Oui |
| `'a'` | Ajout (append) | Oui | Non |
| `'r+'` | Lecture + Écriture | Non | Non |
| `'w+'` | Lecture + Écriture | Oui | Oui |

### 1.3 Lecture de Fichiers

```python
# Lire tout le fichier
with open("texte.txt", "r", encoding="utf-8") as f:
    contenu = f.read()
    print(contenu)

# Lire ligne par ligne
with open("texte.txt", "r", encoding="utf-8") as f:
    for ligne in f:
        print(ligne.strip())

# Lire toutes les lignes dans une liste
with open("texte.txt", "r", encoding="utf-8") as f:
    lignes = f.readlines()
    print(lignes)

# Lire une seule ligne
with open("texte.txt", "r", encoding="utf-8") as f:
    premiere_ligne = f.readline()
    print(premiere_ligne)
```

### 1.4 Écriture de Fichiers

```python
# Écrire (écrase le contenu existant)
with open("sortie.txt", "w", encoding="utf-8") as f:
    f.write("Première ligne\n")
    f.write("Deuxième ligne\n")

# Ajouter au fichier
with open("sortie.txt", "a", encoding="utf-8") as f:
    f.write("Nouvelle ligne ajoutée\n")

# Écrire plusieurs lignes
lignes = ["Ligne 1\n", "Ligne 2\n", "Ligne 3\n"]
with open("sortie.txt", "w", encoding="utf-8") as f:
    f.writelines(lignes)
```

---

## 2. Fichiers CSV

### 2.1 Module csv Standard

```python
import csv

# Lecture de CSV
with open("data.csv", "r", encoding="utf-8") as f:
    lecteur = csv.reader(f)
    en_tete = next(lecteur)  # Première ligne
    
    for ligne in lecteur:
        print(ligne)

# Lecture avec DictReader
with open("data.csv", "r", encoding="utf-8") as f:
    lecteur = csv.DictReader(f)
    
    for ligne in lecteur:
        print(ligne["nom"], ligne["age"])

# Écriture de CSV
data = [
    ["nom", "age", "ville"],
    ["Alice", 25, "Paris"],
    ["Bob", 30, "Lyon"],
    ["Charlie", 35, "Marseille"]
]

with open("sortie.csv", "w", encoding="utf-8", newline="") as f:
    ecrivain = csv.writer(f)
    ecrivain.writerows(data)

# Écriture avec DictWriter
data = [
    {"nom": "Alice", "age": 25, "ville": "Paris"},
    {"nom": "Bob", "age": 30, "ville": "Lyon"}
]

with open("sortie.csv", "w", encoding="utf-8", newline="") as f:
    colonnes = ["nom", "age", "ville"]
    ecrivain = csv.DictWriter(f, fieldnames=colonnes)
    
    ecrivain.writeheader()
    ecrivain.writerows(data)
```

### 2.2 CSV avec Pandas

```python
import pandas as pd

# Lecture de CSV
df = pd.read_csv("data.csv")
print(df)

# Lecture avec options
df = pd.read_csv(
    "data.csv",
    sep=",",           # Séparateur
    encoding="utf-8",  # Encodage
    index_col=0,       # Colonne d'index
    header=0           # Ligne d'en-tête
)

# Écriture de CSV
df.to_csv("sortie.csv", index=False, encoding="utf-8")
```

---

## 3. Fichiers JSON

### 3.1 Module json Standard

```python
import json

# Lire JSON depuis un fichier
with open("data.json", "r", encoding="utf-8") as f:
    donnees = json.load(f)
    print(donnees)

# Écrire JSON dans un fichier
donnees = {
    "nom": "Alice",
    "age": 25,
    "competences": ["Python", "SQL", "Docker"]
}

with open("sortie.json", "w", encoding="utf-8") as f:
    json.dump(donnees, f, indent=2, ensure_ascii=False)

# Convertir objet Python en chaîne JSON
json_string = json.dumps(donnees, indent=2)
print(json_string)

# Convertir chaîne JSON en objet Python
donnees = json.loads(json_string)
print(donnees)
```

### 3.2 JSON avec Pandas

```python
import pandas as pd

# Lire JSON
df = pd.read_json("data.json")

# Écrire JSON
df.to_json("sortie.json", orient="records", indent=2)

# Différents formats d'orientation
# orient="records" : [{col1: val1, col2: val2}, ...]
# orient="index" : {index1: {col1: val1, ...}, ...}
# orient="columns" : {col1: {index1: val1, ...}, ...}
```

---

## 4. Introduction à Pandas

### 4.1 Series (Vecteur 1D)

```python
import pandas as pd

# Création
s = pd.Series([1, 2, 3, 4, 5])
print(s)

# Avec index personnalisé
s = pd.Series([10, 20, 30], index=["a", "b", "c"])
print(s)

# Depuis un dictionnaire
s = pd.Series({"France": 67, "Allemagne": 83, "Italie": 60})
print(s)

# Accès
print(s["France"])  # Par label
print(s[0])         # Par position

# Opérations
print(s * 2)
print(s[s > 65])  # Filtrage
```

### 4.2 DataFrame (Table 2D)

```python
import pandas as pd

# Création depuis un dictionnaire
data = {
    "nom": ["Alice", "Bob", "Charlie"],
    "age": [25, 30, 35],
    "ville": ["Paris", "Lyon", "Marseille"]
}
df = pd.DataFrame(data)
print(df)

# Création depuis une liste de dictionnaires
data = [
    {"nom": "Alice", "age": 25, "ville": "Paris"},
    {"nom": "Bob", "age": 30, "ville": "Lyon"}
]
df = pd.DataFrame(data)

# Informations sur le DataFrame
print(df.info())      # Informations générales
print(df.describe())  # Statistiques descriptives
print(df.head())      # Premières lignes
print(df.tail())      # Dernières lignes
print(df.shape)       # Dimensions (lignes, colonnes)
print(df.columns)     # Noms des colonnes
print(df.index)       # Index
```

### 4.3 Sélection de Données

```python
# Sélectionner une colonne
ages = df["age"]
print(ages)

# Sélectionner plusieurs colonnes
subset = df[["nom", "age"]]
print(subset)

# Sélectionner des lignes par index
print(df.iloc[0])      # Première ligne
print(df.iloc[0:2])    # Premières 2 lignes

# Sélectionner par label
print(df.loc[0])       # Ligne d'index 0
print(df.loc[0:1, ["nom", "age"]])

# Filtrage
adultes = df[df["age"] >= 30]
print(adultes)

# Filtrage multiple
resultat = df[(df["age"] >= 25) & (df["ville"] == "Paris")]
print(resultat)
```

### 4.4 Modification de Données

```python
# Ajouter une colonne
df["pays"] = "France"

# Calculer une nouvelle colonne
df["age_dans_10_ans"] = df["age"] + 10

# Modifier des valeurs
df.loc[0, "age"] = 26

# Supprimer une colonne
df = df.drop("pays", axis=1)

# Supprimer une ligne
df = df.drop(0, axis=0)

# Renommer des colonnes
df = df.rename(columns={"nom": "prenom"})
```

### 4.5 Opérations et Statistiques

```python
# Statistiques sur une colonne
print(df["age"].mean())      # Moyenne
print(df["age"].median())    # Médiane
print(df["age"].std())       # Écart-type
print(df["age"].min())       # Minimum
print(df["age"].max())       # Maximum

# Groupement
grouped = df.groupby("ville")["age"].mean()
print(grouped)

# Tri
df_trie = df.sort_values("age", ascending=False)
print(df_trie)

# Valeurs uniques
print(df["ville"].unique())
print(df["ville"].value_counts())
```

---

## 5. Transformation de Données

### 5.1 CSV vers JSON

```python
import pandas as pd

# Lire CSV
df = pd.read_csv("data.csv")

# Écrire JSON
df.to_json("data.json", orient="records", indent=2)

# Ou avec les modules natifs
import csv
import json

with open("data.csv", "r") as csvfile:
    lecteur = csv.DictReader(csvfile)
    data = list(lecteur)

with open("data.json", "w") as jsonfile:
    json.dump(data, jsonfile, indent=2)
```

### 5.2 JSON vers CSV

```python
import pandas as pd

# Lire JSON
df = pd.read_json("data.json")

# Écrire CSV
df.to_csv("data.csv", index=False)
```

---

## 6. Gestion des Erreurs

```python
import os

# Vérifier si un fichier existe
if os.path.exists("data.csv"):
    df = pd.read_csv("data.csv")
else:
    print("Fichier introuvable")

# Gestion d'erreurs avec try/except
try:
    with open("data.txt", "r") as f:
        contenu = f.read()
except FileNotFoundError:
    print("Le fichier n'existe pas")
except PermissionError:
    print("Pas de permission pour lire le fichier")
except Exception as e:
    print(f"Erreur: {e}")
```

---

## 7. Projet Pratique : Notebook Complet

Consultez `notebooks/csv_json_s8.ipynb` pour un exemple complet avec :

1. **Lecture et exploration** d'un fichier CSV
2. **Nettoyage** des données
3. **Transformation** CSV → JSON
4. **Analyse** avec pandas
5. **Création de résumés** et rapports

---

## 8. Exercices

### Exercice 1 : Analyseur de Logs

Créez un script qui :
1. Lit un fichier de logs
2. Compte les occurrences par niveau (INFO, WARNING, ERROR)
3. Sauvegarde les résultats en JSON

### Exercice 2 : Fusion de CSV

Fusionnez deux fichiers CSV contenant des informations sur des employés et des départements.

### Exercice 3 : Nettoyage de Données

Chargez un CSV avec des données manquantes et :
- Identifiez les valeurs manquantes
- Remplissez-les avec des valeurs par défaut
- Supprimez les lignes avec trop de données manquantes

---

## 9. Bonnes Pratiques

### 9.1 Gestion de Fichiers

```python
# ✅ Bon : Utiliser with (context manager)
with open("file.txt", "r") as f:
    data = f.read()

# ✅ Bon : Spécifier l'encodage
with open("file.txt", "r", encoding="utf-8") as f:
    data = f.read()

# ✅ Bon : Utiliser pathlib
from pathlib import Path

fichier = Path("data") / "input.csv"
if fichier.exists():
    df = pd.read_csv(fichier)
```

### 9.2 Pandas

```python
# ✅ Bon : Chaîner les opérations
df = (pd.read_csv("data.csv")
      .dropna()
      .sort_values("age")
      .reset_index(drop=True))

# ✅ Bon : Utiliser des méthodes vectorisées
df["age_plus_10"] = df["age"] + 10  # Rapide

# ❌ Mauvais : Boucler sur les lignes
for index, row in df.iterrows():  # Lent
    df.loc[index, "age_plus_10"] = row["age"] + 10
```

---

## 10. Ressources

- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [Python CSV Module](https://docs.python.org/fr/3/library/csv.html)
- [Python JSON Module](https://docs.python.org/fr/3/library/json.html)

---

## Résumé

Dans cette session, vous avez appris :

✅ Lire et écrire des fichiers avec context manager  
✅ Manipuler des CSV avec csv et pandas  
✅ Lire et écrire du JSON  
✅ Utiliser pandas pour l'analyse de données  
✅ Transformer des données entre formats  

**Prochaine session (S9)** : Tests, environnements virtuels et style de code

---

## Fichiers du Projet

- `notebooks/csv_json_s8.ipynb` : Notebook interactif complet
- `python_basics/sales_data.csv` : Données d'exemple pour les exercices
