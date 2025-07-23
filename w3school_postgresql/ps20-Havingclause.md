### **PostgreSQL HAVING Clause**

---

### **HAVING Clause Overview**

The `HAVING` clause was introduced in SQL because the `WHERE` clause **cannot be used with aggregate functions** (like `COUNT()`, `SUM()`, `AVG()`, etc.).

* Aggregate functions are often used alongside the `GROUP BY` clause.
* `HAVING` allows us to **filter grouped data**, similar to how `WHERE` filters row-level data.

---

### **Example: Filter Countries Appearing More Than 5 Times**

```sql
SELECT COUNT(customer_id), country
FROM customers
GROUP BY country
HAVING COUNT(customer_id) > 5;
```

This query returns only those countries where the number of customers is greater than 5.

---

### **More HAVING Examples**

---

### **Example: Orders with Total Price ≥ \$400**

```sql
SELECT order_details.order_id, SUM(products.price)
FROM order_details
LEFT JOIN products ON order_details.product_id = products.product_id
GROUP BY order_id
HAVING SUM(products.price) > 400.00;
```

This query lists only those orders whose **total product price** exceeds \$400.

---

### **Example: Customers Who Ordered \$1000 or More**

```sql
SELECT customers.customer_name, SUM(products.price)
FROM order_details
LEFT JOIN products ON order_details.product_id = products.product_id
LEFT JOIN orders ON order_details.order_id = orders.order_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customer_name
HAVING SUM(products.price) > 1000.00;
```

This query lists customers whose **cumulative order value** exceeds \$1000.

---

### **Overview**

The `HAVING` clause in PostgreSQL is used to **filter groups created by the `GROUP BY` clause** based on conditions applied to aggregate functions (e.g., `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`). It is **similar to the `WHERE` clause** but applies to **grouped data** rather than individual rows.

---

### **Key Points**

* **Purpose**: Filters groups based on aggregate conditions after `GROUP BY` is applied.
* **Used With**: Typically used with `GROUP BY` and aggregate functions.
* **Differences from `WHERE`**:

  * `WHERE` filters individual rows **before grouping**.
  * `HAVING` filters groups **after aggregation**.

---

### **Syntax**

```sql
SELECT column1, AGGREGATE_FUNCTION(column2)
FROM table_name
[WHERE condition]
GROUP BY column1
HAVING aggregate_condition;
```

---

### **Execution Order**

1. **FROM** and **JOIN**
2. **WHERE**
3. **GROUP BY**
4. **HAVING**
5. **SELECT**
6. **ORDER BY**

---

### **Common Aggregate Functions**

* **`COUNT()`**: Counts rows in a group.
* **`SUM()`**: Sums values in a column.
* **`AVG()`**: Averages values in a column.
* **`MAX()`**: Finds the maximum value.
* **`MIN()`**: Finds the minimum value.

---

### **Example Table**

For the examples, consider a table `orders` with the following schema:

```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    region VARCHAR(50),
    product VARCHAR(50),
    amount NUMERIC,
    quantity INTEGER
);
```

#### **Sample Data**

```sql
INSERT INTO orders (order_date, region, product, amount, quantity) VALUES
('2023-01-10', 'East', 'Laptop', 1200, 2),
('2023-01-15', 'West', 'Phone', 600, 4),
('2023-01-20', 'East', 'Laptop', 1500, 1),
('2023-02-10', 'West', 'Phone', 800, 3),
('2023-02-15', 'East', 'Tablet', 400, 5),
('2023-03-01', 'West', 'Laptop', 1300, 2);
```

---

### **Example Queries**

---

#### **1. Basic HAVING: Filter Groups by Total Sales**

**Query**:
To find regions with total sales amount greater than 2000:

```sql
SELECT region, SUM(amount) AS total_sales
FROM orders
GROUP BY region
HAVING SUM(amount) > 2000;
```

**Output**:

| region | total\_sales |
| ------ | ------------ |
| East   | 3100         |

---

#### **2. HAVING with Multiple Aggregates**

**Query**:
To find regions with more than 5 items sold and total sales above 1000:

```sql
SELECT region, SUM(amount) AS total_sales, SUM(quantity) AS total_quantity
FROM orders
GROUP BY region
HAVING SUM(quantity) > 5 AND SUM(amount) > 1000;
```

**Output**:

| region | total\_sales | total\_quantity |
| ------ | ------------ | --------------- |
| West   | 2700         | 9               |

---

#### **3. HAVING with Date Functions**

**Query**:
To find months with average order amount above 1000:

```sql
SELECT EXTRACT(MONTH FROM order_date) AS order_month, AVG(amount) AS avg_sales
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING AVG(amount) > 1000
ORDER BY order_month;
```

**Output**:

| order\_month | avg\_sales |
| ------------ | ---------- |
| 1            | 1100       |

---

#### **4. Combining HAVING with WHERE**

**Query**:
To find regions with total sales above 2000 in January 2023:

```sql
SELECT region, SUM(amount) AS total_sales
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY region
HAVING SUM(amount) > 2000;
```

**Output**:

| region | total\_sales |
| ------ | ------------ |
| East   | 2700         |

---

#### **5. HAVING with JOIN**

Assume a `regions` table:

```sql
CREATE TABLE regions (
    region_name VARCHAR(50) PRIMARY KEY,
    manager VARCHAR(50)
);

INSERT INTO regions (region_name, manager) VALUES
('East', 'Alice'),
('West', 'Bob');
```

**Query**:
To find regions with total sales above 2500, including manager names:

```sql
SELECT r.region_name, r.manager, SUM(o.amount) AS total_sales
FROM orders o
JOIN regions r ON o.region = r.region_name
GROUP BY r.region_name, r.manager
HAVING SUM(o.amount) > 2500;
```

**Output**:

| region\_name | manager | total\_sales |
| ------------ | ------- | ------------ |
| East         | Alice   | 3100         |

---

### **Case Study: Retail Sales Performance Analysis**

**Scenario**:
A retail company wants to analyze order data for the first quarter of 2023 to identify high-performing regions and products, focusing on specific performance thresholds.

---

### **Objective**

* Identify regions with total sales exceeding \$2500.
* Find product categories with more than 5 units sold.
* Analyze monthly sales for months with high average order amounts.

---

### **Queries**

---

#### **1. High-Performing Regions**

```sql
SELECT region, SUM(amount) AS total_sales
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY region
HAVING SUM(amount) > 2500
ORDER BY total_sales DESC;
```

**Purpose**: Identifies regions with significant sales contributions.

---

#### **2. Products with High Sales Volume**

```sql
SELECT product, SUM(quantity) AS total_quantity, SUM(amount) AS total_sales
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY product
HAVING SUM(quantity) > 5
ORDER BY total_quantity DESC;
```

**Purpose**: Highlights products with high sales volume.

---

#### **3. High-Value Months**

```sql
SELECT EXTRACT(MONTH FROM order_date) AS order_month, AVG(amount) AS avg_sales
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING AVG(amount) > 800
ORDER BY order_month;
```

**Purpose**: Identifies months with high average order values.

---

### **Analysis Insights**

* **Top Regions**: The **East** region exceeds the \$2500 threshold with \$3100 in sales, indicating strong performance.
* **Product Performance**: **Phones** have a high sales volume (7 units in the West), suggesting popularity in that region.
* **Monthly Trends**: **January** has a high average order amount (1100), likely due to premium products like Laptops.

---

### **Best Practices**

* **Use `HAVING` for Aggregate Conditions**: Apply `HAVING` only for conditions on aggregated values (e.g., `SUM(amount) > 2000`).
* **Combine with `WHERE`**: Use `WHERE` to reduce the dataset before grouping for better performance.
* **Optimize with Indexes**: Index columns used in `WHERE`, `GROUP BY`, or `JOIN` to improve query performance.
* **Validate Conditions**: Test `HAVING` conditions to ensure they correctly filter groups without excluding relevant data.

---

### **Common Errors**

* **Using `HAVING` for Non-Aggregates**:

```sql
-- Incorrect
SELECT region, SUM(amount)
FROM orders
GROUP BY region
HAVING amount > 1000;
-- Error: column "amount" must appear in the GROUP BY clause or be used in an aggregate function
```

✅ **Fix**: Use `WHERE amount > 1000` before grouping or aggregate `amount` in `HAVING`.

* **Missing `GROUP BY`**: Using `HAVING` without `GROUP BY` results in an error unless aggregating the entire table.
* **Overly Restrictive Conditions**: Ensure `HAVING` conditions are not too strict, excluding valid groups unintentionally.

---

### **Conclusion**

The `HAVING` clause is essential for **filtering grouped data** in PostgreSQL, enabling **precise analysis of aggregated results**. By combining `HAVING` with `GROUP BY`, `WHERE`, and `JOIN`, you can extract **meaningful insights** from complex datasets.

✅ Always validate conditions and optimize queries for performance.

