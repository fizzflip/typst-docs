#import "common.typ": *

<practical-9>
#practical_title("9")

#section("Aim")[
  To implement and differentiate between geometric image transformations—specifically Affine and Perspective (Homography) transformations—using OpenCV to warp and align images.
]

#v(.5em)

#section("Name")[
  Geometric Transformations and Image Alignment
]
#v(.5em)

#section("Theory")[
  Geometric transformations change the spatial arrangement of pixels in an image. \
  \
  - *Affine Transformations* require 3 corresponding points between source and destination images. They calculate a $2 times 3$ transformation matrix that preserves collinearity (straight lines stay straight) and parallelism (parallel lines stay parallel). Used for rotation, scaling, translation, and shearing.
  - *Perspective Transformations (Homography)* require 4 corresponding points. They calculate a $3 times 3$ transformation matrix that preserves collinearity but _not_ parallelism. Essential for 3D-to-2D projection corrections—e.g., warping a tilted document scan to appear perfectly flat.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-9.py", [
    #raw(read("../scripts/practical-9.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`np.float32()`:* OpenCV's transformation calculators strictly require 32-bit floating-point NumPy arrays for coordinate points. \
  - *`cv2.getAffineTransform()`:* Solves for the $2 times 3$ matrix $M$ from 3 source and 3 destination points. \
  - *`cv2.warpAffine()`:* Applies $M$ to every pixel, mapping them to new locations in the destination canvas. \
  - *`cv2.getPerspectiveTransform()`:* Calculates a $3 times 3$ matrix using 4 points, accounting for depth/Z-axis scaling. \
  - *`cv2.warpPerspective()`:* Applies the perspective matrix, enabling trapezoidal warps from rectangular inputs.
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated both affine and perspective transformations. Affine preserves parallelism and is suited for simple spatial transformations, while perspective (homography) enables full projective correction using four-point correspondence.
]
