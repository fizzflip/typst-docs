import cv2
import os

os.makedirs("output", exist_ok=True)

face_cascade = cv2.CascadeClassifier(
    cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
)

img = cv2.imread("../samples/images/crowd-low-res.jpg")
img = cv2.resize(img, (800, 500))
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(
    gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30)
)

for (x, y, w, h) in faces:
    # Main bounding box
    cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)
    
    # Label background (filled rectangle)
    label = "Face"
    (text_w, text_h), baseline = cv2.getTextSize(label,
                                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1)
    cv2.rectangle(
        img, (x, y - text_h - 10),
        (x + text_w + 10, y), (0, 255, 0), -1
    )
    # Label text
    cv2.putText(img, label, (x + 5, y - 5), 
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)

cv2.imwrite("output/practical-12-faces.jpg", img)
