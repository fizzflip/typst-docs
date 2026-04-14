import cv2
import numpy as np

img = cv2.imread('real_world_object.jpg')
mask = np.zeros(img.shape[:2], np.uint8)

bgdModel = np.zeros((1, 65), np.float64)
fgdModel = np.zeros((1, 65), np.float64)

# 1. Define the Bounding Box (x, y, width, height)
rect = (50, 50, 450, 290)

# 2. Run GrabCut Algorithm
cv2.grabCut(img, mask, rect, bgdModel, fgdModel, 5, cv2.GC_INIT_WITH_RECT)

# 3. Process the Resulting Mask
mask2 = np.where((mask == 2) | (mask == 0), 0, 1).astype('uint8')
result = img * mask2[:, :, np.newaxis]
