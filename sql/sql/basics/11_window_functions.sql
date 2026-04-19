-- =============================================================================
-- SQL 101 – Fiche 11 : Fonctions de Fenêtrage (Window Functions)
-- =============================================================================
-- Objectifs :
--   • Comprendre la clause OVER() et la notion de "fenêtre"
--   • ROW_NUMBER, RANK, DENSE_RANK – numérotation et classement
--   • LAG / LEAD – accéder aux lignes précédentes et suivantes
--   • FIRST_VALUE / LAST_VALUE – valeur de début / fin de fenêtre
--   • Fonctions d'agrégation en mode fenêtrage (SUM, AVG, COUNT OVER)
--   • PARTITION BY – diviser la fenêtre par groupe
--   • ORDER BY dans OVER() – ordonner la fenêtre
--   • Calculs cumulatifs et glissants (ROWS/RANGE)
-- =============================================================================
-- 💡 Une window function calcule une valeur pour chaque ligne en tenant
--    compte d'un ensemble de lignes voisines (la "fenêtre"), SANS réduire
--    le nombre de lignes dans le résultat — contrairement à GROUP BY.
--
--    Syntaxe générale :
--      fonction() OVER (
--          [PARTITION BY colonne(s)]
--          [ORDER BY colonne(s)]
--          [ROWS/RANGE BETWEEN ...]
--      )
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. ROW_NUMBER() – Numéroter les lignes
--    Attribue un numéro unique à chaque ligne dans la fenêtre.
--    Identique à RANK, mais sans ex-aequo : chaque ligne reçoit un numéro
--    distinct même en cas d'égalité.
-- -----------------------------------------------------------------------------
-- Numéroter les commandes du plus récent au plus ancien
SELECT
    order_id,
    order_date,
    customer_id,
    total_amount,
    ROW_NUMBER() OVER (ORDER BY order_date DESC) AS rang_chronologique
FROM orders
WHERE status != 'cancelled'
LIMIT 15;

-- Numéroter les commandes par client (remise à 1 à chaque nouveau client)
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS numero_commande_client
FROM orders
WHERE status != 'cancelled'
ORDER BY customer_id, order_date
LIMIT 20;


-- -----------------------------------------------------------------------------
-- 2. RANK() et DENSE_RANK() – Classer avec ex-æquo
--    RANK()       : saute des rangs en cas d'ex-aequo (1, 1, 3, 4…)
--    DENSE_RANK() : ne saute pas de rang              (1, 1, 2, 3…)
-- -----------------------------------------------------------------------------
-- Classement des produits par chiffre d'affaires
SELECT
    p.product_name,
    p.category,
    ROUND(SUM(oi.subtotal), 2) AS ca_total,
    RANK()         OVER (ORDER BY SUM(oi.subtotal) DESC) AS rang_rank,
    DENSE_RANK()   OVER (ORDER BY SUM(oi.subtotal) DESC) AS rang_dense
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders      o  ON o.order_id    = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY ca_total DESC
LIMIT 15;

-- Top 3 produits par catégorie (PARTITION BY catégorie)
WITH ventes_par_produit AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        ROUND(SUM(oi.subtotal), 2) AS ca_total
    FROM products p
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders      o  ON o.order_id    = oi.order_id
    WHERE o.status != 'cancelled'
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT
    product_name,
    category,
    ca_total,
    RANK() OVER (PARTITION BY category ORDER BY ca_total DESC) AS rang_dans_categorie
FROM ventes_par_produit
ORDER BY category, rang_dans_categorie;


-- -----------------------------------------------------------------------------
-- 3. SUM() OVER – Total cumulatif (running total)
--    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--    signifie "depuis la première ligne jusqu'à la ligne courante".
-- -----------------------------------------------------------------------------
-- Chiffre d'affaires journalier et cumulatif
SELECT
    strftime('%Y-%m-%d', order_date) AS jour,
    ROUND(SUM(total_amount), 2)      AS ca_journalier,
    ROUND(
        SUM(SUM(total_amount)) OVER (
            ORDER BY strftime('%Y-%m-%d', order_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
    2) AS ca_cumulatif
FROM orders
WHERE status != 'cancelled'
GROUP BY strftime('%Y-%m-%d', order_date)
ORDER BY jour;

-- Montant cumulatif par client (ordre chronologique)
SELECT
    o.customer_id,
    c.first_name || ' ' || c.last_name AS client,
    o.order_date,
    o.total_amount,
    ROUND(
        SUM(o.total_amount) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
    2) AS depenses_cumulees_client
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 20;


-- -----------------------------------------------------------------------------
-- 4. AVG() OVER – Moyenne glissante (moving average)
--    Calculer la moyenne sur une fenêtre mobile de N lignes.
-- -----------------------------------------------------------------------------
-- Moyenne glissante du CA sur 3 commandes consécutives
SELECT
    order_id,
    strftime('%Y-%m-%d', order_date) AS jour,
    total_amount,
    ROUND(
        AVG(total_amount) OVER (
            ORDER BY order_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
    2) AS moy_glissante_3
FROM orders
WHERE status != 'cancelled'
ORDER BY order_date
LIMIT 20;

-- Comparaison entre montant d'une commande et la moyenne globale
SELECT
    order_id,
    customer_id,
    total_amount,
    ROUND(AVG(total_amount) OVER (), 2)                   AS moy_globale,
    ROUND(total_amount - AVG(total_amount) OVER (), 2)    AS ecart_a_la_moy
FROM orders
WHERE status != 'cancelled'
ORDER BY ecart_a_la_moy DESC
LIMIT 15;


-- -----------------------------------------------------------------------------
-- 5. COUNT() OVER – Compter dans une fenêtre
--    Utile pour enrichir chaque ligne avec un comptage contextuel.
-- -----------------------------------------------------------------------------
-- Pour chaque commande, afficher le nombre total de commandes du client
SELECT
    o.order_id,
    o.customer_id,
    c.first_name || ' ' || c.last_name AS client,
    o.order_date,
    o.total_amount,
    COUNT(o.order_id) OVER (PARTITION BY o.customer_id) AS nb_commandes_client
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 20;

-- Pourcentage du CA de chaque commande par rapport au total du client
SELECT
    o.order_id,
    o.customer_id,
    c.first_name || ' ' || c.last_name              AS client,
    o.total_amount,
    ROUND(SUM(o.total_amount) OVER (PARTITION BY o.customer_id), 2)  AS ca_total_client,
    ROUND(
        o.total_amount * 100.0 /
        SUM(o.total_amount) OVER (PARTITION BY o.customer_id),
    1) AS pct_du_total_client
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.total_amount DESC
LIMIT 20;


-- -----------------------------------------------------------------------------
-- 6. LAG() et LEAD() – Accéder aux lignes voisines
--    LAG(col, n)  : valeur de la ligne N rangs AVANT la ligne courante
--    LEAD(col, n) : valeur de la ligne N rangs APRÈS la ligne courante
--    Un 3ème argument optionnel définit la valeur par défaut (si NULL).
-- -----------------------------------------------------------------------------
-- Évolution du CA d'une commande à l'autre pour chaque client
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    LAG(o.total_amount)  OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS commande_precedente,
    ROUND(
        o.total_amount - LAG(o.total_amount) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ),
    2) AS evolution_vs_precedente
FROM orders o
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 20;

-- Délai entre deux commandes consécutives d'un même client
SELECT
    o.order_id,
    o.customer_id,
    c.first_name || ' ' || c.last_name  AS client,
    o.order_date,
    LAG(o.order_date) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS date_commande_precedente,
    ROUND(
        (julianday(o.order_date) - julianday(
            LAG(o.order_date) OVER (
                PARTITION BY o.customer_id
                ORDER BY o.order_date
            )
        )),
    0) AS jours_depuis_derniere_commande
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 20;


-- -----------------------------------------------------------------------------
-- 7. FIRST_VALUE() et LAST_VALUE() – Premier/dernier de la fenêtre
--    FIRST_VALUE(col) : valeur de la 1ère ligne de la fenêtre
--    LAST_VALUE(col)  : valeur de la dernière ligne
--    ⚠️ LAST_VALUE nécessite souvent ROWS BETWEEN UNBOUNDED PRECEDING
--       AND UNBOUNDED FOLLOWING pour couvrir toute la partition.
-- -----------------------------------------------------------------------------
-- Pour chaque commande d'un client, afficher sa toute première commande
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    FIRST_VALUE(o.total_amount) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS montant_premiere_commande,
    LAST_VALUE(o.total_amount) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS montant_derniere_commande
FROM orders o
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 20;

-- Produit le moins cher et le plus cher dans chaque catégorie
SELECT
    product_id,
    product_name,
    category,
    price,
    FIRST_VALUE(product_name) OVER (
        PARTITION BY category
        ORDER BY price ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS produit_le_moins_cher,
    LAST_VALUE(product_name) OVER (
        PARTITION BY category
        ORDER BY price ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS produit_le_plus_cher
FROM products
ORDER BY category, price;


-- -----------------------------------------------------------------------------
-- 8. NTILE(n) – Découper en N tranches égales (quartiles, déciles…)
-- -----------------------------------------------------------------------------
-- Découper les clients en 4 quartiles selon leur dépense totale
WITH depenses_clients AS (
    SELECT
        o.customer_id,
        c.first_name || ' ' || c.last_name AS client,
        ROUND(SUM(o.total_amount), 2)       AS total_depense
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    WHERE o.status != 'cancelled'
    GROUP BY o.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    client,
    total_depense,
    NTILE(4) OVER (ORDER BY total_depense) AS quartile,
    CASE NTILE(4) OVER (ORDER BY total_depense)
        WHEN 1 THEN 'Bronze'
        WHEN 2 THEN 'Argent'
        WHEN 3 THEN 'Or'
        WHEN 4 THEN 'Platine'
    END AS segment
FROM depenses_clients
ORDER BY total_depense DESC;


-- -----------------------------------------------------------------------------
-- 9. Récapitulatif complet : tableau de bord client enrichi
--    Combinaison de plusieurs window functions en une seule requête
-- -----------------------------------------------------------------------------
SELECT
    o.order_id,
    o.customer_id,
    c.first_name || ' ' || c.last_name                                 AS client,
    o.order_date,
    o.total_amount,
    -- Rang de cette commande dans l'historique du client
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
    )                                                                    AS numero_commande,
    -- Nombre total de commandes du client
    COUNT(o.order_id) OVER (PARTITION BY o.customer_id)                 AS nb_total_commandes,
    -- Dépenses cumulées du client
    ROUND(SUM(o.total_amount) OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2)                                                                AS depenses_cumulees,
    -- CA moyen par commande du client
    ROUND(AVG(o.total_amount) OVER (PARTITION BY o.customer_id), 2)    AS moy_panier_client,
    -- Rang global du client par dépenses totales
    RANK() OVER (
        ORDER BY SUM(o.total_amount) OVER (PARTITION BY o.customer_id) DESC
    )                                                                    AS rang_client_global
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
ORDER BY o.customer_id, o.order_date
LIMIT 30;


-- -----------------------------------------------------------------------------
-- 10. Window functions vs GROUP BY — comparaison
-- -----------------------------------------------------------------------------
-- ✅ Avec GROUP BY : une ligne par client (agrégation, perd le détail)
SELECT
    customer_id,
    COUNT(order_id)             AS nb_commandes,
    ROUND(SUM(total_amount), 2) AS total_depense,
    ROUND(AVG(total_amount), 2) AS panier_moyen
FROM orders
WHERE status != 'cancelled'
GROUP BY customer_id
ORDER BY total_depense DESC;

-- ✅ Avec OVER() : chaque commande conservée + infos agrégées
SELECT
    order_id,
    customer_id,
    total_amount,
    COUNT(order_id)        OVER (PARTITION BY customer_id)  AS nb_commandes_client,
    ROUND(SUM(total_amount) OVER (PARTITION BY customer_id), 2) AS total_depense_client,
    ROUND(AVG(total_amount) OVER (PARTITION BY customer_id), 2) AS panier_moyen_client
FROM orders
WHERE status != 'cancelled'
ORDER BY customer_id, order_date
LIMIT 20;

-- =============================================================================
-- Résumé des fonctions de fenêtrage
-- =============================================================================
-- Fonction              Rôle
-- ──────────────────────────────────────────────────────────────────────────────
-- ROW_NUMBER()          Numéro unique par ligne dans la fenêtre (pas d'ex-æquo)
-- RANK()                Classement avec ex-æquo + saut de rang
-- DENSE_RANK()          Classement avec ex-æquo, sans saut de rang
-- NTILE(n)              Divise en n tranches égales
-- SUM() OVER            Somme cumulative ou par partition
-- AVG() OVER            Moyenne (globale, cumulative ou glissante)
-- COUNT() OVER          Comptage dans la fenêtre
-- LAG(col, n)           Valeur de la ligne précédente (n rangs avant)
-- LEAD(col, n)          Valeur de la ligne suivante (n rangs après)
-- FIRST_VALUE(col)      Premiere valeur de la fenêtre
-- LAST_VALUE(col)       Derniere valeur de la fenêtre
-- =============================================================================
