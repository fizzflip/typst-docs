import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/pixel-art.png")
img = cv2.resize(img, (400, 400), interpolation=cv2.INTER_NEAREST)

rows, cols = img.shape[:2]

# 1. Affine Transformation (rotation + translation)
pts1 = np.float32([[50, 50], [200, 50], [50, 200]])
pts2 = np.float32([[10, 100], [200, 50], [100, 250]])
M_affine = cv2.getAffineTransform(pts1, pts2)
affine_result = cv2.warpAffine(img, M_affine, (cols, rows))
cv2.imwrite("output/practical-9-affine.jpg", affine_result)

# 2. Perspective Transformation
pts1 = np.float32([[0, 0], [cols, 0], [0, rows], [cols, rows]])
pts2 = np.float32([[50, 50], [cols - 30, 20], [30, rows - 50], [cols - 50, rows - 20]])
M_persp = cv2.getPerspectiveTransform(pts1, pts2)
persp_result = cv2.warpPerspective(img, M_persp, (cols, rows))
cv2.imwrite("output/practical-9-perspective.jpg", persp_result)

