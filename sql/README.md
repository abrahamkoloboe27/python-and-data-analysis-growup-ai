# 🗄️ SQL et Bases de Données - Documentation

## 📚 Vue d'Ensemble

Ce dossier contient l'ensemble des ressources pour apprendre SQL et les bases de données relationnelles dans le cadre de la formation Grow Up AI. Les sessions couvrent les concepts fondamentaux jusqu'à l'intégration avancée avec Python.

## 📂 Structure du Dossier

```
sql/
├── schema_sales.sql           # Schéma complet de la base de données
├── insert_sample_data.sql     # Données de test (20 clients, 30 produits, 40 commandes)
├── queries_s11.sql            # Requêtes SELECT, filtres, ORDER BY
├── queries_s12.sql            # JOINs, GROUP BY, HAVING
├── report_s12_template.md     # Template de rapport d'analyse
├── sales.db                   # Base de données SQLite complète
└── README.md                  # Ce fichier
```

## 🎯 Sessions de Formation

### 📊 S10 — Concepts SGBD & Modélisation Simple
**Documentation** : [notebooks/S10-README.md](../notebooks/S10-README.md)

**Objectifs** :
- Comprendre SGBDR vs NoSQL
- Maîtriser clés primaires et étrangères
- Apprendre la normalisation (1NF, 2NF, 3NF)
- Concevoir un schéma de base de données

**Fichier principal** : `schema_sales.sql`

**Contenu du schéma** :
- 4 tables : `customers`, `products`, `orders`, `order_items`
- Clés primaires et étrangères
- Contraintes d'intégrité (CHECK, NOT NULL, UNIQUE)
- 2 vues : `order_summary`, `product_sales`
- Index pour optimisation

### 📊 S11 — SQL SELECT, Filtres, ORDER BY
**Documentation** : [notebooks/S11-README.md](../notebooks/S11-README.md)

**Objectifs** :
- Maîtriser SELECT et projections
- Utiliser WHERE, LIKE, IN
- Trier avec ORDER BY et LIMIT
- Fonctions d'agrégation (COUNT, SUM, AVG)

**Fichier principal** : `queries_s11.sql`

**Exercices inclus** :
1. Top 10 clients par chiffre d'affaires
2. Commandes d'un mois donné
3. Produits en rupture de stock
4. Recherche de produits avec LIKE
5. Statistiques par catégorie

### 📊 S12 — JOINs, GROUP BY, HAVING
**Documentation** : [notebooks/S12-README.md](../notebooks/S12-README.md)

**Objectifs** :
- Maîtriser tous les types de JOIN
- Jointures multiples (3+ tables)
- Agrégations avec GROUP BY
- Filtrer les groupes avec HAVING
- Optimisation avec index

**Fichier principal** : `queries_s12.sql`

**Exercices inclus** :
1. CA par produit et par mois
2. Clients avec > N commandes (HAVING)
3. Analyse des catégories rentables
4. Top 5 produits par catégorie
5. Évolution mensuelle des ventes

**Livrable** : Rapport d'analyse avec graphiques (template fourni)

### 📊 S13 — SQL depuis Python
**Documentation** : [notebooks/S13-README.md](../notebooks/S13-README.md)

**Objectifs** :
- Connecter Python à SQLite
- Utiliser sqlite3 et SQLAlchemy
- pandas.read_sql_query() et to_sql()
- Traiter les résultats avec pandas

**Fichier principal** : `../notebooks/sql_python_s13.ipynb`

## 🚀 Démarrage Rapide

### 1️⃣ Créer la Base de Données

```bash
# Se placer dans le dossier sql/
cd sql/

# Créer la base et le schéma
sqlite3 sales.db < schema_sales.sql

# Insérer les données de test
sqlite3 sales.db < insert_sample_data.sql

# Vérifier
sqlite3 sales.db "SELECT COUNT(*) FROM customers;"
# Résultat attendu : 20
```

### 2️⃣ Exécuter les Requêtes

```bash
# Ouvrir la base de données
sqlite3 sales.db

# Mode formaté
.mode column
.headers on

# Exécuter une requête
SELECT * FROM customers LIMIT 5;

# Exécuter un fichier de requêtes
.read queries_s11.sql

# Quitter
.quit
```

### 3️⃣ Utiliser DBeaver (Interface Graphique)

1. **Télécharger** : https://dbeaver.io/
2. **Nouvelle connexion** : SQLite
3. **Chemin** : Sélectionner `sales.db`
4. **Tester** : Exécuter `SELECT * FROM customers;`

### 4️⃣ Depuis Python

```python
import sqlite3
import pandas as pd

# Connexion
conn = sqlite3.connect('sql/sales.db')

# Requête avec pandas
df = pd.read_sql_query("SELECT * FROM customers LIMIT 10", conn)
print(df)

# Fermer
conn.close()
```

## 📊 Schéma de la Base de Données

### Table : customers (20 enregistrements)
```sql
customer_id (PK)    - Identifiant unique
first_name          - Prénom
last_name           - Nom
email (UNIQUE)      - Email
phone               - Téléphone
address             - Adresse
city                - Ville
postal_code         - Code postal
country             - Pays
created_at          - Date de création
```

### Table : products (30 enregistrements)
```sql
product_id (PK)     - Identifiant unique
product_name        - Nom du produit
category            - Catégorie (Électronique, Vêtements, Livres, Maison)
price               - Prix unitaire
stock_quantity      - Quantité en stock
description         - Description
supplier            - Fournisseur
created_at          - Date d'ajout
```

### Table : orders (40 enregistrements)
```sql
order_id (PK)       - Identifiant unique
customer_id (FK)    - Référence au client
order_date          - Date de commande
status              - Statut (pending, processing, shipped, delivered, cancelled)
total_amount        - Montant total
shipping_address    - Adresse de livraison
shipping_city       - Ville de livraison
payment_method      - Moyen de paiement
created_at          - Date de création
```

### Table : order_items (49 enregistrements)
```sql
order_item_id (PK)  - Identifiant unique
order_id (FK)       - Référence à la commande
product_id (FK)     - Référence au produit
quantity            - Quantité commandée
unit_price          - Prix unitaire au moment de la commande
discount_percent    - Pourcentage de réduction
subtotal (CALC)     - Sous-total calculé automatiquement
```

### Relations
```
customers (1) ----< (N) orders
products (1) ----< (N) order_items
orders (1) ----< (N) order_items
```

## 📈 Statistiques des Données

- **Clients** : 20 (répartis dans 20 villes françaises)
- **Produits** : 30 (4 catégories)
- **Commandes** : 40 (25 livrées, 8 expédiées, 5 en traitement, 2 en attente)
- **Articles** : 49 (lignes de commande)
- **Période** : Novembre 2025 - Janvier 2026
- **CA Total** : ~40,000€

### Répartition par Catégorie
- **Électronique** : 10 produits (prix élevés)
- **Vêtements** : 10 produits (volume)
- **Livres** : 5 produits (prix moyens)
- **Maison** : 5 produits (prix variés)

## 💡 Exemples de Requêtes Utiles

### Top 5 Clients
```sql
SELECT 
    c.first_name || ' ' || c.last_name AS client,
    COUNT(o.order_id) AS commandes,
    SUM(o.total_amount) AS ca_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id
ORDER BY ca_total DESC
LIMIT 5;
```

### CA par Catégorie
```sql
SELECT 
    p.category,
    COUNT(DISTINCT o.order_id) AS nb_commandes,
    SUM(oi.subtotal) AS ca_total
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY ca_total DESC;
```

### Évolution Mensuelle
```sql
SELECT 
    strftime('%Y-%m', order_date) AS mois,
    COUNT(*) AS nb_commandes,
    SUM(total_amount) AS ca_mensuel
FROM orders
WHERE status != 'cancelled'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY mois;
```

## 🛠️ Commandes SQLite Utiles

```bash
# Lister les tables
.tables

# Voir le schéma d'une table
.schema customers

# Mode d'affichage
.mode column      # Colonnes alignées
.mode csv         # Format CSV
.mode list        # Liste simple

# Headers
.headers on       # Afficher les en-têtes
.headers off      # Masquer les en-têtes

# Export CSV
.mode csv
.output resultats.csv
SELECT * FROM customers;
.output stdout

# Import CSV
.mode csv
.import data.csv nom_table

# Mesurer le temps
.timer on

# Aide
.help
```

## 📚 Ressources Complémentaires

### Documentation Officielle
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [SQLite Tutorial](https://www.sqlitetutorial.net/)
- [W3Schools SQL](https://www.w3schools.com/sql/)

### Outils
- [DBeaver](https://dbeaver.io/) - Client SQL universel
- [DB Browser for SQLite](https://sqlitebrowser.org/) - Interface SQLite simple
- [SQLite Online](https://sqliteonline.com/) - Tester en ligne

### Cours et Tutoriels
- [SQL Zoo](https://sqlzoo.net/) - Exercices interactifs
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)
- [Khan Academy SQL](https://www.khanacademy.org/computing/computer-programming/sql)

## 🎯 Exercices Suggérés

### Niveau Débutant
1. Lister tous les clients de Paris
2. Trouver les produits à moins de 50€
3. Compter le nombre de commandes livrées
4. Afficher les 10 produits les plus chers

### Niveau Intermédiaire
5. CA total par ville
6. Produits jamais commandés (LEFT JOIN)
7. Panier moyen par catégorie
8. Clients avec plusieurs commandes

### Niveau Avancé
9. Clients inactifs depuis 3 mois
10. Produits souvent achetés ensemble
11. Évolution du CA semaine par semaine
12. Analyse de cohorte (clients par mois d'inscription)

## 🐛 Problèmes Courants

### Erreur : database is locked
```bash
# Vérifier les processus
lsof sales.db

# Ou redémarrer SQLite
```

### Caractères spéciaux dans les noms
```sql
-- Utiliser des guillemets doubles pour les identifiants
SELECT "first name" FROM customers;

-- Ou éviter les espaces dans les noms de colonnes
```

### Performance lente
```sql
-- Créer des index
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- Analyser la requête
EXPLAIN QUERY PLAN SELECT ...;
```

## ✅ Checklist de Validation

Pour vérifier que tout fonctionne :

```sql
-- 1. Nombre de tables (devrait être 4)
SELECT COUNT(*) FROM sqlite_master WHERE type='table';

-- 2. Nombre de clients (devrait être 20)
SELECT COUNT(*) FROM customers;

-- 3. Nombre de produits (devrait être 30)
SELECT COUNT(*) FROM products;

-- 4. Nombre de commandes (devrait être 40)
SELECT COUNT(*) FROM orders;

-- 5. Nombre d'articles (devrait être 49)
SELECT COUNT(*) FROM order_items;

-- 6. Intégrité référentielle (pas de NULL)
SELECT COUNT(*) FROM orders WHERE customer_id IS NULL;
-- Devrait retourner 0
```

## 📧 Support

Pour toute question sur les ressources SQL :
- Consultez d'abord les README de session
- Vérifiez les exemples dans les fichiers .sql
- Référez-vous aux notebooks Jupyter (S13)

---

**Grow Up AI** - Formation SQL et Bases de Données  
*Dernière mise à jour : Janvier 2026*
