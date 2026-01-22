# 📊 S12 — JOINs, GROUP BY, HAVING

## 🎯 Objectifs de la Session

- Maîtriser les différents types de JOIN (INNER, LEFT, RIGHT, FULL)
- Comprendre comment combiner des données de plusieurs tables
- Utiliser GROUP BY pour agréger les données
- Filtrer les groupes avec HAVING
- Créer des analyses complexes multi-tables
- Introduction aux index pour améliorer les performances

## 📚 Contenu Théorique

### 1. Les JOINs : Combiner des Tables

Les JOIN permettent de combiner les données de plusieurs tables en utilisant des clés communes.

#### INNER JOIN
Retourne uniquement les lignes qui ont une correspondance dans les deux tables.

```sql
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
```

**Résultat** : Seulement les clients qui ont passé au moins une commande.

#### LEFT JOIN (LEFT OUTER JOIN)
Retourne toutes les lignes de la table de gauche, même sans correspondance à droite.

```sql
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

**Résultat** : Tous les clients, avec NULL pour ceux sans commande.

**Utilité** : Trouver les clients inactifs :
```sql
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

#### RIGHT JOIN (RIGHT OUTER JOIN)
Retourne toutes les lignes de la table de droite, même sans correspondance à gauche.

```sql
-- SQLite ne supporte pas RIGHT JOIN directement
-- On utilise LEFT JOIN en inversant l'ordre
SELECT 
    o.order_id,
    c.first_name,
    c.last_name
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id;
```

#### FULL OUTER JOIN
Retourne toutes les lignes des deux tables (pas supporté nativement par SQLite).

### 2. Jointures Multiples

```sql
-- Joindre 3 tables : customers, orders, order_items
SELECT 
    c.first_name || ' ' || c.last_name AS client,
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
ORDER BY o.order_date DESC;
```

### 3. GROUP BY : Agréger les Données

GROUP BY permet de regrouper les lignes qui ont les mêmes valeurs dans certaines colonnes.

```sql
-- Nombre de commandes par client
SELECT 
    customer_id,
    COUNT(*) AS nombre_commandes,
    SUM(total_amount) AS ca_total
FROM orders
GROUP BY customer_id;
```

#### Règles Importantes
1. Toute colonne dans SELECT (hors fonctions d'agrégation) doit être dans GROUP BY
2. Les fonctions d'agrégation opèrent sur chaque groupe

```sql
-- ❌ ERREUR : first_name pas dans GROUP BY
SELECT customer_id, first_name, COUNT(*)
FROM orders
GROUP BY customer_id;

-- ✅ CORRECT
SELECT c.customer_id, c.first_name, COUNT(o.order_id)
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name;
```

### 4. HAVING : Filtrer les Groupes

HAVING filtre les résultats APRÈS l'agrégation (WHERE filtre AVANT).

```sql
-- Clients avec plus de 3 commandes
SELECT 
    customer_id,
    COUNT(*) AS nombre_commandes
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;
```

**Différence WHERE vs HAVING** :
```sql
-- WHERE : filtre les lignes AVANT le GROUP BY
SELECT category, COUNT(*)
FROM products
WHERE price > 100  -- Filtre avant agrégation
GROUP BY category;

-- HAVING : filtre les groupes APRÈS le GROUP BY
SELECT category, COUNT(*) AS nb
FROM products
GROUP BY category
HAVING COUNT(*) > 5;  -- Filtre après agrégation
```

### 5. Fonctions d'Agrégation Avancées

```sql
SELECT 
    category,
    COUNT(*) AS nombre_produits,
    SUM(stock_quantity) AS stock_total,
    AVG(price) AS prix_moyen,
    MIN(price) AS prix_min,
    MAX(price) AS prix_max,
    -- Calculs sur agrégations
    ROUND(AVG(price), 2) AS prix_moyen_arrondi,
    SUM(price * stock_quantity) AS valeur_stock_total
FROM products
GROUP BY category
HAVING COUNT(*) > 3
ORDER BY stock_total DESC;
```

### 6. Index : Améliorer les Performances

Les index accélèrent les recherches et les jointures.

```sql
-- Créer un index simple
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- Index sur plusieurs colonnes
CREATE INDEX idx_orders_date_status ON orders(order_date, status);

-- Index unique (garantit l'unicité)
CREATE UNIQUE INDEX idx_customers_email ON customers(email);

-- Supprimer un index
DROP INDEX idx_orders_customer;
```

**Quand utiliser les index ?**
- ✅ Colonnes dans WHERE fréquemment
- ✅ Colonnes dans JOIN
- ✅ Colonnes dans ORDER BY
- ❌ Tables avec beaucoup d'INSERT/UPDATE (ralentit les écritures)
- ❌ Colonnes avec peu de valeurs distinctes

## 💻 Exercices Pratiques

### Exercice 1 : Chiffre d'Affaires par Produit et par Mois

**Objectif** : Analyser les ventes par produit et par mois pour identifier les tendances.

```sql
SELECT 
    strftime('%Y-%m', o.order_date) AS mois,
    p.product_name,
    p.category,
    COUNT(DISTINCT o.order_id) AS nombre_commandes,
    SUM(oi.quantity) AS quantite_vendue,
    SUM(oi.subtotal) AS ca_total,
    ROUND(AVG(oi.unit_price), 2) AS prix_moyen
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'cancelled'
GROUP BY strftime('%Y-%m', o.order_date), p.product_id, p.product_name, p.category
ORDER BY mois DESC, ca_total DESC;
```

### Exercice 2 : Clients avec Plus de N Commandes

**Objectif** : Identifier les clients fidèles (plus de 2 commandes).

```sql
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nom_complet,
    c.email,
    c.city,
    COUNT(o.order_id) AS nombre_commandes,
    SUM(o.total_amount) AS ca_total,
    ROUND(AVG(o.total_amount), 2) AS panier_moyen,
    MIN(o.order_date) AS premiere_commande,
    MAX(o.order_date) AS derniere_commande
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
HAVING COUNT(o.order_id) > 2
ORDER BY ca_total DESC;
```

### Exercice 3 : Analyse des Catégories les Plus Rentables

```sql
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS nombre_produits,
    COUNT(DISTINCT o.order_id) AS nombre_commandes,
    SUM(oi.quantity) AS quantite_totale,
    SUM(oi.subtotal) AS ca_total,
    ROUND(AVG(oi.unit_price), 2) AS prix_moyen,
    ROUND(SUM(oi.subtotal) / COUNT(DISTINCT o.order_id), 2) AS ca_par_commande
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'delivered'
GROUP BY p.category
HAVING COUNT(DISTINCT o.order_id) >= 3
ORDER BY ca_total DESC;
```

### Exercice 4 : Top 5 Produits par Catégorie

```sql
-- Utilisation d'une sous-requête pour le ranking
SELECT *
FROM (
    SELECT 
        p.category,
        p.product_name,
        COUNT(oi.order_item_id) AS fois_commande,
        SUM(oi.quantity) AS quantite_vendue,
        SUM(oi.subtotal) AS ca_produit,
        ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.subtotal) DESC) AS rang
    FROM products p
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'delivered'
    GROUP BY p.category, p.product_id, p.product_name
) ranked
WHERE rang <= 5
ORDER BY category, rang;
```

### Exercice 5 : Évolution Mensuelle des Ventes

```sql
SELECT 
    strftime('%Y-%m', order_date) AS mois,
    COUNT(order_id) AS nombre_commandes,
    COUNT(DISTINCT customer_id) AS clients_uniques,
    SUM(total_amount) AS ca_total,
    ROUND(AVG(total_amount), 2) AS panier_moyen,
    -- Comparaison avec le mois précédent (simplifiée)
    ROUND(SUM(total_amount) * 100.0 / 
        LAG(SUM(total_amount)) OVER (ORDER BY strftime('%Y-%m', order_date)) - 100, 2) 
        AS croissance_pct
FROM orders
WHERE status != 'cancelled'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY mois;
```

## 📝 Livrable 1 : queries_s12.sql

Fichier contenant toutes les requêtes des exercices, bien commentées.

## 📊 Livrable 2 : report_s12.md

Créez un mini rapport avec :
1. **Analyse des Top Clients** : Table et graphique
2. **CA par Catégorie** : Table et graphique
3. **Évolution Mensuelle** : Graphique des ventes

### Structure du Rapport

```markdown
# Rapport d'Analyse - Session 12

## 1. Top 10 Clients Fidèles

### Table des Résultats
[Insérer capture d'écran ou table markdown]

### Insights
- Client le plus fidèle : ...
- Panier moyen des top clients : ...
- Observations : ...

### Graphique
[Insérer graphique exporté]

## 2. Chiffre d'Affaires par Catégorie

### Table des Résultats
[Résultats de la requête]

### Graphique
[Graphique en barres du CA par catégorie]

## 3. Évolution Mensuelle des Ventes

### Graphique
[Graphique en ligne de l'évolution]

### Analyse
- Tendance générale : ...
- Mois le plus performant : ...
- Recommandations : ...
```

## 📈 Créer les Graphiques

### Option 1 : Excel/LibreOffice
1. Exporter les résultats en CSV
2. Ouvrir dans Excel
3. Créer graphique (barres, ligne)
4. Exporter en image

### Option 2 : Python (Bonus)
```python
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3

# Connexion
conn = sqlite3.connect('sales.db')

# Requête
query = """
SELECT category, SUM(subtotal) as ca
FROM ...
GROUP BY category
"""

# Graphique
df = pd.read_sql_query(query, conn)
df.plot(x='category', y='ca', kind='bar', title='CA par Catégorie')
plt.savefig('ca_categories.png')
```

## ✅ Critères de Validation

Votre travail doit :
- [ ] Contenir queries_s12.sql avec toutes les requêtes
- [ ] Avoir des commentaires explicatifs
- [ ] Inclure report_s12.md avec tables et graphiques
- [ ] Montrer des insights pertinents
- [ ] Être bien formaté et professionnel
- [ ] S'exécuter sans erreur

## 🎯 Points Clés à Retenir

1. **INNER JOIN** = uniquement les correspondances
2. **LEFT JOIN** = toutes les lignes de gauche + correspondances
3. **GROUP BY** = regrouper pour agréger
4. **HAVING** = filtrer après agrégation (vs WHERE avant)
5. **Index** = améliorer les performances des requêtes
6. **Fonctions fenêtre** (OVER) = calculs avancés

## 📚 Ressources Complémentaires

- [SQL JOINs Explained](https://www.w3schools.com/sql/sql_join.asp)
- [Visual JOIN Representation](https://joins.spathon.com/)
- [GROUP BY Tutorial](https://www.sqlitetutorial.net/sqlite-group-by/)
- [Window Functions](https://www.sqlitetutorial.net/sqlite-window-functions/)

## 🚀 Pour Aller Plus Loin

1. Créez des requêtes avec SELF JOIN (jointure sur la même table)
2. Expérimentez avec CROSS JOIN
3. Utilisez des CTEs (Common Table Expressions) avec WITH
4. Essayez des fonctions fenêtre avancées (RANK, DENSE_RANK)
5. Optimisez vos requêtes avec EXPLAIN QUERY PLAN

---

**Prochaine Session** : S13 - SQL depuis Python (pandas + SQL)
