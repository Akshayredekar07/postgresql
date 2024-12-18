
## PostgreSQL COUNT Function

### COUNT

The `COUNT()` function returns the number of rows that match a specified criterion.

- If the specified criterion is a column name, the `COUNT()` function returns the number of rows where that column is not `NULL`.

### Example

**Return the number of customers from the `customers` table:**

```sql
SELECT COUNT(customer_id)
FROM customers;
```

*Note: `NULL` values are not counted.*

### Using `WHERE` Clause

By specifying a `WHERE` clause, you can filter the rows to count only those that meet the condition. For example, return the number of customers that come from London.

### Example

**Return the number of customers from London:**

```sql
SELECT COUNT(customer_id)
FROM customers
WHERE city = 'London';
```
