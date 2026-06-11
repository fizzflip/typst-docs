import cv2
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/stone-wall.jpg")
img = cv2.resize(img, (600, 400))

# 1. Gaussian Blur
gaussian = cv2.GaussianBlur(img, (15, 15), 0)
cv2.imwrite("output/practical-7-gaussian.jpg", gaussian)

# 2. Median Blur
median = cv2.medianBlur(img, 15)
cv2.imwrite("output/practical-7-median.jpg", median)

# 3. Bilateral Filter (edge-preserving)
bilateral = cv2.bilateralFilter(img, 15, 75, 75)
cv2.imwrite("output/practical-7-bilateral.jpg", bilateral)

