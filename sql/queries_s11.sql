-- ============================================================================
-- Requêtes SQL - Session 11 : Fondamentaux SQL
-- ============================================================================
-- Auteur : Formation Grow Up AI
-- Date : Janvier 2026
-- Description : Exercices pratiques sur les requêtes SELECT, WHERE, ORDER BY,
--               LIMIT, et fonctions d'agrégation de base
-- Base de données : Système de Ventes E-Commerce
-- ============================================================================

-- ============================================================================
-- EXERCICE 1 : Top 10 des clients par chiffre d'affaires
-- ============================================================================
-- Objectif : Identifier les meilleurs clients en termes de revenus générés
-- Concepts : JOIN, SUM, GROUP BY, ORDER BY, LIMIT
-- ============================================================================

-- Version 1 : Avec informations détaillées du client
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.country,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(oi.order_item_id) AS total_items_purchased,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city, c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- Version 2 : Simplifiée avec nom complet
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    SUM(o.total_amount) AS total_revenue
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================================
-- EXERCICE 2 : Commandes du mois de décembre 2025
-- ============================================================================
-- Objectif : Extraire toutes les commandes d'une période spécifique
-- Concepts : WHERE avec dates, BETWEEN, fonctions de date
-- ============================================================================

-- Version 1 : Utilisation de BETWEEN
SELECT 
    order_id,
    customer_id,
    order_date,
    status,
    total_amount,
    payment_method
FROM orders
WHERE order_date BETWEEN '2025-12-01' AND '2025-12-31 23:59:59'
ORDER BY order_date DESC;

-- Version 2 : Utilisation de strftime (SQLite)
SELECT 
    order_id,
    customer_id,
    order_date,
    status,
    total_amount,
    payment_method
FROM orders
WHERE strftime('%Y-%m', order_date) = '2025-12'
ORDER BY order_date DESC;

-- Version 3 : Avec détails client
SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    o.status,
    o.total_amount,
    o.shipping_city,
    o.shipping_country
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE strftime('%Y-%m', o.order_date) = '2025-12'
ORDER BY o.order_date DESC;

-- Version 4 : Statistiques du mois de décembre
SELECT 
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    MIN(total_amount) AS min_order,
    MAX(total_amount) AS max_order,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders
WHERE strftime('%Y-%m', order_date) = '2025-12'
    AND status != 'cancelled';


-- ============================================================================
-- EXERCICE 3 : Produits en rupture de stock ou stock faible
-- ============================================================================
-- Objectif : Identifier les produits nécessitant un réapprovisionnement
-- Concepts : WHERE avec conditions multiples, ORDER BY
-- ============================================================================

-- Version 1 : Produits en rupture de stock (stock = 0)
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    supplier
FROM products
WHERE stock_quantity = 0
ORDER BY category, product_name;

-- Version 2 : Produits avec stock faible (< 10 unités)
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    supplier,
    CASE 
        WHEN stock_quantity = 0 THEN 'Rupture de stock'
        WHEN stock_quantity < 5 THEN 'Critique'
        WHEN stock_quantity < 10 THEN 'Faible'
    END AS stock_status
FROM products
WHERE stock_quantity < 10
ORDER BY stock_quantity ASC, category;

-- Version 3 : Avec seuil personnalisable par catégorie
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    supplier,
    CASE 
        WHEN category IN ('Électronique', 'Informatique') AND stock_quantity < 15 THEN 'Réapprovisionner'
        WHEN category IN ('Vêtements', 'Accessoires') AND stock_quantity < 20 THEN 'Réapprovisionner'
        WHEN stock_quantity < 10 THEN 'Réapprovisionner'
        ELSE 'OK'
    END AS alert_status
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity ASC;

-- Version 4 : Stock faible avec valeur totale en stock
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    ROUND(price * stock_quantity, 2) AS total_stock_value,
    supplier
FROM products
WHERE stock_quantity < 10
ORDER BY total_stock_value DESC;


-- ============================================================================
-- EXERCICE 4 : Recherche de produits (Pattern Matching)
-- ============================================================================
-- Objectif : Utiliser LIKE pour rechercher des produits par nom
-- Concepts : LIKE, wildcards (%), LOWER/UPPER pour recherche insensible à la casse
-- ============================================================================

-- Version 1 : Recherche simple - produits contenant "laptop"
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM products
WHERE LOWER(product_name) LIKE '%laptop%'
ORDER BY price DESC;

-- Version 2 : Recherche multiple - plusieurs mots-clés
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM products
WHERE LOWER(product_name) LIKE '%phone%'
   OR LOWER(product_name) LIKE '%mobile%'
   OR LOWER(product_name) LIKE '%smartphone%'
ORDER BY product_name;

-- Version 3 : Recherche dans nom et description
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity,
    description
FROM products
WHERE LOWER(product_name) LIKE '%wireless%'
   OR LOWER(description) LIKE '%wireless%'
ORDER BY price ASC;

-- Version 4 : Recherche par catégorie et nom
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM products
WHERE category = 'Électronique'
  AND (LOWER(product_name) LIKE '%samsung%' OR LOWER(product_name) LIKE '%apple%')
ORDER BY price DESC;

-- Version 5 : Produits commençant par un préfixe
SELECT 
    product_id,
    product_name,
    category,
    price
FROM products
WHERE product_name LIKE 'Pro%'
ORDER BY product_name;


-- ============================================================================
-- EXERCICE 5 : Statistiques par catégorie de produits
-- ============================================================================
-- Objectif : Analyser le catalogue de produits par catégorie
-- Concepts : GROUP BY, COUNT, AVG, SUM, MIN, MAX
-- ============================================================================

-- Version 1 : Statistiques de base par catégorie
SELECT 
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Version 2 : Avec valeur totale du stock
SELECT 
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    SUM(stock_quantity) AS total_stock,
    ROUND(SUM(price * stock_quantity), 2) AS total_stock_value
FROM products
GROUP BY category
ORDER BY total_stock_value DESC;

-- Version 3 : Avec pourcentage du catalogue
SELECT 
    category,
    COUNT(*) AS total_products,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM products), 2) AS percentage_of_catalog,
    ROUND(AVG(price), 2) AS average_price,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Version 4 : Statistiques complètes avec classification de prix
SELECT 
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    SUM(stock_quantity) AS total_stock,
    ROUND(SUM(price * stock_quantity), 2) AS total_stock_value,
    COUNT(CASE WHEN stock_quantity = 0 THEN 1 END) AS out_of_stock_count,
    COUNT(CASE WHEN stock_quantity < 10 THEN 1 END) AS low_stock_count
FROM products
GROUP BY category
ORDER BY category;

-- Version 5 : Top 3 catégories les plus chères en moyenne
SELECT 
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY category
ORDER BY average_price DESC
LIMIT 3;


-- ============================================================================
-- EXERCICES BONUS : Requêtes complémentaires
-- ============================================================================

-- BONUS 1 : Produits les plus chers de chaque catégorie
SELECT 
    p.category,
    p.product_name,
    p.price,
    p.stock_quantity
FROM products p
WHERE p.price = (
    SELECT MAX(price) 
    FROM products 
    WHERE category = p.category
)
ORDER BY p.category, p.price DESC;

-- BONUS 2 : Clients sans commande
SELECT 
    customer_id,
    first_name,
    last_name,
    email,
    created_at
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders)
ORDER BY created_at DESC;

-- BONUS 3 : Produits jamais commandés
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.product_id = p.product_id
)
ORDER BY p.category, p.product_name;

-- BONUS 4 : Statistiques globales du système
SELECT 
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM orders WHERE status = 'delivered') AS delivered_orders,
    (SELECT SUM(total_amount) FROM orders WHERE status != 'cancelled') AS total_revenue,
    (SELECT ROUND(AVG(total_amount), 2) FROM orders WHERE status != 'cancelled') AS avg_order_value;

-- BONUS 5 : Distribution des commandes par statut
SELECT 
    status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- ============================================================================
-- Fin des requêtes - Session 11
-- ============================================================================
