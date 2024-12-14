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
