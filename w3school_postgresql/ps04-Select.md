### **PostgreSQL SELECT Statement**

The `SELECT` statement is used to retrieve data from a PostgreSQL database.

### **Select Specific Columns**
To retrieve specific columns from a table, you can specify the column names in the query.

**Syntax**:
```sql
SELECT column1, column2, ... FROM table_name;
```

**Example**:
Retrieve the customer name and country from the `customers` table:
```sql
SELECT customer_name, country FROM customers;
```

---

### **Select All Columns**
To retrieve all columns from a table, you can use the `*` wildcard.

**Syntax**:
```sql
SELECT * FROM table_name;
```

**Example**:
Retrieve all columns from the `customers` table:
```sql
SELECT * FROM customers;
```

### **PostgreSQL SELECT DISTINCT**

The `SELECT DISTINCT` statement is used to retrieve unique values from a column, eliminating duplicate entries.

---

### **Basic Syntax**
```sql
SELECT DISTINCT column_name FROM table_name;
```

---

### **Use Case: Selecting Unique Values**
If a column contains duplicate values, `SELECT DISTINCT` ensures that each value is returned only once.

**Example**: Retrieve unique values from the `country` column in the `customers` table:
```sql
SELECT DISTINCT country FROM customers;
```

---

### **Example Output**
If the `customers` table contains 91 rows but only 21 unique countries, the result will include only those 21 unique countries.

---

### **Counting Distinct Values**
You can combine `DISTINCT` with the `COUNT` function to count the number of unique values in a column.

**Syntax**:
```sql
SELECT COUNT(DISTINCT column_name) FROM table_name;
```

**Example**: Count the number of unique countries in the `customers` table:
```sql
SELECT COUNT(DISTINCT country) FROM customers;
```

---

