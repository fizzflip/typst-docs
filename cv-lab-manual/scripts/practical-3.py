import cv2
import numpy as np

img = cv2.imread('input.jpg')

# 1. Brightness and Contrast Adjustment
alpha = 1.5  # Contrast control (1.0 is original)
beta = 30    # Brightness control (0 is original)
enhanced_img = cv2.convertScaleAbs(img, alpha=alpha, beta=beta)

# 2. Mathematical Operations
matrix = np.ones(img.shape, dtype="uint8") * 50

added_img = cv2.add(img, matrix)
subtracted_img = cv2.subtract(img, matrix)

# 3. Image Blending (Weighted Addition)
blended_img = cv2.addWeighted(img, 0.7, enhanced_img, 0.3, 0)
