#let prompt = ">>> "

#let term_font = ("DejaVu Sans Mono", "Liberation Mono")
#let color_bg_term = rgb("f8fafc")
#let color_bg_code = rgb("e2e8f0")
#let color_bg_diff = rgb("e5e7eb")
#let color_bg_out = rgb("f9fafb")

#let get_group_num(title) = (
  title.replace("A", "").replace("B", "").replace("C", "")
)

#let subheading(label) = {
  v(.8em)
  text(size: 14pt, weight: "bold")[#label]
  linebreak()
}

#let practical_title(code) = {
  let is_grouped = code.contains("A") or code.contains("B")
  if not is_grouped {
    align(center)[
      #v(.35cm)
      #text(size: 18pt, weight: "bold")[PRACTICAL - #code]
      #v(0.15cm)
    ]
    pad(x: -8mm)[
      #line(length: 100%, stroke: 0.6pt + rgb("cbd5e1"))
    ]
    v(0.8em)
  }
}

#let section(label, body) = [
  #text(size: 14pt, weight: "bold")[#label:] \
  #body
]

#let terminal_box(
  body,
  fill,
  stroke,
  text_fill,
  width: 80%,
  inset: 14pt,
) = align(center)[
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
        font: term_font,
      )
      #show raw: set text(size: 10pt, font: term_font)
      #body
    ]
  ]
]

#let code_box(body, width: 80%, label: "script") = terminal_box(
  [
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: color_bg_code,
        stroke: none,
        inset: (x: 10pt, y: 6pt),
        radius: (
          top-left: 6pt,
          top-right: 6pt,
          bottom-left: 0pt,
          bottom-right: 0pt,
        ),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("94a3b8"))],
          [#circle(radius: 3pt, fill: rgb("94a3b8"))],
          [#circle(radius: 3pt, fill: rgb("94a3b8"))],
          [],
          [#text(size: 8pt, fill: rgb("64748b"))[python]],
        )
      ],
      rect(
        width: 100%,
        fill: color_bg_term,
        stroke: none,
        inset: (x: 14pt, y: 10pt),
        radius: (
          top-left: 0pt,
          top-right: 0pt,
          bottom-left: 6pt,
          bottom-right: 6pt,
        ),
      )[
        #body
      ],
    )
  ],
  color_bg_term,
  rgb("cbd5e1"),
  rgb("0f172a"),
  width: width,
  inset: 0pt,
)

#let output_box(body, width: 80%) = terminal_box(
  [
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: color_bg_diff,
        stroke: none,
        inset: (x: 10pt, y: 6pt),
        radius: (
          top-left: 6pt,
          top-right: 6pt,
          bottom-left: 0pt,
          bottom-right: 0pt,
        ),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("ef4444"))],
          [#circle(radius: 3pt, fill: rgb("f59e0b"))],
          [#circle(radius: 3pt, fill: rgb("22c55e"))],
          [],
          [#text(size: 8pt, fill: rgb("6b7280"))[terminal]],
        )
      ],
      rect(
        width: 100%,
        fill: color_bg_out,
        stroke: none,
        inset: (x: 14pt, y: 10pt),
        radius: (
          top-left: 0pt,
          top-right: 0pt,
          bottom-left: 6pt,
          bottom-right: 6pt,
        ),
      )[
        #body
      ],
    )
  ],
  color_bg_out,
  rgb("d1d5db"),
  rgb("111827"),
  width: width,
  inset: 0pt,
)

#let output_image(path, caption: "", width: 80%) = align(center)[
  #rect(
    width: width,
    fill: white,
    stroke: 1pt + rgb("cbd5e1"),
    radius: 6pt,
    inset: 0pt,
  )[
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: rgb("f1f5f9"),
        stroke: none,
        inset: (x: 10pt, y: 6pt),
        radius: (
          top-left: 6pt,
          top-right: 6pt,
          bottom-left: 0pt,
          bottom-right: 0pt,
        ),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("3b82f6"))],
          [#circle(radius: 3pt, fill: rgb("8b5cf6"))],
          [#circle(radius: 3pt, fill: rgb("06b6d4"))],
          [],
          [#text(size: 8pt, fill: rgb("64748b"))[output]],
        )
      ],
      rect(
        width: 100%,
        fill: white,
        stroke: none,
        inset: (x: 10pt, y: 10pt),
        radius: (
          top-left: 0pt,
          top-right: 0pt,
          bottom-left: 6pt,
          bottom-right: 6pt,
        ),
      )[
        #align(center)[
          #image(path, width: 100%)
          #if caption != "" [
            #v(4pt)
            #text(size: 9pt, fill: rgb("64748b"), style: "italic")[#caption]
          ]
        ]
      ],
    )
  ]
]

#let output_grid(items, columns: 2, width: 90%) = align(center)[
  #rect(
    width: width,
    fill: white,
    stroke: 1pt + rgb("cbd5e1"),
    radius: 6pt,
    inset: 0pt,
  )[
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: rgb("f1f5f9"),
        stroke: none,
        inset: (x: 10pt, y: 6pt),
        radius: (
          top-left: 6pt,
          top-right: 6pt,
          bottom-left: 0pt,
          bottom-right: 0pt,
        ),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("3b82f6"))],
          [#circle(radius: 3pt, fill: rgb("8b5cf6"))],
          [#circle(radius: 3pt, fill: rgb("06b6d4"))],
          [],
          [#text(size: 8pt, fill: rgb("64748b"))[output]],
        )
      ],
      rect(
        width: 100%,
        fill: white,
        stroke: none,
        inset: (x: 10pt, y: 10pt),
        radius: (
          top-left: 0pt,
          top-right: 0pt,
          bottom-left: 6pt,
          bottom-right: 6pt,
        ),
      )[
        #grid(
          columns: (1fr,) * columns,
          column-gutter: 8pt,
          row-gutter: 10pt,
          ..items.map(item => [
            #align(center)[
              #image(item.at(0), width: 100%)
              #v(2pt)
              #text(size: 8pt, fill: rgb("64748b"), style: "italic")[#item.at(1)]
            ]
          ])
        )
      ],
    )
  ]
]
