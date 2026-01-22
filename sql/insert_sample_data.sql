-- ============================================================================
-- Script d'Insertion de Données de Test - Système de Ventes
-- ============================================================================
-- Ce script insère des données de test réalistes pour le système de ventes
-- À exécuter après schema_sales.sql
-- ============================================================================

-- ============================================================================
-- Insertion de Clients (20 clients)
-- ============================================================================

INSERT INTO customers (first_name, last_name, email, phone, address, city, postal_code, country) VALUES
('Jean', 'Dupont', 'jean.dupont@email.fr', '0601020304', '12 Rue de la Paix', 'Paris', '75001', 'France'),
('Marie', 'Martin', 'marie.martin@email.fr', '0605060708', '45 Avenue des Champs', 'Lyon', '69001', 'France'),
('Pierre', 'Bernard', 'pierre.bernard@email.fr', '0609101112', '78 Boulevard Victor Hugo', 'Marseille', '13001', 'France'),
('Sophie', 'Dubois', 'sophie.dubois@email.fr', '0613141516', '23 Rue du Commerce', 'Toulouse', '31000', 'France'),
('Luc', 'Thomas', 'luc.thomas@email.fr', '0617181920', '56 Place de la République', 'Nice', '06000', 'France'),
('Julie', 'Robert', 'julie.robert@email.fr', '0621222324', '89 Rue Nationale', 'Nantes', '44000', 'France'),
('Marc', 'Richard', 'marc.richard@email.fr', '0625262728', '34 Avenue de la Liberté', 'Strasbourg', '67000', 'France'),
('Claire', 'Petit', 'claire.petit@email.fr', '0629303132', '67 Rue Saint-Michel', 'Bordeaux', '33000', 'France'),
('Paul', 'Durand', 'paul.durand@email.fr', '0633343536', '12 Place du Capitole', 'Montpellier', '34000', 'France'),
('Emma', 'Leroy', 'emma.leroy@email.fr', '0637383940', '45 Rue de Rivoli', 'Lille', '59000', 'France'),
('Antoine', 'Moreau', 'antoine.moreau@email.fr', '0641424344', '78 Boulevard Haussmann', 'Rennes', '35000', 'France'),
('Camille', 'Simon', 'camille.simon@email.fr', '0645464748', '23 Rue de la Gare', 'Reims', '51100', 'France'),
('Nicolas', 'Laurent', 'nicolas.laurent@email.fr', '0649505152', '56 Avenue Foch', 'Le Havre', '76600', 'France'),
('Laura', 'Lefebvre', 'laura.lefebvre@email.fr', '0653545556', '89 Place Bellecour', 'Saint-Étienne', '42000', 'France'),
('Thomas', 'Michel', 'thomas.michel@email.fr', '0657585960', '34 Rue du Faubourg', 'Toulon', '83000', 'France'),
('Sarah', 'Garcia', 'sarah.garcia@email.fr', '0661626364', '67 Boulevard de la Mer', 'Grenoble', '38000', 'France'),
('Julien', 'Roux', 'julien.roux@email.fr', '0665666768', '12 Rue des Écoles', 'Dijon', '21000', 'France'),
('Alice', 'Fournier', 'alice.fournier@email.fr', '0669707172', '45 Avenue Jean Jaurès', 'Angers', '49000', 'France'),
('David', 'Girard', 'david.girard@email.fr', '0673747576', '78 Place de la Comédie', 'Nîmes', '30000', 'France'),
('Léa', 'Bonnet', 'lea.bonnet@email.fr', '0677787980', '23 Rue Victor Hugo', 'Villeurbanne', '69100', 'France');

-- ============================================================================
-- Insertion de Produits (30 produits dans différentes catégories)
-- ============================================================================

INSERT INTO products (product_name, category, price, stock_quantity, description, supplier) VALUES
-- Électronique (10 produits)
('Laptop Dell XPS 13', 'Électronique', 1299.99, 15, 'Ordinateur portable haute performance 13 pouces', 'Dell Inc.'),
('iPhone 14 Pro', 'Électronique', 1159.00, 25, 'Smartphone Apple dernière génération', 'Apple Inc.'),
('Samsung Galaxy S23', 'Électronique', 899.99, 20, 'Smartphone Android premium', 'Samsung Electronics'),
('iPad Air', 'Électronique', 699.00, 18, 'Tablette Apple 10.9 pouces', 'Apple Inc.'),
('Écouteurs Sony WH-1000XM5', 'Électronique', 379.99, 30, 'Casque antibruit premium', 'Sony Corporation'),
('Apple Watch Series 8', 'Électronique', 449.00, 22, 'Montre connectée Apple', 'Apple Inc.'),
('MacBook Pro 14"', 'Électronique', 2299.00, 10, 'Ordinateur portable professionnel', 'Apple Inc.'),
('Samsung TV QLED 55"', 'Électronique', 1499.00, 8, 'Téléviseur QLED 4K 55 pouces', 'Samsung Electronics'),
('Clavier mécanique Logitech', 'Électronique', 149.99, 35, 'Clavier gaming RGB', 'Logitech'),
('Souris Logitech MX Master 3', 'Électronique', 99.99, 40, 'Souris sans fil ergonomique', 'Logitech'),

-- Vêtements (10 produits)
('T-shirt Nike Sportswear', 'Vêtements', 29.99, 100, 'T-shirt en coton confortable', 'Nike'),
('Jean Levi''s 501', 'Vêtements', 89.99, 75, 'Jean classique coupe droite', 'Levi''s'),
('Veste Adidas à capuche', 'Vêtements', 79.99, 50, 'Veste de sport avec capuche', 'Adidas'),
('Chaussures Nike Air Max', 'Vêtements', 139.99, 60, 'Baskets running confortables', 'Nike'),
('Pull H&M en laine', 'Vêtements', 39.99, 80, 'Pull chaud pour l''hiver', 'H&M'),
('Chemise Zara slim fit', 'Vêtements', 49.99, 65, 'Chemise élégante coupe ajustée', 'Zara'),
('Pantalon chino Uniqlo', 'Vêtements', 59.99, 70, 'Pantalon décontracté confortable', 'Uniqlo'),
('Robe Mango fleurie', 'Vêtements', 69.99, 45, 'Robe d''été légère', 'Mango'),
('Blouson cuir Zara', 'Vêtements', 199.99, 25, 'Blouson en cuir synthétique', 'Zara'),
('Baskets Adidas Superstar', 'Vêtements', 89.99, 55, 'Baskets iconiques blanches', 'Adidas'),

-- Livres (5 produits)
('Python pour les Data Sciences', 'Livres', 39.99, 50, 'Guide complet Python et analyse de données', 'Éditions Eyrolles'),
('Clean Code', 'Livres', 44.99, 40, 'Guide des bonnes pratiques de programmation', 'Prentice Hall'),
('SQL pour les Nuls', 'Livres', 24.99, 60, 'Apprentissage SQL pour débutants', 'First Interactive'),
('L''Art de la Data Science', 'Livres', 34.99, 45, 'Méthodes et techniques d''analyse', 'O''Reilly Media'),
('Intelligence Artificielle', 'Livres', 49.99, 35, 'Introduction à l''IA et Machine Learning', 'Dunod'),

-- Maison (5 produits)
('Cafetière Nespresso', 'Maison', 199.99, 30, 'Machine à café à capsules', 'Nespresso'),
('Aspirateur Dyson V11', 'Maison', 599.99, 15, 'Aspirateur sans fil puissant', 'Dyson'),
('Grille-pain Philips', 'Maison', 49.99, 40, 'Grille-pain 2 fentes', 'Philips'),
('Batterie de cuisine Tefal', 'Maison', 149.99, 25, 'Set de 10 pièces antiadhésif', 'Tefal'),
('Robot cuiseur Thermomix', 'Maison', 1299.00, 8, 'Robot multifonction intelligent', 'Vorwerk');

-- ============================================================================
-- Insertion de Commandes (40 commandes)
-- ============================================================================

-- Commandes livrées (25)
INSERT INTO orders (customer_id, order_date, status, total_amount, shipping_address, shipping_city, shipping_country, payment_method) VALUES
(1, '2025-11-05 10:30:00', 'delivered', 1329.98, '12 Rue de la Paix', 'Paris', 'France', 'Carte bancaire'),
(2, '2025-11-08 14:22:00', 'delivered', 899.99, '45 Avenue des Champs', 'Lyon', 'France', 'PayPal'),
(3, '2025-11-10 09:15:00', 'delivered', 1698.99, '78 Boulevard Victor Hugo', 'Marseille', 'France', 'Carte bancaire'),
(4, '2025-11-12 16:45:00', 'delivered', 199.98, '23 Rue du Commerce', 'Toulouse', 'France', 'Carte bancaire'),
(5, '2025-11-15 11:30:00', 'delivered', 379.99, '56 Place de la République', 'Nice', 'France', 'PayPal'),
(6, '2025-11-18 13:20:00', 'delivered', 2398.99, '89 Rue Nationale', 'Nantes', 'France', 'Carte bancaire'),
(7, '2025-11-20 10:05:00', 'delivered', 149.99, '34 Avenue de la Liberté', 'Strasbourg', 'France', 'Carte bancaire'),
(8, '2025-11-22 15:30:00', 'delivered', 699.00, '67 Rue Saint-Michel', 'Bordeaux', 'France', 'PayPal'),
(9, '2025-11-25 09:45:00', 'delivered', 139.98, '12 Place du Capitole', 'Montpellier', 'France', 'Carte bancaire'),
(10, '2025-11-28 14:10:00', 'delivered', 449.00, '45 Rue de Rivoli', 'Lille', 'France', 'Carte bancaire'),
(11, '2025-12-01 10:20:00', 'delivered', 1159.00, '78 Boulevard Haussmann', 'Rennes', 'France', 'PayPal'),
(12, '2025-12-03 16:55:00', 'delivered', 89.99, '23 Rue de la Gare', 'Reims', 'France', 'Carte bancaire'),
(13, '2025-12-05 11:40:00', 'delivered', 599.99, '56 Avenue Foch', 'Le Havre', 'France', 'Carte bancaire'),
(14, '2025-12-08 13:25:00', 'delivered', 249.97, '89 Place Bellecour', 'Saint-Étienne', 'France', 'PayPal'),
(15, '2025-12-10 09:30:00', 'delivered', 199.99, '34 Rue du Faubourg', 'Toulon', 'France', 'Carte bancaire'),
(1, '2025-12-12 15:15:00', 'delivered', 99.99, '12 Rue de la Paix', 'Paris', 'France', 'Carte bancaire'),
(2, '2025-12-15 10:50:00', 'delivered', 179.98, '45 Avenue des Champs', 'Lyon', 'France', 'PayPal'),
(3, '2025-12-18 14:35:00', 'delivered', 1499.00, '78 Boulevard Victor Hugo', 'Marseille', 'France', 'Carte bancaire'),
(4, '2025-12-20 11:20:00', 'delivered', 279.97, '23 Rue du Commerce', 'Toulouse', 'France', 'Carte bancaire'),
(5, '2025-12-22 16:40:00', 'delivered', 2299.00, '56 Place de la République', 'Nice', 'France', 'PayPal'),
(6, '2025-12-25 10:10:00', 'delivered', 149.99, '89 Rue Nationale', 'Nantes', 'France', 'Carte bancaire'),
(7, '2025-12-28 13:55:00', 'delivered', 89.99, '34 Avenue de la Liberté', 'Strasbourg', 'France', 'Carte bancaire'),
(8, '2025-12-30 09:25:00', 'delivered', 1299.99, '67 Rue Saint-Michel', 'Bordeaux', 'France', 'PayPal'),
(9, '2026-01-02 15:30:00', 'delivered', 449.98, '12 Place du Capitole', 'Montpellier', 'France', 'Carte bancaire'),
(10, '2026-01-05 11:15:00', 'delivered', 379.99, '45 Rue de Rivoli', 'Lille', 'France', 'Carte bancaire'),

-- Commandes expédiées (8)
(11, '2026-01-08 10:40:00', 'shipped', 1329.00, '78 Boulevard Haussmann', 'Rennes', 'France', 'PayPal'),
(12, '2026-01-10 14:20:00', 'shipped', 699.00, '23 Rue de la Gare', 'Reims', 'France', 'Carte bancaire'),
(13, '2026-01-12 09:50:00', 'shipped', 99.99, '56 Avenue Foch', 'Le Havre', 'France', 'Carte bancaire'),
(14, '2026-01-14 16:10:00', 'shipped', 189.98, '89 Place Bellecour', 'Saint-Étienne', 'France', 'PayPal'),
(15, '2026-01-16 11:30:00', 'shipped', 899.99, '34 Rue du Faubourg', 'Toulon', 'France', 'Carte bancaire'),
(16, '2026-01-18 13:45:00', 'shipped', 249.98, '67 Boulevard de la Mer', 'Grenoble', 'France', 'Carte bancaire'),
(17, '2026-01-19 10:20:00', 'shipped', 139.99, '12 Rue des Écoles', 'Dijon', 'France', 'PayPal'),
(18, '2026-01-20 15:05:00', 'shipped', 1159.00, '45 Avenue Jean Jaurès', 'Angers', 'France', 'Carte bancaire'),

-- Commandes en traitement (5)
(19, '2026-01-21 09:30:00', 'processing', 379.99, '78 Place de la Comédie', 'Nîmes', 'France', 'Carte bancaire'),
(20, '2026-01-21 14:15:00', 'processing', 599.99, '23 Rue Victor Hugo', 'Villeurbanne', 'France', 'PayPal'),
(1, '2026-01-22 10:45:00', 'processing', 2299.00, '12 Rue de la Paix', 'Paris', 'France', 'Carte bancaire'),
(2, '2026-01-22 11:30:00', 'processing', 449.00, '45 Avenue des Champs', 'Lyon', 'France', 'Carte bancaire'),
(3, '2026-01-22 13:20:00', 'processing', 149.99, '78 Boulevard Victor Hugo', 'Marseille', 'France', 'PayPal'),

-- Commandes en attente (2)
(4, '2026-01-22 15:50:00', 'pending', 699.00, '23 Rue du Commerce', 'Toulouse', 'France', 'Carte bancaire'),
(5, '2026-01-22 16:30:00', 'pending', 1299.99, '56 Place de la République', 'Nice', 'France', 'Carte bancaire');

-- ============================================================================
-- Insertion d'Articles de Commande (order_items)
-- ============================================================================

-- Commande 1 : Client 1
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1, 1, 1, 1299.99, 0),
(1, 11, 1, 29.99, 0);

-- Commande 2 : Client 2
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(2, 3, 1, 899.99, 0);

-- Commande 3 : Client 3
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(3, 1, 1, 1299.99, 0),
(3, 5, 1, 379.99, 5),
(3, 11, 1, 29.99, 0);

-- Commande 4 : Client 4
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(4, 21, 5, 39.99, 0);

-- Commande 5 : Client 5
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(5, 5, 1, 379.99, 0);

-- Commande 6 : Client 6
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(6, 7, 1, 2299.00, 0),
(6, 10, 1, 99.99, 0);

-- Commande 7 : Client 7
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(7, 9, 1, 149.99, 0);

-- Commande 8 : Client 8
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(8, 4, 1, 699.00, 0);

-- Commande 9 : Client 9
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(9, 14, 1, 139.99, 0);

-- Commande 10 : Client 10
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(10, 6, 1, 449.00, 0);

-- Commande 11 : Client 11
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(11, 2, 1, 1159.00, 0);

-- Commande 12 : Client 12
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(12, 12, 1, 89.99, 0);

-- Commande 13 : Client 13
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(13, 27, 1, 599.99, 0);

-- Commande 14 : Client 14
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(14, 21, 3, 39.99, 10),
(14, 22, 2, 44.99, 10);

-- Commande 15 : Client 15
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(15, 19, 1, 199.99, 0);

-- Commande 16 : Client 1 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(16, 10, 1, 99.99, 0);

-- Commande 17 : Client 2 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(17, 13, 1, 79.99, 0),
(17, 10, 1, 99.99, 0);

-- Commande 18 : Client 3 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(18, 8, 1, 1499.00, 0);

-- Commande 19 : Client 4 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(19, 15, 2, 39.99, 0),
(19, 26, 1, 199.99, 0);

-- Commande 20 : Client 5 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(20, 7, 1, 2299.00, 0);

-- Commande 21 : Client 6 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(21, 9, 1, 149.99, 0);

-- Commande 22 : Client 7 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(22, 20, 1, 89.99, 0);

-- Commande 23 : Client 8 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(23, 1, 1, 1299.99, 0);

-- Commande 24 : Client 9 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(24, 6, 1, 449.00, 0);

-- Commande 25 : Client 10 (2ème commande)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(25, 5, 1, 379.99, 0);

-- Commandes 26-40 (en cours)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(26, 30, 1, 1299.00, 2),
(26, 11, 1, 29.99, 0),
(27, 4, 1, 699.00, 0),
(28, 10, 1, 99.99, 0),
(29, 11, 2, 29.99, 0),
(29, 13, 2, 79.99, 15),
(29, 15, 1, 39.99, 0),
(30, 3, 1, 899.99, 0),
(31, 14, 2, 139.99, 10),
(32, 2, 1, 1159.00, 0),
(33, 5, 1, 379.99, 0),
(34, 27, 1, 599.99, 0),
(35, 7, 1, 2299.00, 0),
(36, 6, 1, 449.00, 0),
(37, 9, 1, 149.99, 0),
(38, 4, 1, 699.00, 0),
(39, 1, 1, 1299.99, 0);

-- ============================================================================
-- Vérifications
-- ============================================================================

-- Vérifier le nombre d'enregistrements insérés
SELECT 'Customers' AS table_name, COUNT(*) AS count FROM customers
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_items;

-- Fin du script d'insertion
