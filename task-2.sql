CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,
    category_id INTEGER REFERENCES categories(id)
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

SELECT
    f.title AS movie_title,
    f.duration AS movie_duration,
    c.name AS category_name
FROM
    films f
JOIN
    categories c ON f.category_id = c.id;

SELECT
    f.title AS movie_title,
    r.rental_date AS rental_date
FROM
    rentals r
JOIN
    films f ON r.film_id = f.id
JOIN
    customers c ON r.customer_id = c.id
WHERE
    c.name = 'Client Name';

SELECT
    f.title AS movie_title,
    COUNT(r.id) AS rental_count
FROM
    rentals r
JOIN
    films f ON r.film_id = f.id
GROUP BY
    f.id
ORDER BY
    rental_count DESC
LIMIT 5;

INSERT INTO customers (name, address, city)
VALUES ('Alice Cooper', '123 Main St', 'San Francisco');

UPDATE customers
SET address = '456 Elm St'
WHERE name = 'Alice Cooper';

DELETE FROM customers
WHERE name = 'Alice Cooper';
