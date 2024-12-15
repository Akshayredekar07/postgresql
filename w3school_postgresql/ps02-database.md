## Database

To create a database in PostgreSQL, you can use the following command in the **psql** command-line interface:

```sql
CREATE DATABASE database_name;
```
To verify the database was created, use:
```sql
\l
```
This lists all databases in the PostgreSQL instance.

### Create Table
The following SQL statement will create a table named cars in your PostgreSQL database:
```sql
CREATE TABLE cars (
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);
```

### PostgreSQL Insert Data

To insert data into a table in PostgreSQL, we use the `INSERT INTO` statement.

The following SQL statement will insert one row of data into the cars table you created in the previous chapter.

```sql
INSERT INTO cars (brand, model, year)
VALUES ('Ford', 'Mustang', 1964);
```

The SQL Shell application will return the following:
```
INSERT 0 1
```
Which means that 1 row was inserted.


### Insert Multiple Rows
To insert multiple rows of data, we use the same INSERT INTO statement, but with multiple values:
```sql
INSERT INTO cars (brand, model, year)
VALUES
  ('Volvo', 'p1800', 1968),
  ('BMW', 'M1', 1978),
  ('Toyota', 'Celica', 1975);
```

### PostgreSQL Select Data

To retrieve data from a data base, we use the `SELECT` statement.

**Specify Columns**
- By specifying the column names, we can choose which columns to select:

**Example**
```sql
SELECT brand, year FROM cars;
```
Return ALL Columns

**_Specify a * instead of the column names to select all columns:_**

```sql
SELECT * FROM cars;
```

### PostgreSQL ADD COLUMN
The ALTER TABLE Statement
- To add a column to an existing table, we have to use the `ALTER TABLE` statement.

The `ALTER TABLE` statement is used to `add, delete, or modify columns in an existing table.`

The ALTER TABLE statement is also used to `add and drop` various `constraints on an existing table.`

**ADD COLUMN**
- We want to add a column named `color` to our `cars` table.

When `adding columns` we must also specify the `data type` of the `column`. Our color column will be a string, and we specify string types with the VARCHAR keyword. we also want to restrict the number of characters to 255:

**Example**
Add a column named color:

```sql
ALTER TABLE cars
ADD color VARCHAR(255);
```
```sql
SELECT * FROM cars;
```
### PostgreSQL UPDATE

**The UPDATE Statement**  
The `UPDATE` statement is used to modify the value(s) in existing records in a table.  

**Example**  
Set the color of the Volvo to `'red'`:  
```sql
UPDATE cars
SET color = 'red'
WHERE brand = 'Volvo';
```  
**Result**  
```plaintext
UPDATE 1
```
This means that 1 row was affected by the `UPDATE` statement.  

**Note:** Be careful with the `WHERE` clause; in the example above, **all rows where `brand = 'Volvo'`** get updated.  


**Warning! Remember WHERE**  
Be cautious when updating records. If you omit the `WHERE` clause, **all records** will be updated!  

**Example**  
Without the `WHERE` clause, **all records** will be updated:  
```sql
UPDATE cars
SET color = 'red';
```  
**Result**  
```plaintext
UPDATE 4
```


**Update Multiple Columns**  
To update more than one column, separate the name/value pairs with a comma `,`:  

**Example**  
Update color and year for the Toyota:  
```sql
UPDATE cars
SET color = 'white', year = 1970
WHERE brand = 'Toyota';
```  
**Result**  
```plaintext
UPDATE 1
```

**PostgreSQL ALTER COLUMN**

**The ALTER TABLE Statement**  
The `ALTER TABLE` statement is used to add, delete, or modify columns in an existing table.  

The `ALTER TABLE` statement is also used to add and drop various constraints on an existing table.  

---

**ALTER COLUMN**  
To change the data type of a column, use the `ALTER COLUMN` statement and the `TYPE` keyword followed by the new data type.  

**Example**  
Change the `year` column of the `cars` table from `INT` to `VARCHAR(4)`:  
```sql
ALTER TABLE cars
ALTER COLUMN year TYPE VARCHAR(4);
```  
**Result**  
```plaintext
ALTER TABLE
```  
**Note**  
Some data types cannot be converted if the column has value. E.g., numbers can always be converted to text, but text cannot always be converted to numbers.  

---

**Change Maximum Allowed Characters**  
To modify the maximum number of characters allowed in a column, use the same syntax as above.  

**Example**  
Change the `color` column from `VARCHAR(255)` to `VARCHAR(30)`:  
```sql
ALTER TABLE cars
ALTER COLUMN color TYPE VARCHAR(30);
```  


**PostgreSQL DROP COLUMN**  

**The ALTER TABLE Statement**  
To remove a column from a table, we have to use the ALTER TABLE statement.  

The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.  

The ALTER TABLE statement is also used to add and drop various constraints on an existing table.  

**DROP COLUMN**  
We want to remove the column named `color` from the `cars` table.  

To remove a column, use the `DROP COLUMN` statement:  

**Example**  
Remove the `color` column:  
```sql
ALTER TABLE cars  
DROP COLUMN color;
```

**Result**  
`ALTER TABLE`  

**Display Table**  
To check the result we can display the table with this SQL statement:  

**Example**  
```sql
SELECT * FROM cars;
```  

---

**PostgreSQL DELETE**  

**The DELETE Statement**  
The DELETE statement is used to delete existing records in a table.  

Note: Be careful when deleting records in a table! Notice the WHERE clause in the DELETE statement. The WHERE clause specifies which record(s) should be deleted.  

If you omit the WHERE clause, all records in the table will be deleted!  

**Example**  
Delete all records where brand is 'Volvo':  
```sql
DELETE FROM cars  
WHERE brand = 'Volvo';
```

**Delete All Records**  
It is possible to delete all rows in a table without deleting the table. This means that the table structure, attributes, and indexes will be intact.  

**Example**  
Delete all records in the cars table:  
```sql
DELETE FROM cars;
```

**Result**  
`DELETE 3`  
Which means that all 3 rows were deleted.  

**Display Table**  
To check the result we can display the table with this SQL statement:  

**Example**  
```sql
SELECT * FROM cars;
```  

**TRUNCATE TABLE**  
Because we omit the WHERE clause in the DELETE statement above, all records will be deleted from the cars table.  

The same would have been achieved by using the TRUNCATE TABLE statement:  

**Example**  
Delete all records in the cars table:  
```sql
TRUNCATE TABLE cars;
```  

**PostgreSQL DROP TABLE**  

**The DROP TABLE Statement**  
The DROP TABLE statement is used to drop an existing table in a database.  

Note: Be careful before dropping a table. Deleting a table will result in the loss of all information stored in the table!  

**Example**  
Delete the cars table:  
```sql
DROP TABLE cars;
```

**Result**  
`DROP TABLE`  

**Display Table**  
To check the result we can display the table with this SQL statement:  

**Example**  
```sql
SELECT * FROM cars;
```  

**Result**  
```
ERROR: relation "cars" does not exist  
LINE 1: SELECT * FROM cars;  
                      ^
```  


### **How to See Currently Used Database**  
To check which database you are currently connected to, use the following command:  

```sql
SELECT current_database();
```  

### **How to Switch Database**  
You cannot directly switch databases within the same session in PostgreSQL. Instead, you need to reconnect to the desired database.  

To connect to a different database, use the following command in the PostgreSQL command-line interface (`psql`):  

```bash
\c database_name
```  

**Example**  
```bash
\c my_new_database
```  

**Result**  
```
You are now connected to database "my_new_database" as user "your_user".
```

---

## Example Database

**_CREATE TABLE categories_**
```sql
CREATE TABLE categories (
  category_id SERIAL NOT NULL PRIMARY KEY,
  category_name VARCHAR(255),
  description VARCHAR(255)
);
```

**_INSERT INTO categories_**
```sql
INSERT INTO categories (category_name, description)
VALUES
  ('Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
  ('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
  ('Confections', 'Desserts, candies, and sweet breads'),
  ('Dairy Products', 'Cheeses'),
  ('Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
  ('Meat/Poultry', 'Prepared meats'),
  ('Produce', 'Dried fruit and bean curd'),
  ('Seafood', 'Seaweed and fish');
```

### Creating the Customers Table
The following SQL statement will create a table named `customers`:

```sql
CREATE TABLE customers (
  customer_id SERIAL NOT NULL PRIMARY KEY,
  customer_name VARCHAR(255),
  contact_name VARCHAR(255),
  address VARCHAR(255),

  city VARCHAR(255),
  postal_code VARCHAR(255),
  country VARCHAR(255)
);
```

**Inserting Data into Customers Table**
```sql
INSERT INTO customers (customer_name, contact_name, address, city, postal_code, country)
VALUES
  ('Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
  ('Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitucion 2222', 'Mexico D.F.', '05021', 'Mexico'),
  ('Antonio Moreno Taquera', 'Antonio Moreno', 'Mataderos 2312', 'Mexico D.F.', '05023', 'Mexico'),
  ('Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
  ('Berglunds snabbkoep', 'Christina Berglund', 'Berguvsvegen 8', 'Lulea', 'S-958 22', 'Sweden'),
  ('Blauer See Delikatessen', 'Hanna Moos', 'Forsterstr. 57', 'Mannheim', '68306', 'Germany'),
  ('Blondel pere et fils', 'Frederique Citeaux', '24, place Kleber', 'Strasbourg', '67000', 'France'),
  ('Bolido Comidas preparadas', 'Martin Sommer', 'C/ Araquil, 67', 'Madrid', '28023', 'Spain'),
  ('Bon app', 'Laurence Lebihans', '12, rue des Bouchers', 'Marseille', '13008', 'France'),
  ('Bottom-Dollar Marketse', 'Elizabeth Lincoln', '23 Tsawassen Blvd.', 'Tsawassen', 'T2F 8M4', 'Canada'),
  ('Bs Beverages', 'Victoria Ashworth', 'Fauntleroy Circus', 'London', 'EC2 5NT', 'UK'),
  ('Cactus Comidas para llevar', 'Patricio Simpson', 'Cerrito 333', 'Buenos Aires', '1010', 'Argentina'),
  ('Centro comercial Moctezuma', 'Francisco Chang', 'Sierras de Granada 9993', 'Mexico D.F.', '05022', 'Mexico'),
  ('Chop-suey Chinese', 'Yang Wang', 'Hauptstr. 29', 'Bern', '3012', 'Switzerland'),
  ('Comercio Mineiro', 'Pedro Afonso', 'Av. dos Lusiadas, 23', 'Sao Paulo', '05432-043', 'Brazil'),
  ('Consolidated Holdings', 'Elizabeth Brown', 'Berkeley Gardens 12 Brewery', 'London', 'WX1 6LT', 'UK'),
  ('Drachenblut Delikatessend', 'Sven Ottlieb', 'Walserweg 21', 'Aachen', '52066', 'Germany'),
  ('Du monde entier', 'Janine Labrune', '67, rue des Cinquante Otages', 'Nantes', '44000', 'France'),
  ('Eastern Connection', 'Ann Devon', '35 King George', 'London', 'WX3 6FW', 'UK'),
  ('Ernst Handel', 'Roland Mendel', 'Kirchgasse 6', 'Graz', '8010', 'Austria'),
  ('Familia Arquibaldo', 'Aria Cruz', 'Rua Oros, 92', 'Sao Paulo', '05442-030', 'Brazil'),
  ('FISSA Fabrica Inter. Salchichas S.A.', 'Diego Roel', 'C/ Moralzarzal, 86', 'Madrid', '28034', 'Spain'),
  ('Folies gourmandes', 'Martine Rance', '184, chaussee de Tournai', 'Lille', '59000', 'France'),
  ('Folk och fe HB', 'Maria Larsson', 'Akergatan 24', 'Brecke', 'S-844 67', 'Sweden'),
  ('Frankenversand', 'Peter Franken', 'Berliner Platz 43', 'Munchen', '80805', 'Germany'),
  ('France restauration', 'Carine Schmitt', '54, rue Royale', 'Nantes', '44000', 'France'),
  ('Franchi S.p.A.', 'Paolo Accorti', 'Via Monte Bianco 34', 'Torino', '10100', 'Italy'),
  ('Furia Bacalhau e Frutos do Mar', 'Lino Rodriguez ', 'Jardim das rosas n. 32', 'Lisboa', '1675', 'Portugal');
```
---

**PRODUCTS**  
```sql
CREATE TABLE products (
  product_id SERIAL NOT NULL PRIMARY KEY,
  product_name VARCHAR(255),
  category_id INT,
  unit VARCHAR(255),
  price DECIMAL(10, 2)
);
```


```sql
INSERT INTO products (product_id, product_name, category_id, unit, price)
VALUES
  (1, 'Chais', 1, '10 boxes x 20 bags', 18),
  (2, 'Chang', 1, '24 - 12 oz bottles', 19),
  (3, 'Aniseed Syrup', 2, '12 - 550 ml bottles', 10),
  (4, 'Chef Antons Cajun Seasoning', 2, '48 - 6 oz jars', 22),
  (5, 'Chef Antons Gumbo Mix', 2, '36 boxes', 21.35),
  (6, 'Grandmas Boysenberry Spread', 2, '12 - 8 oz jars', 25),
  (7, 'Uncle Bobs Organic Dried Pears', 7, '12 - 1 lb pkgs.', 30),
  (8, 'Northwoods Cranberry Sauce', 2, '12 - 12 oz jars', 40),
  (9, 'Mishi Kobe Niku', 6, '18 - 500 g pkgs.', 97),
  (10, 'Ikura', 8, '12 - 200 ml jars', 31),
  (11, 'Queso Cabrales', 4, '1 kg pkg.', 21),
  (12, 'Queso Manchego La Pastora', 4, '10 - 500 g pkgs.', 38),
  (13, 'Konbu', 8, '2 kg box', 6),
  (14, 'Tofu', 7, '40 - 100 g pkgs.', 23.25),
  (15, 'Genen Shouyu', 2, '24 - 250 ml bottles', 15.5),
  (16, 'Pavlova', 3, '32 - 500 g boxes', 17.45),
  (17, 'Alice Mutton', 6, '20 - 1 kg tins', 39),
  (18, 'Carnarvon Tigers', 8, '16 kg pkg.', 62.5),
  (19, 'Teatime Chocolate Biscuits', 3, '10 boxes x 12 pieces', 9.2),
  (20, 'Sir Rodneys Marmalade', 3, '30 gift boxes', 81),
  (21, 'Sir Rodneys Scones', 3, '24 pkgs. x 4 pieces', 10),
  (22, 'Gustafs Kneckebrod', 5, '24 - 500 g pkgs.', 21),
  (23, 'Tunnbrod', 5, '12 - 250 g pkgs.', 9),
  (24, 'Guarani Fantastica', 1, '12 - 355 ml cans', 4.5),
  (25, 'NuNuCa Nui-Nougat-Creme', 3, '20 - 450 g glasses', 14),
  (26, 'Gumber Gummiberchen', 3, '100 - 250 g bags', 31.23),
  (27, 'Schoggi Schokolade', 3, '100 - 100 g pieces', 43.9),
  (28, 'Rassle Sauerkraut', 7, '25 - 825 g cans', 45.6),
  (29, 'Thoringer Rostbratwurst', 6, '50 bags x 30 sausgs.', 123.79),
  (30, 'Nord-Ost Matjeshering', 8, '10 - 200 g glasses', 25.89),
  (31, 'Gorgonzola Telino', 4, '12 - 100 g pkgs', 12.5),
  (32, 'Mascarpone Fabioli', 4, '24 - 200 g pkgs.', 32),
  (33, 'Geitost', 4, '500 g', 2.5),
  (34, 'Sasquatch Ale', 1, '24 - 12 oz bottles', 14),
  (35, 'Steeleye Stout', 1, '24 - 12 oz bottles', 18),
  (36, 'Inlagd Sill', 8, '24 - 250 g jars', 19),
  (37, 'Gravad lax', 8, '12 - 500 g pkgs.', 26),
  (38, 'Cote de Blaye', 1, '12 - 75 cl bottles', 263.5),
  (39, 'Chartreuse verte', 1, '750 cc per bottle', 18),
  (40, 'Boston Crab Meat', 8, '24 - 4 oz tins', 18.4),
  (41, 'Jacks New England Clam Chowder', 8, '12 - 12 oz cans', 9.65),
  (42, 'Singaporean Hokkien Fried Mee', 5, '32 - 1 kg pkgs.', 14),
  (43, 'Ipoh Coffee', 1, '16 - 500 g tins', 46),
  (44, 'Gula Malacca', 2, '20 - 2 kg bags', 19.45),
  (45, 'Rogede sild', 8, '1k pkg.', 9.5),
  (46, 'Spegesild', 8, '4 - 450 g glasses', 12),
  (47, 'Zaanse koeken', 3, '10 - 4 oz boxes', 9.5),
  (48, 'Chocolade', 3, '10 pkgs.', 12.75),
  (49, 'Maxilaku', 3, '24 - 50 g pkgs.', 20),
  (50, 'Valkoinen suklaa', 3, '12 - 100 g bars', 16.25),
  (51, 'Manjimup Dried Apples', 7, '50 - 300 g pkgs.', 53),
  (52, 'Filo Mix', 5, '16 - 2 kg boxes', 7),
  (53, 'Perth Pasties', 6, '48 pieces', 32.8),
  (54, 'Tourtiare', 6, '16 pies', 7.45),
  (55, 'Pate chinois', 6, '24 boxes x 2 pies', 24),
  (56, 'Gnocchi di nonna Alice', 5, '24 - 250 g pkgs.', 38),
  (57, 'Ravioli Angelo', 5, '24 - 250 g pkgs.', 19.5),
  (58, 'Escargots de Bourgogne', 8, '24 pieces', 13.25),
  (59, 'Raclette Courdavault', 4, '5 kg pkg.', 55),
  (60, 'Camembert Pierrot', 4, '15 - 300 g rounds', 34),
  (61, 'Sirop d arable', 2, '24 - 500 ml bottles', 28.5),
  (62, 'Tarte au sucre', 3, '48 pies', 49.3),
  (63, 'Vegie-spread', 2, '15 - 625 g jars', 43.9),
  (64, 'Wimmers gute Semmelknadel', 5, '20 bags x 4 pieces', 33.25),
  (65, 'Louisiana Fiery Hot Pepper Sauce', 2, '32 - 8 oz bottles', 21.05),
  (66, 'Louisiana Hot Spiced Okra', 2, '24 - 8 oz jars', 17),
  (67, 'Laughing Lumberjack Lager', 1, '24 - 12 oz bottles', 14),
  (68, 'Scottish Longbreads', 3, '10 boxes x 8 pieces', 12.5),
  (69, 'Gudbrandsdalsost', 4, '10 kg pkg.', 36),
  (70, 'Outback Lager', 1, '24 - 355 ml bottles', 15),
  (71, 'Flotemysost', 4, '10 - 500 g pkgs.', 21.5),
  (72, 'Mozzarella di Giovanni', 4, '24 - 200 g pkgs.', 34.8),
  (73, 'Red Kaviar', 8, '24 - 150 g jars', 15),
  (74, 'Longlife Tofu', 7, '5 kg pkg.', 10),
  (75, 'Rhenbreu Klosterbier', 1, '24 - 0.5 l bottles', 7.75),
  (76, 'Lakkalikeeri', 1, '500 ml ', 18),
  (77, 'Original Frankfurter gr�ne Soae', 2, '12 boxes', 13);
```

--- 

### ORDERS

CREATE TABLE orders
```sql
CREATE TABLE orders (
  order_id SERIAL NOT NULL PRIMARY KEY,
  customer_id INT,
  order_date DATE
);
```

**INSERT INTO orders**

>> Refer w3school to insert data

[Insert data](https://www.w3schools.com/postgresql/postgresql_create_demodatabase.php)

**ORDER_DETAILS Table**


CREATE TABLE order_details
```sql
CREATE TABLE order_details (
  order_detail_id SERIAL NOT NULL PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT
);
```

[Insert data into order_details](https://www.w3schools.com/postgresql/postgresql_create_demodatabase.php)


### TESTPRODUCTS
CREATE TABLE testproducts
```sql
CREATE TABLE testproducts (
  testproduct_id SERIAL NOT NULL PRIMARY KEY,
  product_name VARCHAR(255),
  category_id INT
);
```

INSERT INTO testproducts
```sql
INSERT INTO testproducts (product_name, category_id)
VALUES
  ('Johns Fruit Cake', 3),
  ('Marys Healthy Mix', 9),
  ('Peters Scary Stuff', 10),
  ('Jims Secret Recipe', 11),
  ('Elisabeths Best Apples', 12),
  ('Janes Favorite Cheese', 4),
  ('Billys Home Made Pizza', 13),
  ('Ellas Special Salmon', 8),
  ('Roberts Rich Spaghetti', 5),
  ('Mias Popular Ice', 14);
```