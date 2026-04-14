import cv2
import numpy as np

# Create a synthetic image with a distinct edge
img = np.ones((300, 300), dtype="uint8") * 150
cv2.rectangle(img, (50, 50), (250, 250), 50, -1)

# Inject "Salt and Pepper" noise
noisy_img = img.copy()
noise_mask = np.random.rand(300, 300)
noisy_img[noise_mask < 0.02] = 0
noisy_img[noise_mask > 0.98] = 255

# 1. Gaussian Blur
gaussian_blurred = cv2.GaussianBlur(noisy_img, (5, 5), 0)

# 2. Median Blur
median_blurred = cv2.medianBlur(noisy_img, 5)

# 3. Bilateral Filter
bilateral_filtered = cv2.bilateralFilter(noisy_img, 9, 75, 75)
