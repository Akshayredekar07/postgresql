
### **PostgreSQL CROSS JOIN**

#### **CROSS JOIN**
The **CROSS JOIN** keyword matches **ALL** records from the "left" table with **EACH** record from the "right" table, creating a **Cartesian product**.  
This results in **every possible combination** of rows from both tables, regardless of any matching condition.

> **Note**: `CROSS JOIN` can produce a **very large result set**, as the number of rows is the product of the row counts of both tables (e.g., 3 travelers × 4 destinations = 12 rows in this case).  
> Use it **cautiously**, as it’s typically applied when you **intentionally need all possible combinations**, such as for planning or testing.

---

### **Case Study: Indian Travel Agency**

This case study involves two tables: `travelers` (left table) and `destinations` (right table).

- The `travelers` table stores details of people booking with the agency.
- The `destinations` table stores information about tourist destinations.

A **CROSS JOIN** will pair **every traveler** with **every destination**, simulating **all possible travel package assignments**.

---

### **SQL Commands**

#### **Create `travelers` Table**
```sql
CREATE TABLE travelers (
    traveler_id INT PRIMARY KEY,
    traveler_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(50)
);
````

#### **Insert Data into `travelers`**

```sql
INSERT INTO travelers VALUES
(1, 'Amit Sharma', 'amit@example.com', '9876543210', 'Delhi'),
(2, 'Sneha Patel', 'sneha@example.com', '8765432109', 'Mumbai'),
(3, 'Ravi Kumar', 'ravi@example.com', '7654321098', 'Bengaluru');
```

#### **Create `destinations` Table**

```sql
CREATE TABLE destinations (
    dest_id INT PRIMARY KEY,
    dest_name VARCHAR(50),
    state VARCHAR(50),
    package_cost DECIMAL(10,2)
);
```

> ✅ Fixed error: removed `package Montricher` (invalid column) and replaced it with `package_cost`.

#### **Insert Data into `destinations`**

```sql
INSERT INTO destinations VALUES
(101, 'Taj Mahal', 'Uttar Pradesh', 5000.00),
(102, 'Goa Beaches', 'Goa', 8000.00),
(103, 'Kerala Backwaters', 'Kerala', 12000.00),
(104, 'Leh Ladakh', 'Ladakh', 15000.00);
```

---

### **CROSS JOIN Query**

Join `travelers` to `destinations` using the `CROSS JOIN` keyword:

```sql
SELECT traveler_id, traveler_name, dest_name, package_cost
FROM travelers
CROSS JOIN destinations;
```

---

### **Result**

All records from `travelers` are paired with each record from `destinations`, resulting in:

> ✅ **3 × 4 = 12 rows**

---

### **Explanation**

* **Total Rows**: With 3 travelers and 4 destinations, the `CROSS JOIN` produces **3 × 4 = 12 rows**.
* **No Matching Condition**: Unlike `INNER`, `LEFT`, or `RIGHT JOIN`, `CROSS JOIN` does **not** use an `ON` clause.
* **All Combinations**: Every traveler is matched with **every destination**.
* **Use Case**: Useful for generating **marketing combinations**, **package planning**, or **scenario simulation**.
* **Challenge**: Result size grows **exponentially**, so it must be used **carefully** with large tables.

---

### **Note**

* `CROSS JOIN` is **equivalent to** combining two tables without any `ON` or `WHERE` condition.
* It's distinct from other joins because it doesn’t filter based on column matches.
* Can be **computationally intensive** and **memory-heavy** when used on large datasets.
