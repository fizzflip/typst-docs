#let practical_title(code) = align(center)[
  #text(size: 18pt, weight: "bold")[PRACTICAL - #code]
]

#let section(label, body) = [
  #text(size: 14pt, weight: "bold")[#label:] \
  #body
]

#let terminal_box(body, fill, stroke, text_fill, width: 80%) = align(center)[
  #rect(
    width: width,
    fill: fill,
    stroke: 1pt + stroke,
    radius: 6pt,
    inset: 14pt,
  )[
    #align(left)[
      #set par(justify: false)
      #text(
        fill: text_fill,
        size: 10pt,
        font: ("DejaVu Sans Mono", "Liberation Mono"),
      )[
        #body
      ]
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
  body,
  rgb("1f2937"),
  rgb("4b5563"),
  white,
  width: width,
)
