### **SQL Lexical Structure – Easy Revision Notes**  

#### **SQL Input & Tokens**  
- SQL is made of **commands**, and each command ends with `;`.  
- Commands contain **tokens**, which are words or symbols SQL understands.  
- **Types of tokens**:  
  - **Keywords** → Special words like `SELECT`, `UPDATE`.  
  - **Identifiers** → Names you create for tables, columns, etc.  
  - **Constants** → Numbers, text, or values.  
  - **Operators** → Symbols like `+`, `-`, `=`, `<`, `>`.  
  - **Special characters** → Symbols like `;`, `,`, `.`.  
- **Spaces & new lines** help separate tokens, but sometimes they are not needed.  

**Example:**  
```sql
SELECT * FROM my_table;
UPDATE my_table SET age = 25;
INSERT INTO my_table VALUES (1, 'Hello');
```

---

#### **Identifiers & Keywords**  
- **Keywords** → Fixed words with special meaning (`SELECT`, `FROM`).  
- **Identifiers** → Names you choose (table names, column names).  

**Rules for Naming Identifiers:**  
✅ Must start with a **letter** or **underscore** (`_`).  
✅ Can contain **letters, numbers, `_`, and `$`** (not common).  
✅ **Max length** → 63 characters.  

**Case Sensitivity (Uppercase & Lowercase Rules):**  
- **Unquoted Names** (`my_table`) → SQL treats them as **lowercase** (`My_Table` = `my_table`).  
- **Quoted Names** (`"My_Table"`) → Case-sensitive (`"My_Table"` ≠ `"my_table"`).  
- Use **double quotes** (`"name"`) for special names (`"select"`, `"my table"`).  

---

#### **Constants (Fixed Values)**  
##### **String Values (Text)**  
- **Single quotes** → `'Hello'`, `'Data'`.  
- To use **single quote inside** → `'John''s book'`.  
- Combine multiple parts → `'Hi' 'there'` → `'Hithere'`.  

##### **Other Types of Constants**  
- **Numbers** → `42`, `3.5`, `.001`, `5e2`.  
- **Binary & Hexadecimal** → `B'1010'`, `X'1FF'`.  
- **Typed Values** → `'100'::INTEGER`, `CAST('100' AS INTEGER)`.  

---

#### **Operators (Symbols for Actions)**  
- Used in calculations & conditions:  
  - **Math** → `+ - * / % ^`.  
  - **Comparison** → `= != < > <= >=`.  
  - **Logical** → `AND`, `OR`, `NOT`.  
- **Example:**  
  ```sql
  SELECT * FROM users WHERE age > 18 AND city = 'Mumbai';
  ```  

---

#### **Special Characters**  
- `$` → Used in **variables** and **dollar-quoted strings**.  
- `()` → **Grouping expressions** (`(5 + 3) * 2`).  
- `[]` → **Array selection** (`numbers[1]`).  
- `,` → **Separates items** in a list (`(1, 'John', 25)`).  
- `;` → **Ends a command**.  
- `:` → Used in **variables** and **array slicing**.  
- `*` → **Select all columns** (`SELECT * FROM users`).  
- `.` → **Separates schema, table, or column** (`database.table.column`).  

---

#### **Comments (Ignoring Text in Code)**  
- **Single-Line** → `-- This is a comment`.  
- **Multi-Line (Block Comment)** →  
  ```sql
  /*  
     This is a comment  
     It can span multiple lines  
  */
  ```

---

#### **Operator Precedence (Order of Execution)**  
- **Some operations happen before others** (just like math).  
- Order from **highest to lowest priority**:  
  1. `.` (table.column), `::` (type conversion).  
  2. `+ -` (unary sign, like `-5`).  
  3. `^` (power), `* / %` (multiplication, division).  
  4. `+ -` (addition, subtraction).  
  5. Other operators (`BETWEEN`, `LIKE`, etc.).  
  6. `< > =` (comparisons).  
  7. `IS`, `NOT`, `AND`, `OR`.  

- **Use `()` to change order**:  
  ```sql
  SELECT (5 + 3) * 2;  -- (5+3) happens first, then multiplication
  ```  

---


## **Value Expressions**  

### **What are Value Expressions?**  
Value expressions help **calculate single values** in SQL. They are used in `SELECT`, `INSERT`, `UPDATE`, etc.  

### **Types of Value Expressions:**  
1. **Column Reference** → Using column names.  
2. **Positional Parameter** → Placeholder for dynamic values.  
3. **Subscripts** → Accessing array elements.  
4. **Field Selection** → Getting a specific field from a composite type.  
5. **Operator Invocation** → Using `+`, `-`, `*`, etc.  
6. **Function Call** → Using SQL functions like `SUM()`, `LENGTH()`.  
7. **Aggregate Expression** → `COUNT()`, `AVG()`, etc.  
8. **Window Function Call** → Ranking functions like `ROW_NUMBER()`.  
9. **Type Cast** → Changing data type (`CAST('5' AS INTEGER)`).  
10. **Collation Expression** → Setting text comparison rules.  
11. **Scalar Subquery** → `(SELECT column FROM table LIMIT 1)`.  
12. **Array Constructor** → Creating arrays (`ARRAY[1, 2, 3]`).  
13. **Row Constructor** → Creating row values (`ROW(1, 'Hello')`).  

---

### **1. Column References**  
Referring to a column directly.  


```sql
SELECT name FROM employees;
```

---

### **2. Positional Parameters**  
Used in prepared queries or functions.  


```sql
SELECT * FROM employees WHERE department = $1;
```

---

### **3. Subscripts (Array Access)**  
Access elements inside an array.  


```sql
SELECT skills[1] FROM employees;
```

---

### **4. Field Selection (Accessing Fields in a Composite Type)**  
Get a specific field from structured data.  


```sql
SELECT (address).city FROM customers;
```

---

### **5. Operator Invocation (Using Operators like `+`, `-`, `*`, `/` )**  


```sql
SELECT salary * 1.10 FROM employees; -- Increase salary by 10%
```

---

### **6. Function Calls**  
Using built-in SQL functions.  


```sql
SELECT UPPER(name) FROM employees; -- Convert name to uppercase
```

---

### **7. Aggregate Expressions**  
Perform calculations on multiple rows.  


```sql
SELECT COUNT(*) FROM employees; -- Count total employees
```

---

### **8. Window Functions**  
Operate on a set of rows **without grouping them**.  


```sql
SELECT name, salary, RANK() OVER (ORDER BY salary DESC) FROM employees;
```

---

### **9. Type Casts**  
Convert values from one type to another.  


```sql
SELECT '123'::INTEGER; -- Convert text '123' to integer
```

---

### **10. Collation Expressions (Sorting Rules for Text)**  
Change how text is compared or sorted.  


```sql
SELECT * FROM employees ORDER BY name COLLATE "C";
```

---

### **11. Scalar Subqueries**  
A subquery returning **one** value.  


```sql
SELECT name, (SELECT MAX(salary) FROM employees) FROM employees;
```

---

### **12. Array Constructors**  
Create arrays inside SQL.  


```sql
SELECT ARRAY[10, 20, 30] AS numbers;
```

---

### **13. Row Constructors**  
Create row-like structures.  

```sql
SELECT ROW(1, 'John', 'Manager');
```

---

### **Evaluation Rules**  
- SQL **does not** guarantee left-to-right execution of expressions.  
- Use `CASE` to ensure safe calculations.  

**Example (Avoid Division by Zero):**  
```sql
SELECT CASE WHEN salary > 0 THEN bonus/salary ELSE 0 END FROM employees;
```

---

### **Calling Functions in PostgreSQL**  

#### **Function Calling Methods**  
PostgreSQL allows three ways to call functions:  

| **Method** | **Description** | **Example** |
|------------|----------------|-------------|
| **Positional Notation** | Arguments must be in the order they appear in the function definition. | `SELECT my_function(10, 5);` |
| **Named Notation** | Arguments are passed by name using `=>`, allowing any order. | `SELECT my_function(a => 10, b => 5);` |
| **Mixed Notation** | Positional arguments first, named arguments after. | `SELECT my_function(10, b => 5);` |

- **Default Values**: Parameters with default values can be omitted.  
- **Named Notation Advantage**: Useful for functions with many parameters.  
- **Mixed Notation Restriction**: Named arguments cannot appear before positional ones.  

---

### **Example: Converting Temperature**  
Let's define a function to **convert temperature** between Celsius and Fahrenheit.  

#### **Step 1: Create the Function**
```sql
CREATE FUNCTION convert_temp(value numeric, to_fahrenheit boolean DEFAULT true)
RETURNS numeric
AS
$$
BEGIN
  IF to_fahrenheit THEN
    RETURN (value * 9/5) + 32;  -- Convert Celsius to Fahrenheit
  ELSE
    RETURN (value - 32) * 5/9;  -- Convert Fahrenheit to Celsius
  END IF;
END;
$$
LANGUAGE plpgsql;
```
**Function Logic:**  
- Takes **one required parameter** (`value` - the temperature).  
- Takes **one optional parameter** (`to_fahrenheit`, defaults to `true`).  
- If `to_fahrenheit = true`, it converts **Celsius → Fahrenheit**.  
- Otherwise, it converts **Fahrenheit → Celsius**.  

---

### **Step 2: Calling the Function**
#### **1. Using Positional Notation**  
```sql
SELECT convert_temp(100, true);
```
🔹 **Output:** `212` (100°C → 212°F)  

```sql
SELECT convert_temp(32, false);
```
🔹 **Output:** `0` (32°F → 0°C)  

---

#### **2. Using Named Notation**  
```sql
SELECT convert_temp(value => 100, to_fahrenheit => true);
```
🔹 **Output:** `212`  

```sql
SELECT convert_temp(to_fahrenheit => false, value => 50);
```
🔹 **Output:** `10` (50°F → 10°C)  

---

#### **3. Using Mixed Notation**  
```sql
SELECT convert_temp(0, to_fahrenheit => true);
```
🔹 **Output:** `32` (0°C → 32°F)  

```sql
SELECT convert_temp(212, to_fahrenheit => false);
```
🔹 **Output:** `100` (212°F → 100°C)  

---

### **Summary Table of Function Calls**  

| **Function Call** | **Output** | **Conversion** |
|------------------|-----------|----------------|
| `SELECT convert_temp(100, true);` | `212` | 100°C → 212°F |
| `SELECT convert_temp(32, false);` | `0` | 32°F → 0°C |
| `SELECT convert_temp(value => 50, to_fahrenheit => false);` | `10` | 50°F → 10°C |
| `SELECT convert_temp(0, to_fahrenheit => true);` | `32` | 0°C → 32°F |
| `SELECT convert_temp(212, to_fahrenheit => false);` | `100` | 212°F → 100°C |

---
