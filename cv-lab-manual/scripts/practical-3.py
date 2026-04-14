import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/nasa-sphere.jpg")
img = cv2.resize(img, (600, 400))

# 1. Brightness adjustment (add constant)
brightened = cv2.convertScaleAbs(img, alpha=1.0, beta=60)
cv2.imwrite("output/practical-3-brightened.jpg", brightened)

# 2. Contrast adjustment (multiply by scalar)
contrasted = cv2.convertScaleAbs(img, alpha=1.8, beta=0)
cv2.imwrite("output/practical-3-contrasted.jpg", contrasted)

# 3. Image blending (addWeighted)
overlay = np.full_like(img, (40, 100, 200), dtype=np.uint8)
blended = cv2.addWeighted(img, 0.7, overlay, 0.3, 0)
cv2.imwrite("output/practical-3-blended.jpg", blended)

