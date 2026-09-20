// theme.typ: Shared styles, colors, and components for Computer Networking Study Guide

// --- Typography & Colors ---
#let crimson-main = rgb("#8B1E2F")
#let crimson-dark = rgb("#5C131F")
#let crimson-light = rgb("#FBF0F2")
#let slate-dark = rgb("#1E212D")
#let slate-muted = rgb("#5C6473")
#let warm-bg = rgb("#FAF7F2")
#let warm-border = rgb("#E8E2D8")
#let code-bg = rgb("#F3EFE9")
#let accent-gold = rgb("#C28822")
#let tag-bg = rgb("#F0ECE4")

// --- Inline Term & Badge Components ---
#let key-term(term) = {
  text(weight: "bold", fill: crimson-dark)[#term]
}

#let concept-badge(label) = {
  box(
    fill: crimson-light,
    stroke: 0.5pt + rgb("#E4B7BE"),
    radius: 3pt,
    inset: (x: 5pt, y: 2pt),
    baseline: 0%,
    text(font: ("Inter", "Liberation Sans"), size: 8pt, weight: "bold", fill: crimson-main)[#label]
  )
}

// --- Marginal Extra Topic Pill Badge ---
#let extra-pill = place(
  left,
  dx: -36pt,
  dy: 2.5pt,
  box(
    fill: crimson-light,
    stroke: 0.5pt + rgb("#E4B7BE"),
    radius: 3pt,
    inset: (x: 3.5pt, y: 1.5pt),
    text(
      font: ("Inter", "Liberation Sans"),
      size: 6.5pt,
      weight: "bold",
      fill: crimson-main,
      tracking: 0.08em,
    )[EXTRA]
  )
)

// --- Figure Card Component ---
#let figure-card(img-path, caption-text, width: 70%) = {
  figure(
    block(
      width: 100%,
      fill: warm-bg,
      stroke: 0.75pt + warm-border,
      radius: 6pt,
      inset: (x: 8pt, y: 7pt),
      align(center, image(img-path, width: width, fit: "contain"))
    ),
    caption: caption-text,
  )
}

// --- Callout Box Component ---
#let callout-box(title: none, icon-char: "✦", content) = {
  block(
    width: 100%,
    fill: warm-bg,
    stroke: (left: 3pt + crimson-main, rest: 0.5pt + warm-border),
    radius: (right: 4pt),
    inset: (x: 10pt, y: 7pt),
    above: 0.9em,
    below: 0.9em,
    breakable: false,
    stack(
      spacing: 0.4em,
      if title != none [
        #text(font: ("Inter", "Liberation Sans"), size: 9.5pt, weight: "bold", fill: crimson-main)[
          #icon-char #title
        ]
      ],
      content
    )
  )
}

// --- Formula Box Component ---
#let formula-box(title, math-expr) = {
  block(
    width: 100%,
    fill: crimson-light,
    stroke: (left: 3.5pt + crimson-main, rest: 0.5pt + rgb("#F0D6DA")),
    radius: (right: 4pt),
    inset: (x: 10pt, y: 7pt),
    above: 0.7em,
    below: 0.7em,
    breakable: false,
    stack(
      spacing: 0.4em,
      text(font: ("Inter", "Liberation Sans"), size: 9pt, weight: "bold", fill: crimson-dark)[#title],
      align(center, math-expr)
    )
  )
}

// --- Algorithm / Monospace Box Component ---
#let algorithm-box(title, code-block) = {
  block(
    width: 100%,
    fill: code-bg,
    stroke: 0.75pt + warm-border,
    radius: 4pt,
    inset: (x: 10pt, y: 8pt),
    above: 0.8em,
    below: 0.8em,
    breakable: false,
    stack(
      spacing: 0.5em,
      grid(
        columns: (1fr, auto),
        text(font: ("Inter", "Liberation Sans"), size: 9pt, weight: "bold", fill: crimson-main)[⚡ #title],
        text(font: ("Inter", "Liberation Sans"), size: 7.5pt, weight: "bold", fill: slate-muted)[ALGORITHM]
      ),
      line(length: 100%, stroke: 0.5pt + warm-border),
      code-block
    )
  )
}

// --- Unit Header Component ---
#let unit-header(unit-num, title, subtitle, checklist: ()) = {
  pagebreak(weak: true)
  block(
    width: 100%,
    fill: warm-bg,
    stroke: 1pt + warm-border,
    radius: 6pt,
    inset: (x: 16pt, y: 14pt),
    above: 1.5em,
    below: 1.5em,
    breakable: false,
    stack(
      spacing: 0.6em,
      grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        align: horizon,
        box(
          fill: crimson-main,
          radius: 3pt,
          inset: (x: 6pt, y: 3pt),
          text(fill: white, font: ("Inter", "Liberation Sans"), size: 9pt, weight: "bold")[UNIT #unit-num]
        ),
        text(size: 8.5pt, font: ("Inter", "Liberation Sans"), weight: "bold", fill: slate-muted)[SYLLABUS MODULE]
      ),
      text(size: 15pt, weight: "bold", font: ("Inter", "Liberation Sans"), fill: crimson-dark)[#title],
      text(size: 9.5pt, font: ("Libertinus Serif", "Liberation Serif"), style: "italic", fill: slate-muted)[#subtitle],
      if checklist.len() > 0 [
        #v(0.3em)
        #line(length: 100%, stroke: 0.5pt + warm-border)
        #v(0.2em)
        #text(size: 8.5pt, font: ("Inter", "Liberation Sans"), weight: "bold", fill: crimson-main)[Core Exam Concepts Covered in this Unit:]
        #v(0.1em)
        #grid(
          columns: (1fr, 1fr),
          gutter: 6pt,
          ..checklist.map(item => [
            #text(size: 8.5pt, font: ("Inter", "Liberation Sans"), fill: slate-dark)[✓ #item]
          ])
        )
      ]
    )
  )
}
