#import "common.typ": *

<practical-4>
#practical_title("4")

#section("Aim")[
  To implement video input/output operations, including capturing video from a camera or file, displaying it in real-time, and writing the processed frames to a new video file.
]

#v(.5em)

#section("Theory")[
  In Computer Vision, a video is simply a rapid sequence of individual images called "frames." OpenCV handles video by reading these frames one by one inside a loop using `cv2.VideoCapture`. To save a video, `cv2.VideoWriter` takes individual frames, encodes them using a specified codec (FourCC), and compiles them into a single file. \
  \
  Key components:
  - *`VideoCapture`:* Initializes a video stream from a camera (`0`) or file path.
  - *`VideoWriter`:* Encodes and writes frames using a FourCC codec (e.g., `mp4v`, `XVID`).
  - *`cap.read()`:* Returns a boolean success flag and the frame array on each loop iteration.
  - *Resource Cleanup:* `.release()` on both capture and writer objects is mandatory to prevent corrupted files or locked hardware.
]

// #v(.5em)
#pagebreak()

#section("Code")[
  #code_box(width: 100%, label: "practical-4.py", [
    #raw(read("../scripts/practical-4.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.VideoCapture(0)`:* `0` accesses the default system camera. Pass a file path string to read an existing video. \
  - *`cv2.VideoWriter_fourcc(*'mp4v')`:* FourCC (Four-Character Code) specifies the video codec. `*'mp4v'` unpacks the string into individual characters. \
  - *`cap.read()`:* Returns `(ret, frame)`. Checking `ret` prevents crashes when a video ends or a webcam disconnects. \
  - *`cv2.waitKey(25)`:* A small delay (25 ms) to display the frame and check for keyboard input. The bitwise `& 0xFF` ensures cross-platform compatibility for key capture.
]

#v(.5em)

#section("Output")[
  #output_image(
    "../scripts/output/practical-4-frame-capture.jpg",
    caption: "Captured Frame from Video Stream (Frame at 25% position)",
  )
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated real-time video capture, display, and file writing using OpenCV's `VideoCapture` and `VideoWriter` pipeline, establishing the standard video processing loop for subsequent experiments.
]
