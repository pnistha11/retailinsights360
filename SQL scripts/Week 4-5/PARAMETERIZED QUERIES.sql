-- Top-N Products by Sales
SELECT
    product_name,
    total_sales,
    total_profit
FROM product_performance
ORDER BY total_sales DESC
LIMIT 5;

-- Category Trend Analysis
SELECT
    category,
    SUM(total_sales) AS category_sales,
    SUM(total_profit) AS category_profit
FROM product_performance
GROUP BY category
ORDER BY category_sales DESC;

-- Monthly Sales Trend
SELECT
    d.year,
    d.month,
    SUM(f.sales) AS monthly_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
