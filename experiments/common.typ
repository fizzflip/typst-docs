#let practical_title(code) = align(center)[
  #text(size: 18pt, weight: "bold")[PRACTICAL - #code]
]

#let section(label, body) = [
  #text(size: 14pt, weight: "bold")[#label:] \
  #body
]

#let code_box(body, width: 80%) = align(center)[
  #rect(width: width, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      #body
    ]
  ]
]

#let output_box(body, width: 80%) = align(center)[
  #rect(width: width, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white)[
        #body
      ]
    ]
  ]
]
