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
    [Database Triggers],
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
    *ALA - III \ Trigger Simulation and Execution Order* \
    Using tools like MySQL Workbench or phpMyAdmin simulate the impact of triggers by creating a table, inserting data, and observing the automatic execution of their triggers. Note and explain the trigger execution order.
  ],
)

#v(1.5em)

// --- Document Content ---
= Environment Setup
\
To begin the simulation, we establish the core database tables. The `inventory` table stores our primary business data, while the `audit_log` table acts as a structured record for trigger execution events.

#styled-image(
  "assets/setup_tables.png",
  caption: [SQL implementation for table creation in phpMyAdmin environment.],
) <fig-setup>

#v(2em)

#styled-image(
  "assets/verify_tables.png",
  width: 85%,
  caption: [Verification of table structure within the database schema.],
) <fig-verification>

#pagebreak()
= Trigger Implementation
\
To observe execution order, two triggers are attached to the `inventory` table. The `BEFORE` trigger captures the intent of the transaction, while the `AFTER` trigger confirms its successful completion.

#styled-image(
  "assets/trigger_logic.png",
  caption: [Defining trigger delimiters and logic in the SQL console.],
) <fig-trigger-creation>

#v(2em)

#styled-image(
  "assets/verify_triggers.png",
  caption: [Verification of successful trigger deployment.],
) <fig-trigger-verify>

#pagebreak()
= Transactional Execution
\
To validate the trigger automation, a standard `INSERT` operation is performed on the `inventory` table.

#styled-image(
  "assets/insert_operation.png",
  caption: [Executing the test insert operation.],
) <fig-insert>

\
```sql
INSERT INTO inventory (item_name, quantity)
VALUES ('Laptop', 15);
```
\
*Observation:* Upon execution, the database engine automatically fires the triggers. A query of the `audit_log` table reveals two entries generated without manual intervention, confirming the deterministic execution of the trigger chain.

#styled-image(
  "assets/audit_logs.png",
  caption: [The audit log showing the captured BEFORE and AFTER execution states.],
) <fig-logs>

#pagebreak()

= Logic & Execution Analysis
\
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
\
= Conclusion
\
The use of database triggers provides a powerful mechanism for enforcing business rules and maintaining comprehensive audit trails. As demonstrated in this assignment, the strict ordering of `BEFORE` and `AFTER` triggers allows developers to decouple validation logic from outcome logging, ensuring data integrity across complex transactional workflows.

