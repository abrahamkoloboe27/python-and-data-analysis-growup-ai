# 📊 S10 — Concepts SGBD & Modélisation Simple

## 🎯 Objectifs de la Session

- Comprendre les concepts fondamentaux des bases de données relationnelles
- Maîtriser les notions de tables, clés primaires et étrangères
- Apprendre la normalisation basique des données
- Concevoir un schéma de base de données simple

## 📚 Contenu Théorique

### 1. SGBDR vs NoSQL

#### SGBDR (Systèmes de Gestion de Bases de Données Relationnelles)
- **Définition** : Bases de données organisées en tables avec des relations
- **Exemples** : MySQL, PostgreSQL, SQLite, Oracle, SQL Server
- **Avantages** :
  - Structure claire et organisée
  - Intégrité des données (contraintes)
  - Langage SQL standardisé
  - Transactions ACID (Atomicité, Cohérence, Isolation, Durabilité)
- **Cas d'usage** : Applications nécessitant des transactions complexes, cohérence des données

#### NoSQL
- **Définition** : Bases de données non-relationnelles
- **Types** : Document (MongoDB), Clé-Valeur (Redis), Colonne (Cassandra), Graphe (Neo4j)
- **Avantages** :
  - Flexibilité du schéma
  - Scalabilité horizontale
  - Performance pour gros volumes
- **Cas d'usage** : Big Data, temps réel, données non structurées

### 2. Concepts Fondamentaux

#### Tables
Une table est une collection de données organisées en lignes (enregistrements) et colonnes (attributs).

```
Table : customers
+----+----------+-----------+-------------+
| id | nom      | email     | pays        |
+----+----------+-----------+-------------+
| 1  | Dupont   | d@ex.com  | France      |
| 2  | Martin   | m@ex.com  | France      |
+----+----------+-----------+-------------+
```

#### Clé Primaire (Primary Key)
- Identifiant unique pour chaque enregistrement
- Ne peut pas être NULL
- Valeur unique dans la table
- Exemple : `id` dans la table customers

#### Clé Étrangère (Foreign Key)
- Référence à la clé primaire d'une autre table
- Maintient l'intégrité référentielle
- Exemple : `customer_id` dans la table orders référence `id` dans customers

### 3. Normalisation Basique

#### Première Forme Normale (1NF)
- Chaque colonne contient des valeurs atomiques (non divisibles)
- Pas de groupes répétitifs
- Chaque enregistrement est unique

#### Deuxième Forme Normale (2NF)
- Respecte 1NF
- Tous les attributs non-clés dépendent de la totalité de la clé primaire

#### Troisième Forme Normale (3NF)
- Respecte 2NF
- Pas de dépendances transitives (attributs non-clés ne dépendent que de la clé)

### 4. Schéma de Base de Données

Un schéma définit :
- Les tables et leurs colonnes
- Les types de données
- Les contraintes (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE)
- Les relations entre tables

## 🛠️ Outils

### SQLite
- **Avantages** :
  - Base de données locale, aucun serveur requis
  - Fichier unique, facile à partager
  - Idéal pour l'apprentissage et le prototypage
- **Installation** :
  ```bash
  # Déjà inclus avec Python
  python -c "import sqlite3; print(sqlite3.version)"
  ```

### PostgreSQL (Concept)
- Base de données entreprise, open-source
- Fonctionnalités avancées (JSON, full-text search, etc.)
- Nécessite installation et configuration serveur

### Interfaces Graphiques

#### DBeaver
- Multi-plateforme, gratuit
- Supporte tous les SGBD
- Téléchargement : https://dbeaver.io/

#### pgAdmin
- Interface spécifique à PostgreSQL
- Téléchargement : https://www.pgadmin.org/

## 💻 Exercice Pratique : Système de Ventes

### Contexte
Vous devez concevoir une base de données pour un système de ventes e-commerce simple.

### Exigences
Le système doit gérer :
1. **Clients** : informations client (nom, email, adresse)
2. **Produits** : catalogue de produits (nom, prix, stock)
3. **Commandes** : commandes passées par les clients
4. **Articles de commande** : produits dans chaque commande (quantité, prix unitaire)

### Schéma Proposé

#### Table : customers
- `customer_id` : identifiant unique (PK)
- `first_name` : prénom
- `last_name` : nom
- `email` : adresse email (unique)
- `phone` : téléphone
- `address` : adresse
- `city` : ville
- `country` : pays
- `created_at` : date de création

#### Table : products
- `product_id` : identifiant unique (PK)
- `product_name` : nom du produit
- `category` : catégorie
- `price` : prix unitaire
- `stock_quantity` : quantité en stock
- `description` : description
- `created_at` : date d'ajout

#### Table : orders
- `order_id` : identifiant unique (PK)
- `customer_id` : référence au client (FK)
- `order_date` : date de commande
- `status` : statut (pending, shipped, delivered, cancelled)
- `total_amount` : montant total
- `shipping_address` : adresse de livraison

#### Table : order_items
- `order_item_id` : identifiant unique (PK)
- `order_id` : référence à la commande (FK)
- `product_id` : référence au produit (FK)
- `quantity` : quantité commandée
- `unit_price` : prix unitaire au moment de la commande

### Relations
```
customers (1) ----< (N) orders
products (1) ----< (N) order_items
orders (1) ----< (N) order_items
```

## 📝 Livrable : schema_sales.sql

Créez un fichier `schema_sales.sql` dans le dossier `sql/` contenant :
1. Les instructions `CREATE TABLE` pour les 4 tables
2. Toutes les contraintes nécessaires (PRIMARY KEY, FOREIGN KEY, NOT NULL, etc.)
3. Des commentaires expliquant les choix de conception

### Exemple de Structure

```sql
-- ============================================================================
-- Schéma de Base de Données : Système de Ventes E-Commerce
-- ============================================================================
-- Auteur : [Votre Nom]
-- Date : [Date]
-- Description : Schéma pour gérer clients, produits, commandes
-- ============================================================================

-- Suppression des tables si elles existent (pour réinitialisation)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Table : customers
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    -- ... autres colonnes
);

-- ... autres tables
```

## ✅ Critères de Validation

Votre schéma doit :
- [ ] Contenir les 4 tables demandées
- [ ] Définir correctement toutes les clés primaires
- [ ] Définir toutes les clés étrangères avec contraintes d'intégrité
- [ ] Utiliser des types de données appropriés
- [ ] Inclure des contraintes NOT NULL où nécessaire
- [ ] Être bien commenté et organisé
- [ ] Pouvoir être exécuté sans erreur sur SQLite

## 📚 Ressources Complémentaires

- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [Database Normalization Explained](https://www.guru99.com/database-normalization.html)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)

## 🚀 Pour Aller Plus Loin

1. Ajoutez une table `categories` pour normaliser les catégories de produits
2. Ajoutez une table `payment_methods` pour gérer différents moyens de paiement
3. Ajoutez des contraintes CHECK (ex: price > 0, stock_quantity >= 0)
4. Créez un script pour insérer des données de test
5. Expérimentez avec différents types de relations (many-to-many)

## 🎓 Points Clés à Retenir

1. **SGBDR** = données structurées en tables avec relations
2. **Clé primaire** = identifiant unique par table
3. **Clé étrangère** = lien entre tables
4. **Normalisation** = organiser les données pour éviter la redondance
5. **Contraintes** = règles pour garantir l'intégrité des données

---

**Prochaine Session** : S11 - SQL SELECT, filtres et ORDER BY
