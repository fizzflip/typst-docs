#import "common.typ": *

<practical-7>
#practical_title("7")

#section("Aim")[
  To implement and compare spatial domain filtering techniques—specifically Gaussian Blur, Median Blur, and Bilateral Filter—for image smoothing and noise reduction using OpenCV.
]

#v(.5em)

#section("Theory")[
  Image smoothing involves sliding a mathematical matrix (a kernel) over an image to modify pixel values based on their neighbours. \
  \
  Three key filters:
  - *Gaussian Blur:* Applies a weighted average using a normal distribution—ideal for general smoothing but smears edges.
  - *Median Blur:* Replaces the centre pixel with the median of its neighbourhood. Highly effective against outlier noise (salt-and-pepper) because extreme values are never selected as the median.
  - *Bilateral Filter:* An advanced technique that considers both spatial distance and pixel intensity similarity, enabling it to smooth flat regions while preserving sharp edges. \
  \
  The code demonstrates these filters on a textured stone wall image for clear comparison.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-7.py", [
    #raw(read("../scripts/practical-7.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.GaussianBlur()`:* Averages neighbours with Gaussian-weighted values. Kernel size must be positive and odd. `sigmaX=0` auto-calculates sigma from the kernel size. \
  - *`cv2.medianBlur()`:* Takes the literal middle value in a sorted neighbourhood, making it the best choice for salt-and-pepper noise elimination. \
  - *`cv2.bilateralFilter()`:* `d` sets the pixel neighbourhood diameter (9 is standard). `sigmaColor` and `sigmaSpace` control how far in colour and spatial distance pixels mix—higher values increase smoothing but preserve edges less aggressively.
]

#v(.5em)

#section("Output")[
  #output_grid(
    (
      ("../samples/images/stone-wall.jpg", "Original Input"),
      ("../scripts/output/practical-7-gaussian.jpg", "Gaussian Blur"),
      ("../scripts/output/practical-7-median.jpg", "Median Blur"),
      ("../scripts/output/practical-7-bilateral.jpg", "Bilateral Filter"),
    ),
    columns: 2,
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment compared three spatial domain filters. Median blur excels at removing impulse noise, Gaussian blur provides general smoothing, and bilateral filtering uniquely preserves edge sharpness while smoothing flat regions.
]
