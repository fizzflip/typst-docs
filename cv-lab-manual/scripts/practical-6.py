import cv2
import numpy as np

# Create a synthetic grayscale image with gradient background
img = np.zeros((300, 300), dtype="uint8")
for i in range(300):
    img[:, i] = int((i / 300) * 150)
cv2.rectangle(img, (50, 50), (150, 150), 200, -1)
cv2.circle(img, (220, 220), 50, 30, -1)

# 1. Simple Global Thresholding
ret, thresh_simple = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY)

# 2. Otsu's Binarization
ret_otsu, thresh_otsu = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
print(f"Otsu's calculated threshold value: {ret_otsu}")

# 3. Adaptive Thresholding
thresh_adaptive = cv2.adaptiveThreshold(
    img, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2
)

# 4. Connected Component Analysis
num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(
    thresh_simple, connectivity=8
)
print(f"Total components detected: {num_labels} (includes background)")
