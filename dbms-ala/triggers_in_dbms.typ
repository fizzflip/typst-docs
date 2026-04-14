#set document(title: "MySQL Triggers Assignment", author: "Student Name")
#set page(paper: "us-letter", margin: 1in)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1.")

#align(center)[
  #text(size: 17pt, weight: "bold")[Database Systems: MySQL Triggers Assignment] \
  #v(1em)
  [Your Name/ID Here] \
  #datetime.today().display()
]

#v(2em)

= Objective
The goal of this assignment is to simulate the impact of database triggers using MySQL Workbench. We will create tables, insert data, and create `BEFORE` and `AFTER` triggers to observe and explain their automatic execution order.

= Step 1: Environment Setup
First, we create a new database, a `products` table for our main data, and an `audit_log` table to record when our triggers fire. We also insert an initial product to test against.

```sql
-- Create and use a new database
CREATE DATABASE TriggerAssignment;
USE TriggerAssignment;

-- Create a table to hold our main data
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create a table to log when our triggers fire
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trigger_type VARCHAR(50),
    action_message VARCHAR(255)
);

-- Insert initial data
INSERT INTO products (product_name, price) VALUES ('Gaming Laptop', 1500.00);
```

= Step 2: Creating the Triggers
Next, we define two triggers that activate automatically when an `UPDATE` statement is executed on the `products` table. The `DELIMITER //` command is used to ensure MySQL Workbench processes the entire trigger block correctly without stopping at the internal semicolons.

```sql
DELIMITER //

-- 1. Create the BEFORE UPDATE trigger
CREATE TRIGGER before_price_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (trigger_type, action_message)
    VALUES (
        'BEFORE UPDATE', 
        CONCAT('About to change price from $', OLD.price, ' to $', NEW.price)
    );
END //

-- 2. Create the AFTER UPDATE trigger
CREATE TRIGGER after_price_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (trigger_type, action_message)
    VALUES (
        'AFTER UPDATE', 
        CONCAT('Successfully changed price to $', NEW.price)
    );
END //

DELIMITER ;
```

= Step 3: Simulating the Impact
To cause the triggers to fire automatically, we execute an `UPDATE` statement modifying the price of the laptop we inserted earlier.

```sql
UPDATE products SET price = 1350.00 WHERE product_name = 'Gaming Laptop';
```

= Step 4: Observing the Execution Order
We query the `audit_log` table to observe the exact order in which the triggers were executed by the database engine.

```sql
SELECT trigger_type, action_message, execution_time 
FROM audit_log 
ORDER BY log_id ASC;
```

= Step 5: Explanation of Execution Order
Based on the results generated in the `audit_log` table, the execution order is as follows:

+ *The Event:* The user issues the `UPDATE` statement.
+ *BEFORE Trigger Execution:* The database intercepts the update and executes the `BEFORE UPDATE` trigger first. This phase is typically used to validate data, modify incoming values (using the `NEW` keyword), or cancel the transaction if constraints are violated.
+ *Row Modification:* Assuming the BEFORE trigger succeeds without errors, the database engine commits the actual row update to the disk.
+ *AFTER Trigger Execution:* Once the row is successfully modified, the `AFTER UPDATE` trigger fires. This is used for secondary actions that must only occur if the primary update was completely successful, such as maintaining audit logs or synchronizing data with other tables.
