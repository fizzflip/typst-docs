import cv2
import numpy as np

# Create a synthetic binary image
img = np.zeros((300, 300), dtype="uint8")
cv2.rectangle(img, (50, 50), (150, 150), 255, -1)
cv2.circle(img, (220, 220), 40, 255, -1)
cv2.circle(img, (100, 200), 5, 255, -1)
cv2.rectangle(img, (70, 70), (90, 90), 0, -1)

# 1. Morphological Operations
kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))

eroded_img = cv2.erode(img, kernel, iterations=1)
dilated_img = cv2.dilate(img, kernel, iterations=1)
opened_img = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
closed_img = cv2.morphologyEx(img, cv2.MORPH_CLOSE, kernel)

# 2. Connected Component Analysis
num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(
    opened_img, connectivity=8
)

print(f"Total components detected: {num_labels} (includes 1 background label)")

# Visualize labeled components
label_hue = np.uint8(179 * labels / np.max(labels))
blank_ch = 255 * np.ones_like(label_hue)
labeled_img = cv2.merge([label_hue, blank_ch, blank_ch])
labeled_img = cv2.cvtColor(labeled_img, cv2.COLOR_HSV2BGR)
labeled_img[label_hue == 0] = 0
