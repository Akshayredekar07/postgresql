
## PostgreSQL MIN and MAX Functions  
_`MIN`_ 

The MIN() function returns the smallest value of the selected column.  

Example  
Return the lowest price in the products table:  

```sql
SELECT MIN(price)  
FROM products;
```

_`MAX`_ 
The MAX() function returns the largest value of the selected column.  

Example  
Return the highest price in the products table:  

```sql
SELECT MAX(price)  
FROM products;
```

**`Set Column Name  `**
When you use `MIN()` or `MAX()`, the returned column will be named min or max by default. To give the column a new name, use the AS keyword.  

Example  
Return the lowest price, and name the column lowest_price:  

```sql
SELECT MIN(price) AS lowest_price  
FROM products;
```
