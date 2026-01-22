# 📊 Rapport d'Analyse SQL - Session 12

**Auteur** : [Votre Nom]  
**Date** : [Date]  
**Sujet** : Analyse des données de ventes - JOINs et GROUP BY

---

## 📋 Table des Matières

1. [Top 10 Clients Fidèles](#1-top-10-clients-fidèles)
2. [Chiffre d'Affaires par Catégorie](#2-chiffre-daffaires-par-catégorie)
3. [Évolution Mensuelle des Ventes](#3-évolution-mensuelle-des-ventes)
4. [Analyse des Produits les Plus Vendus](#4-analyse-des-produits-les-plus-vendus)
5. [Conclusions et Recommandations](#5-conclusions-et-recommandations)

---

## 1. Top 10 Clients Fidèles

### 📊 Requête SQL

```sql
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nom_complet,
    c.email,
    c.city,
    COUNT(o.order_id) AS nombre_commandes,
    SUM(o.total_amount) AS ca_total,
    ROUND(AVG(o.total_amount), 2) AS panier_moyen
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status != 'cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
HAVING COUNT(o.order_id) > 2
ORDER BY ca_total DESC
LIMIT 10;
```

### 📈 Résultats

| Rang | Nom Complet | Email | Ville | Nb Commandes | CA Total (€) | Panier Moyen (€) |
|------|-------------|-------|-------|--------------|--------------|------------------|
| 1 | [Nom] | [email] | [ville] | X | X,XXX.XX | XXX.XX |
| 2 | ... | ... | ... | ... | ... | ... |
| 3 | ... | ... | ... | ... | ... | ... |
| ... | ... | ... | ... | ... | ... | ... |

### 💡 Insights

- **Client le plus fidèle** : [Nom] avec [X] commandes et [X,XXX]€ de CA
- **Panier moyen des top clients** : [XXX]€
- **Ville la plus représentée** : [Ville]
- **Observations** :
  - Les clients fidèles représentent [X]% du CA total
  - Le panier moyen augmente avec la fidélité
  - [Autres observations]

### 📊 Graphique : CA par Top Client

```
[Insérer ici un graphique en barres horizontales montrant le CA des top 10 clients]

Recommandation : Créez ce graphique avec :
- Axe X : Chiffre d'affaires (€)
- Axe Y : Nom des clients
- Type : Barres horizontales
- Couleur : Dégradé selon le montant
```

---

## 2. Chiffre d'Affaires par Catégorie

### 📊 Requête SQL

```sql
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS nombre_produits,
    COUNT(DISTINCT o.order_id) AS nombre_commandes,
    SUM(oi.quantity) AS quantite_totale,
    SUM(oi.subtotal) AS ca_total,
    ROUND(AVG(oi.unit_price), 2) AS prix_moyen
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY ca_total DESC;
```

### 📈 Résultats

| Catégorie | Nb Produits | Nb Commandes | Quantité Vendue | CA Total (€) | Prix Moyen (€) |
|-----------|-------------|--------------|-----------------|--------------|----------------|
| Électronique | XX | XXX | XXX | XX,XXX.XX | XXX.XX |
| Vêtements | XX | XXX | XXX | XX,XXX.XX | XXX.XX |
| Livres | XX | XXX | XXX | X,XXX.XX | XX.XX |
| Maison | XX | XXX | XXX | X,XXX.XX | XXX.XX |

### 💡 Insights

- **Catégorie la plus rentable** : [Catégorie] avec [XX,XXX]€
- **Part de marché** :
  - Électronique : [X]%
  - Vêtements : [X]%
  - Livres : [X]%
  - Maison : [X]%
- **Observations** :
  - [Catégorie] a le panier moyen le plus élevé
  - [Catégorie] est la plus commandée en volume
  - Opportunité de croissance sur [Catégorie]

### 📊 Graphiques

#### Graphique 1 : CA par Catégorie (Camembert)

```
[Insérer graphique en camembert montrant la répartition du CA par catégorie]
```

#### Graphique 2 : Nombre de Commandes par Catégorie (Barres)

```
[Insérer graphique en barres montrant le nombre de commandes par catégorie]
```

---

## 3. Évolution Mensuelle des Ventes

### 📊 Requête SQL

```sql
SELECT 
    strftime('%Y-%m', order_date) AS mois,
    COUNT(order_id) AS nombre_commandes,
    COUNT(DISTINCT customer_id) AS clients_uniques,
    SUM(total_amount) AS ca_total,
    ROUND(AVG(total_amount), 2) AS panier_moyen
FROM orders
WHERE status != 'cancelled'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY mois;
```

### 📈 Résultats

| Mois | Nb Commandes | Clients Uniques | CA Total (€) | Panier Moyen (€) |
|------|--------------|-----------------|--------------|------------------|
| 2025-11 | XX | XX | XX,XXX.XX | XXX.XX |
| 2025-12 | XX | XX | XX,XXX.XX | XXX.XX |
| 2026-01 | XX | XX | XX,XXX.XX | XXX.XX |

### 💡 Insights

- **Tendance générale** : [Croissance/Décroissance/Stable]
- **Mois le plus performant** : [Mois] avec [XX,XXX]€
- **Croissance mensuelle moyenne** : [X]%
- **Observations** :
  - Pic de ventes en [Mois] probablement dû à [raison]
  - Le panier moyen [augmente/diminue/reste stable]
  - Nombre de clients uniques [augmente/diminue]

### 📊 Graphique : Évolution du CA Mensuel

```
[Insérer graphique en courbe montrant :
- Axe X : Mois
- Axe Y1 : CA Total (€) - Courbe principale
- Axe Y2 : Nombre de commandes - Courbe secondaire
- Type : Courbe avec marqueurs]
```

---

## 4. Analyse des Produits les Plus Vendus

### 📊 Requête SQL

```sql
SELECT 
    p.product_name,
    p.category,
    COUNT(DISTINCT o.order_id) AS fois_commande,
    SUM(oi.quantity) AS quantite_vendue,
    SUM(oi.subtotal) AS ca_produit,
    ROUND(AVG(oi.unit_price), 2) AS prix_moyen
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY ca_produit DESC
LIMIT 10;
```

### 📈 Top 10 Produits

| Rang | Produit | Catégorie | Fois Commandé | Quantité | CA (€) | Prix Moyen (€) |
|------|---------|-----------|---------------|----------|--------|----------------|
| 1 | [Produit] | [Cat] | XX | XXX | X,XXX.XX | XXX.XX |
| 2 | ... | ... | ... | ... | ... | ... |
| ... | ... | ... | ... | ... | ... | ... |

### 💡 Insights

- **Best-seller** : [Produit] avec [X,XXX]€ de CA
- **Produit le plus fréquent** : [Produit] commandé [XX] fois
- **Catégorie dominante dans le top 10** : [Catégorie]

---

## 5. Conclusions et Recommandations

### 🎯 Conclusions Principales

1. **Performance globale** :
   - CA total sur la période : [XX,XXX]€
   - Nombre total de commandes : [XXX]
   - Panier moyen : [XXX]€

2. **Segments clés** :
   - [X]% du CA provient des top 10 clients
   - La catégorie [Catégorie] représente [X]% du CA
   - Tendance à la [croissance/stabilité]

3. **Points forts** :
   - Forte fidélisation des clients (panier moyen élevé)
   - Diversification des catégories
   - [Autres points]

4. **Points d'amélioration** :
   - Acquisition de nouveaux clients
   - Développement de [Catégorie] sous-performante
   - [Autres points]

### 💡 Recommandations

1. **Fidélisation** :
   - Programme de fidélité pour les top clients
   - Offres personnalisées basées sur l'historique
   - Communication ciblée

2. **Croissance** :
   - Focus sur les catégories à fort potentiel
   - Promotions sur les produits complémentaires
   - Expansion de la gamme [Catégorie]

3. **Optimisation** :
   - Améliorer le stock des produits best-sellers
   - Analyser les abandons de panier
   - Tests A/B sur les prix

### 📊 KPIs à Suivre

- CA mensuel et croissance
- Taux de fidélisation (% clients récurrents)
- Panier moyen
- CA par catégorie
- Taux de conversion

---

## 📎 Annexes

### Méthodologie

- **Source des données** : Base de données sales.db (SQLite)
- **Période d'analyse** : [Date début] à [Date fin]
- **Outils utilisés** : SQLite, DBeaver, [Excel/Python/etc.]
- **Requêtes disponibles** : queries_s12.sql

### Notes Techniques

- Les commandes annulées sont exclues des analyses
- Les montants sont en euros (€)
- Les dates sont au format ISO 8601
- [Autres notes]

---

**Fin du Rapport**

*Généré le [Date] | Formation Grow Up AI - Session 12*
