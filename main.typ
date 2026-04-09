#import "experiments/common.typ": *

#set page(
  paper: "a4",
  margin: (top: 1.6cm, bottom: 1.8cm),
)

#let practicals = (
  ("1", "1", <practical-1>),
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
#v(4em)
#align(center)[#text(size: 22pt, weight: "bold")[Index of Practicals]]
#v(1.5em)

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

#counter(page).update(1)
#set page(
  margin: (top: 3.0cm, bottom: 1.8cm),
  background: [
    #place(top + center, dy: 2.1cm)[
      #box(
        width: 86%,
        height: 100% - 2.6cm,
        inset: 0pt,
        radius: 8pt,
        stroke: 1.1pt + rgb("94a3b8"),
        fill: none,
      )[]
    ]
    #place(top + center, dy: 2.35cm)[
      #box(
        width: 83.8%,
        height: 100% - 3.1cm,
        inset: 0pt,
        radius: 6pt,
        stroke: 0.6pt + rgb("cbd5e1"),
        fill: none,
      )[]
    ]
  ],
  header: [
    #text(size: 9pt)[
      #grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 1em,
        align: (left, center, right),
        [Rahul P Jani], [xxxxxxxxxxxxx], [Operating Systems],
      )
    ]
    #v(-0.1em)
    #line(length: 100%, stroke: 0.5pt + luma(180))
  ],
  footer: [
    #context align(center)[#text(size: 9pt)[Page #counter(page).display()]]
  ],
)

#for (i, item) in practicals.enumerate() [
  #include ("experiments/practical-" + item.at(1) + ".typ")
  #if i < practicals.len() - 1 [
    #pagebreak()
  ]
]
