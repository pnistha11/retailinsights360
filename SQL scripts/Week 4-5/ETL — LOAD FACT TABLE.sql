INSERT INTO fact_sales (
    order_id,
    product_key,
    customer_key,
    date_key,
    store_key,
    sales,
    profit,
    quantity,
    discount
)
SELECT
    s.`Order ID`,
    p.product_key,
    c.customer_key,
    d.date_key,
    st.store_key,
    s.Sales,
    s.Profit,
    s.Quantity,
    s.Discount
FROM superstore_cleaned s
JOIN dim_product p
    ON s.`Product ID` = p.product_id
JOIN dim_customer c
    ON s.`Customer ID` = c.customer_id
JOIN dim_date d
    ON s.`Order Date` = d.order_date
JOIN dim_store_channel st
    ON s.Country = st.country
   AND s.Region = st.region
   AND s.State = st.state
   AND s.City = st.city;
