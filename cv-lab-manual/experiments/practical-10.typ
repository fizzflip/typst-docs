#import "common.typ": *

<practical-10>
#practical_title("10")

#section("Aim")[
  To implement a feature matching system using the ORB (Oriented FAST and Rotated BRIEF) algorithm and utilize RANSAC (Random Sample Consensus) to filter outliers and geometrically align an object within a scene.
]

#v(.5em)

#section("Name")[
  Feature Matching and Object Alignment
]
#v(.5em)

#section("Theory")[
  Feature matching identifies corresponding points between a query image (object) and a train image (scene). \
  \
  - *ORB:* An efficient, rotation-invariant algorithm that detects unique "keypoints" and describes their surrounding pixel patterns as binary descriptors.
  - *Brute-Force Matcher:* Compares every descriptor in Image 1 against every descriptor in Image 2 using Hamming distance (bitwise XOR for binary descriptors).
  - *RANSAC:* Iteratively selects random subsets of matches to calculate a Homography model, discarding matches that deviate beyond a pixel threshold as outliers, leaving only geometrically consistent inliers. \
  \
  The verified Homography matrix enables projecting the object's bounding box into the scene.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-10.py", [
    #raw(read("../scripts/practical-10.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.ORB_create()`:* ORB is fast, rotation-invariant, and completely free/unpatented (unlike SIFT/SURF). \
  - *`cv2.BFMatcher(NORM_HAMMING, crossCheck=True)`:* Hamming distance compares binary descriptors. `crossCheck` ensures a match is only accepted if mutually best. \
  - *`cv2.findHomography(..., RANSAC, 5.0)`:* RANSAC finds the dominant geometric transformation, discarding outliers beyond 5 pixels. Returns the $3 times 3$ Homography matrix and an inlier mask. \
  - *`cv2.perspectiveTransform()`:* Projects the object's corner coordinates through the Homography to localize it in the scene.
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated a complete feature-based object recognition pipeline: ORB for efficient keypoint detection, brute-force matching with Hamming distance, and RANSAC for robust geometric verification and alignment.
]
