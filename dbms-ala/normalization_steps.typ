#set page(paper: "a4", margin: (x: 0.8in, y: 0.8in))
#set text(font: "Magnisa Sans", size: 10.5pt)

#import "@preview/fletcher:0.5.6" as fletcher: diagram, edge, node

// Helpers for Key formatting
#let pk(t) = text(fill: rgb("#2563eb"), strong([#t (PK)]))
#let fk(t) = text(fill: rgb("#059669"), emph([#t (FK)]))
#let pkfk(t) = text(fill: rgb("#7c3aed"), strong(emph([#t (PK/FK)])))

// DB Card component
#let db-entity(name, ..fields) = {
  let content = fields.pos().join([\ ])
  block(
    stroke: 1pt + rgb("#37474f"),
    radius: 4pt,
    clip: true,
    width: 95pt,
    stack(
      dir: ttb,
      block(
        fill: rgb("#f1f5f9"),
        width: 100%,
        inset: 6pt,
        stroke: (bottom: 1pt + rgb("#cbd5e1")),
        [*#name*],
      ),
      block(fill: white, width: 100%, inset: 6pt, align(left, content)),
    ),
  )
}

// DB Table helper
#let db-table(title, columns, ..data) = {
  box(width: 100%)[
    #text(weight: "bold", fill: rgb("#334155"), size: 10pt)[Table: #title]
    #v(0.2em)
    #table(
      columns: columns,
      fill: (x, y) => if y == 0 { rgb("#f1f5f9") } else { white },
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 6pt,
      align: left,
      ..data.pos().map(it => text(size: 9pt, it))
    )
  ]
}

#align(center)[
  #text(
    size: 24pt,
    weight: "bold",
    fill: rgb("#1e293b"),
    [Database Normalization],
  ) #v(0.2em)
  #text(
    size: 13pt,
    fill: rgb("#64748b"),
    [Interactive Exercise: Visualizing Schema Evolution],
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
    *ALA - II \ Interactive Digital Tools* \
    In this activity, students utilize digital design tools to experiment with creating normalized tables. By visualizing transformation steps, we can test functional dependencies and observe how normalization structurally resolves redundancy and potential anomalies. \
    *Tools*: dbdesigner.net, erd.dbdesigner.net
  ],
)

#v(1.5em)

// --- Page 1: 1NF ---
== 1. First Normal Form (1NF): Flattening for Atomicity

Normalization begins by addressing the *Unnormalized Form (UNF)*. In this state, data contains attributes with multiple values (repeating groups), representing a non-relational structure.
#v(1em)

#db-table(
  "Orders_UNF",
  (1fr, 1.2fr, 1fr, 1.5fr, 2fr),
  [*ID*],
  [*Date*],
  [*Cust_ID*],
  [*Customer*],
  [*Items (Repeating)*],
  [101],
  [2024-04-10],
  [C01],
  [Alice Smith],
  [Laptop (1), Mouse (2)],
  [102],
  [2024-04-11],
  [C02],
  [Bob Johnson],
  [Keyboard (1)],
  [103],
  [2024-04-11],
  [C01],
  [Alice Smith],
  [Monitor (1), HDMI (1)],
)
#v(1em)

*The Problem:* *Repeating Groups.*
Attributes like `Items_List` make simple queries (e.g., "Find all customers who bought a Mouse") extremely difficult and slow.

#box(
  fill: rgb("#fdf2f8"),
  inset: 10pt,
  radius: 4pt,
  stroke: 0.5pt + rgb("#fbcfe8"),
)[
  #set text(size: 9.5pt, fill: rgb("#9d174d"))
  *Anomaly Test (Update):* If Alice Smith moves and changes her name, we must find every row she appears in and update the string. In UNF, this is prone to errors.
]
#v(1em)

#align(center)[
  #diagram(
    spacing: 50pt,
    node(
      (0, 0),
      db-entity("Orders_UNF", "Order_ID", "..", "Items_List"),
      name: <unf>,
    ),
    node(
      (2, 0),
      db-entity("Orders_1NF", pk("Order_ID"), pk("Item_ID"), "..", "Item_Name"),
      name: <1nf>,
    ),
    edge(<unf>, <1nf>, "=>", label: "Flatten", stroke: 1.2pt + gray),
  )
]

#v(1em)


#db-table(
  "Orders_1NF",
  (0.6fr, 0.6fr, 1.2fr, 1.5fr, 1.5fr, 0.6fr),
  [*OID*],
  [*IID*],
  [*Date*],
  [*Customer*],
  [*Item Name*],
  [*Qty*],
  [101],
  [P01],
  [2024-04-10],
  [Alice Smith],
  [Laptop],
  [1],
  [101],
  [P02],
  [2024-04-10],
  [Alice Smith],
  [Mouse],
  [2],
  [102],
  [P03],
  [2024-04-11],
  [Bob Johnson],
  [Keyboard],
  [1],
  [103],
  [P04],
  [2024-04-11],
  [Alice Smith],
  [Monitor],
  [1],
)

#pagebreak()

// --- Page 2: 2NF ---
== 2. Second Normal Form (2NF): Eliminating Partial Dependencies

In 1NF, every row is unique, but data is redundant. Notice how `Alice Smith` and the date `2024-04-10` are repeated unnecessarily.

*The Problem:* *Partial Functional Dependency.*
Attributes like `Order_Date` depend only on `Order_ID`, not the whole composite key (`Order_ID`, `Item_ID`).

#box(
  fill: rgb("#eff6ff"),
  inset: 10pt,
  radius: 4pt,
  stroke: 0.5pt + rgb("#bfdbfe"),
)[
  #set text(size: 9.5pt, fill: rgb("#1e40af"))
  *Anomaly Test (Insertion):* We cannot store information about a new "Webcam" (Item Name and Price) unless someone actually orders it, because we would need an `Order_ID` to create the row.
]

#v(1em)
#align(center)[
  #diagram(
    spacing: (65pt, 45pt),
    node(
      (0, 0),
      db-entity("Order", pk("Order_ID"), "Order_Date", "Cust_Name"),
      name: <order>,
    ),
    node(
      (2, 0),
      db-entity("Item", pk("Item_ID"), "Item_Name", "Price"),
      name: <item>,
    ),
    node(
      (1, 1),
      db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Qty"),
      name: <oi>,
    ),
    edge(<order>, <oi>, "-|>", label: [1..n]),
    edge(<item>, <oi>, "-|>", label: [1..n]),
  )
]
#v(2em)

#db-table(
  "Table: Items (2NF)",
  (0.8fr, 2fr, 0.8fr),
  [*Item_ID*],
  [*Item_Name*],
  [*Price*],
  [P01],
  [Laptop],
  [\$1200],
  [P02],
  [Mouse],
  [\$25],
  [P03],
  [Keyboard],
  [\$45],
  [P04],
  [Monitor],
  [\$300],
)
#v(1em)
#db-table(
  "Table: Orders (2NF - Preliminary)",
  (0.8fr, 1.2fr, 1.5fr),
  [*Order_ID*],
  [*Order_Date*],
  [*Customer_Name*],
  [101],
  [2024-04-10],
  [Alice Smith],
  [102],
  [2024-04-11],
  [Bob Johnson],
  [103],
  [2024-04-11],
  [Alice Smith],
)

#pagebreak()

// --- Page 3: 3NF ---
== 3. Third Normal Form (3NF): Resolving Transitive Dependencies

The final step addresses *Transitive Dependencies*. In our `Orders` table, `Customer_Name` depends on `Customer_ID`, and `Customer_ID` depends on `Order_ID`.

#box(
  fill: rgb("#f0fdf4"),
  inset: 10pt,
  radius: 4pt,
  stroke: 0.5pt + rgb("#bbf7d0"),
)[
  #set text(size: 9.5pt, fill: rgb("#166534"))
  *Anomaly Test (Deletion):* If we delete Alice's only order (103), we lose the fact that Alice Smith exists in our system. Her customer data is transitively tied to the order.
]

#v(1em)
#align(center)[
  #diagram(
    spacing: (65pt, 45pt),
    node(
      (0, 0),
      db-entity("Customer", pk("Customer_ID"), "C_Name"),
      name: <cust>,
    ),
    node(
      (0, 1),
      db-entity("Order", pk("Order_ID"), "Date", fk("Cust_ID")),
      name: <ord>,
    ),
    node(
      (2, 1),
      db-entity("Item", pk("Item_ID"), "I_Name", "Price"),
      name: <item>,
    ),
    node(
      (1, 2),
      db-entity("Order_Item", pkfk("OID"), pkfk("IID"), "Qty"),
      name: <oi>,
    ),
    edge(<cust>, <ord>, "-|>", label: [1..n]),
    edge(<ord>, <oi>, "-|>", label: [1..n]),
    edge(<item>, <oi>, "-|>", label: [1..n]),
  )
]

#v(3em)
#grid(
  columns: (1fr, 1fr),
  gutter: 15pt,
  db-table(
    "Customer",
    (0.8fr, 2fr),
    [*CID*],
    [*Name*],
    [C01],
    [Alice Smith],
    [C02],
    [Bob Johnson],
  ),
  db-table(
    "Order",
    (0.8fr, 1.2fr, 0.8fr),
    [*OID*],
    [*Date*],
    [*CID*],
    [101],
    [2024-04-10],
    [C01],
    [102],
    [2024-04-11],
    [C02],
    [103],
    [2024-04-11],
    [C01],
  ),
)
#v(0.5em)
#grid(
  columns: (1.2fr, 1fr),
  gutter: 15pt,
  db-table(
    "Item",
    (0.8fr, 1.5fr, 0.8fr),
    [*IID*],
    [*Name*],
    [*Price*],
    [P01],
    [Laptop],
    [\$1200],
    [P02],
    [Mouse],
    [\$25],
    [P03],
    [Keyboard],
    [\$45],
  ),
  db-table(
    "Order_Item",
    (0.7fr, 0.7fr, 0.6fr),
    [*OID*],
    [*IID*],
    [*Qty*],
    [101],
    [P01],
    [1],
    [101],
    [P02],
    [2],
    [102],
    [P03],
    [1],
  ),
)

#v(0.5em)
*Final Schema Summary:* The data is now fully normalized into four distinct, logically isolated tables. This ensures maximum integrity, minimal storage waste, and a professional relational architecture.
