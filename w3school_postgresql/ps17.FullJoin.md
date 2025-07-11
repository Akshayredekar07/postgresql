
### **PostgreSQL FULL JOIN**

#### **FULL JOIN**

The **FULL JOIN** keyword selects **ALL** records from both tables, whether or not there is a match. For rows with a match, values from both tables are included; for rows without a match, the empty fields are assigned **NULL**.

---

#### **Case Study: Indian Online Learning Platform**

This case study involves two tables: `learners` (left table) and `courses` (right table). The `learners` table stores details of learners enrolled in courses, and the `courses` table stores course information.

Some learners are enrolled in courses that don’t exist in the `courses` table, and some courses have no enrolled learners, making this a challenging scenario for FULL JOIN.

> **Note**:
> Some `course_id` values in `learners` (e.g., `704`, `705`, `706`) do not match any `course_id` in the `courses` table, and some courses (e.g., `course_id 707`) have no enrolled learners.

---

#### **SQL Commands**

##### **Create `learners` Table**

```sql
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    learner_name VARCHAR(50),
    email VARCHAR(50),
    course_id INT,
    enrollment_date DATE
);
```

##### **Insert Data into `learners`**

```sql
INSERT INTO learners VALUES
(1, 'Aditi Sharma', 'aditi@example.com', 701, '2023-02-01'),
(2, 'Rohan Gupta', 'rohan@example.com', 702, '2023-02-03'),
(3, 'Sanjay Patel', 'sanjay@example.com', 703, '2023-02-05'),
(4, 'Neha Verma', 'neha@example.com', 704, '2023-02-07'),
(5, 'Kunal Jain', 'kunal@example.com', 705, '2023-02-10'),
(6, 'Priya Singh', 'priya@example.com', 702, '2023-02-12'),
(7, 'Vikram Rao', 'vikram@example.com', 706, '2023-02-15');
```

##### **Create `courses` Table**

```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50),
    duration_weeks INT
);
```

##### **Insert Data into `courses`**

```sql
INSERT INTO courses VALUES
(701, 'Python Programming', 'Dr. Anil Kumar', 8),
(702, 'Data Science', 'Prof. Meera Desai', 12),
(703, 'Web Development', 'Mr. Rajesh Nair', 10),
(707, 'Machine Learning', 'Dr. Sunita Reddy', 14);
```

---

#### **FULL JOIN Query**

Join `learners` to `courses` using the `course_id` column:

```sql
SELECT learner_id, learner_name, course_name, instructor
FROM learners
FULL JOIN courses ON learners.course_id = courses.course_id;
```

---

#### **Result**

| learner\_id | learner\_name | course\_name       | instructor        |
| ----------- | ------------- | ------------------ | ----------------- |
| 1           | Aditi Sharma  | Python Programming | Dr. Anil Kumar    |
| 2           | Rohan Gupta   | Data Science       | Prof. Meera Desai |
| 6           | Priya Singh   | Data Science       | Prof. Meera Desai |
| 3           | Sanjay Patel  | Web Development    | Mr. Rajesh Nair   |
| 4           | Neha Verma    | NULL               | NULL              |
| 5           | Kunal Jain    | NULL               | NULL              |
| 7           | Vikram Rao    | NULL               | NULL              |
| NULL        | NULL          | Machine Learning   | Dr. Sunita Reddy  |

> **(8 rows)**

---

#### **Explanation**

**Matched Rows:**

* `course_id = 701`: Matches **Aditi Sharma** with **Python Programming**.
* `course_id = 702`: Matches **Rohan Gupta** and **Priya Singh** with **Data Science** (2 rows).
* `course_id = 703`: Matches **Sanjay Patel** with **Web Development**.

**Unmatched Learners:**

* `course_id = 704`, `705`, `706` (learners: **Neha Verma**, **Kunal Jain**, **Vikram Rao**) have **no matching courses**, so `course_name` and `instructor` are **NULL**.

**Unmatched Courses:**

* `course_id = 707` (**Machine Learning**) has **no enrolled learners**, so `learner_id` and `learner_name` are **NULL**.

**Total Rows:**

* **7 learners** + **1 unmatched course** = **8 rows**

> ✅ **Note**:
> `FULL JOIN` and `FULL OUTER JOIN` produce the **same result**. `OUTER` is the default join type for FULL JOIN.


---

## Case Study: University Course Management System

We have the following **four related tables**:

1. **students**
2. **enrollments**
3. **courses**
4. **instructors**

### 🔗 Relationships:

* Each **student** may be enrolled in **0 or more courses** (`enrollments.student_id → students.student_id`)
* Each **course** may have **0 or more enrollments** (`enrollments.course_id → courses.course_id`)
* Each **course** has **one instructor** (`courses.instructor_id → instructors.instructor_id`)

---

## 🔧 Table Structures and Sample Data

### 1. **students**

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    email VARCHAR(100),
    major VARCHAR(50),
    year INT
);

INSERT INTO students VALUES
(1, 'Alice Johnson', 'alice@univ.com', 'Computer Science', 2),
(2, 'Bob Smith', 'bob@univ.com', 'Mathematics', 3),
(3, 'Carol Lee', 'carol@univ.com', 'Physics', 1),
(4, 'David Miller', 'david@univ.com', 'Biology', 4);
```

---

### 2. **courses**

```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    semester VARCHAR(10),
    instructor_id INT
);

INSERT INTO courses VALUES
(101, 'Database Systems', 4, 'Spring', 9001),
(102, 'Calculus II', 3, 'Fall', 9002),
(103, 'Genetics', 4, 'Spring', 9003),
(104, 'Quantum Mechanics', 4, 'Fall', 9004);
```

---

### 3. **instructors**

```sql
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100),
    department VARCHAR(100),
    email VARCHAR(100),
    office VARCHAR(20)
);

INSERT INTO instructors VALUES
(9001, 'Dr. Neha Reddy', 'Computer Science', 'neha@univ.com', 'CS-201'),
(9002, 'Dr. Arjun Rao', 'Mathematics', 'arjun@univ.com', 'MATH-110'),
(9003, 'Dr. Priya Mehta', 'Biology', 'priya@univ.com', 'BIO-305'),
(9005, 'Dr. Kiran Das', 'Chemistry', 'kiran@univ.com', 'CHEM-101'); -- Note: Unmatched instructor
```

---

### 4. **enrollments**

```sql
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO enrollments VALUES
(1, 1, 101, '2023-01-15', 'A'),
(2, 2, 102, '2023-01-16', 'B'),
(3, 3, 104, '2023-01-18', 'C'),
(4, 1, 102, '2023-01-19', 'B');
```

---

## 🔍 FULL JOIN Example

We will perform a **multi-level FULL JOIN** across these 4 tables:

```sql
SELECT 
    s.student_name,
    s.major,
    c.course_name,
    c.semester,
    i.instructor_name,
    e.grade
FROM students s
FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id
FULL JOIN instructors i ON c.instructor_id = i.instructor_id;
```

---

## 🧾 Result Explanation

| student\_name | major            | course\_name      | semester | instructor\_name | grade |
| ------------- | ---------------- | ----------------- | -------- | ---------------- | ----- |
| Alice Johnson | Computer Science | Database Systems  | Spring   | Dr. Neha Reddy   | A     |
| Bob Smith     | Mathematics      | Calculus II       | Fall     | Dr. Arjun Rao    | B     |
| Carol Lee     | Physics          | Quantum Mechanics | Fall     | Dr. Kiran Das    | C     |
| Alice Johnson | Computer Science | Calculus II       | Fall     | Dr. Arjun Rao    | B     |
| David Miller  | Biology          | NULL              | NULL     | NULL             | NULL  |
| NULL          | NULL             | Genetics          | Spring   | Dr. Priya Mehta  | NULL  |
| NULL          | NULL             | NULL              | NULL     | Dr. Kiran Das    | NULL  |

---

## ✅ Summary

* 🎓 **Matched Rows**:

  * Students enrolled in existing courses taught by instructors.
* ❌ **Unmatched Rows**:

  * Student **David Miller** has no enrollment.
  * Course **Genetics** has no enrolled students.
  * Instructor **Dr. Kiran Das** is not assigned to any course in the `courses` table.

