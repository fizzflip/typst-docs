import cv2
import numpy as np

# Create a synthetic image with different intensities
img = np.zeros((300, 300), dtype="uint8")
cv2.rectangle(img, (50, 50), (150, 150), 255, -1)
cv2.circle(img, (220, 220), 50, 100, -1)

img = cv2.GaussianBlur(img, (3, 3), 0)

# 1. Sobel Edge Detection
sobel_x = cv2.Sobel(img, cv2.CV_64F, 1, 0, ksize=3)
sobel_y = cv2.Sobel(img, cv2.CV_64F, 0, 1, ksize=3)
sobel_combined = cv2.addWeighted(
    cv2.convertScaleAbs(sobel_x), 0.5, cv2.convertScaleAbs(sobel_y), 0.5, 0
)

# 2. Canny Edge Detection
canny_wide = cv2.Canny(img, 50, 150)
canny_tight = cv2.Canny(img, 200, 250)
