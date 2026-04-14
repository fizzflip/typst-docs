#import "common.typ": *

<practical-5>
#practical_title("5")

#section("Aim")[
  To apply morphological operations (erosion, dilation, opening, closing) to filter binary images and use connected component analysis to count and analyze distinct objects.
]

#v(.5em)

#section("Name")[
  Morphological Operations and Connected Components
]
#v(.5em)

#section("Theory")[
  Morphological operations process images based on shape using a small matrix called a *structuring element* (kernel) to probe the image. *Erosion* shrinks foreground objects (removing small white noise), while *dilation* expands them (filling small black holes). \
  \
  Compound operations:
  - *Opening* (Erosion → Dilation): Removes noise while preserving object size.
  - *Closing* (Dilation → Erosion): Fills holes while preserving object size.
  \
  *Connected Component Analysis (CCA)* scans a binary image and groups adjacent foreground pixels into discrete, labelled objects, allowing extraction of properties like area, bounding boxes, and centroids.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-5.py", [
    #raw(read("../scripts/practical-5.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.getStructuringElement()`:* Creates the kernel. `MORPH_RECT` creates a solid rectangle; alternatives include `MORPH_ELLIPSE` and `MORPH_CROSS`. \
  - *`cv2.erode()` / `cv2.dilate()`:* Base morphological functions. The `iterations` parameter controls how many times the operation is applied consecutively. \
  - *`cv2.morphologyEx()`:* Wrapper for compound operations. `MORPH_OPEN` performs erosion then dilation; `MORPH_CLOSE` does the reverse. \
  - *`cv2.connectedComponentsWithStats()`:* Returns `num_labels` (count including background as label 0), `labels` (pixel-to-object map), `stats` (X, Y, width, height, area per object), and `centroids` (centre coordinates per object).
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated morphological filtering to clean binary images and connected component analysis to identify and quantify discrete objects—fundamental techniques for shape-based image analysis.
]
