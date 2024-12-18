## LIKE

The `LIKE` operator is used in a `WHERE` clause to search for a specified pattern in a column.

### Wildcards Used with LIKE

1. `%` - The percent sign represents zero, one, or multiple characters.
2. `_` - The underscore sign represents one single character.

---

### Starts With

To return records that start with a specific letter or phrase, add `%` at the end of the letter or phrase.

**Example: Return all customers with a name that starts with the letter 'A':**

```sql
SELECT * FROM customers
WHERE customer_name LIKE 'A%';
```

---

### Contains

To return records that contain a specific letter or phrase, add `%` both before and after the letter or phrase.

**Example: Return all customers with a name that contains the letter 'A':**

```sql
SELECT * FROM customers
WHERE customer_name LIKE '%A%';
```


---

## IN

The `IN` operator allows you to specify a list of possible values in the `WHERE` clause. It is a shorthand for multiple `OR` conditions.

### Example

**Return all customers from 'Germany', 'France', or 'UK':**

```sql
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');
```

---

## NOT IN

By using the `NOT` keyword in front of the `IN` operator, you can return all records that are NOT any of the values in the list.

### Example

**Return all customers that are NOT from 'Germany', 'France', or 'UK':**

```sql
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');
```

---

## IN with SELECT

You can use a `SELECT` statement inside the parentheses to return all records that match the result of the `SELECT` query.

### Example

**Return all customers that have an order in the `orders` table:**

```sql
SELECT * FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);
```

---

## NOT IN with SELECT

To find records that do NOT match the result of the `SELECT` query, use `NOT IN`.

### Example

**Return all customers that have NOT placed any orders in the `orders` table:**

```sql
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);
```
