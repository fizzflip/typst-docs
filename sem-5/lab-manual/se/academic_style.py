import re

def update_typst_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Update font and basic page setup
    content = re.sub(
        r'#set page\(.*?\n\)',
        r'''#set page(
  paper: "a4",
  margin: (x: 2.54cm, y: 2.54cm),
  header: context {
    if here().page() > 2 {
      set text(size: 9pt, font: ("Times New Roman", "Serif"))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [Software Engineering Lab Manual (BETCE15502)],
        [#meta-data.name | #meta-data.roll_no],
      )
      v(-0.3em)
      line(length: 100%, stroke: 0.5pt)
    }
  },
  footer: context {
    if here().page() > 1 {
      set text(size: 9pt, font: ("Times New Roman", "Serif"))
      align(center)[
        #counter(page).display("1")
      ]
    }
  },
)''',
        content,
        flags=re.DOTALL
    )

    content = re.sub(
        r'#set text\(.*?size: 10pt,\n\)',
        r'''#set text(
  font: ("Times New Roman", "Serif"),
  size: 11pt,
)''',
        content,
        flags=re.DOTALL
    )

    # 2. Update heading styles
    content = re.sub(
        r'#show heading: it => block\([\s\S]*?it\.body\n  \)\n\)',
        r'''#show heading: it => block(
  inset: (top: 1em, bottom: 0.5em),
  text(weight: "bold", it)
)''',
        content
    )

    content = re.sub(
        r'#show heading\.where\(level: 1\): it => block\([\s\S]*?it\.body\)',
        r'''#show heading.where(level: 1): it => block(
  width: 100%,
  inset: (bottom: 6pt, top: 1.5em),
  text(size: 16pt, weight: "bold", it.body)
)''',
        content
    )

    # 3. UI Component Helpers Replacement
    helpers_replacement = '''// UI Component Helpers
#let badge(body, fill: none, stroke-color: none, text-color: none) = [
  #text(weight: "bold", body)
]

#let info-card(title, content, border-color: none) = [
  #v(1em)
  #block(
    width: 100%,
    inset: (left: 10pt, top: 5pt, bottom: 5pt),
    stroke: (left: 2pt + luma(100)),
    [
      #text(weight: "bold", title) \\
      #v(3pt)
      #content
    ]
  )
  #v(1em)
]

#let practical-header(num, title, unit, hrs) = [
  #v(1.5em)
  #heading(level: 1, [Practical #num])
  #v(0.5em)
  #text(size: 14pt, weight: "bold", title)
  #v(0.5em)
  #text(style: "italic", [Unit: #unit | Hours: #hrs])
  #v(1em)
]

#let custom-table(columns, ..data) = table(
  columns: columns,
  stroke: 0.5pt + luma(0),
  inset: 7pt,
  align: left + horizon,
  ..data
)'''
    
    content = re.sub(
        r'// UI Component Helpers[\s\S]*?align: left \+ horizon,\n  \.\.data\n\)',
        helpers_replacement,
        content
    )

    # 4. Cover Page update
    cover_page_replacement = '''// =============================================================================
// COVER PAGE
// =============================================================================

#align(center)[
  #v(3em)
  #text(size: 14pt, weight: "bold")[DEPARTMENT OF COMPUTER ENGINEERING]

  #v(4em)
  #text(size: 24pt, weight: "bold")[SOFTWARE ENGINEERING] \\
  #v(1em)
  #text(size: 16pt, weight: "semibold")[LABORATORY MANUAL & PRACTICAL RECORD] \\
  #v(2em)
  #text(size: 12pt)[Course Code: #meta-data.sub_code | Academic Term: #meta-data.semester (#meta-data.academic_year)]

  #v(6em)

  #align(center)[
    #text(size: 14pt, weight: "bold")[STUDENT PROFILE]
    #v(1em)
    
    #grid(
      columns: (auto, auto),
      row-gutter: 12pt,
      column-gutter: 20pt,
      align: (right, left),
      [Student Name:], [#text(weight: "bold")[#meta-data.name]],
      [Enrollment No:], [#text()[#meta-data.roll_no]],
      [Semester / Division:], [#text()[#meta-data.semester / #meta-data.section]],
      [Department:], [#text()[#meta-data.department]],
      [Subject:], [#text()[#meta-data.subject (#meta-data.sub_code)]],
      [Total Practicals:], [#text()[13 Experiments (30 Contact Hours)]],
    )
  ]

  #v(6em)
  #text(size: 10pt, style: "italic")[Comprehensive Engineering Laboratory Record • Unified ShopNex Case Study & Vector Models]
]'''

    content = re.sub(
        r'// =============================================================================\n// COVER PAGE\n// =============================================================================[\s\S]*?\]\n\n#pagebreak\(\)',
        cover_page_replacement + '\n\n#pagebreak()',
        content
    )
    
    # Optional: Fix any remaining colored badges in Bug Reports
    content = re.sub(r'#badge\(\[(.*?)\], fill:.*?\)', r'*\1*', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

update_typst_file('/home/mrbot/.temp/typst-docs/sem-5/lab-manual/se/se_lab_manual.typ')
