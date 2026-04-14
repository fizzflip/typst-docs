#import "common.typ": *

<practical-11>
#practical_title("11")

#section("Aim")[
  To implement the GrabCut algorithm for interactive foreground-background segmentation and extract objects from real-world scenes.
]

#v(.5em)

#section("Theory")[
  GrabCut is an advanced segmentation technique that treats an image as a graph. It requires an initial user-defined bounding box to identify the "probable foreground." \
  \
  The algorithm uses Gaussian Mixture Models (GMMs) to model the colour distributions of the foreground and background. It then iteratively refines the segmentation by minimizing an energy function using graph cuts, effectively finding the most likely boundary between the object and the background. \
  \
  The resulting mask contains four states: Definite Background (0), Definite Foreground (1), Probable Background (2), and Probable Foreground (3), enabling fine-grained segmentation control.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-11.py", [
    #raw(read("../scripts/practical-11.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.grabCut()`:* Core function that takes the image, internal GMM models, and a bounding box. It modifies the `mask` in-place. The `iterCount` parameter (5) balances precision versus speed. \
  - *`cv2.GC_INIT_WITH_RECT`:* Tells the algorithm to initialise segmentation from a rectangular bounding box. \
  - *Mask Processing:* Values 0 and 2 (Definite/Probable Background) map to 0; values 1 and 3 (Definite/Probable Foreground) map to 1, creating a clean binary alpha mask. \
  - *`np.newaxis`:* Aligns the 2D mask (H×W) with the 3D image (H×W×C) for element-wise multiplication, zeroing out background pixels.
]

#v(.5em)

#section("Output")[
  #output_grid(
    (
      ("../samples/images/gray-catbird.jpg", "Original Input"),
      ("../scripts/output/practical-11-grabcut.jpg", "GrabCut Segmentation"),
    ),
    columns: 2,
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated GrabCut for interactive image segmentation. The algorithm's GMM-based iterative refinement, initialised by a bounding box, effectively separates foreground objects from complex real-world backgrounds.
]
