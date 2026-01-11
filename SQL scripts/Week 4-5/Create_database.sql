CREATE DATABASE ecommerce_dw;
USE ecommerce_dw;
SELECT DATABASE();

USE ecommerce_dw;

DROP TABLE IF EXISTS staging_sales;

CREATE TABLE staging_sales (
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code INT,
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);


SELECT COUNT(*) FROM superstore_cleaned;
SELECT * FROM superstore_cleaned;

SHOW TABLE STATUS;
