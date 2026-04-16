#set page(
  paper: "a4",
  margin: (x: 2.25cm, y: 2.5cm),
  background: place(
    left + top,
    rect(width: 3pt, height: 100%, fill: rgb("e2e8f0")),
  ),
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("e2e8f0"))
    #grid(
      columns: (1fr, 1fr),
      text(size: 8pt, fill: rgb("94a3b8"))[Technical Report: HAAR-CASCADE-01],
      align(right, text(size: 8pt, fill: rgb("94a3b8"))[Page #context counter(page).display()]),
    )
  ],
)

#set text(
  font: "Arcon",
  size: 10.5pt,
  fill: rgb("0f172a"),
)

#set par(justify: true, leading: 0.65em)

// --- Styling Constants ---
#let term_font = ("DejaVu Sans Mono", "Liberation Mono")
#let accent_color = rgb("4f46e5")
#let tech_gray = rgb("64748b")

// --- Components ---

#let report_header(title) = {
  v(1cm)
  text(size: 28pt, weight: "bold", fill: rgb("1e1b4b"))[#title]
  v(0.5em)
  line(length: 100%, stroke: 2pt + accent_color)
  v(1em)

  grid(
    columns: (1fr, 1fr),
    gutter: 1cm,
    [
      #stack(
        spacing: 0.6em,
        text(size: 8pt, weight: "bold", fill: tech_gray)[STUDENT IDENTIFICATION],
        text(size: 11pt, weight: "semibold")[Name: [Your Name Here]],
        text(size: 11pt, weight: "semibold")[Roll No: [Your Roll Number]],
      )
    ],
    [
      #stack(
        spacing: 0.6em,
        text(size: 8pt, weight: "bold", fill: tech_gray)[SUBMISSION DETAILS],
        text(size: 11pt, weight: "semibold")[Course: Computer Vision],
        text(size: 11pt, weight: "semibold")[Date: #datetime.today().display()],
      )
    ],
  )
  v(3em)
}

#let report_section(num, title) = {
  v(2em)
  text(size: 13pt, weight: "bold", fill: accent_color)[#num. #upper(title)]
  v(0.6em)
}

#let callout_box(title, body) = {
  v(1em)
  rect(
    width: 100%,
    fill: rgb("eff6ff"),
    stroke: (left: 3pt + rgb("3b82f6")),
    inset: 12pt,
    radius: 2pt,
  )[
    #text(size: 9pt, weight: "bold", fill: rgb("1d4ed8"))[#upper(title)] \
    #text(size: 10pt, fill: rgb("1e40af"))[#body]
  ]
  v(1em)
}

#let code_box(body, label: "implementation.py") = align(center)[
  #block(
    width: 100%,
    fill: rgb("0f172a"),
    stroke: 1pt + rgb("1e293b"),
    radius: 6pt,
    clip: true,
  )[
    #stack(
      spacing: 0pt,
      rect(
        width: 100%,
        fill: rgb("1e293b"),
        stroke: none,
        inset: (x: 10pt, y: 6pt),
      )[
        #grid(
          columns: (auto, auto, auto, 1fr, auto),
          column-gutter: 5pt,
          align: (left, center),
          [#circle(radius: 3pt, fill: rgb("ef4444"))],
          [#circle(radius: 3pt, fill: rgb("fbbf24"))],
          [#circle(radius: 3pt, fill: rgb("10b981"))],
          [],
          [#text(size: 8pt, fill: rgb("94a3b8"), font: term_font)[#label]],
        )
      ],
      rect(
        width: 100%,
        fill: rgb("0f172a"),
        stroke: none,
        inset: 14pt,
      )[
        #align(left)[
          #set par(justify: false)
          #set text(font: term_font, size: 9pt, fill: rgb("cbd5e1"))
          #body
        ]
      ],
    )
  ]
]

#let tech_table(header: (), rows: ()) = align(center)[
  #block(
    stroke: 0.5pt + rgb("e2e8f0"),
    radius: 6pt,
    fill: white,
    inset: 0pt,
    clip: true,
  )[
    #table(
      columns: (1.2fr, 2.5fr),
      fill: (x, y) => if y == 0 { rgb("f8fafc") } else { white },
      inset: 8pt,
      stroke: 0.5pt + rgb("f1f5f9"),
      ..header.map(h => text(size: 8pt, weight: "bold", fill: tech_gray, font: term_font)[#upper(h)]),
      ..rows.flatten().map(r => text(size: 9pt, fill: rgb("334155"))[#r]),
    )
  ]
]

#let figure_box(path, caption) = align(center)[
  #v(1em)
  #block(
    stroke: 1pt + rgb("e2e8f0"),
    radius: 8pt,
    clip: true,
    inset: 0pt,
  )[
    #image(path, width: 100%)
  ]
  #v(0.5em)
  #text(size: 9pt, weight: "medium", fill: tech_gray)[Fig 1.0: #caption]
  #v(1em)
]

// --- Report Content ---

#report_header("Face Detection System Synthesis")

#report_section("1", "Abstract")
This report evaluates the implementation of a real-time facial recognition pipeline utilizing the Viola-Jones framework, specifically optimized through Haar Cascade classifiers. The following sections detail the theoretical underpinnings, the algorithmic implementation in an OpenCV environment, and a critical analysis of detection accuracy in high-density crowd scenarios.

#report_section("2", "Problem Identification")
Facial detection in unconstrained environments—characterized by varying lighting, occlusions, and diverse orientations—remains a fundamental challenge in computer vision. The objective is to deploy a computationally efficient system capable of isolating facial regions of interest (ROIs) from complex backgrounds with high precision.

#report_section("3", "Theoretical Framework")
The Haar Cascade classifier functions by evaluating a series of increasingly complex features. Instead of processing raw pixel values, the algorithm utilizes *Integral Images* to compute rectangular feature sums in constant time ($O(1)$).

#tech_table(
  header: ("Haar Component", "Technical Functional Utility"),
  rows: (
    ("Integral Image", "Pre-calculates cumulative sums for extremely fast sub-window checks."),
    ("AdaBoost", "Iteratively selects the small subset of features that provide maximum classification power."),
    (
      "Cascade Architecture",
      "An ensemble of stages that rejects non-face regions nearly instantly, preserving CPU cycles.",
    ),
    ("Haar-like Features", "Edge, line, and center-surround features that map to facial anatomy (e.g. eye sockets)."),
  ),
)

#report_section("4", "Implementation Methodology")
A Python-based solution was developed using the `CascadeClassifier` module. The pipeline involves grayscale normalization to ensure intensity-based feature extraction remains invariant to chrominance noise.

#code_box(label: "vision_system.py")[
  ```python
  import cv2

  # System Initialization: Loading pre-trained weights
  cascade_engine = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

  # Acquisition and Normalization
  source_data = cv2.imread('source_sample.jpg')
  normalized_gray = cv2.cvtColor(source_data, cv2.COLOR_BGR2GRAY)

  # Invoking the multi-scale detection engine
  # Parameters: factor=1.1, neighbors=5, min_size=30x30
  detections = cascade_engine.detectMultiScale(normalized_gray, 1.1, 5, minSize=(30, 30))

  # Annotation Matrix
  for (x, y, w, h) in detections:
      cv2.rectangle(source_data, (x, y), (x + w, y + h), (0, 255, 0), 2)
      cv2.putText(source_data, "FACE_DETECTED", (x, y - 8),
                  cv2.FONT_HERSHEY_SIMPLEX, 0.45, (0, 255, 0), 2)

  cv2.imwrite('detection_output.jpg', source_data)
  ```
]

#report_section("5", "Experimental Results & Evaluation")
The system was tested on a high-density crowd image. As shown in the figure below, the classifier successfully localized faces even with significant scale variations.

#figure_box(
  "../scripts/output/practical-12-faces.jpg",
  "Experimental detection results within a crowded outdoor environment.",
)

#callout_box(
  "Technical Observation",
  "The algorithm displays exceptional performance on frontal faces but requires higher 'minNeighbors' values (5-7) to avoid false detections in textured backgrounds.",
)

#report_section("6", "Conclusion")
The Haar Cascade approach provides a robust baseline for real-time face detection due to its unmatched execution speed. While MTCNN or ResNet-based models offer higher accuracy in edge cases, the current implementation fulfills the requirements for a high-performance, low-latency identification system.
