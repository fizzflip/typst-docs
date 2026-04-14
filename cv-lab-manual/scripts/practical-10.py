import cv2
import numpy as np
import os

os.makedirs("output", exist_ok=True)

# Load scene image and create object by cropping a region from it
scene = cv2.imread("../samples/images/boat-town.jpg")
scene = cv2.resize(scene, (800, 500))

# Crop a distinctive region as the "object" to find
obj = scene[100:300, 200:450].copy()
cv2.imwrite("output/practical-10-object.jpg", obj)

# Convert to grayscale
gray_obj = cv2.cvtColor(obj, cv2.COLOR_BGR2GRAY)
gray_scene = cv2.cvtColor(scene, cv2.COLOR_BGR2GRAY)

# ORB detector
orb = cv2.ORB_create(nfeatures=500)

kp1, des1 = orb.detectAndCompute(gray_obj, None)
kp2, des2 = orb.detectAndCompute(gray_scene, None)

# BFMatcher with Hamming distance
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
matches = bf.match(des1, des2)
matches = sorted(matches, key=lambda x: x.distance)

# Draw top 30 matches
match_img = cv2.drawMatches(obj, kp1, scene, kp2, matches[:30],
                             None, flags=cv2.DrawMatchesFlags_NOT_DRAW_SINGLE_POINTS)
cv2.imwrite("output/practical-10-matches.jpg", match_img)

print(f"Found {len(matches)} matches, showing top 30.")
print("Practical 10 outputs generated.")
