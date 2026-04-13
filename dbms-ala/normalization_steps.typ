#set page(paper: "a4", margin: 1in)
#set text(font: "Magnisa Sans", size: 11pt)

#import "@preview/fletcher:0.5.6" as fletcher: diagram, edge, node

// Helpers for Key formatting
#let pk(t) = text(fill: rgb("#2563eb"), strong([#t (PK)]))
#let fk(t) = text(fill: rgb("#059669"), emph([#t (FK)]))
#let pkfk(t) = text(fill: rgb("#7c3aed"), strong(emph([#t (PK/FK)])))

// DB Card component using Fletcher node compatibility
#let db-entity(name, ..fields) = {
  let content = fields.pos().join([\ ])
  block(
    stroke: 1pt + rgb("#37474f"),
    radius: 4pt,
    clip: true,
    width: 100pt,
    stack(
      dir: ttb,
      block(
        fill: rgb("#f1f5f9"),
        width: 100%,
        inset: 8pt,
        stroke: (bottom: 1pt + rgb("#cbd5e1")),
        [*#name*],
      ),
      block(fill: white, width: 100%, inset: 8pt, align(left, content)),
    ),
  )
}

#align(center)[
  #text(size: 24pt, weight: "bold", fill: rgb("#1e293b"), [Database Normalization]) #v(0.2em)
  #text(size: 13pt, fill: rgb("#64748b"), [Interactive Exercise: Visualizing Schema Evolution])
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
    *Interactive Digital Tools Activity* \
    In this activity, students utilize digital design tools to experiment with creating normalized tables. By visualizing transformation steps, we can test *Functional Dependencies* and observe how normalization structurally resolves redundancy and potential anomalies.
  ],
)

#v(1.5em)

== 1. First Normal Form (1NF): Flattening for Atomicity

The journey begins with the *Unnormalized Form (UNF)*. In real-world scenarios, data often arrives in nested formats where a single cell contains multiple values.

*The Problem:* *Repeating Groups.*
In our `Orders_UNF` table, the `Items_List` attribute is a multi-valued field. This makes searching for a specific item nearly impossible and leads to storage inefficiencies.

#box(fill: rgb("#fdf2f8"), inset: 10pt, radius: 4pt, stroke: 0.5pt + rgb("#fbcfe8"))[
  #set text(size: 9.5pt, fill: rgb("#9d174d"))
  *Anomaly Test (Update):* If we need to change the name of "Item A" and it appears inside twenty different `Items_List` strings, we risk missing some updates, leading to inconsistent data.
]

#v(0.8em)

#align(center)[
  #diagram(
    spacing: 55pt,
    node(
      (0, 0),
      db-entity(
        "Orders_UNF",
        "Order_ID",
        "Order_Date",
        "Customer_ID",
        "Customer_Name",
        "Items_List",
      ),
      name: <unf>,
    ),
    node(
      (2, 0),
      db-entity(
        "Orders_1NF",
        pk("Order_ID"),
        pk("Item_ID"),
        "Order_Date",
        "Customer_ID",
        "Customer_Name",
        "Item_Name",
        "Quantity",
        "Price",
      ),
      name: <1nf>,
    ),
    edge(<unf>, <1nf>, "=>", label: "Flatten", stroke: 1.5pt + gray),
  )
]

#pagebreak()
== 2. Second Normal Form (2NF): Eliminating Partial Dependencies

While 1NF ensures atomic data, it often introduces massive redundancy. Every time a customer places an order with multiple items, their name and the order date are repeated for every row.

*The Problem:* *Partial Functional Dependency.*
Attributes like `Order_Date` and `Customer_Name` depend solely on `Order_ID`. They do *not* depend on `Item_ID`. Since the PK is composite, these attributes are only *partially* dependent on the PK.

#box(fill: rgb("#eff6ff"), inset: 10pt, radius: 4pt, stroke: 0.5pt + rgb("#bfdbfe"))[
  #set text(size: 9.5pt, fill: rgb("#1e40af"))
  *Anomaly Test (Insertion):* We cannot record a new `Item` (with its `Item_Name` and `Price`) until someone actually orders it. This is because we would need an `Order_ID` to create the row.
]

#v(3em)

#align(center)[
  #diagram(
    spacing: (70pt, 50pt),
    node(
      (0, 0),
      db-entity(
        "Order",
        pk("Order_ID"),
        "Order_Date",
        "Customer_ID",
        "Customer_Name",
      ),
      name: <order>,
    ),
    node(
      (2, 0),
      db-entity("Item", pk("Item_ID"), "Item_Name", "Price"),
      name: <item>,
    ),
    node(
      (1, 1),
      db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"),
      name: <order_item>,
    ),

    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]),
  )
]
#pagebreak()

== 3. Third Normal Form (3NF): Resolving Transitive Dependencies

Our schema is much cleaner, but one logical flaw remains in the `Order` table. `Customer_Name` depends on `Customer_ID`, and `Customer_ID` depends on `Order_ID`.

*The Problem:* *Transitive Dependency.*
A transitive dependency occurs when a non-key attribute (`Customer_Name`) depends on another non-key attribute (`Customer_ID`) rather than the Primary Key directly.

#box(fill: rgb("#f0fdf4"), inset: 10pt, radius: 4pt, stroke: 0.5pt + rgb("#bbf7d0"))[
  #set text(size: 9.5pt, fill: rgb("#166534"))
  *Anomaly Test (Deletion):* If we delete our only order for "Customer X," we lose the customer's name and details entirely from our database. Data shouldn't vanish just because a transaction is cancelled!
]

#v(0.8em)

#align(center)[
  #diagram(
    spacing: (70pt, 50pt),
    node(
      (0, 0),
      db-entity("Customer", pk("Customer_ID"), "Customer_Name"),
      name: <customer>,
    ),
    node(
      (0, 1),
      db-entity("Order", pk("Order_ID"), "Order_Date", fk("Customer_ID")),
      name: <order>,
    ),
    node(
      (2, 1),
      db-entity("Item", pk("Item_ID"), "Item_Name", "Price"),
      name: <item>,
    ),
    node(
      (1, 2),
      db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"),
      name: <order_item>,
    ),

    edge(<customer>, <order>, "-|>", label: [1..n]),
    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]),
  )
]

#v(1em)

*Final Schema Summary:* The database is now fully normalized into four distinct tables: Customer, Order, Item, and Order_Item. This structure ensures long-term data integrity and minimal redundancy.
