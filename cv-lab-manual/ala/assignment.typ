#let rivi_assignment(
  title: "Assignment Title",
  subtitle: "Subtitle or subtitle description",
  author: "Author Name",
  student_name: "Student Name",
  ala_number: "I",
  assignment_name: "Assignment Name",
  repo_url: "https://github.com/fizzflip/rivi",
  series_title: "COMPUTER VISION",
  body,
) = {
  // --- DESIGN SYSTEM CONFIGURATION ---
  let primary-color = rgb("000000")
  let secondary-color = rgb("666666")
  let accent-color = rgb("EEEEEE")
  let code-bg = rgb("F7F9FC")

  set document(title: title, author: author)

  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 35mm, bottom: 35mm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr),
          text(8pt, font: "Inter", fill: secondary-color)[#title],
          align(right)[#text(8pt, font: "Inter", fill: secondary-color)[#student_name]],
        )
        v(-5pt)
        line(length: 100%, stroke: 0.5pt + accent-color)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 0.5pt + accent-color)
        v(5pt)
        align(center)[#text(8pt, font: "Inter", fill: secondary-color)[Page #counter(page).display("1")]]
      }
    },
  )

  set text(font: "Inter", size: 10.5pt, fill: rgb("1A1A1A"))
  set par(leading: 0.7em, justify: true)

  // Standardized, clean section numbering
  set heading(numbering: "1.1. ")

  // --- COMPONENT STYLING ---
  show heading.where(level: 1): it => block(
    width: 100%,
    stroke: (bottom: 1pt + accent-color),
    inset: (bottom: 0.5em),
    below: 1.2em,
    above: 2em,
    text(
      font: "New Computer Modern",
      fill: primary-color,
      weight: "regular",
      size: 20pt,
      it,
    ),
  )

  show heading.where(level: 2): it => block(
    below: 0.8em,
    above: 1.5em,
    text(font: "Inter", fill: primary-color, weight: "semibold", size: 12pt, it),
  )

  show raw.where(block: true): it => block(
    fill: code-bg,
    stroke: 1pt + accent-color,
    inset: 12pt,
    radius: 4pt,
    width: 100%,
    breakable: true,
    {
      set text(size: 10pt, font: "FiraCode Nerd Font Mono", fill: rgb("333333"))
      it
    },
  )

  // --- COVER PAGE ---
  page(header: none, footer: none)[
    #v(15%)
    #align(center)[
      #text(12pt, weight: "light", tracking: 2pt)[#series_title]
      #v(10pt)
      #line(length: 40%, stroke: 0.5pt + secondary-color)
      #v(20pt)
      #text(42pt, font: "New Computer Modern", weight: "regular")[#title]
      #v(0pt)
      #text(14pt, style: "italic", fill: secondary-color)[#subtitle]
      #v(40pt)

      #block(
        width: 40%,
        stroke: 0.5pt + accent-color,
        inset: 20pt,
        radius: 4pt,
        [
          #align(left)[
            #grid(
              columns: (1fr, 1.2fr),
              row-gutter: 10pt,
              text(8pt, fill: secondary-color)[NAME], text(9pt, weight: "semibold")[#student_name],
              text(8pt, fill: secondary-color)[ERN], text(9pt, weight: "semibold")[240905050085],
            )
          ]
        ],
      )
      #v(1fr)
      #if repo_url != "" [
        #block(
          inset: (bottom: 40pt),
          [
            #text(size: 7.5pt, weight: "semibold", fill: secondary-color, tracking: 1.5pt)[Live Demo at] \
            #v(2pt)
            #link(repo_url)[#text(size: 8.5pt, font: "FiraCode Nerd Font Mono", fill: primary-color)[#repo_url]]
          ],
        )
      ]
    ]
  ]
  pagebreak()
  body
}

// --- UTILITY FUNCTIONS ---

// Styled blocks for definitions
#let defblock(title, body) = block(
  fill: rgb("F7F9FC"),
  stroke: (left: 2pt + rgb("000000")),
  inset: 12pt,
  radius: 2pt,
  width: 100%,
  [
    #text(weight: "bold", size: 9pt, title) \
    #v(2pt)
    #text(size: 9.5pt, body)
  ],
)

// Diagram nodes
#let diagram_node(title, body, fill: white) = block(
  fill: fill,
  stroke: 1pt + rgb("DDDDDD"),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  align(center)[
    #text(8pt, weight: "bold", fill: black)[#title] \
    #v(2pt)
    #text(7pt, fill: rgb("666666"))[#body]
  ],
)

#show: rivi_assignment.with(
  title: "Face Detection",
  subtitle: "Implementing Haar Cascades on Dense Media",
  student_name: "Sandeep Prasad",
  ala_number: "III",
  assignment_name: "Object Detection",
  repo_url: "face-detect-demo.netlify.app",
)

= Objectives

In this practical exercise, the primary objective is to evaluate the viability of Haar Cascade classifiers when subjected to complex, high-density environments. Unlike optimal portrait conditions, dense crowds present unique challenges such as occlusions, diverse scaling, and complex background textures.

The core intent of this experiment is to construct an end-to-end Python script using OpenCV to successfully localize human faces within `dense-crowd.jpg` and document the model tuning necessary to suppress false positives. \

= Execution Pipeline

To systematically approach the problem, the image processing workflow was designed as a linear sequence of transformations and operations: \ \

#align(center)[
  #block(
    fill: white,
    stroke: 1pt + rgb("EEEEEE"),
    radius: 8pt,
    inset: 15pt,
    width: 90%,
    [
      #grid(
        columns: 1fr,
        row-gutter: 12pt,
        diagram_node("Image Ingestion", "Read and load the dense crowd image"),
        align(center)[#text(12pt)[$arrow.b$]],
        diagram_node("Preprocessing", "Resize constraint (800x500) & convert to Grayscale"),
        align(center)[#text(12pt)[$arrow.b$]],
        diagram_node(
          "Haar Cascade Evaluation",
          "detectMultiScale() via loaded FrontalFace XML Model",
          fill: rgb("F7F9FC"),
        ),
        align(center)[#text(12pt)[$arrow.b$]],
        diagram_node("Geometry Rendering", "Draw bounding boxes & text labels highlighting candidates"),
      )
    ],
  )
]

= Implementation

The following script encapsulates the pipeline described above. Modifications include standardizing the input constraints via `cv2.resize` to normalize the dense image dimensions before passing it to the cascade.
\ \
```python
import cv2
import os

os.makedirs("output", exist_ok=True)

# Initialize the Haar Frontal Face detector
face_cascade = cv2.CascadeClassifier(
    cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
)

# Ingest and sanitize input image
img = cv2.imread("../samples/images/dense-crowd.jpg")
img = cv2.resize(img, (800, 500))
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Execute detection
faces = face_cascade.detectMultiScale(
    gray, scaleFactor=1.05, minNeighbors=3, minSize=(15, 15)
)

# Apply visual boundary markers
for (x, y, w, h) in faces:
    cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)

    label = "Face"
    (text_w, text_h), baseline = cv2.getTextSize(label, cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1)
    cv2.rectangle(
        img, (x, y - text_h - 10),
        (x + text_w + 10, y), (0, 255, 0), -1
    )
    cv2.putText(img, label, (x + 5, y - 5),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)

cv2.imwrite("output/detected-faces.jpg", img)
```
#pagebreak()
= Tuning Hyperparameters

When processing dense images, default configurations often fail by marking random visual artifacts (like folds in clothes or brick textures) as faces.

\

#defblock("MinNeighbors Parameter")[
  This parameter is the most critical threshold in OpenCV's implementation. It dictates how many overlapping candidate rectangles must exist for a feature to be officially declared a "face". A higher number ensures strictness.
]
\

For `dense-crowd.jpg`, the following tuning matrix was settled on to balance the recall and precision trade-off:

#align(center)[
  #table(
    columns: (1fr, 3fr),
    fill: (x, y) => if y == 0 { rgb("F7F9FC") } else { white },
    inset: 10pt,
    stroke: 0.5pt + rgb("EEEEEE"),
    [*Argument*], [*Impact Analysis*],
    [scaleFactor (1.05)],
    [A fine 5% scaling increment ensures that dense crowds with highly variable subject proximities are exhaustively scanned.],

    [minNeighbors (3)],
    [A relaxed confidence threshold allows the cascade engine to accept candidiate bounding boxes even where features might overlap or be partially obscured.],

    [minSize (15, 15)],
    [A strict 15x15 pixel limit is essential for detecting the smallest sub-regions characteristic of distant background figures in full-view dense photography.],
  )
]
#pagebreak()
= Evaluation & Output

The resulting localization map effectively captured the prominent subjects within the crowd. However, the model's high sensitivity settings inadvertently introduced more than 2 instances of false positives, misclassifying certain background textures as faces. This clearly highlights the classic precision-recall trade-off inherent in basic cascading classifiers when processing complex, high-noise imagery. \ \

#figure(
  image("../scripts/output/practical-12-faces.jpg", width: 100%),
  caption: [Detection Output from `dense-crowd.jpg` showing bounding boxes with false positives.],
)
\ \
Despite its efficiency and rapid execution speed, the limitations of frontal-only detection are visible. Subjects angled away from the camera are reliably ignored by the engine, contrasting with the false positive misidentifications elsewhere in the unconstrained environment.
