#let practical_title(code) = align(center)[
  #text(size: 18pt, weight: "bold")[PRACTICAL - #code]
]

#let section(label, body) = [
  #text(size: 14pt, weight: "bold")[#label:] \
  #body
]

#let terminal_box(body, fill, stroke, text_fill, width: 80%, inset: 14pt) = align(center)[
  #rect(
    width: width,
    fill: fill,
    stroke: 1pt + stroke,
    radius: 6pt,
    inset: inset,
  )[
    #align(left)[
      #set par(justify: false)
      #set text(
        fill: text_fill,
        size: 10pt,
        font: ("DejaVu Sans Mono", "Liberation Mono"),
      )
      #body
    ]
  ]
]

#let code_box(body, width: 80%) = terminal_box(
  body,
  rgb("f8fafc"),
  rgb("cbd5e1"),
  rgb("0f172a"),
  width: width,
)

#let output_box(body, width: 80%) = terminal_box(
  [
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: rgb("111827"),
        stroke: none,
        inset: (x: 10pt, y: 6pt),
        radius: (top-left: 6pt, top-right: 6pt, bottom-left: 0pt, bottom-right: 0pt),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("ef4444"))],
          [#circle(radius: 3pt, fill: rgb("f59e0b"))],
          [#circle(radius: 3pt, fill: rgb("22c55e"))],
          [],
          [#text(size: 8pt, fill: rgb("9ca3af"))[terminal]],
        )
      ],
      rect(
        width: 100%,
        fill: rgb("1f2937"),
        stroke: none,
        inset: (x: 14pt, y: 10pt),
        radius: (top-left: 0pt, top-right: 0pt, bottom-left: 6pt, bottom-right: 6pt),
      )[
        #body
      ],
    )
  ],
  rgb("1f2937"),
  rgb("4b5563"),
  white,
  width: width,
  inset: 0pt,
)
