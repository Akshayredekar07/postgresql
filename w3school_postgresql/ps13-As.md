
## **PostgreSQL AS**

**Aliases**  
SQL aliases are used to give a table, or a column in a table, a temporary name.  
Aliases are often used to make column names more readable.  
An alias only exists for the duration of that query.  
An alias is created with the AS keyword.

**Example**  
Using aliases for columns:

```sql
SELECT customer_id AS id
FROM customers;
```

**AS is Optional**  
Actually, you can skip the AS keyword and get the same result:

**Example**  
Same result without AS:

```sql
SELECT customer_id id
FROM customers;
```

**Concatenate Columns**  
The AS keyword is often used when two or more fields are concatenated into one.  
To concatenate two fields use `||`.

**Example**  
Concatenate two fields and call them product:

```sql
SELECT product_name || unit AS product
FROM products;
```
