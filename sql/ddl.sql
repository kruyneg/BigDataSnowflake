-- Таблица клиентов
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(50)
);

-- Таблица питомцев
CREATE TABLE dim_customer_pet (
    pet_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customer(customer_id),
    name VARCHAR(50),
    type VARCHAR(50),
    breed VARCHAR(50),
    category VARCHAR(50)
)

-- Таблица продавцов
CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(50)
);

-- Таблица товаров
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price FLOAT,
    quantity INT,
    weight FLOAT,
    color VARCHAR(50),
    size VARCHAR(50),
    brand VARCHAR(50),
    material VARCHAR(50),
    description VARCHAR(1024),
    rating FLOAT,
    reviews INT,
    release_date DATE,
    expiry_date DATE
);

-- Таблица поставщиков
CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    contact VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Таблица магазинов
CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(50)
);

-- Таблица для дат
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    day INT,
    month INT,
    year INT,
    weekday VARCHAR(15)
);

-- Основная таблица продаж
CREATE TABLE fact_sales (
    sale_id INT,
    customer_id INT REFERENCES dim_customer(customer_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    product_id INT REFERENCES dim_product(product_id),
    supplier_id INT REFERENCES dim_supplier(supplier_id),
    store_id INT REFERENCES dim_store(store_id),
    date_id INT REFERENCES dim_date(date_id),
    quantity INT,
    total_price FLOAT
);

-- Таблица со всеми данными
CREATE TABLE mock_data (
	id INT PRIMARY KEY,
	customer_first_name varchar(50) NULL,
	customer_last_name varchar(50) NULL,
	customer_age INT NULL,
	customer_email varchar(50) NULL,
	customer_country varchar(50) NULL,
	customer_postal_code varchar(50) NULL,
	customer_pet_type varchar(50) NULL,
	customer_pet_name varchar(50) NULL,
	customer_pet_breed varchar(50) NULL,
	seller_first_name varchar(50) NULL,
	seller_last_name varchar(50) NULL,
	seller_email varchar(50) NULL,
	seller_country varchar(50) NULL,
	seller_postal_code varchar(50) NULL,
	product_name varchar(50) NULL,
	product_category varchar(50) NULL,
	product_price float4 NULL,
	product_quantity INT NULL,
	sale_date varchar(50) NULL,
	sale_customer_id INT NOT NULL,
	sale_seller_id INT NOT NULL,
	sale_product_id INT NOT NULL,
	sale_quantity INT NULL,
	sale_total_price float4 NULL,
	store_name varchar(50) NULL,
	store_location varchar(50) NULL,
	store_city varchar(50) NULL,
	store_state varchar(50) NULL,
	store_country varchar(50) NULL,
	store_phone varchar(50) NULL,
	store_email varchar(50) NULL,
	pet_category varchar(50) NULL,
	product_weight float4 NULL,
	product_color varchar(50) NULL,
	product_size varchar(50) NULL,
	product_brand varchar(50) NULL,
	product_material varchar(50) NULL,
	product_description varchar(1024) NULL,
	product_rating float4 NULL,
	product_reviews INT NULL,
	product_release_date varchar(50) NULL,
	product_expiry_date varchar(50) NULL,
	supplier_name varchar(50) NULL,
	supplier_contact varchar(50) NULL,
	supplier_email varchar(50) NULL,
	supplier_phone varchar(50) NULL,
	supplier_address varchar(50) NULL,
	supplier_city varchar(50) NULL,
	supplier_country varchar(50) NULL
);
