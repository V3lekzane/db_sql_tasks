CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    release_year INTEGER,
    rating VARCHAR(10)
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE rentals (
    id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films(id),
    customer_id INTEGER REFERENCES customers(id),
    rental_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    store_id INTEGER
);

CREATE TABLE stores (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

SELECT
    c.name AS category_name,
    COUNT(f.id) AS total_movies
FROM
    categories c
LEFT JOIN
    films f ON c.id = f.category_id
GROUP BY
    c.name;

SELECT
    c.name AS category_name,
    AVG(f.duration) AS average_duration
FROM
    categories c
LEFT JOIN
    films f ON c.id = f.category_id
GROUP BY
    c.name;

SELECT
    MIN(duration) AS min_duration,
    MAX(duration) AS max_duration
FROM
    films;

SELECT
    COUNT(*) AS total_customers
FROM
    customers;

SELECT
    c.name AS customer_name,
    SUM(p.amount) AS total_payments
FROM
    customers c
JOIN
    payments p ON c.id = p.customer_id
GROUP BY
    c.name;

SELECT
    c.name AS customer_name,
    SUM(p.amount) AS total_payments
FROM
    customers c
JOIN
    payments p ON c.id = p.customer_id
GROUP BY
    c.name
ORDER BY
    total_payments DESC
LIMIT 5;

SELECT
    c.name AS customer_name,
    COUNT(r.id) AS total_rentals
FROM
    customers c
LEFT JOIN
    rentals r ON c.id = r.customer_id
GROUP BY
    c.name;

SELECT
    AVG(EXTRACT(YEAR FROM AGE(NOW(), TO_TIMESTAMP(f.release_year::text, 'YYYY')))) AS average_age
FROM
    films f;

SELECT
    COUNT(*) AS total_rentals
FROM
    rentals
WHERE
    rental_date BETWEEN '2024-01-01' AND '2024-12-31';

SELECT
    DATE_TRUNC('month', p.payment_date) AS month,
    SUM(p.amount) AS total_payments
FROM
    payments p
GROUP BY
    month
ORDER BY
    month;

SELECT
    c.name AS customer_name,
    MAX(p.amount) AS max_payment
FROM
    customers c
JOIN
    payments p ON c.id = p.customer_id
GROUP BY
    c.name;

SELECT
    c.name AS customer_name,
    AVG(p.amount) AS average_payment
FROM
    customers c
JOIN
    payments p ON c.id = p.customer_id
GROUP BY
    c.name;

SELECT
    f.rating AS film_rating,
    COUNT(f.id) AS total_movies
FROM
    films f
GROUP BY
    f.rating;

SELECT
    s.name AS store_name,
    AVG(p.amount) AS average_payment
FROM
    stores s
JOIN
    payments p ON s.id = p.store_id
GROUP BY
    s.name;
