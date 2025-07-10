### **PostgreSQL RIGHT JOIN**

#### **RIGHT JOIN**
The **RIGHT JOIN** keyword selects **ALL** records from the "right" table and the matching records from the "left" table. If there is no match, the result includes **NULL** values for columns from the left table.

#### **Case Study: Product Categories**
This example involves two tables: `testproducts` (left table) and `categories` (right table). The `testproducts` table stores product details, and the `categories` table stores category information. Some categories may not have any associated products.

**Note**: Many products in `testproducts` have a `category_id` that does not match any categories in the `categories` table.

#### **SQL Commands**

**Create `testproducts` Table**:
```sql
CREATE TABLE testproducts (
    testproduct_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT
);
```
Insert Data into testproducts:
```sql
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
Create categories Table:
```sql
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    description VARCHAR(100)
);
```
Insert Data into categories:
```sql
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
RIGHT JOIN Query
Join testproducts to categories using the category_id column:
```sql
SELECT testproduct_id, product_name, category_name
FROM testproducts
RIGHT JOIN categories ON testproducts.category_id = categories.category_id;
```
Result
All records from categories (right table) are included, with matching records from testproducts. If no match exists, testproduct_id and product_name are NULL:

### **RIGHT JOIN Result**

| testproduct_id | product_name           | category_name  |
|----------------|------------------------|----------------|
| 1              | Johns Fruit Cake       | Confections    |
| 6              | Janes Favorite Cheese  | Dairy Products |
| 8              | Ellas Special Salmon   | Seafood        |
| 9              | Roberts Rich Spaghetti | Grains/Cereals |
| NULL           | NULL                   | Beverages      |
| NULL           | NULL                   | Condiments     |
| NULL           | NULL                   | Meat/Poultry   |
| NULL           | NULL                   | Produce        |

(8 rows)


Note: RIGHT JOIN and RIGHT OUTER JOIN produce the same result. OUTER is the default join type for RIGHT JOIN, so RIGHT JOIN is equivalent to RIGHT OUTER JOIN.

---

### Case Study: Indian E-commerce Platform

We’ll use four tables—`customers`, `orders`, `order_items`, and `products`—each with more than three fields to give you a richer structure. The goal is to use RIGHT JOIN to include all records from the `products` table (the right table), even if some products haven’t been ordered, and connect them with the other tables to show customer and order details where they exist.

#### Table Structures

Here’s how the tables are set up with multiple fields:

- **`customers`**  
  - `customer_id` (INT): Unique customer identifier  
  - `customer_name` (VARCHAR): Name of the customer  
  - `email` (VARCHAR): Customer’s email address  
  - `phone` (VARCHAR): Customer’s phone number  
  - `address` (VARCHAR): Customer’s shipping address  

- **`orders`**  
  - `order_id` (INT): Unique order identifier  
  - `customer_id` (INT): Links to the customer who placed the order  
  - `order_date` (DATE): Date the order was placed  
  - `total_amount` (DECIMAL): Total cost of the order  
  - `status` (VARCHAR): Order status (e.g., Shipped, Processing)  

- **`order_items`**  
  - `order_item_id` (INT): Unique identifier for each item in an order  
  - `order_id` (INT): Links to the order  
  - `product_id` (INT): Links to the product  
  - `quantity` (INT): Number of units ordered  
  - `price` (DECIMAL): Price per unit at the time of order  

- **`products`**  
  - `product_id` (INT): Unique product identifier  
  - `product_name` (VARCHAR): Name of the product  
  - `category` (VARCHAR): Product category (e.g., Electronics, Stationery)  
  - `price` (DECIMAL): Current price of the product  
  - `stock` (INT): Number of items in stock  

These tables have relationships: `orders` links to `customers` via `customer_id`, and `order_items` connects `orders` and `products` using `order_id` and `product_id`. This setup is more complex than a basic three-field structure and reflects a realistic e-commerce database.

---

#### SQL Commands to Set Up the Tables

Let’s create and populate the tables with some data to work with.

```sql
-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    address VARCHAR(100)
);
```
```sql
-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20)
);

```
```sql
-- Create the order_items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
);
```
```sql
-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);
```
```sql
-- Insert data into customers
INSERT INTO customers VALUES
(1, 'Rajesh Kumar', 'rajesh@example.com', '9876543210', 'Delhi'),
(2, 'Priya Sharma', 'priya@example.com', '8765432109', 'Mumbai');
```
```sql
-- Insert data into orders
INSERT INTO orders VALUES
(101, 1, '2023-01-01', 5000.00, 'Shipped'),
(102, 2, '2023-01-02', 3000.00, 'Processing'),
(103, 1, '2023-01-03', 20000.00, 'Shipped');
```
```sql
-- Insert data into products
INSERT INTO products VALUES
(501, 'Laptop', 'Electronics', 50000.00, 10),
(502, 'Smartphone', 'Electronics', 20000.00, 20),
(503, 'Book', 'Stationery', 500.00, 100),
(504, 'Tablet', 'Electronics', 15000.00, 15);
```
```sql
-- Insert data into order_items
INSERT INTO order_items VALUES
(1001, 101, 501, 1, 50000.00),
(1002, 101, 503, 2, 1000.00),
(1003, 102, 502, 1, 20000.00),
(1004, 103, 502, 1, 20000.00);
```

This data includes:
- Two customers with orders.
- Three orders, with one customer (Rajesh) placing two orders.
- Four products, one of which (Tablet) isn’t ordered.
- Order items linking orders to products, with Smartphone appearing in two different orders.

---

#### Understanding RIGHT JOIN

A **RIGHT JOIN** includes **all records from the right table** and the matching records from the left table. If there’s no match, the result shows `NULL` for the left table’s columns. In this case, we’ll use `products` as the right table to list all products, even those not ordered.

Here’s the query:

```sql
SELECT c.customer_name, o.order_id, p.product_name, oi.quantity
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
RIGHT JOIN products p ON oi.product_id = p.product_id;
```

#### How the Query Works

1. **Start with `customers`**: We begin with the `customers` table.
2. **LEFT JOIN to `orders`**: This includes all customers and their orders. If a customer has no orders, their order fields would be `NULL` (not applicable here since all customers have orders).
3. **LEFT JOIN to `order_items`**: This links orders to their items. If an order had no items, those fields would be `NULL`.
4. **RIGHT JOIN to `products`**: This ensures all products are included. If a product isn’t in `order_items`, the `quantity`, `order_id`, and `customer_name` will be `NULL`.

The joins are evaluated left to right, so the RIGHT JOIN on `products` takes precedence, pulling in all products regardless of prior matches.

---

#### Result of the Query

Here’s what you get when you run the query:

| customer_name | order_id | product_name | quantity |
|---------------|----------|--------------|----------|
| Rajesh Kumar  | 101      | Laptop       | 1        |
| Rajesh Kumar  | 101      | Book         | 2        |
| Priya Sharma  | 102      | Smartphone   | 1        |
| Rajesh Kumar  | 103      | Smartphone   | 1        |
| NULL          | NULL     | Tablet       | NULL     |

(5 rows)

#### Breaking Down the Result

- **Laptop**: Ordered by Rajesh (order 101), quantity 1.
- **Book**: Ordered by Rajesh (order 101), quantity 2.
- **Smartphone**: Ordered twice—by Priya (order 102) and Rajesh (order 103), quantity 1 each.
- **Tablet**: Not ordered, so `customer_name`, `order_id`, and `quantity` are `NULL`.

This shows how RIGHT JOIN preserves all records from `products`, adding `NULL` where there’s no match in `order_items`, `orders`, or `customers`.

---

#### Why This Helps You Learn RIGHT JOIN

- **Multiple Fields**: Each table has 5 fields, giving you a more detailed structure to explore.
- **Complex Relationships**: The tables are linked across multiple levels (`customers` → `orders` → `order_items` → `products`), not just a simple two-table join.
- **Real-World Scenario**: It mimics an e-commerce setup where not all products are ordered, and some products are ordered multiple times.
- **RIGHT JOIN in Action**: You see how it includes all products, even the unordered Tablet, and correctly ties ordered products to their customers and orders.

