import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/gray-catbird.jpg")
img = cv2.resize(img, (600, 400))

mask = np.zeros(img.shape[:2], np.uint8)

# Define a rectangle around the foreground object (the bird)
# Format: (startX, startY, width, height)
h, w = img.shape[:2]
rect = (w // 6, h // 6, 4 * w // 6, 4 * h // 6)

bgdModel = np.zeros((1, 65), np.float64)
fgdModel = np.zeros((1, 65), np.float64)

cv2.grabCut(img, mask, rect, bgdModel, fgdModel, 5, cv2.GC_INIT_WITH_RECT)

# Create binary mask: 0 and 2 -> background, 1 and 3 -> foreground
mask2 = np.where((mask == 2) | (mask == 0), 0, 1).astype("uint8")
result = img * mask2[:, :, np.newaxis]

cv2.imwrite("output/practical-11-grabcut.jpg", result)
print("Practical 11 outputs generated.")
