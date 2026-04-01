-- ============================================================
-- 01 — KPIs E-COMMERCE EN SQL
-- ============================================================
-- Dataset : ecommerce_transactions.csv (~71k lignes)
-- Contexte : un directeur commercial veut un état des lieux
-- complet de l'activité e-commerce sur 2024-2025.
-- ============================================================


-- ============================================================
-- Q1 — Top 10 clients par chiffre d'affaires
-- Objectif : identifier les clients les plus rentables
-- pour orienter les actions de fidélisation.
-- ============================================================

SELECT
    customer_id,
    customer_city,
    customer_region,
    COUNT(DISTINCT order_id)          AS nb_commandes,
    SUM(quantity)                     AS total_articles,
    ROUND(SUM(total_amount), 2)      AS chiffre_affaires,
    ROUND(AVG(total_amount), 2)      AS panier_moyen_ligne
FROM ecommerce_transactions
GROUP BY customer_id, customer_city, customer_region
ORDER BY chiffre_affaires DESC
LIMIT 10;


-- ============================================================
-- Q2 — Top 10 produits les plus vendus (volume + CA)
-- Objectif : identifier les produits stars à mettre en avant
-- dans les campagnes et à surveiller en stock.
-- ============================================================

SELECT
    product_id,
    product_category,
    product_sub_category,
    SUM(quantity)                     AS total_unites_vendues,
    COUNT(DISTINCT order_id)         AS nb_commandes,
    ROUND(SUM(total_amount), 2)      AS chiffre_affaires,
    ROUND(AVG(unit_price), 2)        AS prix_moyen
FROM ecommerce_transactions
GROUP BY product_id, product_category, product_sub_category
ORDER BY total_unites_vendues DESC
LIMIT 10;


-- ============================================================
-- Q3 — Panier moyen par mois
-- Objectif : suivre l'évolution du panier moyen et détecter
-- les variations saisonnières (soldes, fêtes, etc.).
-- ============================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m')               AS mois,
    COUNT(DISTINCT order_id)                       AS nb_commandes,
    ROUND(SUM(total_amount), 2)                    AS ca_mensuel,
    ROUND(SUM(total_amount) / COUNT(DISTINCT order_id), 2)  AS panier_moyen
FROM ecommerce_transactions
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY mois;


-- ============================================================
-- Q4 — Chiffre d'affaires par catégorie de produits
-- Objectif : comprendre la répartition du CA par univers
-- produit et identifier les catégories à développer.
-- ============================================================

SELECT
    product_category,
    COUNT(*)                                       AS nb_lignes,
    SUM(quantity)                                  AS total_articles,
    ROUND(SUM(total_amount), 2)                    AS chiffre_affaires,
    ROUND(SUM(total_amount) * 100.0 / 
          (SELECT SUM(total_amount) FROM ecommerce_transactions), 1)  AS pct_ca,
    ROUND(AVG(total_amount), 2)                    AS montant_moyen_ligne
FROM ecommerce_transactions
GROUP BY product_category
ORDER BY chiffre_affaires DESC;


-- ============================================================
-- Q5 — Répartition géographique des ventes (par ville)
-- Objectif : visualiser la concentration géographique du CA
-- pour adapter le ciblage marketing par zone.
-- ============================================================

SELECT
    customer_city,
    customer_region,
    COUNT(DISTINCT customer_id)                    AS nb_clients,
    COUNT(DISTINCT order_id)                       AS nb_commandes,
    ROUND(SUM(total_amount), 2)                    AS chiffre_affaires,
    ROUND(SUM(total_amount) * 100.0 / 
          (SELECT SUM(total_amount) FROM ecommerce_transactions), 1)  AS pct_ca
FROM ecommerce_transactions
GROUP BY customer_city, customer_region
ORDER BY chiffre_affaires DESC;


-- ============================================================
-- Q6 — Évolution trimestrielle du chiffre d'affaires
-- Objectif : mesurer la croissance trimestre par trimestre
-- et détecter la saisonnalité (Q4 fort, Q1 faible).
-- ============================================================

SELECT
    CONCAT(YEAR(order_date), '-Q', QUARTER(order_date))  AS trimestre,
    COUNT(DISTINCT order_id)                              AS nb_commandes,
    ROUND(SUM(total_amount), 2)                           AS chiffre_affaires,
    ROUND(SUM(total_amount) / COUNT(DISTINCT order_id), 2) AS panier_moyen
FROM ecommerce_transactions
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY YEAR(order_date), QUARTER(order_date);


-- ============================================================
-- Q7 — Répartition par mode de paiement
-- Objectif : connaître les préférences de paiement
-- des clients pour optimiser le checkout.
-- ============================================================

SELECT
    payment_method,
    COUNT(*)                                       AS nb_transactions,
    COUNT(DISTINCT customer_id)                    AS nb_clients,
    ROUND(SUM(total_amount), 2)                    AS chiffre_affaires,
    ROUND(SUM(total_amount) * 100.0 / 
          (SELECT SUM(total_amount) FROM ecommerce_transactions), 1)  AS pct_ca,
    ROUND(AVG(total_amount), 2)                    AS montant_moyen
FROM ecommerce_transactions
GROUP BY payment_method
ORDER BY chiffre_affaires DESC;


-- ============================================================
-- Q8 — Taux de remise moyen par catégorie
-- Objectif : vérifier si certaines catégories sont
-- sur-discountées et évaluer l'impact sur la marge.
-- ============================================================

SELECT
    product_category,
    ROUND(AVG(discount) * 100, 1)                  AS remise_moyenne_pct,
    ROUND(MAX(discount) * 100, 0)                  AS remise_max_pct,
    COUNT(CASE WHEN discount > 0 THEN 1 END)       AS nb_lignes_remisees,
    COUNT(*)                                       AS nb_lignes_total,
    ROUND(COUNT(CASE WHEN discount > 0 THEN 1 END) * 100.0 / COUNT(*), 1) AS pct_lignes_remisees
FROM ecommerce_transactions
GROUP BY product_category
ORDER BY remise_moyenne_pct DESC;


-- ============================================================
-- Q9 — Nombre de commandes par jour de la semaine
-- Objectif : identifier les jours les plus actifs
-- pour planifier les envois de newsletters et les promos.
-- ============================================================

SELECT
    DAYNAME(order_date)                            AS jour_semaine,
    DAYOFWEEK(order_date)                          AS jour_num,
    COUNT(DISTINCT order_id)                       AS nb_commandes,
    ROUND(SUM(total_amount), 2)                    AS chiffre_affaires,
    ROUND(AVG(total_amount), 2)                    AS montant_moyen_ligne
FROM ecommerce_transactions
GROUP BY DAYNAME(order_date), DAYOFWEEK(order_date)
ORDER BY jour_num;


-- ============================================================
-- Q10 — Chiffre d'affaires par tranche d'âge client
-- Objectif : segmenter la base par âge pour adapter
-- le discours marketing et le ciblage publicitaire.
-- ============================================================

SELECT
    CASE
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 55 THEN '46-55'
        WHEN customer_age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '66+'
    END                                            AS tranche_age,
    COUNT(DISTINCT customer_id)                    AS nb_clients,
    COUNT(DISTINCT order_id)                       AS nb_commandes,
    ROUND(SUM(total_amount), 2)                    AS chiffre_affaires,
    ROUND(SUM(total_amount) * 100.0 / 
          (SELECT SUM(total_amount) FROM ecommerce_transactions), 1)  AS pct_ca,
    ROUND(SUM(total_amount) / COUNT(DISTINCT customer_id), 2)         AS ca_moyen_par_client
FROM ecommerce_transactions
GROUP BY tranche_age
ORDER BY MIN(customer_age);
