# 🛒 E-Commerce Analytics SQL Project (Version 2)

## 📌 Project Overview

This project implements a relational **E-Commerce Database System** using MySQL and performs business analytics queries on transactional data.

It demonstrates:

- Relational database design
- Primary & Foreign Keys
- Data insertion & validation
- JOIN operations (INNER & LEFT)
- GROUP BY & HAVING
- Subqueries
- Revenue analytics
- ARPU calculation
- Customer lifetime value logic

---

## 🗄 Database Setup

### Database Name
`ecommerce_db`

---

## 🧱 Schema Design

### 1️⃣ customers

| Column        | Type          | Constraint        |
|--------------|--------------|------------------|
| customer_id | INT          | PRIMARY KEY      |
| name         | VARCHAR(100) |
| city         | VARCHAR(100) |
| signup_date  | DATE         |

---

### 2️⃣ products

| Column        | Type            | Constraint   |
|--------------|-----------------|-------------|
| product_id   | INT             | PRIMARY KEY |
| product_name | VARCHAR(100)    |
| category     | VARCHAR(100)    |
| price        | DECIMAL(10,2)   |

---

### 3️⃣ orders

| Column      | Type | Constraint |
|------------|------|------------|
| order_id   | INT  | PRIMARY KEY |
| customer_id| INT  | FOREIGN KEY → customers(customer_id) |
| order_date | DATE |            |

---

### 4️⃣ order_items

| Column        | Type | Constraint |
|--------------|------|------------|
| order_item_id| INT  | PRIMARY KEY |
| order_id     | INT  | FOREIGN KEY → orders(order_id) |
| product_id   | INT  | FOREIGN KEY → products(product_id) |
| quantity     | INT  |

---

## 📥 Sample Dataset (New Version)

### Customers

| ID | Name  | City       |
|----|-------|-----------|
| 1  | Arjun | Hyderabad |
| 2  | Meera | Chennai   |
| 3  | Karan | Pune      |
| 4  | Sneha | Bangalore |

---

### Products

| ID  | Product      | Price |
|-----|-------------|-------|
| 201 | Tablet      | 30000 |
| 202 | Headphones  | 5000  |
| 203 | Watch       | 7000  |
| 204 | Backpack    | 2500  |

---

### Orders Summary

- Arjun → 2 orders
- Meera → 1 order
- Karan → 1 order
- Sneha → 0 orders

---

## 📊 Analytical Queries Implemented

---

### 1️⃣ Filter High-Value Products

```sql
SELECT *
FROM products
WHERE price > 6000
ORDER BY price DESC;
```

---

### 2️⃣ Orders Per Customer

```sql
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
```

---

### 3️⃣ INNER JOIN (Customers with Orders)

```sql
SELECT c.name, o.order_id, o.order_date
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;
```

---

### 4️⃣ LEFT JOIN (Include Customers Without Orders)

```sql
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
```

Demonstrates handling NULL values for inactive customers.

---

### 5️⃣ Customers With More Than 1 Order

```sql
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);
```

Result: **Arjun**

---

### 6️⃣ ARPU (Average Revenue Per User)

```sql
SELECT 
SUM(p.price * oi.quantity) / COUNT(DISTINCT o.customer_id) AS ARPU
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
```

Result:
```
42500
```

---

### 7️⃣ Total Spending Per Customer

```sql
SELECT c.name,
SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;
```

Results:

| Name  | Total Spent |
|-------|------------|
| Arjun | 47500 |
| Meera | 7000 |
| Karan | 30000 |

---

## 📈 Business Insights Derived

- Revenue distribution per customer
- Identification of repeat customers
- Identification of inactive users
- Average revenue per paying user
- High-value product filtering
- Customer lifetime value estimation

---

## 🧠 Concepts Demonstrated

- Relational Modeling
- Referential Integrity
- Aggregation Functions
- DISTINCT counting
- Subqueries with HAVING
- JOIN Optimization
- Revenue Computation Logic

