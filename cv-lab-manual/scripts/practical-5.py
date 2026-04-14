import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/handwritten-notes.jpg", cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img, (600, 800))

# Binarize for morphological operations
_, binary = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY_INV)

kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))

# Erosion
eroded = cv2.erode(binary, kernel, iterations=1)
cv2.imwrite("output/practical-5-eroded.jpg", eroded)

# Dilation
dilated = cv2.dilate(binary, kernel, iterations=1)
cv2.imwrite("output/practical-5-dilated.jpg", dilated)

# Opening (erosion then dilation) - removes small noise
opened = cv2.morphologyEx(binary, cv2.MORPH_OPEN, kernel)
cv2.imwrite("output/practical-5-opened.jpg", opened)

# Closing (dilation then erosion) - fills small holes
closed = cv2.morphologyEx(binary, cv2.MORPH_CLOSE, kernel)
cv2.imwrite("output/practical-5-closed.jpg", closed)

print("Practical 5 outputs generated.")
