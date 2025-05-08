-- Для заполнения таблицы mock_data
INSERT INTO mock_data
SELECT
    9000 + id,
    customer_first_name, customer_last_name, customer_age,
    customer_email, customer_country, customer_postal_code,
    customer_pet_type, customer_pet_name, customer_pet_breed,

    seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code,

    product_name, product_category, product_price, product_quantity,

    sale_date,
    9000 + sale_customer_id,
    9000 + sale_seller_id,
    9000 + sale_product_id,
    sale_quantity,
    sale_total_price,

    store_name, store_location, store_city, store_state,
    store_country, store_phone, store_email,

    pet_category,

    product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating,
    product_reviews, product_release_date, product_expiry_date,

    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
FROM mock_data_9

-- Для заполнения моих таблиц
INSERT INTO dim_customer
    (customer_id, first_name, last_name, age, email, country, postal_code)
SELECT DISTINCT 
    sale_customer_id,
    customer_first_name, customer_last_name, customer_age,
    customer_email, customer_country, customer_postal_code
FROM mock_data;

INSERT INTO dim_customer_pet
    (customer_id, name, type, breed, category)
SELECT 
    c.customer_id,
    m.customer_pet_name, m.customer_pet_type,
    m.customer_pet_breed, m.pet_category
FROM mock_data m
JOIN dim_customer c ON c.customer_id = m.sale_customer_id;

INSERT INTO dim_seller
    (seller_id, first_name, last_name, email, country, postal_code)
SELECT DISTINCT 
    sale_seller_id,
    seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code
FROM mock_data;

INSERT INTO dim_product (
    product_id, name, category, price, quantity, weight,
    color, size, brand, material, description, rating, reviews,
    release_date, expiry_date
)
SELECT DISTINCT
    sale_product_id,
    product_name, product_category, product_price, product_quantity, product_weight, product_color, product_size,
    product_brand, product_material, product_description, product_rating, product_reviews,
    TO_DATE(product_release_date, 'MM/DD/YYYY'),
    TO_DATE(product_expiry_date, 'MM/DD/YYYY')
FROM mock_data;

INSERT INTO dim_supplier
    (name, contact, email, phone, address, city, country)
SELECT DISTINCT
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
FROM mock_data;

INSERT INTO dim_store
    (name, location, city, state, country, phone, email)
SELECT DISTINCT
    store_name, store_location, store_city, store_state,
    store_country, store_phone, store_email
FROM mock_data;

INSERT INTO dim_date (date, day, month, year, weekday)
SELECT DISTINCT
    TO_DATE(sale_date, 'MM/DD/YYYY') AS date,
    EXTRACT(DAY FROM TO_DATE(sale_date, 'MM/DD/YYYY')),
    EXTRACT(MONTH FROM TO_DATE(sale_date, 'MM/DD/YYYY')),
    EXTRACT(YEAR FROM TO_DATE(sale_date, 'MM/DD/YYYY')),
    TO_CHAR(TO_DATE(sale_date, 'MM/DD/YYYY'), 'Day')
FROM mock_data;

INSERT INTO fact_sales (
    sale_id,
    customer_id,
    seller_id,
    product_id,
    supplier_id,
    store_id,
    date_id,
    quantity,
    total_price
)
SELECT
    m.id,
    c.customer_id,
    s.seller_id,
    p.product_id,
    sup.supplier_id,
    st.store_id,
    d.date_id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
JOIN dim_customer c ON m.sale_customer_id = c.customer_id
JOIN dim_seller s ON m.sale_seller_id = s.seller_id
JOIN dim_product p ON m.sale_product_id = p.product_id
JOIN dim_store st ON
    m.store_name = st.name AND
    m.store_location = st.location AND
    m.store_city = st.city AND
    m.store_state = st.state AND
    m.store_country = st.country AND
    m.store_phone = st.phone AND
    m.store_email = st.email
JOIN dim_supplier sup ON
    m.supplier_name = sup.name AND
    m.supplier_contact = sup.contact AND
    m.supplier_email = sup.email AND
    m.supplier_phone = sup.phone AND
    m.supplier_address = sup.address AND
    m.supplier_city = sup.city AND
    m.supplier_country = sup.country
JOIN dim_date d ON d.date = TO_DATE(m.sale_date, 'MM/DD/YYYY');
