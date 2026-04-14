#set page(
  paper: "a4",
  margin: (x: 0.8in, y: 0.8in),
  numbering: "1",
  number-align: center,
)
#set text(font: "Magnisa Sans", size: 10.5pt)
#set par(justify: true)
#set heading(numbering: "1.")

#import "@preview/fletcher:0.5.6" as fletcher: diagram, edge, node
#let meta = json("metadata.json")

#let styled-image(path, width: 90%, caption: none) = {
  figure(
    block(
      radius: 6pt,
      stroke: 0.5pt + rgb("#cbd5e1"),
      clip: true,
      image(path, width: 100%),
    ),
    caption: caption,
  )
}

#align(center)[
  #text(
    size: 24pt,
    weight: "bold",
    fill: rgb("#1e293b"),
    [Database Triggers Assignment],
  ) #v(0.2em)
  #text(
    size: 13pt,
    fill: rgb("#64748b"),
    [#meta.name \ #meta.roll_no],
  )
]

#v(1em)

#block(
  fill: rgb("#f8fafc"),
  inset: 16pt,
  radius: 8pt,
  stroke: 1pt + rgb("#e2e8f0"),
  [
    #set text(size: 10pt, fill: rgb("#334155"))
    #set par(leading: 0.65em)
    *ALA - II \ Simulation and Execution Order* \
    This document outlines the process of simulating database triggers using MySQL. The objective is to create an inventory table, insert data, and observe the automatic execution of both `BEFORE` and `AFTER` triggers by tracking their activity in an audit log. Finally, it notes and explains the execution order of these database triggers.
  ],
)

#v(1.5em)

// --- Document Content ---
= Phase 1: Environment Setup
To begin the simulation, we establish the core database tables. The `inventory` table stores our primary business data, while the `audit_log` table acts as a structured record for trigger execution events.

#styled-image(
  "Screenshot-2026-04-15 00-13-25.png",
  caption: [SQL implementation for table creation in phpMyAdmin environment.],
) <fig-setup>


```sql
-- Create the main inventory table
CREATE TABLE inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    quantity INT
);

-- Create a table to log the trigger actions
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_description VARCHAR(255),
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#styled-image(
  "Screenshot-2026-04-15 00-15-03.png",
  width: 85%,
  caption: [Verification of table structure within the database schema.],
) <fig-verification>

= Phase 2: Trigger Implementation
To observe execution order, two triggers are attached to the `inventory` table. The `BEFORE` trigger captures the intent of the transaction, while the `AFTER` trigger confirms its successful completion.

#styled-image(
  "Screenshot-2026-04-15 00-15-47.png",
  caption: [Defining trigger delimiters and logic in the SQL console.],
) <fig-trigger-creation>

```sql
DELIMITER //

-- Trigger 1: Runs BEFORE the insert happens
CREATE TRIGGER before_item_insert
BEFORE INSERT ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action_description)
    VALUES (CONCAT('BEFORE TRIGGER: Attempting to insert item: ', NEW.item_name));
END //

-- Trigger 2: Runs AFTER the insert happens
CREATE TRIGGER after_item_insert
AFTER INSERT ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action_description)
    VALUES (CONCAT('AFTER TRIGGER: Successfully inserted item: ', NEW.item_name, ' with quantity ', NEW.quantity));
END //

DELIMITER ;
```

#styled-image(
  "Screenshot-2026-04-15 00-17-23.png",
  caption: [Verification of successful trigger deployment.],
) <fig-trigger-verify>


= Phase 3: Transactional Execution
To validate the trigger automation, a standard `INSERT` operation is performed on the `inventory` table.

#styled-image(
  "Screenshot-2026-04-15 00-17-55.png",
  caption: [Executing the test insert operation.],
) <fig-insert>

```sql
INSERT INTO inventory (item_name, quantity)
VALUES ('Laptop', 15);
```

*Observation:* Upon execution, the database engine automatically fires the triggers. A query of the `audit_log` table reveals two entries generated without manual intervention, confirming the deterministic execution of the trigger chain.

#styled-image(
  "Screenshot-2026-04-15 00-18-26.png",
  caption: [The audit log showing the captured BEFORE and AFTER execution states.],
) <fig-logs>


= Phase 4: Logic & Execution Analysis
Based on the simulation results, the execution order of triggers during a Data Manipulation Language (DML) event is structured and immutable.

#v(1em)
#align(center)[
  #diagram(
    spacing: (90pt, 60pt),
    node-stroke: 1pt + rgb("#37474f"),
    node-fill: white,
    edge-stroke: 1.2pt + rgb("#64748b"),

    node((0, 0), [User Request], name: <req>, fill: rgb("#f1f5f9")),
    node((1, 0), [BEFORE Trigger], name: <bt>, stroke: rgb("#2563eb")),
    node((2, 0), text(weight: "bold")[Primary Operation], name: <op>),
    node((2, 1), [AFTER Trigger], name: <at>, stroke: rgb("#059669")),
    node((1, 1), [Execution Completion], name: <end>, fill: rgb("#f1f5f9")),

    edge(<req>, <bt>, "-|>", label: text(size: 9pt)[Intercept], label-pos: 0.5),
    edge(<bt>, <op>, "-|>", label: text(size: 9pt)[Valid Transaction], label-pos: 0.5),
    edge(<op>, <at>, "-|>", label: text(size: 9pt)[Success], label-side: right, label-pos: 0.5),
    edge(<at>, <end>, "-|>", label: text(size: 9pt)[Audit Log Updated], label-pos: 0.5),
  )
]
#v(1em)

The execution flow involves the following distinct stages:

+ *The Intercept (BEFORE):* The RDBMS intercepts the DML request. This phase is critical for data validation or normalization (modifying the `NEW` record) before the physical write. If the `BEFORE` trigger fails, the entire transaction is rolled back.
+ *The Nucleus (Primary Operation):* If the pre-validation passes, the database engine executes the actual `INSERT`, `UPDATE`, or `DELETE`.
+ *The Confirmation (AFTER):* Immediately following a successful nucleus operation, the `AFTER` trigger fires. This is the optimal location for logging (as seen in @fig-logs) or updating dependent aggregate tables, as success is guaranteed.

= Conclusion
The use of database triggers provides a powerful mechanism for enforcing business rules and maintaining comprehensive audit trails. As demonstrated in this assignment, the strict ordering of `BEFORE` and `AFTER` triggers allows developers to decouple validation logic from outcome logging, ensuring data integrity across complex transactional workflows.

