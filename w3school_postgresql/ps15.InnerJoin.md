
### **PostgreSQL INNER JOIN**

#### **INNER JOIN**
The **INNER JOIN** keyword selects records that have matching values in both tables.

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

We will try to join the `testproducts` table with the `categories` table:

| category_id | category_name  | description                                              |
|-------------|----------------|----------------------------------------------------------|
| 1           | Beverages      | Soft drinks, coffees, teas, beers, and ales              |
| 2           | Condiments     | Sweet and savory sauces, relishes, spreads, and seasonings |
| 3           | Confections    | Desserts, candies, and sweet breads                      |
| 4           | Dairy Products | Cheeses                                                  |
| 5           | Grains/Cereals | Breads, crackers, pasta, and cereal                      |
| 6           | Meat/Poultry   | Prepared meats                                           |
| 7           | Produce        | Dried fruit and bean curd                                |
| 8           | Seafood        | Seaweed and fish                               |

(8 rows)

Notice that many of the products in `testproducts` have a `category_id` that does not match any of the categories in the `categories` table.

By using **INNER JOIN** we will **not** get the records where there is **not a match**, we will only get the records that **matches match** both tables**:

#### **Example**
Join **testproducts** `testproducts` to `categories` using **the** `category_id` **column**:

```sql
SELECT testproduct_id, product_name, category_name
FROM testproducts
INNER JOIN categories ON testproducts.category_id = categories.category_id;
```

#### **Result**
Only the records with a match in **BOTH** tables are returned:

| testproduct_id | product_name           | category_name  |
|----------------|------------------------|----------------|
| 1              | Johns Fruit Cake       | Confections    |
| 6              | Janes Favorite Cheese  | Dairy Products |
| 8              | Ellas Special Salmon   | Seafood        |
| 9              | Roberts Rich Spaghetti | Grains/Cereals |

(4 rows)

**Note**: `JOIN` and `INNER JOIN` will give the same result.

**INNER** is the default join type for `JOIN`, so when you write `JOIN` the parser actually writes `INNER JOIN`.

#### **Exercise**
**What does the INNER JOIN keyword return?**

- **Only matching records from both tables**
- All records from the left table and matching records from the right table
- All records from the right table and matching records from the left table
- All records from both tables

### **Exercise**

```sql
-- Create testproducts table
CREATE TABLE testproducts (
    testproduct_id INTEGER PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INTEGER
);
```

```sql
-- Create categories table
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(50),
    description VARCHAR(100)
);

```

```sql
-- Insert data into testproducts
INSERT INTO testproducts VALUES
(1, 'Johns Fruit Cake', 3),
(2, 'Marys Healthy Mix', 9),
(3, 'Peters Scary Stuff', 10),
(4, 'Jims Secret Recipe', 11),
(5, 'Elisabeths Best Apples', 12),
(6, 'Janes Favorite Cheese', 4),
(7, 'Billys Home Made Pizza', 13),
(8, 'Ellas Special Salmon', 8),
(9, 'Roberts Rich Spaghetti', 5),
(10, 'Mias Popular Ice', 14);
```

```sql
-- Insert data into categories
INSERT INTO categories VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, 'Confections', 'Desserts, candies, and sweet breads'),
(4, 'Dairy Products', 'Cheeses'),
(5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
(6, 'Meat/Poultry', 'Prepared meats'),
(7, 'Produce', 'Dried fruit and bean curd'),
(8, 'Seafood', 'Seaweed and fish');
```

```sql
-- Perform INNER JOIN
SELECT testproduct_id, product_name, category_name
FROM testproducts
INNER JOIN categories ON testproducts.category_id = categories.category_id;
```

### **Exercise 02**

```sql
-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT
);

-- Create departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Insert data into employees table
INSERT INTO employees VALUES
(101, 'Alice Smith', 10),
(102, 'Bob Johnson', 20),
(103, 'Carol White', 30),
(104, 'David Lee', 40),
(105, 'Emma Brown', 50),
(106, 'Frank Green', 20),
(107, 'Grace Taylor', 60);

-- Insert data into departments
INSERT INTO departments VALUES
(10, 'HR', 'New York'),
(20, 'IT', 'San Francisco'),
(30, 'Finance', 'Chicago'),
(40, 'Marketing', 'Los Angeles');

-- Perform INNER JOIN
SELECT emp_name, dept_name, location
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;
```

### **Notes**

- **INNER JOIN**: Returns only records with matching values in both tables.
- Matches rows based on a specified condition (e.g., `table1.column = table2.column`).
- Default join type: `JOIN` is the same as `INNER JOIN`.
- Excludes non-matching rows from both tables.
- Syntax: `SELECT columns FROM table1 INNER JOIN table2 ON table1.column = table2.column;`
- Use for precise data retrieval where only common records are needed.