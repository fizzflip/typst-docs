import cv2
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/corpo-building.jpg", cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img, (600, 800))

# 1. Sobel Edge Detection
sobel_x = cv2.Sobel(img, cv2.CV_64F, 1, 0, ksize=3)
sobel_y = cv2.Sobel(img, cv2.CV_64F, 0, 1, ksize=3)
sobel_combined = cv2.convertScaleAbs(cv2.addWeighted(
    cv2.convertScaleAbs(sobel_x), 0.5,
    cv2.convertScaleAbs(sobel_y), 0.5, 0
))
cv2.imwrite("output/practical-8-sobel.jpg", sobel_combined)

# 2. Canny Edge Detection
canny = cv2.Canny(img, 50, 150)
cv2.imwrite("output/practical-8-canny.jpg", canny)

