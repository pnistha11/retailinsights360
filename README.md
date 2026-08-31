# RetailInsights360

**An end-to-end retail analytics stack — raw orders to a dimensional warehouse to executive dashboards.**

Built with Python, MySQL, and Tableau. The project takes a raw retail order file and carries it all the way through cleaning, dimensional modeling, SQL analytics, forecasting, and four published Tableau dashboards aimed at different stakeholders.

**[View the live dashboards on Tableau Public →](https://public.tableau.com/app/profile/nistha.patel7414/viz/Superstore_sales_17721199867740/RetailInsights?publish=yes)**

---

## The business problem

A retail business with several years of order history can answer "what did we sell?" from a spreadsheet. It usually cannot answer the questions that actually drive decisions:

- Which customers are worth keeping, and which are about to leave?
- Which products look profitable but are quietly being destroyed by discounting?
- What will next quarter look like, and how much should we trust that number?
- Are retention rates improving, or does each new cohort behave exactly like the last?

Answering those requires a data model, not a spreadsheet. This project builds one, then puts a reporting layer on top so a non-technical stakeholder can answer them without asking an analyst.

## The data

Sample Superstore — **9,986 order line items** spanning **5,009 distinct orders** and **793 customers**, covering <!-- FILL: date range, e.g. 2014-2017 -->, with customer, product, geography, and financial attributes at one row per product per order.

A deliberate note on the dataset: Superstore is a widely used public dataset, so the novelty here is not the data. It is the modeling, the analytics layer, and the reporting design built on top of it. Using a familiar dataset also means anyone reviewing this repo can verify the numbers independently.

## Architecture

```
Raw CSV
   ↓  Python / Pandas
Profiling → cleaning → standardization
   ↓
MySQL staging table
   ↓  ETL logic
Star schema (dim + fact)
   ↓  SQL views
Metrics · RFM · Cohorts · CLTV · Churn
   ↓  Python
Feature engineering → forecasting baselines
   ↓
Aggregated extracts → Tableau dashboards
```

### Data model

A star schema was chosen over querying the flat table directly so that metrics are defined once and reused, and so dashboards read from a stable interface rather than from raw columns.

| Table | Grain | Notes |
|---|---|---|
| `fact_orders` | One row per product per order | Sales, quantity, discount, profit |
| `dim_customer` | One row per customer | Segment, assigned RFM segment |
| `dim_product` | One row per product | Category, sub-category |
| `dim_geography` | One row per location | Country, state, city, region, postal code |
| `dim_date` | One row per day | Year, month, day, calendar features |

<!-- FILL: adjust the table above to match your actual dimension and fact table names -->

Data integrity is validated after every load by recomputing headline KPIs against the cleaned source and asserting they match.

## What the pipeline does

**Cleaning and standardization.** Removes duplicate records, filters cancelled orders (negative or zero quantity), corrects invalid sales values, parses and validates dates, and standardizes inconsistent category, region, and country labels. KPIs are compared before and after cleaning so the impact of every cleaning decision is visible rather than silent.

**SQL analytics layer.** Reusable views compute daily sales trends, product performance, customer lifetime value, and RFM segmentation. Parameterized queries handle top-performing products and category-level trend analysis.

**Customer analytics.** RFM segmentation classifies customers into business-readable segments. Cohort analysis tracks retention by acquisition month. Churn logic identifies at-risk customers, giving marketing a targetable list rather than an aggregate statistic.

**Forecasting.** Data is aggregated to a regular time grain with calendar features, lag and rolling features, and holiday/promo flags. An ETS model is evaluated using standard error metrics against a naive baseline — the naive comparison is included deliberately, because a forecasting model that cannot beat "next period looks like last period" is not worth deploying.

**Recommender prototype.** A content-based recommender using product metadata and cosine similarity, demonstrating a cross-sell path from the same warehouse.

## Key findings

**Scale.** $2,297,201 in revenue against $286,397 in profit — a **12.47% gross margin**, thin enough that discounting discipline drives the entire bottom line. Average order value is **$459** across 5,009 orders.

**Profit is regionally concentrated.** West ($108,418) and East ($91,523) together generate **70% of all profit**. Central contributes just $39,706 — 14% of profit on a materially larger share of revenue, making it the clearest margin-recovery target.

**A quarter of customers churn.** Churn rate sits at **25.09%**, and CLTV segmentation shows value concentrated in the High Value tier ($601,474 total CLTV) rather than in VIPs, who are too small a group to carry revenue.

**Revenue is highly seasonal and volatile.** March ($352,461), August ($325,294), and November ($307,650) are peaks; September ($59,751) collapses to under a fifth of March. That 6x swing is the core planning problem the forecast layer exists to address.

**Product revenue is long-tailed.** The top product (Canon imageCLASS 2200) accounts for $61,600 — only 2.7% of revenue — so there is no single SKU to protect; margin has to be managed at the sub-category and discount-band level instead.

**Forecast quality is the honest weak point.** The ETS model returns a **39% MAPE** and under-forecasts consistently — the error trend is negative across every month from April to December. This is a directional planning aid, not a reliable number, and the systematic bias suggests the model is not capturing the seasonal peaks.

## Dashboards

Four dashboards, each built for a different reader rather than one dashboard trying to serve everyone.

| Dashboard | Audience | Answers |
|---|---|---|
| Executive KPI | Leadership | How is the business tracking overall? |
| Customer Insights | Marketing / CRM | Who is valuable, who is at risk? |
| Product Performance | Merchandising | What is profitable after discounting? |
| Forecast | Planning | What is coming, and how reliable is it? |

Dashboards read from pre-aggregated extracts rather than live-querying the fact table, which keeps them responsive.

A static export is available in [`RetailInsights_Dashboards.pdf`](RetailInsights_Dashboards.pdf), and the interactive versions are on [Tableau Public](https://public.tableau.com/app/profile/nistha.patel7414/viz/Superstore_sales_17721199867740/RetailInsights?publish=yes).

## Repository structure

```
├── RetailInsights360.ipynb        # Cleaning, EDA, feature engineering, forecasting
├── SQL scripts/                   # Schema DDL, ETL logic, analytical views
├── data/raw/                      # Immutable raw snapshot
├── RetailInsights_Dashboards.pdf  # Static dashboard export
└── README.md
```

The raw data snapshot is kept immutable and never written to, so every result in this repo is reproducible from source.

## Running it locally

```bash
git clone https://github.com/pnistha11/retailinsights360.git
cd retailinsights360
pip install -r requirements.txt
```

1. Create a MySQL database and set your connection details in <!-- FILL: config file or .env name -->
2. Run the schema and ETL scripts in `SQL scripts/` in order
3. Open `RetailInsights360.ipynb` and run top to bottom

<!-- FILL: add a requirements.txt to the repo if there isn't one — reviewers who can't run your code assume it doesn't run -->

## Tech stack

Python (Pandas, NumPy, Scikit-learn, Matplotlib/Seaborn) · MySQL · Tableau · Jupyter · Git

## Limitations and next steps

Being explicit about what this does not do:

- The dataset is historical and static; there is no incremental or scheduled load.
- Forecasting stops at baseline models — no hyperparameter search or ensemble comparison.
- The recommender is a prototype demonstrating approach, not an evaluated system.
- Transformations live in SQL scripts and a notebook rather than an orchestrated, tested pipeline. Moving the modeling layer to dbt with tests, and scheduling the load, would be the natural next step.

---

Built by [Nistha Patel](https://www.linkedin.com/in/nisthapatel1107) · [github.com/pnistha11](https://github.com/pnistha11)
