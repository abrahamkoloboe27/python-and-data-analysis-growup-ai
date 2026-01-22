-- ============================================================================
-- Schéma de Base de Données : Système de Ventes E-Commerce
-- ============================================================================
-- Auteur : Formation Grow Up AI
-- Date : Janvier 2026
-- Description : Schéma complet pour gérer clients, produits, commandes et
--               articles de commande dans un système e-commerce
-- Base de données : SQLite (compatible PostgreSQL avec modifications mineures)
-- ============================================================================

-- Suppression des tables si elles existent (pour réinitialisation)
-- L'ordre est important à cause des contraintes de clés étrangères
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- ============================================================================
-- Table : customers
-- ============================================================================
-- Stocke les informations des clients
-- Clé primaire : customer_id (auto-incrémenté)
-- Contraintes : email unique, champs obligatoires
-- ============================================================================

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50) NOT NULL DEFAULT 'France',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index pour améliorer les recherches par email
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_customers_country ON customers(country);

-- ============================================================================
-- Table : products
-- ============================================================================
-- Catalogue de produits disponibles à la vente
-- Clé primaire : product_id (auto-incrémenté)
-- Contraintes : prix et stock non négatifs
-- ============================================================================

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    description TEXT,
    supplier VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index pour améliorer les recherches par catégorie
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_price ON products(price);

-- ============================================================================
-- Table : orders
-- ============================================================================
-- Commandes passées par les clients
-- Clé primaire : order_id (auto-incrémenté)
-- Clé étrangère : customer_id référence customers
-- Contraintes : status limité à des valeurs spécifiques
-- ============================================================================

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' 
        CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    shipping_address VARCHAR(200),
    shipping_city VARCHAR(50),
    shipping_country VARCHAR(50),
    payment_method VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Contrainte de clé étrangère
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE RESTRICT  -- Empêche la suppression d'un client avec des commandes
        ON UPDATE CASCADE   -- Met à jour automatiquement si l'ID client change
);

-- Index pour améliorer les recherches
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_status ON orders(status);

-- ============================================================================
-- Table : order_items
-- ============================================================================
-- Détails des produits dans chaque commande (table de liaison)
-- Clé primaire : order_item_id (auto-incrémenté)
-- Clés étrangères : order_id et product_id
-- Contraintes : quantité et prix positifs
-- ============================================================================

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    discount_percent DECIMAL(5, 2) DEFAULT 0 CHECK (discount_percent >= 0 AND discount_percent <= 100),
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unit_price * (1 - discount_percent/100)) STORED,
    
    -- Contraintes de clés étrangères
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE   -- Supprime les items si la commande est supprimée
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE RESTRICT  -- Empêche la suppression d'un produit commandé
        ON UPDATE CASCADE,
    
    -- Contrainte d'unicité : un produit ne peut apparaître qu'une fois par commande
    UNIQUE(order_id, product_id)
);

-- Index pour améliorer les performances des jointures
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

-- ============================================================================
-- Vue : order_summary
-- ============================================================================
-- Vue pratique pour voir le résumé des commandes avec informations client
-- ============================================================================

CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    o.total_amount,
    COUNT(oi.order_item_id) AS items_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, o.status, c.customer_id, c.first_name, c.last_name, c.email, o.total_amount;

-- ============================================================================
-- Vue : product_sales
-- ============================================================================
-- Vue pour analyser les ventes par produit
-- ============================================================================

CREATE VIEW product_sales AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price AS current_price,
    COUNT(oi.order_item_id) AS times_ordered,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'cancelled' OR o.status IS NULL
GROUP BY p.product_id, p.product_name, p.category, p.price;

-- ============================================================================
-- Commentaires sur le Schéma
-- ============================================================================
-- 
-- CHOIX DE CONCEPTION :
--
-- 1. AUTOINCREMENT : Utilisé pour garantir des IDs uniques et croissants
--
-- 2. TIMESTAMPS : created_at et updated_at pour tracer les modifications
--
-- 3. CHECK CONSTRAINTS : Validations au niveau base de données pour :
--    - Prix et quantités non négatifs
--    - Status limités à des valeurs valides
--    - Pourcentage de remise entre 0 et 100
--
-- 4. ON DELETE RESTRICT : Pour customers et products - protection des données
--    ON DELETE CASCADE : Pour order_items - nettoyage automatique
--
-- 5. COLONNES CALCULÉES : subtotal dans order_items calculé automatiquement
--
-- 6. INDEX : Sur les colonnes fréquemment utilisées dans les WHERE et JOIN
--
-- 7. VUES : Facilitent les requêtes courantes sans répéter le code SQL
--
-- NORMALISATION :
-- - 3NF respectée : pas de redondance, toutes les dépendances sont vers les clés
-- - Chaque table a une responsabilité claire
-- - Les relations sont bien définies via les clés étrangères
--
-- AMÉLIORATION POSSIBLES :
-- - Ajouter une table categories pour normaliser les catégories
-- - Ajouter une table shipping_methods
-- - Ajouter une table payment_transactions pour l'historique des paiements
-- - Ajouter des triggers pour mettre à jour updated_at automatiquement
-- - Ajouter des triggers pour gérer le stock automatiquement
--
-- ============================================================================

-- Fin du schéma
