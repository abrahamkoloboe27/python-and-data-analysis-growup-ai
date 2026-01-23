# 📊 S11 — SQL SELECT, filtres, ORDER BY

## 🎯 Objectifs de la Session

- Maîtriser la requête SELECT et ses variantes
- Utiliser les clauses WHERE pour filtrer les données
- Trier les résultats avec ORDER BY
- Limiter les résultats avec LIMIT
- Introduction aux fonctions d'agrégation (COUNT, SUM)

## 📚 Contenu Théorique

### 1. SELECT : La Requête Fondamentale

#### Syntaxe de Base
```sql
SELECT colonne1, colonne2, ...
FROM nom_table;
```

#### SELECT * (toutes les colonnes)
```sql
-- Récupérer toutes les colonnes
SELECT * FROM customers;
```

⚠️ **Attention** : `SELECT *` est pratique pour explorer, mais en production utilisez des colonnes explicites pour :
- Meilleures performances
- Code plus maintenable
- Documentation claire

#### Projections (colonnes spécifiques)
```sql
-- Sélectionner seulement certaines colonnes
SELECT first_name, last_name, email
FROM customers;
```

### 2. Alias : Renommer les Colonnes

```sql
-- Alias avec AS (recommandé)
SELECT 
    first_name AS prénom,
    last_name AS nom,
    email AS "adresse email"
FROM customers;

-- Alias sans AS (possible mais moins lisible)
SELECT 
    first_name prénom,
    last_name nom
FROM customers;
```

#### Expressions calculées
```sql
-- Calculer un prix TTC
SELECT 
    product_name,
    price AS prix_ht,
    price * 1.20 AS prix_ttc,
    ROUND(price * 1.20, 2) AS prix_ttc_arrondi
FROM products;
```

### 3. WHERE : Filtrer les Données

#### Opérateurs de Comparaison
```sql
-- Égalité
SELECT * FROM products WHERE category = 'Électronique';

-- Différent
SELECT * FROM products WHERE category != 'Électronique';
SELECT * FROM products WHERE category <> 'Électronique';  -- Même chose

-- Comparaisons numériques
SELECT * FROM products WHERE price > 100;
SELECT * FROM products WHERE price >= 100;
SELECT * FROM products WHERE price < 100;
SELECT * FROM products WHERE price <= 100;
SELECT * FROM products WHERE stock_quantity BETWEEN 10 AND 50;
```

#### Opérateurs Logiques
```sql
-- AND : toutes les conditions doivent être vraies
SELECT * FROM products 
WHERE category = 'Électronique' AND price < 500;

-- OR : au moins une condition doit être vraie
SELECT * FROM products 
WHERE category = 'Électronique' OR category = 'Livres';

-- NOT : inverse la condition
SELECT * FROM products 
WHERE NOT category = 'Électronique';
```

#### IN : Liste de Valeurs
```sql
-- Plusieurs valeurs possibles
SELECT * FROM products 
WHERE category IN ('Électronique', 'Livres', 'Maison');

-- Équivalent à :
SELECT * FROM products 
WHERE category = 'Électronique' 
   OR category = 'Livres' 
   OR category = 'Maison';
```

#### LIKE : Recherche de Motifs
```sql
-- % = zéro ou plusieurs caractères
-- _ = exactement un caractère

-- Commence par 'Jean'
SELECT * FROM customers WHERE first_name LIKE 'Jean%';

-- Contient 'mart'
SELECT * FROM customers WHERE email LIKE '%mart%';

-- Se termine par '.fr'
SELECT * FROM customers WHERE email LIKE '%.fr';

-- Deuxième lettre est 'a'
SELECT * FROM customers WHERE first_name LIKE '_a%';
```

#### IS NULL / IS NOT NULL
```sql
-- Valeurs nulles
SELECT * FROM customers WHERE phone IS NULL;

-- Valeurs non nulles
SELECT * FROM customers WHERE phone IS NOT NULL;
```

### 4. ORDER BY : Trier les Résultats

```sql
-- Tri croissant (par défaut)
SELECT * FROM products ORDER BY price;
SELECT * FROM products ORDER BY price ASC;  -- Explicite

-- Tri décroissant
SELECT * FROM products ORDER BY price DESC;

-- Tri sur plusieurs colonnes
SELECT * FROM products 
ORDER BY category ASC, price DESC;
```

### 5. LIMIT : Limiter les Résultats

```sql
-- Les 10 premiers résultats
SELECT * FROM products ORDER BY price DESC LIMIT 10;

-- Pagination : LIMIT avec OFFSET
SELECT * FROM products 
ORDER BY product_id
LIMIT 20 OFFSET 0;   -- Page 1 : enregistrements 1-20

SELECT * FROM products 
ORDER BY product_id
LIMIT 20 OFFSET 20;  -- Page 2 : enregistrements 21-40
```

### 6. Fonctions d'Agrégation (Introduction)

```sql
-- COUNT : compter les lignes
SELECT COUNT(*) AS nombre_produits FROM products;
SELECT COUNT(DISTINCT category) AS nombre_categories FROM products;

-- SUM : somme
SELECT SUM(stock_quantity) AS stock_total FROM products;

-- AVG : moyenne
SELECT AVG(price) AS prix_moyen FROM products;

-- MIN / MAX : valeurs minimale et maximale
SELECT MIN(price) AS prix_min, MAX(price) AS prix_max FROM products;
```

### 7. DISTINCT : Éliminer les Doublons

```sql
-- Toutes les catégories uniques
SELECT DISTINCT category FROM products;

-- Combinaison de colonnes
SELECT DISTINCT category, supplier FROM products;
```

## 💻 Exercices Pratiques

### Exercice 1 : Top 10 Clients par Chiffre d'Affaires

**Objectif** : Identifier les 10 meilleurs clients en fonction du montant total de leurs commandes.

**Requête** :
```sql
-- Agréger par client
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nom_complet,
    c.email,
    COUNT(o.order_id) AS nombre_commandes,
    SUM(o.total_amount) AS chiffre_affaires
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY chiffre_affaires DESC
LIMIT 10;
```

**Résultat attendu** : Table avec les 10 clients ayant généré le plus de CA.

### Exercice 2 : Commandes d'un Mois Donné

**Objectif** : Récupérer toutes les commandes de décembre 2025.

**Requête avec BETWEEN** :
```sql
SELECT 
    order_id,
    customer_id,
    order_date,
    status,
    total_amount
FROM orders
WHERE order_date BETWEEN '2025-12-01' AND '2025-12-31 23:59:59'
ORDER BY order_date DESC;
```

**Requête avec strftime (SQLite)** :
```sql
SELECT 
    order_id,
    customer_id,
    strftime('%Y-%m-%d', order_date) AS date_commande,
    status,
    total_amount
FROM orders
WHERE strftime('%Y-%m', order_date) = '2025-12'
ORDER BY order_date DESC;
```

### Exercice 3 : Produits en Rupture de Stock

```sql
SELECT 
    product_id,
    product_name,
    category,
    stock_quantity,
    price
FROM products
WHERE stock_quantity < 10
ORDER BY stock_quantity ASC, category;
```

### Exercice 4 : Recherche de Produits

```sql
-- Tous les produits Apple
SELECT * FROM products 
WHERE product_name LIKE '%Apple%' OR supplier LIKE '%Apple%'
ORDER BY price DESC;

-- Produits entre 50€ et 200€
SELECT 
    product_name,
    category,
    price
FROM products
WHERE price BETWEEN 50 AND 200
ORDER BY price ASC;
```

### Exercice 5 : Statistiques par Catégorie

```sql
SELECT 
    category,
    COUNT(*) AS nombre_produits,
    AVG(price) AS prix_moyen,
    MIN(price) AS prix_min,
    MAX(price) AS prix_max,
    SUM(stock_quantity) AS stock_total
FROM products
GROUP BY category
ORDER BY nombre_produits DESC;
```

## 📝 Livrable : queries_s11.sql

Créez un fichier `queries_s11.sql` contenant toutes les requêtes des exercices ci-dessus, bien commentées et organisées.

### Structure du Fichier

```sql
-- ============================================================================
-- Requêtes SQL - Session 11
-- ============================================================================
-- Auteur : [Votre Nom]
-- Date : [Date]
-- Description : Requêtes de base SELECT, WHERE, ORDER BY, LIMIT
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Exercice 1 : Top 10 clients par chiffre d'affaires
-- ----------------------------------------------------------------------------

-- Votre requête ici...

-- ----------------------------------------------------------------------------
-- Exercice 2 : Commandes d'un mois donné (Décembre 2025)
-- ----------------------------------------------------------------------------

-- Votre requête ici...

-- etc.
```

## 📊 Export CSV des Résultats

### Méthode 1 : SQLite en ligne de commande
```bash
# Se connecter à la base
sqlite3 sales.db

# Activer le mode CSV
.mode csv
.headers on
.output top_10_clients.csv
-- Exécuter votre requête
SELECT ...;
.output stdout
```

### Méthode 2 : DBeaver
1. Exécuter votre requête
2. Clic droit sur les résultats → Export Data
3. Choisir format CSV
4. Configurer les options (séparateur, guillemets)
5. Sauvegarder

### Méthode 3 : Python (bonus)
```python
import sqlite3
import pandas as pd

conn = sqlite3.connect('sales.db')
df = pd.read_sql_query("SELECT ...", conn)
df.to_csv('resultat.csv', index=False)
conn.close()
```

## ✅ Critères de Validation

Votre livrable doit :
- [ ] Contenir toutes les requêtes des exercices
- [ ] Avoir des commentaires clairs pour chaque requête
- [ ] Produire les résultats attendus
- [ ] Être bien formaté (indentation, lisibilité)
- [ ] Inclure les exports CSV des résultats
- [ ] Pouvoir s'exécuter sans erreur

## 🎯 Points Clés à Retenir

1. **SELECT** = récupérer des données
2. **WHERE** = filtrer les lignes
3. **ORDER BY** = trier les résultats
4. **LIMIT** = limiter le nombre de résultats
5. **Alias** = renommer les colonnes pour plus de clarté
6. **LIKE** = recherche de motifs avec % et _
7. **Agrégations** = COUNT, SUM, AVG, MIN, MAX

## 📚 Ressources Complémentaires

- [SQLite SELECT Tutorial](https://www.sqlitetutorial.net/sqlite-select/)
- [SQL WHERE Clause](https://www.w3schools.com/sql/sql_where.asp)
- [SQL ORDER BY](https://www.w3schools.com/sql/sql_orderby.asp)
- [SQL Aggregate Functions](https://www.w3schools.com/sql/sql_count_avg_sum.asp)

## 🚀 Pour Aller Plus Loin

1. Essayez des requêtes avec plusieurs conditions WHERE complexes
2. Combinez DISTINCT avec ORDER BY
3. Expérimentez avec les fonctions de date (strftime en SQLite)
4. Créez des requêtes avec des sous-requêtes simples
5. Explorez les fonctions de chaînes (UPPER, LOWER, SUBSTR)

---

**Prochaine Session** : S12 - JOINs, GROUP BY, HAVING
