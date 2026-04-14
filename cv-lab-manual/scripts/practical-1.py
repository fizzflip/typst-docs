import cv2
import numpy as np

def show_image(title, image):
    """Displays an image using OpenCV and waits for a key press."""
    cv2.imshow(title, image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# 1. Reading and Writing Images
img = cv2.imread('input.jpg')
cv2.imwrite('output_copy.jpg', img)

# 2. Resizing
resized_img = cv2.resize(img, (400, 300))

# 3. Cropping
cropped_img = img[50:250, 100:300]

# 4. Bitwise Operations
mask = np.zeros(resized_img.shape[:2], dtype="uint8")
cv2.rectangle(mask, (100, 50), (300, 250), 255, -1)

bit_and = cv2.bitwise_and(resized_img, resized_img, mask=mask)
bit_not = cv2.bitwise_not(resized_img)

show_image("Original", img)
show_image("Resized", resized_img)
show_image("Cropped", cropped_img)
show_image("Mask", mask)
show_image("Bitwise AND", bit_and)
show_image("Bitwise NOT", bit_not)
