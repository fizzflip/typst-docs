import cv2
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/boat-town.jpg")
img = cv2.resize(img, (800, 500))

# Drawing a line
cv2.line(img, (50, 50), (750, 50), (0, 255, 0), 3)

# Drawing a rectangle
cv2.rectangle(img, (100, 100), (400, 350), (255, 0, 0), 2)

# Drawing a circle
cv2.circle(img, (600, 250), 80, (0, 0, 255), 3)

# Drawing an ellipse
cv2.ellipse(img, (400, 250), (120, 60), 0, 0, 360, (255, 255, 0), 2)

# Adding text
cv2.putText(img, "OpenCV Annotations", (200, 470),
            cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)

cv2.imwrite("output/practical-2-annotated.jpg", img)
