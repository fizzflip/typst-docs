import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/handwritten-notes.jpg", cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img, (600, 800))

# 1. Simple binary thresholding
_, thresh_binary = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY)
cv2.imwrite("output/practical-6-binary.jpg", thresh_binary)

# 2. Otsu's thresholding (automatic threshold selection)
_, thresh_otsu = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
cv2.imwrite("output/practical-6-otsu.jpg", thresh_otsu)

# 3. Connected Component Analysis
_, binary_inv = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY_INV)
num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(binary_inv)

# Colorize connected components
output = np.zeros((*labels.shape, 3), dtype=np.uint8)
for i in range(1, num_labels):
    color = np.random.randint(50, 255, size=3).tolist()
    output[labels == i] = color

cv2.imwrite("output/practical-6-connected.jpg", output)
print(f"Found {num_labels - 1} connected components.")
