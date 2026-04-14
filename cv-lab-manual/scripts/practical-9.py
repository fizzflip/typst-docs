import cv2
import numpy as np

# Create a synthetic image (white square with a red circle)
img = np.zeros((300, 300, 3), dtype="uint8")
cv2.rectangle(img, (50, 50), (250, 250), (255, 255, 255), -1)
cv2.circle(img, (150, 150), 50, (0, 0, 255), -1)

rows, cols, ch = img.shape

# 1. Affine Transformation
pts1_affine = np.float32([[50, 50], [250, 50], [50, 250]])
pts2_affine = np.float32([[10, 100], [200, 50], [100, 250]])

M_affine = cv2.getAffineTransform(pts1_affine, pts2_affine)
affine_warped = cv2.warpAffine(img, M_affine, (cols, rows))

# 2. Perspective Transformation (Homography)
pts1_persp = np.float32([[50, 50], [250, 50], [50, 250], [250, 250]])
pts2_persp = np.float32([[0, 0], [300, 0], [50, 300], [250, 300]])

M_persp = cv2.getPerspectiveTransform(pts1_persp, pts2_persp)
persp_warped = cv2.warpPerspective(img, M_persp, (cols, rows))
