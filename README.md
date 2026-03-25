# 📊 Data Marketing Toolkit

**Un portfolio de projets Data Marketing concrets** — des requêtes SQL aux modèles prédictifs, construits autour de scénarios marketing réalistes.

Chaque dossier est une analyse autonome avec son propre README, son code et ses résultats. Ouvrez n'importe quel projet, lisez le README, et voyez ce que je sais faire avec de la donnée.

---

## 🗂️ Projets

| # | Projet | Stack | Description |
|---|--------|-------|-------------|
| 01 | [KPIs E-commerce en SQL](./01-sql-kpis-ecommerce/) | SQL | KPIs e-commerce fondamentaux : top clients, performance produits, tendances CA |
| 02 | [Segmentation RFM](./02-rfm-segmentation/) | SQL + Python | Segmentation client par scoring Recency, Frequency, Monetary |
| 03 | [EDA E-commerce](./03-eda-ecommerce/) | Python | Exploration complète des données : distributions, outliers, saisonnalité |
| 04 | [A/B Test Campagne](./04-ab-test-campaign/) | Python | Test A/B statistique (ANOVA) sur les canaux marketing |
| 05 | [Web Analytics Multi-canal](./05-web-analytics-multichannel/) | Python + Looker | Performance campagne multi-canal : CTR, CPA, ROAS, analyse ROI |
| 06 | [Dashboard Storytelling](./06-dashboard-storytelling/) | Looker Studio | Dashboard exécutif avec drill-downs, choix de design documentés |
| 07 | [Normalisation BDD](./07-normalisation-bdd/) | SQL | D'un fichier plat à un schéma relationnel normalisé (1FN → 3FN) |
| 08 | [Prédiction de Churn](./08-churn-prediction/) | Python | Pipeline ML : feature engineering, comparaison de modèles, recommandations business |
| 09 | [Prévision de Ventes](./09-regression-ventes/) | Python | Régression linéaire et polynomiale pour la prévision mensuelle des ventes |
| 10 | [Lead Scoring](./10-lead-scoring/) | SQL + Python | Modèle de scoring prédictif avec classification Hot / Warm / Cold |
| 11 | [Pipeline End-to-End](./11-pipeline-end-to-end/) | SQL + Python + Looker | **Projet signature** — pipeline complet de la donnée brute au dashboard |

---

## ⚙️ Stack technique

- **Python** — Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn, SciPy, Statsmodels
- **SQL** — Requêtes analytiques, window functions, modélisation de données
- **Looker Studio** — Dashboards interactifs et data storytelling
- **Jupyter Notebooks** — Analyses documentées et narratives

## 📁 Données

Tous les datasets sont dans le dossier [`data/`](./data/) — nettoyés, anonymisés et prêts à l'emploi. Chaque analyse référence le dataset qu'elle utilise dans son propre README.

| Dataset | Lignes | Description |
|---------|--------|-------------|
| `ecommerce_transactions.csv` | ~5 600 | Historique de transactions e-commerce sur 2 ans avec détails clients et produits |
| `olist_sample.csv` | 10 000 | Données de commandes marketplace avec livraison, avis et paiements |
| `campaign_performance.csv` | 168 | Métriques mensuelles de campagnes marketing sur 7 canaux |
| `superstore_clean.csv` | 8 000 | Données de ventes retail multi-catégories, régions et segments |

## 🧭 Comment naviguer dans ce repo

**Vous avez 30 secondes** → Lisez le tableau des projets ci-dessus, cliquez sur celui qui vous intéresse.

**Vous avez 5 minutes** → Ouvrez le [Projet 11 (Pipeline End-to-End)](./11-pipeline-end-to-end/) — il démontre le workflow complet, de la donnée brute aux recommandations business.

**Vous voulez creuser** → Les projets sont ordonnés par complexité croissante. Commencez par le 01 pour les fondamentaux SQL, terminez par le 11 pour le pipeline complet.

## 👤 À propos

Analyste Data Marketing spécialisé en analytics client, mesure de performance des campagnes et modélisation prédictive. Je fais le lien entre stratégie marketing et prise de décision data-driven.

Ce repo est un portfolio vivant — chaque projet représente un cas concret de Data Marketing, résolu avec du code propre et des insights actionnables.

---

*Construit avec Python, SQL et Looker Studio*
