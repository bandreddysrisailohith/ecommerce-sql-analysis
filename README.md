# Brazilian E-Commerce Analysis: SQL + Python

**Portfolio Project 2 | Data Analytics**

---

## Business Context

This project answers a real business question: *what does 100,000+ orders of transaction data actually tell a marketplace owner about their business?*

The Olist platform connects Brazilian small businesses to customers across the country. By loading the raw data into a relational database and querying it with SQL joins, this analysis surfaces which product categories drive revenue, where delivery is failing customers, what predicts a bad review, and when customers are most likely to buy — giving a business owner clear, evidence-backed decisions to make.

---

## Technical Approach

Raw CSV files were loaded into a **relational SQLite database** (8 tables, ~65 MB). Each of the 8 business questions was answered by writing a **multi-table SQL JOIN query**, executing it with `pandas.read_sql_query()`, and visualising the result in Python.

This mirrors the real-world data analyst workflow:
1. Design and populate a database from raw source files
2. Write SQL to answer specific business questions across multiple tables
3. Translate query results into visual stories
4. Communicate findings to a non-technical audience

The database schema used:

```
orders ──────────┬── order_items ──┬── products ── category_translation
                 │                 └── sellers
customers ───────┘
payments ────────┘ (via order_id)
reviews ─────────┘ (via order_id)
```

---

## Dataset

**Olist Brazilian E-Commerce** — publicly available on [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

| Metric | Value |
|---|---|
| Orders | 100,000+ |
| Time period | September 2016 – October 2018 |
| Tables | 8 CSVs covering orders, customers, products, sellers, payments, and reviews |
| Geography | All Brazilian states |

---

## Tools

| Tool | Purpose |
|---|---|
| Python 3 | Core programming language |
| pandas | Data loading, SQL result processing, merging |
| SQLite (sqlite3) | Relational database — no server required |
| matplotlib | Chart rendering |
| seaborn | Statistical chart styling |
| scipy | Correlation testing |
| Jupyter Notebook | Interactive analysis environment |

---

## Key Findings

1. **Health & beauty is the #1 revenue category** — lifestyle products, not electronics, dominate Brazilian online spending.
2. **Business grew consistently 2016–2018**, with a reliable Black Friday spike every November — seasonality is highly predictable.
3. **Delivery speed is the strongest driver of review scores** — 1-star orders waited ~2.5× longer than 5-star orders.
4. **Northern states (Roraima, Amapá, Amazonas) wait 3× longer than São Paulo** — the platform's most visible service gap.
5. **Credit card drives ~74% of purchases and the highest average spend** — seamless credit checkout is non-negotiable.
6. **~97% of customers buy only once** — converting even a small fraction to repeat buyers would have an outsized revenue impact.

---

## Business Recommendations

1. **Invest in northern Brazil logistics** — partner with a regional carrier or open a micro-fulfilment hub near Manaus to cut northern delivery times from 30 to 18 days.
2. **Concentrate paid marketing Monday–Thursday 10am–2pm** — order volume peaks sharply in this window; shifting budget here improves cost-per-acquisition.
3. **Launch a loyalty programme targeting second purchases** — a post-delivery R$20 voucher sent 14 days after first order could measurably increase repeat purchase rates.

---

## Project Structure

```
ecommerce-sql-analysis/
├── data/                          ← Raw CSV files (Olist dataset)
│   ├── olist_orders_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_customers_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   └── product_category_name_translation.csv
│
├── database/
│   └── ecommerce.db               ← SQLite database (all 8 tables)
│
├── notebooks/
│   └── analysis.ipynb             ← Main analysis notebook (33 cells)
│
├── outputs/
│   ├── q1_revenue_by_category.png
│   ├── q2_monthly_trend.png
│   ├── q3_delivery_time_by_state.png
│   ├── q4_payment_methods.png
│   ├── q5_reviews_vs_delivery.png
│   ├── q6_seller_performance.png
│   ├── q7_repeat_customers.png
│   ├── q8_order_heatmap.png
│   ├── correlation_heatmap.png
│   └── sql_queries/               ← All 8 SQL queries saved as .sql files
│       ├── q1_revenue_by_category.sql
│       ├── q2_monthly_trend.sql
│       ├── q3_delivery_time_by_state.sql
│       ├── q4_payment_methods.sql
│       ├── q5_reviews_vs_delivery.sql
│       ├── q6_seller_performance.sql
│       ├── q7_repeat_customers.sql
│       └── q8_peak_hours.sql
│
├── venv/                          ← Python virtual environment
└── README.md
```

---

## How to Run Locally

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/ecommerce-sql-analysis.git
cd ecommerce-sql-analysis

# 2. Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate          # Mac/Linux
# venv\Scripts\activate           # Windows

# 3. Install dependencies
pip install pandas matplotlib seaborn plotly jupyter openpyxl scipy

# 4. Launch Jupyter and open the notebook
jupyter notebook notebooks/analysis.ipynb

# Run all cells top to bottom (Kernel → Restart & Run All)
# The database will be created automatically on first run.
```

> **Note:** The CSV files in `data/` must be present before running. Download the dataset from Kaggle if needed.

---

## SQL Queries

All 8 queries are saved as standalone `.sql` files in `outputs/sql_queries/`. Each file is:
- Commented to explain every JOIN and WHERE clause
- Formatted with uppercase SQL keywords
- Indented for readability
- Ready to run in any SQLite-compatible tool (e.g. DB Browser for SQLite)

Example query topics:
- Three-table JOINs (order_items + products + category_translation)
- Date arithmetic using `julianday()` and `strftime()`
- Subqueries for customer classification
- `HAVING` clause filtering for statistical significance

---

## About This Project

This is **Portfolio Project 2** in a data analytics portfolio, designed to demonstrate SQL proficiency with multi-table joins — a core skill tested in data analyst interviews.

**Certifications:**
- Google Data Analytics Professional Certificate (Coursera / Google)
- Google Advanced Data Analytics Professional Certificate (Coursera / Google)

**Related Projects:**
- Project 1 — Single-table sales analysis: [github.com/bandreddysrisailohith/superstore-sales-analysis](https://github.com/bandreddysrisailohith/superstore-sales-analysis)
