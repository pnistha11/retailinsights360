CREATE OR REPLACE VIEW daily_sales AS
SELECT
    d.order_date,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.order_date
ORDER BY d.order_date;
