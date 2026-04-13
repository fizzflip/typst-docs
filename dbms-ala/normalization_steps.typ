#set page(paper: "a4", margin: 1in)
#set text(font: "Magnisa Sans", size: 11pt)

#import "@preview/fletcher:0.5.6" as fletcher: diagram, edge, node

// Helpers for Key formatting
#let pk(t) = strong([#t (PK)])
#let fk(t) = emph([#t (FK)])
#let pkfk(t) = strong(emph([#t (PK/FK)]))

// DB Card component using Fletcher node compatibility
#let db-entity(name, ..fields) = {
  let content = fields.pos().join([\ ])
  block(
    stroke: 1pt + rgb("#37474f"),
    radius: 4pt,
    clip: true,
    width: 150pt, // Fixed width for consistent diagram layout
    stack(
      dir: ttb,
      block(fill: rgb("#eceff1"), width: 100%, inset: 8pt, stroke: (bottom: 1pt + rgb("#37474f")), [*#name*]),
      block(fill: white, width: 100%, inset: 8pt, align(left, content)),
    ),
  )
}

#align(center)[
  #text(size: 20pt, weight: "bold", [Database Normalization])  #v(0.5em)
  #text(size: 12pt, [Entity-Relationship diagrams powered by `fletcher`])
]
#v(1.5em)


== 1. Unnormalized Form (UNF) & First Normal Form (1NF)
*Action:* Flatten the repeating item lists to ensure atomic values.

#v(0.5em)
#align(center)[
  #diagram(
    spacing: 30pt,
    node(
      (0, 0),
      db-entity("Orders_UNF", "Order_ID", "Order_Date", "Customer_ID", "Customer_Name", "Items_List (Repeating)"),
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
*Action:* Remove partial dependencies.
Here we begin to see true relational design. Fletcher allows us to easily map the *1-to-many (`1..n`)* relationships using connected nodes and labeled arrows (`-|>`).

#v(0.5em)
#align(center)[
  #diagram(
    spacing: 40pt,
    node((0, 0), db-entity("Order", pk("Order_ID"), "Order_Date", "Customer_ID", "Customer_Name"), name: <order>),
    node((2, 0), db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"), name: <order_item>),
    node((4, 0), db-entity("Item", pk("Item_ID"), "Item_Name", "Price"), name: <item>),

    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]),
  )
]

#v(1.5em)
== 3. Third Normal Form (3NF)
*Action:* Remove transitive dependencies.
`Customer` gets its own table. Fletcher routes everything cleanly onto a 2D coordinate plane.

#v(0.5em)
#align(center)[
  #diagram(
    spacing: 50pt,
    node((0, 0), db-entity("Customer", pk("Customer_ID"), "Customer_Name"), name: <customer>),
    node((2, 0), db-entity("Order", pk("Order_ID"), "Order_Date", fk("Customer_ID")), name: <order>),
    node((4, 0), db-entity("Order_Item", pkfk("Order_ID"), pkfk("Item_ID"), "Quantity"), name: <order_item>),
    node((4, 1), db-entity("Item", pk("Item_ID"), "Item_Name", "Price"), name: <item>),

    edge(<customer>, <order>, "-|>", label: [1..n]),
    edge(<order>, <order_item>, "-|>", label: [1..n]),
    edge(<item>, <order_item>, "-|>", label: [1..n]), // Fletcher automatically routes this upwards!
  )
]
