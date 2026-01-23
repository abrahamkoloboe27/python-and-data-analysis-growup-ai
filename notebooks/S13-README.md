# 🐍 S13 — SQL depuis Python

## 🎯 Objectifs de la Session

- Connecter Python à des bases de données SQLite
- Utiliser les modules `sqlite3` et `sqlalchemy`
- Exécuter des requêtes SQL depuis Python
- Intégrer SQL avec pandas pour l'analyse de données
- Maîtriser `read_sql_query()` et `to_sql()`
- Traiter et transformer les résultats avec pandas
- Appliquer les bonnes pratiques de sécurité et gestion d'erreurs

## 📚 Contenu Théorique

### 1. Connexion à une Base de Données SQLite

#### Module sqlite3 (Standard Python)

Le module `sqlite3` est inclus dans Python et permet de travailler avec des bases SQLite.

```python
import sqlite3

# Connexion à une base de données
conn = sqlite3.connect('sales.db')

# Créer un curseur pour exécuter des requêtes
cursor = conn.cursor()

# Exécuter une requête
cursor.execute("SELECT * FROM customers LIMIT 5")

# Récupérer les résultats
results = cursor.fetchall()

# Fermer la connexion
conn.close()
```

**Avantages** :
- Inclus dans Python (pas d'installation)
- Léger et rapide
- Parfait pour SQLite

**Inconvénients** :
- API bas niveau
- Pas de support natif pour autres SGBD
- Nécessite plus de code

#### SQLAlchemy (Recommandé)

SQLAlchemy est un ORM (Object-Relational Mapping) puissant qui supporte plusieurs SGBD.

```python
from sqlalchemy import create_engine
import pandas as pd

# Créer une connexion
engine = create_engine('sqlite:///sales.db')

# Exécuter une requête avec pandas
df = pd.read_sql_query("SELECT * FROM customers", engine)
```

**Avantages** :
- Support multi-SGBD (SQLite, PostgreSQL, MySQL, etc.)
- Intégration parfaite avec pandas
- Syntaxe plus pythonique
- Gestion automatique des ressources

**Installation** :
```bash
pip install sqlalchemy
```

### 2. Exécuter des Requêtes SELECT

#### Avec sqlite3

```python
import sqlite3

conn = sqlite3.connect('sales.db')
cursor = conn.cursor()

# Requête simple
cursor.execute("SELECT first_name, last_name, email FROM customers")
rows = cursor.fetchall()

for row in rows:
    print(f"{row[0]} {row[1]} - {row[2]}")

conn.close()
```

#### Avec pandas (Recommandé)

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('sqlite:///sales.db')

# Lire directement dans un DataFrame
df = pd.read_sql_query("""
    SELECT first_name, last_name, email, country
    FROM customers
    WHERE country = 'France'
""", engine)

print(df.head())
```

### 3. Requêtes avec Paramètres (Sécurité)

⚠️ **DANGER** : Ne jamais concaténer des variables dans une requête SQL !

```python
# ❌ MAUVAISE PRATIQUE (vulnérable aux injections SQL)
country = "France"
query = f"SELECT * FROM customers WHERE country = '{country}'"
df = pd.read_sql_query(query, engine)

# ✅ BONNE PRATIQUE (utiliser des paramètres)
country = "France"
query = "SELECT * FROM customers WHERE country = ?"
df = pd.read_sql_query(query, engine, params=[country])
```

**Avec sqlite3** :
```python
cursor.execute("SELECT * FROM customers WHERE country = ?", (country,))
```

**Avec pandas** :
```python
df = pd.read_sql_query(
    "SELECT * FROM customers WHERE country = :country",
    engine,
    params={'country': country}
)
```

### 4. pandas.read_sql_query()

Cette fonction lit une requête SQL et retourne un DataFrame pandas.

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('sqlite:///sales.db')

# Requête simple
df = pd.read_sql_query("SELECT * FROM products", engine)

# Requête avec JOIN
query = """
    SELECT 
        c.first_name,
        c.last_name,
        o.order_date,
        o.total_amount
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_date >= '2024-01-01'
    ORDER BY o.order_date DESC
"""
df_orders = pd.read_sql_query(query, engine)

# Avec paramètres
df_filtered = pd.read_sql_query(
    "SELECT * FROM orders WHERE total_amount > :min_amount",
    engine,
    params={'min_amount': 100}
)
```

**Paramètres utiles** :
- `index_col` : Utiliser une colonne comme index
- `parse_dates` : Convertir des colonnes en datetime
- `chunksize` : Lire par morceaux (pour gros datasets)

```python
# Utiliser customer_id comme index
df = pd.read_sql_query(
    "SELECT * FROM customers",
    engine,
    index_col='customer_id'
)

# Parser les dates automatiquement
df = pd.read_sql_query(
    "SELECT * FROM orders",
    engine,
    parse_dates=['order_date', 'created_at']
)

# Lire par morceaux (gros datasets)
for chunk in pd.read_sql_query("SELECT * FROM orders", engine, chunksize=1000):
    # Traiter chaque chunk
    process_chunk(chunk)
```

### 5. pandas.to_sql()

Cette fonction écrit un DataFrame dans une table SQL.

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('sqlite:///sales.db')

# Créer un DataFrame
data = {
    'product_name': ['Laptop', 'Mouse', 'Keyboard'],
    'price': [999.99, 29.99, 79.99],
    'stock': [10, 50, 30]
}
df = pd.DataFrame(data)

# Écrire dans une nouvelle table
df.to_sql('new_products', engine, if_exists='replace', index=False)
```

**Paramètres importants** :
- `if_exists` : 
  - `'fail'` : Erreur si la table existe (défaut)
  - `'replace'` : Supprimer et recréer la table
  - `'append'` : Ajouter les données à la table existante
- `index` : Inclure l'index du DataFrame (True/False)
- `index_label` : Nom de la colonne pour l'index
- `dtype` : Spécifier les types de colonnes

```python
# Ajouter des données à une table existante
df.to_sql('products', engine, if_exists='append', index=False)

# Remplacer complètement une table
df.to_sql('temp_products', engine, if_exists='replace', index=False)

# Spécifier les types de données
from sqlalchemy.types import String, Float, Integer

df.to_sql('products', engine, 
          if_exists='replace',
          index=False,
          dtype={
              'product_name': String(100),
              'price': Float,
              'stock': Integer
          })
```

### 6. Requêtes JOIN avec pandas

```python
# Requête complexe avec plusieurs JOIN
query = """
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        c.country,
        o.order_id,
        o.order_date,
        o.total_amount,
        p.product_name,
        p.category,
        oi.quantity,
        oi.unit_price,
        (oi.quantity * oi.unit_price) AS line_total
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN products p ON oi.product_id = p.product_id
    WHERE o.order_date >= '2024-01-01'
    ORDER BY o.order_date DESC, c.last_name
"""

df = pd.read_sql_query(query, engine)

# Analyse avec pandas
print(f"Nombre total de commandes : {df['order_id'].nunique()}")
print(f"Montant total : {df['line_total'].sum():.2f} €")
print(f"\nTop 5 produits :")
print(df.groupby('product_name')['quantity'].sum().sort_values(ascending=False).head())
```

### 7. Traitement des Résultats avec pandas

Une fois les données extraites, pandas offre de puissantes capacités d'analyse.

```python
# Lire les données
df = pd.read_sql_query("""
    SELECT 
        o.order_id,
        o.order_date,
        o.total_amount,
        o.status,
        c.country
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
""", engine)

# Nettoyage et transformation
df['order_date'] = pd.to_datetime(df['order_date'])
df['month'] = df['order_date'].dt.month
df['year'] = df['order_date'].dt.year

# Analyse par pays
country_stats = df.groupby('country').agg({
    'order_id': 'count',
    'total_amount': ['sum', 'mean', 'median']
}).round(2)

print(country_stats)

# Analyse temporelle
monthly_sales = df.groupby(['year', 'month'])['total_amount'].sum()
print(monthly_sales)

# Filtrage
high_value_orders = df[df['total_amount'] > 200]
print(f"Commandes > 200€ : {len(high_value_orders)}")
```

### 8. Gestion des Erreurs

```python
import sqlite3
from sqlalchemy import create_engine
import pandas as pd

def get_customers_by_country(country):
    """Récupère les clients d'un pays avec gestion d'erreurs."""
    try:
        engine = create_engine('sqlite:///sales.db')
        
        query = """
            SELECT customer_id, first_name, last_name, email
            FROM customers
            WHERE country = :country
        """
        
        df = pd.read_sql_query(query, engine, params={'country': country})
        
        if df.empty:
            print(f"Aucun client trouvé pour le pays : {country}")
            return None
        
        return df
        
    except sqlite3.Error as e:
        print(f"Erreur SQLite : {e}")
        return None
    except Exception as e:
        print(f"Erreur inattendue : {e}")
        return None
    finally:
        # Le moteur SQLAlchemy gère automatiquement la fermeture
        pass

# Utilisation
df_france = get_customers_by_country('France')
if df_france is not None:
    print(df_france)
```

### 9. Transactions et Modifications

#### Insertion de données

```python
# Avec sqlite3
conn = sqlite3.connect('sales.db')
cursor = conn.cursor()

try:
    cursor.execute("""
        INSERT INTO customers (first_name, last_name, email, country)
        VALUES (?, ?, ?, ?)
    """, ('Jean', 'Dupont', 'jean.dupont@email.com', 'France'))
    
    conn.commit()
    print("Client ajouté avec succès")
except sqlite3.IntegrityError as e:
    print(f"Erreur : {e}")
    conn.rollback()
finally:
    conn.close()

# Avec pandas (plus simple)
new_customer = pd.DataFrame({
    'first_name': ['Jean'],
    'last_name': ['Dupont'],
    'email': ['jean.dupont@email.com'],
    'country': ['France']
})

new_customer.to_sql('customers', engine, if_exists='append', index=False)
```

#### Mise à jour et suppression

```python
conn = sqlite3.connect('sales.db')
cursor = conn.cursor()

# UPDATE
cursor.execute("""
    UPDATE customers
    SET country = ?
    WHERE customer_id = ?
""", ('Belgique', 5))

# DELETE
cursor.execute("""
    DELETE FROM customers
    WHERE customer_id = ?
""", (100,))

conn.commit()
conn.close()
```

### 10. Bonnes Pratiques

#### ✅ À FAIRE

1. **Utiliser des paramètres** pour éviter les injections SQL
2. **Fermer les connexions** (ou utiliser context managers)
3. **Gérer les erreurs** avec try/except
4. **Valider les données** avant insertion
5. **Utiliser pandas** pour l'analyse (plus efficace)
6. **Indexer les colonnes** utilisées dans WHERE/JOIN
7. **Limiter les résultats** avec LIMIT si nécessaire

```python
# Context manager (fermeture automatique)
with sqlite3.connect('sales.db') as conn:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM customers")
    results = cursor.fetchall()
# Connexion fermée automatiquement

# Avec SQLAlchemy
from sqlalchemy import create_engine

engine = create_engine('sqlite:///sales.db')
with engine.connect() as conn:
    result = conn.execute("SELECT * FROM customers")
    rows = result.fetchall()
```

#### ❌ À ÉVITER

1. **Ne jamais** concaténer des variables dans SQL
2. **Ne pas** laisser les connexions ouvertes
3. **Éviter** de charger toutes les données si inutile
4. **Ne pas** ignorer les erreurs
5. **Éviter** les requêtes N+1 (charger en une seule requête)

```python
# ❌ MAUVAIS : Requêtes N+1
customers = pd.read_sql_query("SELECT * FROM customers", engine)
for _, customer in customers.iterrows():
    orders = pd.read_sql_query(
        f"SELECT * FROM orders WHERE customer_id = {customer['customer_id']}",
        engine
    )
    # Traitement...

# ✅ BON : Une seule requête avec JOIN
df = pd.read_sql_query("""
    SELECT c.*, o.order_id, o.order_date, o.total_amount
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
""", engine)
```

### 11. Export des Résultats

```python
# Export vers CSV
df = pd.read_sql_query("SELECT * FROM customers", engine)
df.to_csv('customers_export.csv', index=False, encoding='utf-8')

# Export vers Excel (nécessite openpyxl)
df.to_excel('customers_export.xlsx', index=False, sheet_name='Customers')

# Export vers JSON
df.to_json('customers_export.json', orient='records', indent=2)

# Export vers HTML
df.to_html('customers_export.html', index=False)
```

## 💻 Exercices Pratiques

### Exercice 1 : Connexion et Requêtes Simples

**Objectif** : Se connecter à la base `sales.db` et exécuter des requêtes SELECT.

**Instructions** :
1. Connectez-vous à `sales.db` avec SQLAlchemy
2. Récupérez tous les clients français dans un DataFrame
3. Affichez les 10 premiers résultats
4. Comptez le nombre total de clients par pays

**Livrable** : Script Python avec les requêtes et résultats affichés.

### Exercice 2 : Analyses avec JOIN

**Objectif** : Combiner plusieurs tables pour des analyses complexes.

**Instructions** :
1. Récupérez toutes les commandes avec les informations clients
2. Calculez le montant total des ventes par pays
3. Trouvez les 5 clients ayant dépensé le plus
4. Identifiez les produits les plus vendus (par quantité)

**Livrable** : Notebook Jupyter avec les requêtes et visualisations.

### Exercice 3 : Nettoyage et Transformation

**Objectif** : Extraire des données, les nettoyer et les transformer avec pandas.

**Instructions** :
1. Récupérez toutes les commandes de 2024
2. Convertissez les dates en format datetime
3. Ajoutez une colonne `month` et `quarter`
4. Créez un rapport mensuel des ventes
5. Exportez le résultat en CSV

**Livrable** : Script Python et fichier CSV généré.

### Exercice 4 : Création de Table Analytique

**Objectif** : Créer une table résumée pour l'analyse.

**Instructions** :
1. Créez un DataFrame avec les statistiques par client :
   - Nombre de commandes
   - Montant total dépensé
   - Montant moyen par commande
   - Date de dernière commande
2. Sauvegardez ce DataFrame dans une nouvelle table `customer_stats`
3. Vérifiez que la table a été créée correctement

**Livrable** : Script Python créant la table.

### Exercice 5 : Rapport Complet

**Objectif** : Créer un rapport d'analyse complet.

**Instructions** :
1. Récupérez les données de ventes avec tous les détails (clients, produits, commandes)
2. Calculez :
   - Chiffre d'affaires total
   - Nombre de clients uniques
   - Panier moyen
   - Top 10 produits
   - Distribution des ventes par catégorie
   - Évolution mensuelle des ventes
3. Créez des visualisations (graphiques)
4. Exportez le rapport en HTML

**Livrable** : Notebook Jupyter avec rapport complet et visualisations.

## 🔍 Ressources Complémentaires

### Documentation
- [sqlite3 - Python Docs](https://docs.python.org/3/library/sqlite3.html)
- [SQLAlchemy - Documentation](https://docs.sqlalchemy.org/)
- [pandas.read_sql_query](https://pandas.pydata.org/docs/reference/api/pandas.read_sql_query.html)
- [pandas.to_sql](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_sql.html)

### Tutorials
- [Real Python - Python SQL](https://realpython.com/python-sql-libraries/)
- [DataCamp - SQL in Python](https://www.datacamp.com/tutorial/sqlalchemy-tutorial-examples)

### Outils
- [DB Browser for SQLite](https://sqlitebrowser.org/) - Interface graphique pour SQLite
- [DBeaver](https://dbeaver.io/) - Client SQL universel

## 📝 Points Clés à Retenir

1. **sqlite3** est inclus dans Python, **SQLAlchemy** est plus puissant
2. **pandas.read_sql_query()** est la méthode la plus simple pour lire des données SQL
3. Toujours utiliser des **paramètres** dans les requêtes (sécurité)
4. **Fermer les connexions** ou utiliser context managers
5. **pandas** offre des outils puissants pour transformer les données SQL
6. **to_sql()** permet d'écrire facilement des DataFrames en base
7. Gérer les **erreurs** avec try/except
8. Privilégier une **seule requête JOIN** plutôt que plusieurs requêtes

## 🎯 Checklist de Compétences

Après cette session, vous devriez être capable de :

- [ ] Établir une connexion à une base SQLite avec sqlite3 et SQLAlchemy
- [ ] Exécuter des requêtes SELECT depuis Python
- [ ] Utiliser pandas.read_sql_query() pour charger des données
- [ ] Passer des paramètres sécurisés dans les requêtes
- [ ] Effectuer des JOIN complexes et analyser les résultats
- [ ] Transformer et nettoyer les données avec pandas
- [ ] Sauvegarder des DataFrames en base avec to_sql()
- [ ] Gérer les erreurs de connexion et de requête
- [ ] Exporter les résultats dans différents formats
- [ ] Appliquer les bonnes pratiques de sécurité et performance

---

**Prochaine session** : S14 — Visualisation de Données avec Matplotlib et Seaborn 📊
