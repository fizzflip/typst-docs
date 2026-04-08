#import "experiments/common.typ": *

#let practicals = (
  ("2A", "2a", <practical-2a>),
  ("2B", "2b", <practical-2b>),
  ("3A", "3a", <practical-3a>),
  ("3B", "3b", <practical-3b>),
  ("4", "4", <practical-4>),
  ("5", "5", <practical-5>),
  ("6", "6", <practical-6>),
  ("7A", "7a", <practical-7a>),
  ("7B", "7b", <practical-7b>),
  ("8", "8", <practical-8>),
  ("9", "9", <practical-9>),
  ("10", "10", <practical-10>),
  ("11", "11", <practical-11>),
  ("12", "12", <practical-12>),
)

#align(center)[#text(size: 22pt, weight: "bold")[Index of Practicals]]

#v(2em)

#for item in practicals [
  #let target = item.at(2)
  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: (left, right),
    [
      #text(size: 18pt)[#link(target)[Practical #item.at(0)]]
    ],
    [
      #text(size: 18pt)[#context counter(page).at(target).first() pg]
    ],
  )
  #v(0.15em)
]

#pagebreak()

#for (i, item) in practicals.enumerate() [
  #include ("experiments/practical-" + item.at(1) + ".typ")
  #if i < practicals.len() - 1 [
    #pagebreak()
  ]
]
