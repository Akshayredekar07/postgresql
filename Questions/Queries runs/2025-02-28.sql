
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE DEFAULT CURRENT_DATE
);


INSERT INTO employees (name, age, department, salary)
VALUES
    ('Alice Johnson', 30, 'HR', 55000.00),
    ('Bob Smith', 25, 'IT', 62000.50),
    ('Charlie Brown', 40, 'Finance', 75000.75);


select * from employees;
