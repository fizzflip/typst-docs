#import "common.typ": *

<practical-8>
#practical_title("8")

#section("Aim")[
  To implement and analyse edge detection techniques, primarily focusing on the Canny Edge Detector, to identify structural boundaries and feature outlines within an image.
]

#v(.5em)

#section("Theory")[
  Edge detection identifies points in an image where brightness changes sharply (high-frequency gradients). \
  \
  - *Sobel Operator:* Calculates the first derivative of pixel intensities in the X (horizontal) and Y (vertical) directions to detect vertical and horizontal edges respectively.
  - *Canny Edge Detector:* A multi-stage algorithm that:
    + Applies Gaussian blur to reduce noise.
    + Finds intensity gradients using Sobel.
    + Applies "non-maximum suppression" to thin edges to a single pixel width.
    + Uses "hysteresis thresholding" with two parameters (`min_val`, `max_val`) to link strong and weak edges while discarding noise. \
  \
  Gradients above `max_val` are guaranteed edges; below `min_val` are discarded. Values in between are kept only if connected to a sure-edge pixel.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-8.py", [
    #raw(read("../scripts/practical-8.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.Sobel()`:* Parameters `1, 0` detect vertical edges; `0, 1` detect horizontal edges. `cv2.CV_64F` depth allows negative gradient values from white-to-black transitions. \
  - *`cv2.Canny()`:* Outputs a clean binary image (black background, white edges). \
  - *Hysteresis Thresholding:* Wide thresholds (50, 150) capture both strong and weak edges; tight thresholds (200, 250) only capture very distinct edges, ignoring objects with low-contrast boundaries.
]

#v(.5em)

#section("Output")[
  #output_image("../scripts/output/practical-8-sobel.jpg", caption: "Sobel Edge Detection (Combined X + Y Gradients)")
  #v(.5em)
  #output_image("../scripts/output/practical-8-canny.jpg", caption: "Canny Edge Detection (thresholds: 50, 150)")
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated Sobel and Canny edge detection on a real-world architectural image. Canny's multi-stage pipeline produces cleaner, single-pixel-width edges, and its hysteresis thresholds allow precise tuning of detection sensitivity.
]
