### **5.1. Table Basics in PostgreSQL**  

A table in a relational database consists of **rows and columns**. Each column has a **fixed name and data type**, while the number of rows is variable, depending on the stored data.  

- The **order of rows is not guaranteed** unless explicitly sorted using an `ORDER BY` clause.  
- SQL does **not assign unique identifiers** to rows, which means duplicate rows can exist unless prevented with constraints.  

---

### **5.1.1. Columns and Data Types**  

Each column in a table has a **specific data type**, which:  
- **Constrains** the allowed values.  
- **Defines operations** that can be performed on the data.  

Common PostgreSQL data types:  

| **Data Type** | **Description** |
|--------------|----------------|
| `integer` | Stores whole numbers. |
| `numeric` | Stores fractional/decimal numbers. |
| `text` | Stores character strings. |
| `date` | Stores date values. |
| `time` | Stores time-of-day values. |
| `timestamp` | Stores both date and time values. |

PostgreSQL provides built-in data types and allows users to define their own.  

---

### **5.1.2. Creating a Table**  

Use the `CREATE TABLE` command to define a new table, specifying:  
- **Table name**  
- **Column names and data types**  

#### **Example: Simple Table Creation**  
```sql
CREATE TABLE my_first_table (
    first_column text,
    second_column integer
);
```
This creates a table `my_first_table` with:  
- `first_column` of type `text`.  
- `second_column` of type `integer`.  

#### **Example: Practical Table Creation**  
```sql
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric
);
```
- The `products` table stores product details.  
- `product_no` is an integer (e.g., product ID).  
- `name` is text (e.g., product name).  
- `price` is numeric (supports decimals for monetary values).  

#### **Naming Conventions**  
When creating multiple related tables:  
- Maintain a **consistent naming pattern**.  
- Choose between **singular** (e.g., `product`) or **plural** (e.g., `products`) for table names.  

---

### **5.1.3. Table Column Limits**  

- A table can contain **between 250 and 1600 columns**, depending on data types.  
- However, defining too many columns is **uncommon and may indicate poor design**.  

---

### **5.1.4. Dropping a Table**  

Use `DROP TABLE` to remove an existing table.  

#### **Example: Deleting a Table**  
```sql
DROP TABLE my_first_table;
DROP TABLE products;
```
- If the table does not exist, PostgreSQL returns an error.  

#### **Avoiding Errors**  
To prevent errors when dropping a non-existent table:  
```sql
DROP TABLE IF EXISTS my_first_table;
```
This ensures the command executes **only if the table exists**.  

---

### **5.1.5. Modifying an Existing Table**  

- Tables can be **altered** after creation using `ALTER TABLE`.  
- Modifications include **adding, removing, or modifying columns**.  
- More details are covered in **Section 5.7**.  

---

## **5.2. Default Values in PostgreSQL**  

A column in a table can have a **default value**, which is automatically assigned if no value is specified during insertion.  

- **If no default is declared**, PostgreSQL **assigns NULL** by default.  
- The default value can be **a constant, an expression, or a function**.  
- A column’s default value can also be explicitly set using the `DEFAULT` keyword in `INSERT` statements.  

---

### **5.2.1. Defining Default Values**  

A default value is specified **after the column's data type** in `CREATE TABLE`.  

#### **Example: Default Numeric Value**  
```sql
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric DEFAULT 9.99
);
```
- `price` defaults to `9.99` if not specified during insertion.  

#### **Example: Default Timestamp (Current Time)**  
```sql
CREATE TABLE orders (
    order_id SERIAL,
    order_date timestamp DEFAULT CURRENT_TIMESTAMP
);
```
- `order_date` is set to the current timestamp when a new row is inserted.  

---

### **5.2.2. Using Sequences for Default Values**  

In PostgreSQL, **sequences** generate unique values for columns like **primary keys**.  
The `nextval()` function retrieves the next value from a sequence.  

#### **Example: Using `nextval()` for Auto-Increment**  
```sql
CREATE TABLE products (
    product_no integer DEFAULT nextval('products_product_no_seq'),
    name text
);
```
- `nextval('products_product_no_seq')` ensures `product_no` gets a unique value.  

---

### **5.2.3. Using `SERIAL` for Auto-Increment**  

Since using `nextval()` manually is common, PostgreSQL provides a shorthand:  

#### **Example: Using `SERIAL`**  
```sql
CREATE TABLE products (
    product_no SERIAL,
    name text
);
```
- `SERIAL` automatically creates and links a sequence to `product_no`.  
- It is equivalent to:  
  ```sql
  CREATE SEQUENCE products_product_no_seq;
  CREATE TABLE products (
      product_no integer DEFAULT nextval('products_product_no_seq'),
      name text
  );
  ```
- This shorthand is **discussed further in Section 8.1.4**.  

---

## **5.3. Identity Columns in PostgreSQL**  

An **identity column** is an automatically generated column that provides unique values using an **implicit sequence**. It is often used for **primary keys** or unique row identifiers.

---

### **5.3.1. Creating an Identity Column**  

PostgreSQL provides two ways to define identity columns:  
1. `GENERATED ALWAYS AS IDENTITY`  
2. `GENERATED BY DEFAULT AS IDENTITY`  

#### **Example: Creating an Identity Column**
```sql
CREATE TABLE people (
    id bigint GENERATED ALWAYS AS IDENTITY,
    name text,
    address text
);
```
- The `id` column is an **identity column**, meaning PostgreSQL will automatically generate values for it.
- The **sequence starts at 1 and increments by 1** by default.

Alternatively, you can use:  
```sql
CREATE TABLE people (
    id bigint GENERATED BY DEFAULT AS IDENTITY,
    name text,
    address text
);
```
- The **difference** between `ALWAYS` and `BY DEFAULT` is explained below.

---

### **5.3.2. Inserting Data into an Identity Column**  

When inserting data into a table with an **identity column**, you do **not** need to provide a value for the identity column.  

#### **Example: Insert Without ID (Auto-generated)**
```sql
INSERT INTO people (name, address) VALUES ('A', 'foo');
INSERT INTO people (name, address) VALUES ('B', 'bar');
```
**Resulting Table Data:**
```
 id | name | address
----+------+---------
  1 | A    | foo
  2 | B    | bar
```
- **PostgreSQL automatically assigns values** to the `id` column starting from `1`.

#### **Example: Explicitly Using DEFAULT**
```sql
INSERT INTO people (id, name, address) VALUES (DEFAULT, 'C', 'baz');
```
- The `DEFAULT` keyword **requests a system-generated value**.

---

### **5.3.3. ALWAYS vs. BY DEFAULT**  

The difference between `ALWAYS` and `BY DEFAULT` is how PostgreSQL handles **user-specified values** during `INSERT` and `UPDATE`.

| Clause | Behavior |
|--------|----------|
| **ALWAYS** | PostgreSQL **always generates** an identity value. A user-specified value is **only allowed** if `OVERRIDING SYSTEM VALUE` is specified. |
| **BY DEFAULT** | PostgreSQL generates a value **only if no value is provided**. If a user specifies a value, it is **used instead**. |

#### **Example: Using `ALWAYS`**
```sql
INSERT INTO people (id, name, address) VALUES (100, 'D', 'xyz');  
-- ERROR: cannot insert into column "id"  
```
- To **override** an `ALWAYS` identity column:
```sql
INSERT INTO people (id, name, address) OVERRIDING SYSTEM VALUE VALUES (100, 'D', 'xyz');
```

#### **Example: Using `BY DEFAULT`**
```sql
INSERT INTO people (id, name, address) VALUES (200, 'E', 'abc');
```
- The **user-specified value (200) is accepted**.

---

### **5.3.4. Identity Column Constraints**  

- **Identity columns are automatically `NOT NULL`**.
- **They do NOT enforce uniqueness**—use `PRIMARY KEY` or `UNIQUE` constraints if needed.
- **You can modify an identity column's sequence** using `ALTER TABLE`.

#### **Example: Enforcing Uniqueness**
```sql
CREATE TABLE people (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text,
    address text
);
```
- The `PRIMARY KEY` constraint **ensures uniqueness**.

---

### **5.3.5. Identity Columns in Inheritance & Partitioning**  

- **Child tables do NOT inherit identity columns automatically**.
- **Partitions inherit identity columns from the parent table**, but **cannot have their own identity properties**.

---

### **5.4. Generated Columns in PostgreSQL**  

A **generated column** is a column that is **automatically computed** from other columns in the table. It is similar to how **views** work for tables but applies to individual columns.

---

### **5.4.1. Types of Generated Columns**  

There are two types of generated columns:  

| Type | Storage | Computation Time | Supported in PostgreSQL? |
|------|---------|-----------------|--------------------------|
| **Stored** | Takes up storage like a normal column | Computed **when inserted/updated** | ✅ Yes |
| **Virtual** | Occupies **no storage** | Computed **when read** | ❌ No |

- **PostgreSQL only supports stored generated columns**.

---

### **5.4.2. Creating a Generated Column**  

To create a generated column, use the `GENERATED ALWAYS AS` clause in `CREATE TABLE`.

#### **Example: Convert Height from cm to inches**
```sql
CREATE TABLE people (
    name text,
    height_cm numeric,
    height_in numeric GENERATED ALWAYS AS (height_cm / 2.54) STORED
);
```
- The column `height_in` is **automatically calculated** whenever a row is inserted or updated.
- The `STORED` keyword **must** be specified in PostgreSQL.

---

### **5.4.3. Inserting and Updating Data**  

Since generated columns are **computed automatically**, they **cannot be manually inserted or updated**.

#### **Example: Insert Data**
```sql
INSERT INTO people (name, height_cm) VALUES ('Tanvi', 160);
```
**Result:**
```
 name  | height_cm | height_in
-------+----------+-----------
 Tanvi | 160      | 62.99
```
- The `height_in` column is automatically computed.

#### **Example: Attempting to Manually Insert a Value**
```sql
INSERT INTO people (name, height_cm, height_in) VALUES ('Om', 170, 66.93);
-- ERROR: column "height_in" is a generated column
```
- Directly inserting into a **generated column** is **not allowed**.

---

### **5.4.4. Difference Between Default Values and Generated Columns**  

| Feature | Default Values | Generated Columns |
|---------|---------------|-------------------|
| Evaluated | Once at **INSERT** | **Every time** the row is updated |
| Can reference other columns? | ❌ No | ✅ Yes |
| Can use volatile functions (e.g., `random()`, `CURRENT_TIMESTAMP`)? | ✅ Yes | ❌ No |
| Can be manually overridden? | ✅ Yes | ❌ No |

#### **Example: Default vs. Generated Column**
```sql
CREATE TABLE products (
    price numeric DEFAULT 9.99,  -- Default value, can be overridden
    discount_price numeric GENERATED ALWAYS AS (price * 0.9) STORED
);
```
- `price` has a **default** of `9.99` but can be set manually.
- `discount_price` is **always 90% of `price`** and **cannot be overridden**.

---

### **5.4.5. Restrictions on Generated Columns**  

1. **Cannot be directly inserted or updated**  
   - Only `DEFAULT` can be used to reference a generated column in `INSERT`.

2. **Expression Limitations**  
   - The generation expression:
     - **Must use immutable functions** (i.e., functions that always return the same output for the same input).
     - **Cannot reference another generated column**.
     - **Cannot reference system columns** (except `tableoid`).

3. **Cannot have a Default or Identity definition**  
   - A column **cannot be both generated and have a default value**.
   - A generated column **cannot be an identity column**.

4. **Cannot be a Partition Key**  
   - A partitioned table **cannot use a generated column** as its partition key.

---

### **5.4.6. Generated Columns in Inheritance and Partitioning**  

| Case | Behavior |
|------|----------|
| **Parent column is generated** | Child column **must** also be generated. |
| **Parent column is NOT generated** | Child column **cannot** be generated. |
| **Multiple parent tables (inheritance)** | All parents must have **generated columns** with explicit generation expressions. |
| **Partitioned tables** | Partitions **inherit** generated columns from the parent. |

#### **Example: Inheritance of Generated Columns**
```sql
CREATE TABLE parent_table (
    amount numeric,
    tax numeric GENERATED ALWAYS AS (amount * 0.18) STORED
);

CREATE TABLE child_table () INHERITS (parent_table);
```
- `child_table` **inherits** `tax` as a generated column.

---

### **5.4.7. Security & Replication Considerations**  

- **Access Control:**  
  - A user **can** be given permission to read a generated column **without** permission to read the base column.

- **Triggers:**  
  - **Before triggers** run **before** a generated column is computed.
  - Generated columns **cannot be accessed in BEFORE triggers**.

- **Replication & Logical Replication:**  
  - Generated columns are **skipped** during logical replication.
  - Cannot be included in `CREATE PUBLICATION` column lists.

---

- **Generated columns** are computed **automatically** from other columns.
- **PostgreSQL only supports stored generated columns**.
- They **cannot be manually updated or inserted**.
- **Must use immutable functions** and **cannot reference other generated columns**.
- **Partitioned tables inherit generated columns, but they cannot be partition keys**.
- **They are computed after BEFORE triggers and skipped in logical replication**.

---