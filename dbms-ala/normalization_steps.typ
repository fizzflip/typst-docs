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
    width: 100pt, // Further reduced width to prevent page overflow
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


== 1. Unnormalized Form (UNF) & First Normal Form (1NF)
*Action:* Flatten repeating item lists to ensure atomic values.

#box(fill: rgb("#fdf2f8"), inset: 8pt, radius: 4pt, stroke: 0.5pt + rgb("#fbcfe8"))[
  #set text(size: 9pt, fill: rgb("#9d174d"))
  *Dependency Test:* Identify non-atomic attributes (repeating groups). In `Orders_UNF`, the `Items_List` violates 1NF by containing multiple values per cell.
]

#v(1em)
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
        "Items_List (Repeating)",
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

#v(1.5em)
== 2. Second Normal Form (2NF)
*Action:* Remove partial dependencies (attributes dependent on only part of a composite PK).

#box(fill: rgb("#eff6ff"), inset: 8pt, radius: 4pt, stroke: 0.5pt + rgb("#bfdbfe"))[
  #set text(size: 9pt, fill: rgb("#1e40af"))
  *Dependency Test:* In 1NF, `Price` and `Item_Name` only depend on `Item_ID`, not the whole primary key (`Order_ID`, `Item_ID`). This is a *Partial Dependency*.
]

#v(1em)
#align(center)[
  #diagram(
    spacing: 55pt,
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
      db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"),
      name: <order_item>,
    ),
    node(
      (4, 0),
      db-entity("Item", pk("Item_ID"), "Item_Name", "Price"),
      name: <item>,
    ),

    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]),
  )
]

#v(1.5em)
== 3. Third Normal Form (3NF)
*Action:* Remove transitive dependencies (non-key attributes dependent on other non-key attributes).

#box(fill: rgb("#f0fdf4"), inset: 8pt, radius: 4pt, stroke: 0.5pt + rgb("#bbf7d0"))[
  #set text(size: 9pt, fill: rgb("#166534"))
  *Dependency Test:* In 2NF, `Customer_Name` depends on `Customer_ID`, which is not the PK of the `Order` table. This is a *Transitive Dependency*.
]

#v(1em)
#align(center)[
  #diagram(
    spacing: 55pt,
    node(
      (0, 0),
      db-entity("Customer", pk("Customer_ID"), "Customer_Name"),
      name: <customer>,
    ),
    node(
      (2, 0),
      db-entity("Order", pk("Order_ID"), "Order_Date", fk("Customer_ID")),
      name: <order>,
    ),
    node(
      (4, 0),
      db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"),
      name: <order_item>,
    ),
    node(
      (4, 1),
      db-entity("Item", pk("Item_ID"), "Item_Name", "Price"),
      name: <item>,
    ),

    edge(<customer>, <order>, "-|>", label: [1..n]),
    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]), // Fletcher automatically routes this upwards!
  )
]
