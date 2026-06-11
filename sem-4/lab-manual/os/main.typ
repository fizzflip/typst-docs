#import "experiments/common.typ": *
#let meta = json("../../misc/metadata.json")

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

#for (i, item) in practicals.enumerate() [
  #let title = item.at(0)
  #let target = item.at(2)
  #let group_num = get_group_num(title)

  #let prev_title = if i > 0 { practicals.at(i - 1).at(0) } else { "" }
  #let prev_group = get_group_num(prev_title)

  #if group_num != prev_group [
    #grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      align: (left, right),
      [
        #text(size: 18pt)[#link(target)[Practical #group_num]]
      ],
      [
        #text(size: 18pt)[#context counter(page).at(target).first() pg]
      ],
    )
    #v(0.15em)
  ]
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
    #text(size: 9pt, font: ("DejaVu Sans Mono", "Liberation Mono"))[
      #grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 1em,
        align: (left, center, right),
        [#meta.name], [#meta.roll_no], [Operating System],
      )
    ]
    #v(0.25em)
    #line(length: 100%, stroke: 0.5pt + luma(180))
  ],
  footer: [
    #context align(center)[#text(size: 9pt)[Page #counter(page).display()]]
  ],
)

#for (i, item) in practicals.enumerate() [
  #let title = item.at(0)
  #let is_grouped = title.contains("A") or title.contains("B")
  #let group_num = get_group_num(title)

  #let prev_title = if i > 0 { practicals.at(i - 1).at(0) } else { "" }
  #let prev_group = get_group_num(prev_title)

  #if is_grouped and group_num != prev_group [
    #v(0.35cm)
    #align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - #group_num]]
    #v(0.15cm)
  ]

  #if is_grouped [
    #let part_label = if title.contains("A") { "I" } else if title.contains(
      "B",
    ) { "II" } else if title.contains("C") {
      "III"
    } else { "" }
    #pad(x: -8mm)[
      #grid(
        columns: (1fr, auto, 1fr),
        align: (horizon, center, horizon),
        column-gutter: 1em,
        line(length: 100%, stroke: 0.6pt + rgb("cbd5e1")),
        text(weight: "bold", size: 13pt, fill: rgb("64748b"))[ #part_label ],
        line(length: 100%, stroke: 0.6pt + rgb("cbd5e1")),
      )
    ]
    #v(0.8em)
  ]

  #include ("experiments/practical-" + item.at(1) + ".typ")

  #let next_title = if i < practicals.len() - 1 {
    practicals.at(i + 1).at(0)
  } else { "" }
  #let next_group = get_group_num(next_title)

  #if i < practicals.len() - 1 [
    #if is_grouped and group_num == next_group [
      #v(3em)
    ] else [
      #pagebreak()
    ]
  ]
]
