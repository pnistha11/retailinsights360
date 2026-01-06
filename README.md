# retailinsights360
End-to-end BI analytics project using SQL, Python, and Tableau

## Week 1 – Project Setup & Data Exploration

- Created GitHub repository and folder structure
- Loaded Sample Superstore dataset
- Saved immutable raw data snapshot
- Performed initial EDA:
  - Dataset shape
  - Data types
  - Missing values
  - Sample records
  - Basic sales & profit checks
- Deliverable: EDA notebook



# Data Dictionary – Sample Superstore

## Orders Dataset

| Column Name | Data Type | Description | Example |
|------------|----------|------------|--------|
| Order ID | String | Unique order identifier | CA-2016-152156 |
| Order Date | Date | Order placement date | 2016-11-08 |
| Ship Date | Date | Shipping date | 2016-11-11 |
| Ship Mode | String | Shipping type | Second Class |
| Customer ID | String | Unique customer ID | CG-12520 |
| Customer Name | String | Customer name | Claire Gute |
| Segment | String | Customer segment | Consumer |
| Country | String | Country | United States |
| City | String | City | Henderson |
| State | String | State | Kentucky |
| Postal Code | Integer | Postal code | 42420 |
| Region | String | Sales region | South |
| Product ID | String | Product identifier | FUR-BO-10001798 |
| Category | String | Product category | Furniture |
| Sub-Category | String | Product sub-category | Bookcases |
| Product Name | String | Product description | Bush Somerset Bookcase |
| Sales | Float | Revenue | 261.96 |
| Quantity | Integer | Units sold | 2 |
| Discount | Float | Discount applied | 0.0 |
| Profit | Float | Profit/Loss | 41.91 |

## Notes
- One row = one product in an order
- Sales values already include discount
- Negative profit indicates loss



## Week 2 – Data Profiling & Business Requirements

- Defined business problem and stakeholder goals
- Identified core KPIs and metrics
- Performed data profiling (structure, types, nulls)
- Validated KPI calculations using Python
- Created detailed data dictionary
- Documented business assumptions


## Week 3 – Data Cleaning & Standardization

- Removed duplicate records
- Filtered cancelled orders (negative/zero quantity)
- Fixed invalid sales values
- Parsed and validated date columns
- Standardized category, region, and country names
- Created basic date features (year, month, day)
- Compared KPIs before and after cleaning
- Saved cleaned dataset for downstream SQL & analytics

**Week 4 – Database Design & Ingest**

Designed and implemented a star schema in MySQL (WAMP).
Loaded cleaned retail data into a staging table and populated
dimension and fact tables using SQL-based ETL.
Validated data integrity by matching KPIs between staging
and fact tables.
