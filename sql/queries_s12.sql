-- ============================================================================
-- Requêtes SQL - Session 12 : JOINs et Agrégations Avancées
-- ============================================================================
-- Auteur : Formation Grow Up AI
-- Date : Janvier 2026
-- Description : Exercices pratiques sur les différents types de JOIN,
--               GROUP BY avec HAVING, et agrégations complexes
-- Base de données : Système de Ventes E-Commerce
-- ============================================================================

-- ============================================================================
-- EXERCICE 1 : INNER JOIN - Commandes avec détails client
-- ============================================================================
-- Objectif : Comprendre l'INNER JOIN pour combiner les tables orders et customers
-- Concepts : INNER JOIN, alias de tables, sélection de colonnes multiples
-- ============================================================================

-- Version 1 : INNER JOIN basique
SELECT 
    o.order_id,
    o.order_date,
    o.status,
    o.total_amount,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- Version 2 : INNER JOIN avec filtres
SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.city,
    o.status,
    o.total_amount,
    o.payment_method
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'delivered' 
  AND o.total_amount > 100
ORDER BY o.total_amount DESC;

-- Version 3 : INNER JOIN multiple - Commandes avec produits
SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    oi.discount_percent,
    oi.subtotal
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status != 'cancelled'
ORDER BY o.order_date DESC, o.order_id, p.product_name;


-- ============================================================================
-- EXERCICE 2 : LEFT JOIN - Tous les clients et leurs commandes
-- ============================================================================
-- Objectif : Utiliser LEFT JOIN pour inclure tous les clients, même sans commande
-- Concepts : LEFT JOIN, IS NULL pour trouver les enregistrements sans correspondance
-- ============================================================================

-- Version 1 : LEFT JOIN basique - Tous les clients
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
ORDER BY total_spent DESC;

-- Version 2 : Clients sans commande
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    c.city,
    c.country,
    c.created_at
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.created_at DESC;

-- Version 3 : Clients avec et sans commande (marquage)
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    CASE 
        WHEN COUNT(o.order_id) = 0 THEN 'Inactif'
        WHEN COUNT(o.order_id) < 3 THEN 'Occasionnel'
        WHEN COUNT(o.order_id) < 10 THEN 'Régulier'
        ELSE 'VIP'
    END AS customer_segment
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_spent DESC;


-- ============================================================================
-- EXERCICE 3 : RIGHT JOIN - Simulation avec LEFT JOIN
-- ============================================================================
-- Objectif : Comprendre le concept de RIGHT JOIN (SQLite ne le supporte pas nativement)
-- Concepts : RIGHT JOIN simulé avec LEFT JOIN
-- Note : SQLite ne supporte pas RIGHT JOIN, on inverse les tables pour simuler
-- ============================================================================

-- Version 1 : Tous les produits et leurs ventes (simulé avec LEFT JOIN)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity,
    COUNT(oi.order_item_id) AS times_ordered,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(oi.subtotal), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status != 'cancelled'
GROUP BY p.product_id, p.product_name, p.category, p.price, p.stock_quantity
ORDER BY total_revenue DESC;

-- Version 2 : Produits jamais vendus
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity,
    ROUND(p.price * p.stock_quantity, 2) AS stock_value
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL
ORDER BY stock_value DESC;


-- ============================================================================
-- EXERCICE 4 : Chiffre d'affaires par produit et par mois
-- ============================================================================
-- Objectif : Analyser les ventes dans le temps avec agrégations complexes
-- Concepts : DATE functions, GROUP BY multiple, agrégations
-- ============================================================================

-- Version 1 : Revenus mensuels par produit
SELECT 
    strftime('%Y-%m', o.order_date) AS year_month,
    p.product_id,
    p.product_name,
    p.category,
    COUNT(oi.order_item_id) AS orders_count,
    SUM(oi.quantity) AS quantity_sold,
    ROUND(SUM(oi.subtotal), 2) AS monthly_revenue
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status != 'cancelled'
GROUP BY strftime('%Y-%m', o.order_date), p.product_id, p.product_name, p.category
ORDER BY year_month DESC, monthly_revenue DESC;

-- Version 2 : Revenus mensuels par catégorie
SELECT 
    strftime('%Y-%m', o.order_date) AS year_month,
    p.category,
    COUNT(DISTINCT o.order_id) AS orders_count,
    COUNT(oi.order_item_id) AS items_sold,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS monthly_revenue,
    ROUND(AVG(oi.subtotal), 2) AS avg_item_value
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status != 'cancelled'
GROUP BY strftime('%Y-%m', o.order_date), p.category
ORDER BY year_month DESC, monthly_revenue DESC;

-- Version 3 : Évolution mensuelle globale
SELECT 
    strftime('%Y-%m', order_date) AS year_month,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(total_amount), 2) AS monthly_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    MIN(total_amount) AS min_order,
    MAX(total_amount) AS max_order
FROM orders
WHERE status != 'cancelled'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY year_month DESC;

-- Version 4 : Top 5 produits par mois
WITH monthly_product_sales AS (
    SELECT 
        strftime('%Y-%m', o.order_date) AS year_month,
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity) AS quantity_sold,
        ROUND(SUM(oi.subtotal), 2) AS revenue
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN products p ON oi.product_id = p.product_id
    WHERE o.status != 'cancelled'
    GROUP BY strftime('%Y-%m', o.order_date), p.product_id, p.product_name, p.category
)
SELECT 
    year_month,
    product_name,
    category,
    quantity_sold,
    revenue
FROM monthly_product_sales
WHERE year_month = '2025-12'  -- Remplacer par le mois souhaité
ORDER BY revenue DESC
LIMIT 5;


-- ============================================================================
-- EXERCICE 5 : Clients avec plus de N commandes (HAVING)
-- ============================================================================
-- Objectif : Utiliser HAVING pour filtrer après agrégation
-- Concepts : GROUP BY, HAVING, COUNT, filtres post-agrégation
-- ============================================================================

-- Version 1 : Clients avec plus de 5 commandes
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;

-- Version 2 : Clients avec dépenses totales > 1000€
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING SUM(o.total_amount) > 1000
ORDER BY total_spent DESC;

-- Version 3 : Clients avec panier moyen > 200€
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.country,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.country
HAVING AVG(o.total_amount) > 200
ORDER BY avg_order_value DESC;

-- Version 4 : Clients actifs avec critères multiples
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    MIN(o.order_date) AS first_order,
    MAX(o.order_date) AS last_order
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(o.order_id) >= 3 
   AND SUM(o.total_amount) > 500
   AND AVG(o.total_amount) > 100
ORDER BY total_spent DESC;


-- ============================================================================
-- EXERCICE 6 : Agrégations complexes avec GROUP BY
-- ============================================================================
-- Objectif : Maîtriser les agrégations avancées et les calculs dérivés
-- Concepts : GROUP BY, fonctions d'agrégation multiples, CASE, sous-requêtes
-- ============================================================================

-- Version 1 : Analyse des ventes par catégorie et statut
SELECT 
    p.category,
    o.status,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue,
    ROUND(AVG(oi.subtotal), 2) AS avg_item_revenue
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category, o.status
ORDER BY p.category, o.status;

-- Version 2 : Performance des produits avec taux de retour
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(oi.order_item_id) AS times_ordered,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS unique_orders,
    SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) * 100.0 / 
        COUNT(DISTINCT oi.order_id), 
        2
    ) AS cancellation_rate
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name, p.category
HAVING COUNT(oi.order_item_id) > 0
ORDER BY total_revenue DESC;

-- Version 3 : Analyse de la clientèle par pays
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(COUNT(o.order_id)) OVER (PARTITION BY c.country), 2) AS avg_orders_per_customer,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status != 'cancelled'
GROUP BY c.country
HAVING COUNT(DISTINCT o.order_id) > 0
ORDER BY total_revenue DESC;

-- Version 4 : Analyse par tranche de prix
SELECT 
    CASE 
        WHEN o.total_amount < 50 THEN '0-50€'
        WHEN o.total_amount < 100 THEN '50-100€'
        WHEN o.total_amount < 200 THEN '100-200€'
        WHEN o.total_amount < 500 THEN '200-500€'
        ELSE '500€+'
    END AS price_range,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders WHERE status != 'cancelled'), 2) AS percentage,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders o
WHERE status != 'cancelled'
GROUP BY 
    CASE 
        WHEN o.total_amount < 50 THEN '0-50€'
        WHEN o.total_amount < 100 THEN '50-100€'
        WHEN o.total_amount < 200 THEN '100-200€'
        WHEN o.total_amount < 500 THEN '200-500€'
        ELSE '500€+'
    END
ORDER BY MIN(o.total_amount);


-- ============================================================================
-- EXERCICES BONUS : Requêtes avancées avec JOIN et agrégations
-- ============================================================================

-- BONUS 1 : Panier moyen par catégorie de produit
SELECT 
    p.category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.quantity) AS total_items_sold,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue,
    ROUND(AVG(oi.quantity), 2) AS avg_quantity_per_order,
    ROUND(AVG(oi.subtotal), 2) AS avg_revenue_per_item
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'cancelled'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- BONUS 2 : Top 10 combinaisons client-produit
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_id,
    p.product_name,
    COUNT(oi.order_item_id) AS times_purchased,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_spent_on_product
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, p.product_id, p.product_name
ORDER BY total_spent_on_product DESC
LIMIT 10;

-- BONUS 3 : Produits souvent achetés ensemble (dans la même commande)
SELECT 
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(DISTINCT oi1.order_id) AS times_together,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM order_items oi1
INNER JOIN order_items oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id < oi2.product_id
INNER JOIN products p1 ON oi1.product_id = p1.product_id
INNER JOIN products p2 ON oi2.product_id = p2.product_id
INNER JOIN orders o ON oi1.order_id = o.order_id
WHERE o.status != 'cancelled'
GROUP BY p1.product_id, p1.product_name, p2.product_id, p2.product_name
HAVING COUNT(DISTINCT oi1.order_id) >= 2
ORDER BY times_together DESC
LIMIT 20;

-- BONUS 4 : Analyse de rétention client par cohorte mensuelle
SELECT 
    strftime('%Y-%m', c.created_at) AS cohort_month,
    COUNT(DISTINCT c.customer_id) AS customers_acquired,
    COUNT(DISTINCT CASE WHEN o.order_date IS NOT NULL THEN c.customer_id END) AS customers_with_orders,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.order_date IS NOT NULL THEN c.customer_id END) * 100.0 / 
        COUNT(DISTINCT c.customer_id), 
        2
    ) AS activation_rate,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COALESCE(SUM(o.total_amount), 0), 2) AS total_revenue
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status != 'cancelled'
GROUP BY strftime('%Y-%m', c.created_at)
ORDER BY cohort_month DESC;

-- BONUS 5 : Produits populaires par segment de clientèle
WITH customer_segments AS (
    SELECT 
        c.customer_id,
        CASE 
            WHEN COUNT(o.order_id) = 0 THEN 'Inactif'
            WHEN COUNT(o.order_id) < 3 THEN 'Occasionnel'
            WHEN COUNT(o.order_id) < 10 THEN 'Régulier'
            ELSE 'VIP'
        END AS segment
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status != 'cancelled'
    GROUP BY c.customer_id
)
SELECT 
    cs.segment,
    p.product_name,
    p.category,
    COUNT(oi.order_item_id) AS times_ordered,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM customer_segments cs
INNER JOIN customers c ON cs.customer_id = c.customer_id
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status != 'cancelled'
GROUP BY cs.segment, p.product_id, p.product_name, p.category
ORDER BY cs.segment, total_revenue DESC;

-- ============================================================================
-- Fin des requêtes - Session 12
-- ============================================================================
