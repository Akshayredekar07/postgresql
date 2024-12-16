
## PostgreSQL Operators


### **Equality and Comparison Operators**
| Operator   | Description                                  | Example                                                                                     |
|------------|----------------------------------------------|---------------------------------------------------------------------------------------------|
| `=`        | Equal to                                    | `SELECT * FROM cars WHERE brand = 'Volvo';`                                                |
| `<`        | Less than                                   | `SELECT * FROM cars WHERE year < 1975;`                                                    |
| `>`        | Greater than                                | `SELECT * FROM cars WHERE year > 1975;`                                                    |
| `<=`       | Less than or equal to                       | `SELECT * FROM cars WHERE year <= 1975;`                                                   |
| `>=`       | Greater than or equal to                    | `SELECT * FROM cars WHERE year >= 1975;`                                                   |
| `<>`, `!=` | Not equal to                                | `SELECT * FROM cars WHERE brand <> 'Volvo';`                                               |

---

### **Pattern Matching**
| Operator   | Description                                  | Example                                                                                     |
|------------|----------------------------------------------|---------------------------------------------------------------------------------------------|
| `LIKE`     | Case-sensitive pattern matching             | `SELECT * FROM cars WHERE model LIKE 'M%';`                                                |
| `ILIKE`    | Case-insensitive pattern matching           | `SELECT * FROM cars WHERE model ILIKE 'm%';`                                               |

**Wildcards for Pattern Matching**:
- `%` → Matches zero, one, or multiple characters.
- `_` → Matches a single character.

---

### **Logical Operators**
| Operator   | Description                                  | Example                                                                                     |
|------------|----------------------------------------------|---------------------------------------------------------------------------------------------|
| `AND`      | Logical AND                                 | `SELECT * FROM cars WHERE brand = 'Volvo' AND year = 1968;`                                 |
| `OR`       | Logical OR                                  | `SELECT * FROM cars WHERE brand = 'Volvo' OR year = 1975;`                                  |

---

### **Set Operators**
| Operator   | Description                                  | Example                                                                                     |
|------------|----------------------------------------------|---------------------------------------------------------------------------------------------|
| `IN`       | Matches any value in a list                 | `SELECT * FROM cars WHERE brand IN ('Volvo', 'Mercedes', 'Ford');`                          |
| `BETWEEN`  | Matches values within a range (inclusive)   | `SELECT * FROM cars WHERE year BETWEEN 1970 AND 1980;`                                      |

---

### **Null Operators**
| Operator         | Description                           | Example                                                                                     |
|------------------|---------------------------------------|---------------------------------------------------------------------------------------------|
| `IS NULL`        | Checks if a value is NULL            | `SELECT * FROM cars WHERE model IS NULL;`                                                  |
| `IS NOT NULL`    | Checks if a value is NOT NULL        | `SELECT * FROM cars WHERE model IS NOT NULL;`                                              |

---

### **Negation with `NOT`**
| Operator          | Description                          | Example                                                                                     |
|-------------------|--------------------------------------|---------------------------------------------------------------------------------------------|
| `NOT LIKE`        | Negates the `LIKE` operator         | `SELECT * FROM cars WHERE brand NOT LIKE 'B%';`                                            |
| `NOT ILIKE`       | Negates the `ILIKE` operator        | `SELECT * FROM cars WHERE brand NOT ILIKE 'b%';`                                           |
| `NOT IN`          | Negates the `IN` operator           | `SELECT * FROM cars WHERE brand NOT IN ('Volvo', 'Mercedes', 'Ford');`                     |
| `NOT BETWEEN`     | Negates the `BETWEEN` operator      | `SELECT * FROM cars WHERE year NOT BETWEEN 1970 AND 1980;`                                 |

---

### Key Notes
- **`BETWEEN`** includes boundary values (`from` and `to`).
- **`NOT`** negates the result of other operators like `LIKE`, `IN`, `BETWEEN`, etc.
- Pattern matching with **`LIKE`** is **case-sensitive**, while **`ILIKE`** is **case-insensitive**.
