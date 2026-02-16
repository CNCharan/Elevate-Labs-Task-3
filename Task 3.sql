DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1,'Arjun','Hyderabad','2024-02-01'),
(2,'Meera','Chennai','2024-02-10'),
(3,'Karan','Pune','2024-03-05'),
(4,'Sneha','Bangalore','2024-03-20');
INSERT INTO products VALUES
(201,'Tablet','Electronics',30000),
(202,'Headphones','Electronics',5000),
(203,'Watch','Accessories',7000),
(204,'Backpack','Fashion',2500);
INSERT INTO orders VALUES
(5001,1,'2024-04-01'),
(5002,2,'2024-04-03'),
(5003,1,'2024-04-05'),
(5004,3,'2024-04-08');
INSERT INTO order_items VALUES
(1,5001,201,1),
(2,5001,202,2),
(3,5002,203,1),
(4,5003,204,3),
(5,5004,201,1);
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT *
FROM products
WHERE price > 6000
ORDER BY price DESC;
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
INSERT INTO orders VALUES
(5001,1,'2024-04-01'),
(5002,2,'2024-04-03'),
(5003,1,'2024-04-05'),
(5004,3,'2024-04-08');
INSERT INTO order_items VALUES
(1,5001,201,1),
(2,5001,202,2),
(3,5002,203,1),
(4,5003,204,3),
(5,5004,201,1);
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);
SELECT 
SUM(p.price * oi.quantity) / COUNT(DISTINCT o.customer_id) AS ARPU
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
SELECT c.name,
SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;















