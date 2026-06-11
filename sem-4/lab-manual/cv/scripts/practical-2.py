import cv2
import os

os.makedirs("output", exist_ok=True)

img = cv2.imread("../samples/images/boat-town.jpg")
img = cv2.resize(img, (800, 500))

# Bounding box around the foreground boat
cv2.rectangle(img, (230, 300), (430, 430), (0, 255, 0), 2)
cv2.putText(img, "Boat", (240, 295),
            cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

# Bounding box around the second boat (background)
cv2.rectangle(img, (300, 240), (460, 310), (0, 200, 255), 2)
cv2.putText(img, "Boat", (310, 235),
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 200, 255), 2)

# Circle around the pagoda tower
cv2.circle(img, (430, 120), 35, (255, 100, 0), 2)
cv2.putText(img, "Pagoda", (390, 80),
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 100, 0), 2)

# Line marking the waterline along the right canal bank
cv2.line(img, (520, 235), (800, 360), (255, 255, 0), 2)
cv2.putText(img, "Waterline", (650, 330),
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 2)

# Ellipse highlighting the tree canopy
cv2.ellipse(img, (370, 155), (70, 40), 0, 0, 360, (0, 255, 200), 2)
cv2.putText(img, "Trees", (345, 200),
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 200), 2)

# Arrow pointing to the building on the right
cv2.arrowedLine(img, (730, 150), (680, 200), (200, 200, 255), 2)
cv2.putText(img, "Building", (690, 145),
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (200, 200, 255), 2)

cv2.imwrite("output/practical-2-annotated.jpg", img)
