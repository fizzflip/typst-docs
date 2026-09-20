#set document(
  title: "Computer Networking Study Guide · Semester 5 Revision Handbook",
  author: "Computer Science Revision Series",
  date: auto,
)

#import "theme.typ": *

// --- Page & Geometry Setup ---
#set page(
  paper: "a4",
  margin: (x: 2.2cm, top: 2.5cm, bottom: 2.5cm),
  header: context {
    if here().page() > 1 [
      #grid(
        columns: (1fr, auto),
        align(left)[#text(size: 8.5pt, fill: slate-muted, font: ("Inter", "Liberation Sans"), weight: "medium")[Computer Networking Study Guide]],
        align(right)[#text(size: 8.5pt, fill: crimson-main, font: ("Inter", "Liberation Sans"), weight: "bold")[Semester 5 Revision Handbook]],
      )
      #v(-0.4em)
      #line(length: 100%, stroke: 0.5pt + warm-border)
    ]
  },
  footer: context {
    let page-count = counter(page).final().at(0)
    let current-page = here().page()
    align(center)[
      #text(size: 8.5pt, fill: slate-muted, font: ("Inter", "Liberation Sans"))[
        #text(fill: crimson-main, weight: "bold")[#current-page] / #page-count
      ]
    ]
  }
)

#set text(
  font: ("Libertinus Serif", "Linux Libertine O", "Liberation Serif"),
  size: 10pt,
  fill: slate-dark,
  lang: "en",
)

#show raw: set text(font: ("FiraCode Nerd Font", "DejaVu Sans Mono"), size: 8.5pt)

#set par(
  justify: true,
  leading: 0.72em,
)

#set list(
  spacing: 0.65em,
  indent: 0.5em,
)

// --- Headings Styling ---
#show heading: set text(font: ("Inter", "Liberation Sans"), fill: crimson-main)

#show heading.where(level: 1): it => block(
  width: 100%,
  breakable: false,
  above: 2.0em,
  below: 0.9em,
  stack(
    spacing: 0.5em,
    text(size: 13pt, weight: "bold", fill: crimson-main, it.body),
    line(length: 100%, stroke: 1.2pt + crimson-main),
  )
)

#show heading.where(level: 2): it => block(
  above: 1.3em,
  below: 0.5em,
  text(size: 10.5pt, weight: "bold", fill: crimson-dark, it.body)
)

#show heading.where(level: 3): it => block(
  above: 1.0em,
  below: 0.3em,
  text(size: 9.5pt, weight: "bold", fill: slate-dark, it.body)
)

// --- Figure Styling ---
#show figure.caption: it => [
  #v(0.3em)
  #text(size: 8.5pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[
    #text(weight: "bold", fill: crimson-main)[#it.supplement #context it.counter.display(it.numbering)]: #it.body
  ]
]

// ==========================================
// FRONT MATTER: BANNER & TABLE OF CONTENTS
// ==========================================

#block(
  width: 100%,
  fill: warm-bg,
  stroke: 1pt + warm-border,
  radius: 8pt,
  inset: (x: 20pt, top: 18pt, bottom: 18pt),
  below: 1.5em,
  stack(
    spacing: 0.8em,
    [
      #text(font: ("Inter", "Liberation Sans"), size: 8.5pt, weight: "bold", fill: crimson-main, tracking: 0.15em)[
        COMPUTER SCIENCE & ENGINEERING · SEMESTER 5 REVISION
      ]
    ],
    [
      #text(font: ("Inter", "Liberation Sans"), size: 21pt, weight: "bold", fill: crimson-dark)[
        Computer Networking Study Guide
      ]
    ],
    [
      #text(size: 10.5pt, style: "italic", fill: slate-muted)[
        A Comprehensive Examination & Revision Handbook Grounded in Top-Down Network Architecture
      ]
    ],
    v(0.3em),
    line(length: 100%, stroke: 0.75pt + warm-border),
    v(0.2em),
    grid(
      columns: (1fr, 1fr, 1fr, 1fr),
      align: (left, center, center, right),
      text(size: 8pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[*Syllabus:* 5 Units],
      text(size: 8pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[*Topics:* 31 Sections],
      text(size: 8pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[*Diagrams:* 17 High-Res],
      text(size: 8pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[*Model:* TCP/IP & OSI],
    )
  )
)

#block(
  width: 100%,
  stroke: 0.5pt + warm-border,
  radius: 6pt,
  inset: 14pt,
  below: 2em,
  [
    #grid(
      columns: (1fr, auto),
      align: horizon,
      text(font: ("Inter", "Liberation Sans"), size: 12pt, weight: "bold", fill: crimson-main)[Table of Contents],
      text(size: 8pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[
        #box(fill: crimson-light, stroke: 0.5pt + rgb("#E4B7BE"), radius: 2.5pt, inset: (x: 3pt, y: 1pt), text(font: ("Inter", "Liberation Sans"), size: 6pt, weight: "bold", fill: crimson-main)[EXTRA]) in margin = Expanded Curriculum Topics
      ]
    )
    #v(0.4em)
    #outline(
      title: none,
      indent: 1.2em,
      depth: 1,
    )
  ]
)

// ==========================================
// SYLLABUS UNITS 1 THROUGH 5
// ==========================================

#include "unit1.typ"
#include "unit2.typ"
#include "unit3.typ"
#include "unit4.typ"
#include "unit5.typ"

// ==========================================
// CONCLUDING REMARKS
// ==========================================

#v(1.5em)
#align(center)[
  #block(
    width: 70%,
    stroke: (top: 0.75pt + warm-border),
    inset: (top: 8pt),
    text(size: 8.5pt, font: ("Inter", "Liberation Sans"), fill: slate-muted)[
      *End of Computer Networking Revision Handbook* · Semester 5 Comprehensive Syllabus Grounding
    ]
  )
]
