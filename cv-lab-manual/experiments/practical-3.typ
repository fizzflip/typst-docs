#import "common.typ": *

<practical-3>
#practical_title("3")

#section("Aim")[
  To enhance image quality by adjusting brightness and contrast, and to perform basic mathematical operations (addition and subtraction) on image matrices using OpenCV.
]

#v(.5em)

#section("Theory")[
  Image enhancement improves the perceptibility of information in images. Adjusting contrast and brightness mathematically transforms individual pixel values using the fundamental equation $g(x) = alpha f(x) + beta$, where $alpha$ controls contrast (multiplication) and $beta$ controls brightness (addition). \
  \
  Mathematical operations like addition and subtraction must be handled carefully to avoid integer overflow or underflow. OpenCV provides _saturation arithmetic_ functions (`cv2.add`, `cv2.subtract`) that clip values to the valid 0–255 range, unlike NumPy's modulo arithmetic which wraps around. \
  \
  For blending, `cv2.addWeighted()` applies the formula $O = (I_1 times alpha) + (I_2 times beta) + gamma$, enabling smooth transitions between two images.
]

#v(.5em)

#section("Code")[
  #code_box(width: 90%, label: "practical-3.py", [
    #raw(read("../scripts/practical-3.py"), lang: "python")
  ])
]

#v(.5em)

#section("Explanation")[
  - *`cv2.convertScaleAbs()`:* The safest way to adjust brightness/contrast—scales, takes absolute values, and converts to `uint8` with automatic clamping. \
  - *`np.ones() * 50`:* Creates a matrix of matching dimensions where every pixel has value 50, enabling element-wise mathematical operations. \
  - *`cv2.add()` / `cv2.subtract()`:* Use _clipping_ (saturation arithmetic), so $250 + 10 = 255$ instead of wrapping to 4 as NumPy would. \
  - *`cv2.addWeighted()`:* Linearly blends two same-sized images using weighted contributions.
]

#v(.5em)

#section("Output")[
  #output_image("../scripts/output/practical-3-brightened.jpg", caption: "Brightness Adjusted (β = +60)")
  #v(.5em)
  #output_image("../scripts/output/practical-3-contrasted.jpg", caption: "Contrast Enhanced (α = 1.8)")
  #v(.5em)
  #output_image("../scripts/output/practical-3-blended.jpg", caption: "Blended Output (70% Original + 30% Overlay)")
]

#v(.5em)

#section("Conclusion")[
  The experiment demonstrated pixel-level image enhancement through brightness/contrast adjustment and safe mathematical operations using OpenCV's saturation arithmetic functions, avoiding the visual artifacts caused by integer overflow.
]
