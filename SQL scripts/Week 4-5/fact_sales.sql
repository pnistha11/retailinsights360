CREATE TABLE fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    product_key INT,
    customer_key INT,
    date_key INT,
    store_key INT,
    sales DECIMAL(10,2),
    profit DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),

    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store_channel(store_key)
);
