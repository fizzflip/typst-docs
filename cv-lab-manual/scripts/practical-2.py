import cv2
import numpy as np

canvas = np.zeros((500, 500, 3), dtype="uint8")

# 1. Drawing a Line
cv2.line(canvas, (50, 50), (450, 50), (255, 0, 0), 3)

# 2. Drawing Rectangles
cv2.rectangle(canvas, (50, 100), (200, 250), (0, 255, 0), 2)
cv2.rectangle(canvas, (250, 100), (400, 250), (0, 0, 255), -1)

# 3. Drawing a Circle
cv2.circle(canvas, (125, 375), 50, (0, 255, 255), 2)

# 4. Adding Text
font = cv2.FONT_HERSHEY_SIMPLEX
cv2.putText(canvas, 'OpenCV Annotations', (50, 470), font, 1.2, (255, 255, 255), 2)

cv2.imshow("Annotations", canvas)
cv2.waitKey(0)
cv2.destroyAllWindows()
