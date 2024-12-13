
### Starting the PostgreSQL Server
```bash
sudo systemctl start postgresql
```

### Stopping the PostgreSQL Server
```bash
sudo systemctl stop postgresql
```

### Restarting the PostgreSQL Server
```bash
sudo systemctl restart postgresql
```

### Checking the Status of the PostgreSQL Server
```bash
sudo systemctl status postgresql
```

### Enabling PostgreSQL to Start at Boot
```bash
sudo systemctl enable postgresql
```

### Disabling PostgreSQL from Starting at Boot
```bash
sudo systemctl disable postgresql
```

### Checking PostgreSQL Version
```bash
psql --version
```

### Accessing the PostgreSQL Command Line Interface (CLI)
```bash
sudo -u postgres psql
```

### Exiting the PostgreSQL CLI
In the `psql` interface, type:
```sql
\q
```

---

PostgreSQL commands related to user (role) management. These commands can be run either directly in the PostgreSQL command-line interface (`psql`) or via SQL queries.


### **Create a New User**
```sql
CREATE USER username WITH PASSWORD 'password';
```

### **Grant a User Superuser Privileges**
```sql
ALTER USER username WITH SUPERUSER;
```

### **Modify a User's Password**
```sql
ALTER USER username WITH PASSWORD 'new_password';
```

### **List All Users**
In the `psql` command line:
```sql
\du
```

Or as a query:
```sql
SELECT usename FROM pg_user;
```

### **Grant Privileges to a User**
To grant access to a database:
```sql
GRANT ALL PRIVILEGES ON DATABASE database_name TO username;
```

To grant access to a specific table:
```sql
GRANT ALL PRIVILEGES ON TABLE table_name TO username;
```

### **Revoke Privileges from a User**
Revoke access from a table:
```sql
REVOKE ALL PRIVILEGES ON TABLE table_name FROM username;
```

### **Delete a User**
```sql
DROP USER username;
```

### **Check Privileges of a User**
```sql
SELECT grantee, privilege_type, table_schema, table_name
FROM information_schema.role_table_grants
WHERE grantee = 'username';
```

### **Create a User with Role-Specific Privileges**
Create a user with login privileges and database creation rights:
```sql
CREATE USER username WITH LOGIN CREATEDB;
```

---

### Additional User Management Commands

#### Switch to a Specific User in `psql`
```bash
sudo -u postgres psql -U username
```

#### Grant a User Role to Another User
```sql
GRANT role_name TO username;
```

#### Remove a Role from a User
```sql
REVOKE role_name FROM username;
```
