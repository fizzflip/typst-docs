#import "common.typ": *

<practical-12>
#practical_title("12")

#section("Aim")[
  To implement a basic real-time face detection system using pre-trained Haar Cascade classifiers and a live video feed using OpenCV.
]

#v(.5em)

#section("Theory")[
  Haar Cascade classifiers use machine learning to train an object detection function based on positive (faces) and negative (non-faces) images. Instead of using complex deep learning models, Haar cascades extract simple "Haar features" (comparing sums of pixels in adjacent rectangular regions) by sliding a window across the image. \
  \
  Performance optimizations:
  - *Integral Image:* Pre-computes cumulative sums for extremely fast rectangular region calculations.
  - *Cascade Structure:* A series of classification stages that immediately discard non-face regions at early stages, dramatically reducing computation.
  - *Multi-Scale Detection:* `detectMultiScale` progressively shrinks the image by `scaleFactor` on each pass to find faces of varying sizes. \
  \
  The `minNeighbors` parameter acts as a confidence threshold—requiring multiple overlapping detections at the same location before confirming a face.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-12.py", [
    #raw(read("../scripts/practical-12.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.CascadeClassifier()`:* Loads the `.xml` file containing trained weights. `cv2.data.haarcascades` points to OpenCV's pre-trained models directory. \
  - *`cv2.cvtColor(frame, COLOR_BGR2GRAY)`:* Conversion to grayscale is mandatory—Haar features evaluate pixel intensity differences, not colour. \
  - *`detectMultiScale()` parameters:*
    - `scaleFactor=1.1`: Image reduced by 10% at each scale. Smaller steps improve detection but slow processing.
    - `minNeighbors=5`: Requires at least 5 overlapping detections to confirm a face—primary defence against false positives.
    - `minSize=(30, 30)`: Ignores potential faces smaller than $30 times 30$ pixels.
]

#v(.5em)

#section("Output")[
  #output_grid(
    (
      ("../samples/images/crowd-low-res.jpg", "Original Input"),
      ("../scripts/output/practical-12-faces.jpg", "8 Faces Detected"),
    ),
    columns: 2,
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment implemented a real-time face detection system using Haar Cascade classifiers. The cascade architecture's early-rejection strategy enables efficient real-time detection, while `minNeighbors` tuning provides control over detection confidence.
]
