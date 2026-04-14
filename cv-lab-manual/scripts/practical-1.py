import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

# 1. Reading and Writing Images
img = cv2.imread("../samples/images/paris-street.jpg")
cv2.imwrite("output/practical-1-original.jpg", img)

# 2. Resizing
resized = cv2.resize(img, (400, 300))
cv2.imwrite("output/practical-1-resized.jpg", resized)

# 3. Cropping
h, w = img.shape[:2]
cropped = img[h // 4 : 3 * h // 4, w // 4 : 3 * w // 4]
cv2.imwrite("output/practical-1-cropped.jpg", cropped)

# 4. Bitwise Operations
mask = np.zeros(resized.shape[:2], dtype="uint8")
cv2.rectangle(mask, (100, 50), (300, 250), 255, -1)



bit_and = cv2.bitwise_and(resized, resized, mask=mask)
cv2.imwrite("output/practical-1-bitwise-and.jpg", bit_and)

bit_not = cv2.bitwise_not(resized)
cv2.imwrite("output/practical-1-bitwise-not.jpg", bit_not)

