#import "common.typ": *

<practical-1>
#practical_title("1")

#section("Aim")[
  To perform fundamental image manipulation techniques—including reading, writing, cropping, resizing, and bitwise operations—using the OpenCV library.
]

#v(.5em)

#section("Name")[
  Basic Image Processing Operations
]
#v(.5em)

#section("Theory")[
  Basic image processing serves as the preprocessing pipeline for almost all Computer Vision tasks. Images in OpenCV are represented as multidimensional NumPy arrays. Operations like cropping and resizing normalize image data for algorithms, while bitwise operations allow for pixel-level logical combinations, which are essential for masking and filtering specific regions of interest. \
  \
  Key operations include:
  - *Reading/Writing:* `cv2.imread()` loads images as BGR arrays; `cv2.imwrite()` saves them.
  - *Resizing:* `cv2.resize()` changes spatial dimensions to a target `(width, height)`.
  - *Cropping:* Achieved via NumPy array slicing: `image[y1:y2, x1:x2]`.
  - *Bitwise Operations:* `cv2.bitwise_and` applies masks to extract regions; `cv2.bitwise_not` inverts pixel colours.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-1.py", [
    #raw(read("../scripts/practical-1.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.imread()` / `cv2.imwrite()`:* Standard I/O functions. By default, `imread` loads images in BGR (Blue, Green, Red) colour space rather than standard RGB. \
  - *`cv2.resize()`:* Takes the source image and a tuple defining the new `(width, height)`. Can also resize by scaling factors using `fx` and `fy` parameters. \
  - *Cropping `img[y1:y2, x1:x2]`:* OpenCV doesn't have a dedicated crop function—images are NumPy arrays, so cropping is just height (Y-axis) and width (X-axis) slicing. \
  - *Bitwise Operations:* `bitwise_and` is highly useful for applying masks to extract specific parts of an image. `bitwise_not` creates a colour negative.
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated fundamental image I/O and manipulation operations using OpenCV. Reading, resizing, cropping, and bitwise masking form the essential preprocessing toolkit for all subsequent computer vision tasks.
]
