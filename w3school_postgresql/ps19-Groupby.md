
### **PostgreSQL GROUP BY Clause**

---

### **GROUP BY**

The **GROUP BY** clause groups rows that have the **same values** into summary rows.  
It is typically used to **aggregate data**, like answering:  
> "**Find the number of customers in each country**."

The **GROUP BY** clause is often used with **aggregate functions** such as:
- **COUNT()**
- **MAX()**
- **MIN()**
- **SUM()**
- **AVG()**

---

### **Example: Grouping by Country**

> **Lists the number of customers in each country**

```sql
SELECT COUNT(customer_id), country
FROM customers
GROUP BY country;
````

---

### **GROUP BY with JOIN**

You can use **GROUP BY** along with **JOINs** to aggregate data across related tables.

---

### **Example: Number of Orders Per Customer**

```sql
SELECT customers.customer_name, COUNT(orders.order_id)
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customer_name;
```

---

### **Explanation**

* The **LEFT JOIN** brings in all records from `orders`, and matches with `customers` using `customer_id`.
* The **GROUP BY customer\_name** groups the results by each customer.
* The **COUNT(orders.order\_id)** returns the total number of orders for each customer.

---

## **PostgreSQL GROUP BY Clause Notes**

---

### **Overview**

The **GROUP BY** clause in PostgreSQL is used to group rows that have the **same values** in specified columns into **summary rows**.  
It is typically used with **aggregate functions** to compute metrics like **counts, sums, averages**, etc., for each group.

---

### **Key Points**

- **Purpose**: Aggregates data based on one or more columns.
- **Common Aggregate Functions**:
  - **COUNT()**: Counts the number of rows in each group.
  - **SUM()**: Calculates the sum of a numeric column.
  - **AVG()**: Computes the average of a numeric column.
  - **MAX()**: Finds the maximum value in a column.
  - **MIN()**: Finds the minimum value in a column.

---

### **Syntax**

```sql
SELECT column1, column2, AGGREGATE_FUNCTION(column3)
FROM table_name
GROUP BY column1, column2;
````

---

### **Rules**

* Columns in the `SELECT` clause that are **not part of an aggregate function** must appear in the `GROUP BY` clause.
* `GROUP BY` is applied **after the WHERE clause** but **before ORDER BY**.
* Can be used with **HAVING** to filter groups based on aggregate conditions.

---

### **Example Table**

For the examples, consider a table `sales`:

```sql
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    region VARCHAR(50),
    product VARCHAR(50),
    amount NUMERIC,
    quantity INTEGER
);
```

#### **Sample Data**

```sql
INSERT INTO sales (sale_date, region, product, amount, quantity) VALUES
('2023-01-10', 'North', 'Laptop', 1000, 2),
('2023-01-15', 'South', 'Phone', 500, 5),
('2023-01-20', 'North', 'Laptop', 1200, 1),
('2023-02-10', 'South', 'Phone', 600, 3),
('2023-02-15', 'North', 'Tablet', 300, 4),
('2023-03-01', 'South', 'Laptop', 1100, 2);
```

---

### **Example Queries**

---

#### **1. Basic GROUP BY: Total Sales by Region**

```sql
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region;
```

**Output**:

| region | total\_sales |
| ------ | ------------ |
| North  | 2500         |
| South  | 2200         |

---

#### **2. GROUP BY Multiple Columns: Sales by Region and Product**

```sql
SELECT region, product, SUM(amount) AS total_sales, SUM(quantity) AS total_quantity
FROM sales
GROUP BY region, product;
```

**Output**:

| region | product | total\_sales | total\_quantity |
| ------ | ------- | ------------ | --------------- |
| North  | Laptop  | 2200         | 3               |
| North  | Tablet  | 300          | 4               |
| South  | Phone   | 1100         | 8               |
| South  | Laptop  | 1100         | 2               |

---

#### **3. Using HAVING: Filter Groups**

```sql
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(amount) > 2000;
```

**Output**:

| region | total\_sales |
| ------ | ------------ |
| North  | 2500         |

---

#### **4. GROUP BY with Date Functions**

```sql
SELECT EXTRACT(MONTH FROM sale_date) AS sale_month, SUM(amount) AS total_sales
FROM sales
GROUP BY EXTRACT(MONTH FROM sale_date)
ORDER BY sale_month;
```

**Output**:

| sale\_month | total\_sales |
| ----------- | ------------ |
| 1           | 2700         |
| 2           | 900          |
| 3           | 1100         |

---

#### **5. Combining with JOIN**

Assume a `regions` table:

```sql
CREATE TABLE regions (
    region_name VARCHAR(50) PRIMARY KEY,
    manager VARCHAR(50)
);
```

```sql
INSERT INTO regions (region_name, manager) VALUES
('North', 'Alice'),
('South', 'Bob');
```

```sql
SELECT r.region_name, r.manager, SUM(s.amount) AS total_sales
FROM sales s
JOIN regions r ON s.region = r.region_name
GROUP BY r.region_name, r.manager;
```

**Output**:

| region\_name | manager | total\_sales |
| ------------ | ------- | ------------ |
| North        | Alice   | 2500         |
| South        | Bob     | 2200         |

---

### **Case Study: Retail Sales Analysis**

#### **Scenario**

A retail company wants to analyze sales performance across regions and products for **Q1 2023**.

---

### **Objective**

* Calculate total sales and quantities sold by region and product.
* Identify regions with sales exceeding a threshold (e.g., \$2000).
* Summarize monthly sales trends.

---

### **Queries**

---

#### **1. Total Sales and Quantities by Region and Product**

```sql
SELECT region, product, SUM(amount) AS total_sales, SUM(quantity) AS total_quantity
FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY region, product
ORDER BY region, total_sales DESC;
```

**Purpose**: Identify which products are driving sales in each region.

---

#### **2. High-Performing Regions**

```sql
SELECT region, SUM(amount) AS total_sales
FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY region
HAVING SUM(amount) > 2000
ORDER BY total_sales DESC;
```

**Purpose**: Filters regions with significant sales contributions.

---

#### **3. Monthly Sales Trends**

```sql
SELECT EXTRACT(MONTH FROM sale_date) AS sale_month, SUM(amount) AS total_sales
FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY EXTRACT(MONTH FROM sale_date)
ORDER BY sale_month;
```

**Purpose**: Tracks sales performance over time to identify trends.

---

### **Analysis Insights**

* **Top Regions**: The **North** region has higher sales (\$2500) compared to **South** (\$2200).
* **Product Performance**: **Laptops** dominate in the North, while **Phones** dominate in the South.
* **Monthly Trends**: **January** shows the highest sales—possibly due to post-holiday demand.

---

### **Best Practices**

* ✅ **Include Non-Aggregated Columns in GROUP BY**: Avoid errors by including all selected non-aggregated columns.
* ✅ **Use HAVING for Group Filtering**: Use `HAVING` to filter aggregate results, not `WHERE`.
* ✅ **Optimize with Indexes**: Use indexes on columns used in `GROUP BY` or `WHERE` for performance.
* ✅ **Test Queries**: Always validate with small datasets first.

---

### **Common Errors**

---

#### ❌ **Missing GROUP BY Columns**

```sql
SELECT region, product, amount
FROM sales
GROUP BY region;
```

**Error**: column "product" must appear in the GROUP BY clause or be used in an aggregate function.

---

#### ❌ **Misusing HAVING**

Using `HAVING` for non-aggregated conditions instead of `WHERE`.

---

#### ❌ **Performance Issues**

Grouping on large datasets **without indexes** can be slow and inefficient.

---

### **Conclusion**

The **GROUP BY** clause is a **powerful tool** for summarizing data in PostgreSQL.
By combining it with **aggregate functions**, **joins**, and **date functions**, you can generate **meaningful insights** for business analysis.
Always ensure proper **column inclusion** and **optimize queries** for performance.


