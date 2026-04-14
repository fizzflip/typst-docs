#import "common.typ": *

<practical-6>
#practical_title("6")

#section("Aim")[
  To segment grayscale images into binary images using global, adaptive, and Otsu's thresholding techniques, and to extract object statistics using connected component analysis.
]

#v(.5em)

#section("Theory")[
  Thresholding is a fundamental segmentation technique that converts a grayscale image to a binary (black and white) image by comparing pixel intensities against a threshold value. \
  \
  Three principal approaches:
  - *Global Thresholding:* Uses a single fixed value for the entire image.
  - *Otsu's Method:* Mathematically calculates the optimal global threshold by minimizing intra-class variance in a bimodal histogram.
  - *Adaptive Thresholding:* Calculates varying threshold values for smaller local regions, making it robust against uneven lighting and shadows. \
  \
  Connected Component Analysis (CCA) is then applied to the resulting binary image to label and quantify the distinct isolated shapes.
]

// #v(.5em)
#pagebreak()

#section("Code")[
  #code_box(width: 95%, label: "practical-6.py", [
    #raw(read("../scripts/practical-6.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.threshold()`:* Returns the threshold value used and the thresholded image. `THRESH_BINARY` sets pixels exceeding the threshold to `max_value` (255). \
  - *`cv2.THRESH_OTSU`:* An additional flag that analyses the image histogram to find the optimal threshold value that minimizes intra-class variance. \
  - *`cv2.adaptiveThreshold()`:* Examines a local window (e.g., $11 times 11$). `ADAPTIVE_THRESH_GAUSSIAN_C` uses a weighted Gaussian sum of neighbourhood values minus a constant $C$. \
  - *`cv2.connectedComponentsWithStats()`:* Groups adjacent white pixels into numbered labels with associated area, bounding box, and centroid statistics.
]

// #v(.5em)
#pagebreak()
#section("Output")[
  #output_grid(
    (
      ("../samples/images/handwritten-notes.jpg", "Original Input"),
      ("../scripts/output/practical-6-otsu.jpg", "Otsu's Threshold"),
      ("../scripts/output/practical-6-connected.jpg", "Connected Components"),
    ),
    columns: 3,
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated three thresholding strategies for image binarization. Otsu's method automates global threshold selection, while adaptive thresholding handles non-uniform illumination. CCA provides quantitative object analysis on the segmented output.
]
