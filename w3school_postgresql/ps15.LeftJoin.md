
### **PostgreSQL LEFT JOIN**

#### **LEFT JOIN**
The **LEFT JOIN** keyword selects **ALL** records from the "left" table and the matching records from the "right" table. If there is no match, the result includes **NULL** values for columns from the right table.

Let's look at an example using our dummy `testproducts` table:

| testproduct_id | product_name           | category_id |
|----------------|------------------------|-------------|
| 1              | Johns Fruit Cake       | 3           |
| 2              | Marys Healthy Mix      | 9           |
| 3              | Peters Scary Stuff     | 10          |
| 4              | Jims Secret Recipe     | 11          |
| 5              | Elisabeths Best Apples | 12          |
| 6              | Janes Favorite Cheese  | 4           |
| 7              | Billys Home Made Pizza | 13          |
| 8              | Ellas Special Salmon   | 8           |
| 9              | Roberts Rich Spaghetti | 5           |
| 10             | Mias Popular Ice       | 14          |

(10 rows)

We will join the `testproducts` table with the `categories` table:

| category_id | category_name  | description                                              |
|-------------|----------------|----------------------------------------------------------|
| 1           | Beverages      | Soft drinks, coffees, teas, beers, and ales              |
| 2           | Condiments     | Sweet and savory sauces, relishes, spreads, and seasonings |
| 3           | Confections    | Desserts, candies, and sweet breads                      |
| 4           | Dairy Products | Cheeses                                                  |
| 5           | Grains/Cereals | Breads, crackers, pasta, and cereal                      |
| 6           | Meat/Poultry   | Prepared meats                                           |
| 7           | Produce        | Dried fruit and bean curd                                |
| 8           | Seafood        | Seaweed and fish                                         |

(8 rows)

**Note**: Many products in `testproducts` have a `category_id` that does not match any categories in the `categories` table.

By using **LEFT JOIN**, we will get **all records** from `testproducts`, even those with no match in the `categories` table, with **NULL** for unmatched `category_name` values.

#### **Example**
Join `testproducts` to `categories` using the `category_id` column:

```sql
SELECT testproduct_id, product_name, category_name
FROM testproducts
LEFT JOIN categories ON testproducts.category_id = categories.category_id;
```


### **PostgreSQL LEFT JOIN Case Study: Library System**

#### **Overview**
This case study demonstrates a **LEFT JOIN** using a library system with Indian members' data. The `library_members` table stores member details, and the `cities` table stores city information. Some members have a `city_id` that does not match any city in the `cities` table.

#### **Creating Tables**

**`library_members` Table**:
```sql
CREATE TABLE library_members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    city_id INT
);
```

```sql
cities Table:
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50),
    state VARCHAR(50)
);
```

Inserting Data
library_members Data:
```sql
INSERT INTO library_members VALUES
(1, 'Aarav Sharma', 101),
(2, 'Priya Patel', 102),
(3, 'Vikram Singh', 103),
(4, 'Ananya Gupta', 104),
(5, 'Rohan Kumar', 105),
(6, 'Sneha Verma', 102),
(7, 'Kiran Yadav', 106);
```

cities Data:


```sql
INSERT INTO cities VALUES
(101, 'Mumbai', 'Maharashtra'),
(102, 'Delhi', 'Delhi'),
(103, 'Bengaluru', 'Karnataka'),
(104, 'Kolkata', 'West Bengal');

```

Note: Some city_id values in library_members (e.g., 105, 106) do not match any city_id in the cities table.
Performing LEFT JOIN

```sql
The LEFT JOIN retrieves all records from library_members (left table) and matching records from cities (right table). Unmatched records from cities will show NULL for city_name and state.
SELECT member_id, member_name, city_name, state
FROM library_members
LEFT JOIN cities ON library_members.city_id = cities.city_id;
```
Result
All records from library_members are returned, with NULL for city_name and state where no match exists in cities:


---
Let’s break down the `LEFT JOIN ... ON` clause using the library system case study and explain which table is considered the "left" table, which is the "right" table, and how the mapping happens.

### Explanation of `LEFT JOIN cities ON`

**Query**:
```sql
SELECT member_id, member_name, city_name, state
FROM library_members
LEFT JOIN cities ON library_members.city_id = cities.city_id;
```

#### 1. **Which Table is Left and Which is Right?**
- **Left Table**: The table specified **before** the `LEFT JOIN` keyword is the **left table**. In this query, it is `library_members`.
- **Right Table**: The table specified **after** the `LEFT JOIN` keyword is the **right table**. In this query, it is `cities`.

So:
- `library_members` = Left table
- `cities` = Right table

#### 2. **What Does `LEFT JOIN` Do?**
- A **LEFT JOIN** (or `LEFT OUTER JOIN`) includes **all rows** from the **left table** (`library_members`) in the result, regardless of whether there is a match in the **right table** (`cities`).
- For rows in the left table that have no matching row in the right table, the columns from the right table will return `NULL` in the result.

#### 3. **What Does `ON library_members.city_id = cities.city_id` Mean?**
- The `ON` clause specifies the **condition** for matching rows between the two tables.
- Here, `library_members.city_id = cities.city_id` means the join will match rows where the `city_id` column in the `library_members` table equals the `city_id` column in the `cities` table.
- This condition defines how the two tables are related.

#### 4. **How Does the Mapping Happen?**
The mapping process involves comparing each row of the **left table** (`library_members`) with rows in the **right table** (`cities`) based on the `ON` condition. Here’s how it works step-by-step:

- **Step 1**: Take the first row from `library_members`.
- **Step 2**: Check its `city_id` value and look for a row in `cities` where `cities.city_id` matches that `city_id`.
- **Step 3**: If a match is found, include the corresponding `city_name` and `state` from `cities` in the result, along with `member_id` and `member_name` from `library_members`.
- **Step 4**: If no match is found, include the `member_id` and `member_name` from `library_members`, but place `NULL` for `city_name` and `state`.
- **Step 5**: Repeat for all rows in `library_members`.

#### 5. **Dry Run of Mapping with Example Data**
Let’s use the data from the case study to illustrate:

**`library_members` (Left Table)**:
| member_id | member_name   | city_id |
|-----------|---------------|---------|
| 1         | Aarav Sharma  | 101     |
| 2         | Priya Patel   | 102     |
| 3         | Vikram Singh  | 103     |
| 4         | Ananya Gupta  | 104     |
| 5         | Rohan Kumar   | 105     |
| 6         | Sneha Verma   | 102     |
| 7         | Kiran Yadav   | 106     |

**`cities` (Right Table)**:
| city_id | city_name | state         |
|---------|-----------|---------------|
| 101     | Mumbai    | Maharashtra   |
| 102     | Delhi     | Delhi         |
| 103     | Bengaluru | Karnataka     |
| 104     | Kolkata   | West Bengal   |

**Mapping Process**:
- **Row 1 (library_members)**: `city_id = 101`
  - Matches `city_id = 101` in `cities` → Returns `Mumbai, Maharashtra`.
  - Result: `(1, Aarav Sharma, Mumbai, Maharashtra)`
- **Row 2**: `city_id = 102`
  - Matches `city_id = 102` in `cities` → Returns `Delhi, Delhi`.
  - Result: `(2, Priya Patel, Delhi, Delhi)`
- **Row 3**: `city_id = 103`
  - Matches `city_id = 103` in `cities` → Returns `Bengaluru, Karnataka`.
  - Result: `(3, Vikram Singh, Bengaluru, Karnataka)`
- **Row 4**: `city_id = 104`
  - Matches `city_id = 104` in `cities` → Returns `Kolkata, West Bengal`.
  - Result: `(4, Ananya Gupta, Kolkata, West Bengal)`
- **Row 5**: `city_id = 105`
  - No match for `city_id = 105` in `cities` → Returns `NULL, NULL`.
  - Result: `(5, Rohan Kumar, NULL, NULL)`
- **Row 6**: `city_id = 102`
  - Matches `city_id = 102` in `cities` → Returns `Delhi, Delhi`.
  - Result: `(6, Sneha Verma, Delhi, Delhi)`
- **Row 7**: `city_id = 106`
  - No match for `city_id = 106` in `cities` → Returns `NULL, NULL`.
  - Result: `(7, Kiran Yadav, NULL, NULL)`

#### 6. **Final Result**
The LEFT JOIN ensures **all 7 rows** from `library_members` appear in the result, with `city_name` and `state` from `cities` where matches exist, or `NULL` otherwise:

| member_id | member_name   | city_name | state       |
|-----------|---------------|-----------|-------------|
| 1         | Aarav Sharma  | Mumbai    | Maharashtra |
| 2         | Priya Patel   | Delhi     | Delhi       |
| 3         | Vikram Singh  | Bengaluru | Karnataka   |
| 4         | Ananya Gupta  | Kolkata   | West Bengal |
| 5         | Rohan Kumar   | NULL      | NULL        |
| 6         | Sneha Verma   | Delhi     | Delhi       |
| 7         | Kiran Yadav   | NULL      | NULL        |

#### 7. **Key Points**
- **Left Table (`library_members`)**: All rows are included, no matter what.
- **Right Table (`cities`)**: Only matching rows are included; unmatched rows result in `NULL` for right table columns.
- **ON Condition**: Defines the relationship (`library_members.city_id = cities.city_id`) for matching rows.
- **Mapping**: Each row in the left table is paired with a matching row from the right table (if any) based on the `ON` condition.

This process ensures that no data from `library_members` is excluded, while `cities` data is only included when there’s a match.


```sql
-- Dry Run of RIGHT JOIN Query:
-- Query: SELECT c.customer_name, o.order_id, p.product_name, oi.quantity
-- FROM customers c
-- LEFT JOIN orders o ON c.customer_id = o.customer_id
-- LEFT JOIN order_items oi ON o.order_id = oi.order_id
-- RIGHT JOIN products p ON oi.product_id = p.product_id;

-- Step 1: Understand the table data
-- customers table:
-- | customer_id | customer_name | email              | phone       | address |
-- |-------------|---------------|--------------------|-------------|---------|
-- | 1           | Rajesh Kumar  | rajesh@example.com | 9876543210  | Delhi   |
-- | 2           | Priya Sharma  | priya@example.com  | 8765432109  | Mumbai  |

-- orders table:
-- | order_id | customer_id | order_date  | total_amount | status     |
-- |----------|------------|-------------|--------------|------------|
-- | 101      | 1          | 2023-01-01  | 5000.00      | Shipped    |
-- | 102      | 2          | 2023-01-02  | 3000.00      | Processing |
-- | 103      | 1          | 2023-01-03  | 20000.00     | Shipped    |

-- order_items table:
-- | order_item_id | order_id | product_id | quantity | price     |
-- |---------------|----------|------------|----------|-----------|
-- | 1001          | 101      | 501        | 1        | 50000.00  |
-- | 1002          | 101      | 503        | 2        | 1000.00   |
-- | 1003          | 102      | 502        | 1        | 20000.00  |
-- | 1004          | 103      | 502        | 1        | 20000.00  |

-- products table:
-- | product_id | product_name | category    | price    | stock |
-- |------------|--------------|-------------|----------|-------|
-- | 501        | Laptop       | Electronics | 50000.00 | 10    |
-- | 502        | Smartphone   | Electronics | 20000.00 | 20    |
-- | 503        | Book         | Stationery  | 500.00   | 100   |
-- | 504        | Tablet       | Electronics | 15000.00 | 15    |

-- Step 2: RIGHT JOIN explanation
-- The RIGHT JOIN ensures ALL rows from the products table (right table) are included.
-- The LEFT JOINs (customers to orders, orders to order_items) are processed first, then the RIGHT JOIN to products.
-- If no match exists in order_items, orders, or customers for a product, NULL is returned for their columns (customer_name, order_id, quantity).

-- Step 3: Process joins step-by-step
-- The query is evaluated left to right:
-- 1. LEFT JOIN customers to orders: All customers, matched with their orders (all customers have orders here).
-- 2. LEFT JOIN to order_items: All orders, matched with their items.
-- 3. RIGHT JOIN to products: All products, matched with order_items (and upstream tables); NULL for unmatched products.

-- Step 4: Dry run starting with products (RIGHT JOIN drives the result)
-- Since RIGHT JOIN prioritizes products, we process each row in products and work backward.

-- Product 1: product_id=501, product_name='Laptop'
--   - Look for product_id=501 in order_items: Found (order_item_id=1001, order_id=101, quantity=1)
--   - For order_id=101 in orders: Found (customer_id=1, order_date=2023-01-01, status=Shipped)
--   - For customer_id=1 in customers: Found (customer_name='Rajesh Kumar')
--   - Output: ('Rajesh Kumar', 101, 'Laptop', 1)

-- Product 2: product_id=502, product_name='Smartphone'
--   - Look for product_id=502 in order_items: Found TWO rows
--     - Row 1: (order_item_id=1003, order_id=102, quantity=1)
--       - For order_id=102 in orders: Found (customer_id=2, order_date=2023-01-02, status=Processing)
--       - For customer_id=2 in customers: Found (customer_name='Priya Sharma')
--       - Output: ('Priya Sharma', 102, 'Smartphone', 1)
--     - Row 2: (order_item_id=1004, order_id=103, quantity=1)
--       - For order_id=103 in orders: Found (customer_id=1, order_date=2023-01-03, status=Shipped)
--       - For customer_id=1 in customers: Found (customer_name='Rajesh Kumar')
--       - Output: ('Rajesh Kumar', 103, 'Smartphone', 1)

-- Product 3: product_id=503, product_name='Book'
--   - Look for product_id=503 in order_items: Found (order_item_id=1002, order_id=101, quantity=2)
--   - For order_id=101 in orders: Found (customer_id=1, order_date=2023-01-01, status=Shipped)
--   - For customer_id=1 in customers: Found (customer_name='Rajesh Kumar')
--   - Output: ('Rajesh Kumar', 101, 'Book', 2)

-- Product 4: product_id=504, product_name='Tablet'
--   - Look for product_id=504 in order_items: Not found
--   - No match in order_items, so no orders or customers to trace
--   - Output: (NULL, NULL, 'Tablet', NULL)

-- Step 5: Final Result
-- All 4 products are included (due to RIGHT JOIN), with 5 rows total because Smartphone appears in two orders:
-- | customer_name | order_id | product_name | quantity |
-- |---------------|----------|--------------|----------|
-- | Rajesh Kumar  | 101      | Laptop       | 1        |
-- | Rajesh Kumar  | 101      | Book         | 2        |
-- | Priya Sharma  | 102      | Smartphone   | 1        |
-- | Rajesh Kumar  | 103      | Smartphone   | 1        |
-- | NULL          | NULL     | Tablet       | NULL     |
-- (5 rows)

-- RIGHT JOIN Query
SELECT c.customer_name, o.order_id, p.product_name, oi.quantity
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
RIGHT JOIN products p ON oi.product_id = p.product_id;
```