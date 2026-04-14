#import "common.typ": *

<practical-2>
#practical_title("2")

#section("Aim")[
  To implement basic image annotation techniques by drawing geometric shapes (lines, circles, rectangles) and overlaying text onto an image using OpenCV.
]

#v(.5em)

#section("Theory")[
  Image annotation is vital for visualizing the results of computer vision algorithms, such as drawing bounding boxes around detected faces or labeling tracked objects. OpenCV provides built-in drawing functions that modify the multidimensional image array directly in place. \
  \
  Key concepts:
  - *Canvas Creation:* `np.zeros((H, W, 3))` creates a blank black image with 3 BGR channels.
  - *Coordinate System:* Origin `(0, 0)` is at the top-left; X extends right, Y extends downward.
  - *Colour Tuples:* Specified in `(Blue, Green, Red)` order—e.g., `(255, 0, 0)` is pure blue.
  - *Thickness:* A positive integer sets border width in pixels; `-1` fills the shape completely.
  - All drawing functions operate _in-place_, modifying the array directly rather than returning a new copy.
]

// #pagebreak()
#section("Code")[
  #code_box(width: 100%, label: "practical-2.py", [
    #raw(read("../scripts/practical-2.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.line()`:* Draws a line between two coordinate points with specified colour and thickness. \
  - *`cv2.rectangle()`:* Draws an outline or filled rectangle given top-left and bottom-right corners. \
  - *`cv2.circle()`:* Draws an outline or filled circle given centre coordinates and radius. \
  - *`cv2.putText()`:* Overlays a text string at the specified bottom-left origin using a chosen font face and scale.
]

#v(.5em)

#section("Output")[
  #output_grid(
    (
      ("../samples/images/boat-town.jpg", "Original Input"),
      ("../scripts/output/practical-2-annotated.jpg", "Annotated Output"),
    ),
    columns: 2,
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated how to use OpenCV's built-in drawing primitives to annotate images with lines, rectangles, circles, and text—capabilities essential for visualizing detection and tracking outputs.
]
