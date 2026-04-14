import cv2
import numpy as np

# Create a textured 'object' and embed it into a larger 'scene'
img_object = np.random.randint(50, 200, (100, 100), dtype=np.uint8)
img_scene = np.zeros((300, 300), dtype=np.uint8)
img_scene[100:200, 150:250] = img_object

# 1. Initialize ORB detector
orb = cv2.ORB_create()

# 2. Detect keypoints and compute descriptors
kp1, des1 = orb.detectAndCompute(img_object, None)
kp2, des2 = orb.detectAndCompute(img_scene, None)

# 3. Feature Matching (Brute-Force with Hamming distance)
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
matches = bf.match(des1, des2)
matches = sorted(matches, key=lambda x: x.distance)

# 4. Object Alignment using RANSAC
if len(matches) >= 4:
    src_pts = np.float32([kp1[m.queryIdx].pt for m in matches]).reshape(-1, 1, 2)
    dst_pts = np.float32([kp2[m.trainIdx].pt for m in matches]).reshape(-1, 1, 2)

    M, mask = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC, 5.0)
    matchesMask = mask.ravel().tolist()

    h, w = img_object.shape
    pts = np.float32([[0, 0], [0, h-1], [w-1, h-1], [w-1, 0]]).reshape(-1, 1, 2)
    dst = cv2.perspectiveTransform(pts, M)

    img_scene_aligned = cv2.polylines(
        img_scene.copy(), [np.int32(dst)], True, 255, 3, cv2.LINE_AA
    )
else:
    print(f"Not enough matches are found - {len(matches)}/4")
    matchesMask = None
    img_scene_aligned = img_scene.copy()
