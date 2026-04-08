#import "experiments/common.typ": *

#let practicals = (
  ("2A", "2a"),
  ("2B", "2b"),
  ("3A", "3a"),
  ("3B", "3b"),
  ("4", "4"),
  ("5", "5"),
  ("6", "6"),
  ("7A", "7a"),
  ("7B", "7b"),
  ("8", "8"),
  ("9", "9"),
  ("10", "10"),
  ("11", "11"),
  ("12", "12"),
)

#align(center)[#text(size: 22pt, weight: "bold")[Index of Practicals]]

#v(2em)

#for item in practicals [
  #text(size: 18pt)[Practical #item.at(0) \ #v(0.05em) ]
]

#pagebreak()

#for (i, item) in practicals.enumerate() [
  #include ("experiments/practical-" + item.at(1) + ".typ")
  #if i < practicals.len() - 1 [
    #pagebreak()
  ]
]
