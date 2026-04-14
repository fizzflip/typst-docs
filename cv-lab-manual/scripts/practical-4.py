import cv2
import os

os.makedirs("output", exist_ok=True)

cap = cv2.VideoCapture("../samples/videos/test-jellyfin-basic.mp4")

frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps = cap.get(cv2.CAP_PROP_FPS)
total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

print(f"Video: {frame_width}x{frame_height} @ {fps:.1f} FPS, {total_frames} frames")

# Capture frame at 25% of the video
cap.set(cv2.CAP_PROP_POS_FRAMES, total_frames // 4)
ret, frame = cap.read()
if ret:
    cv2.imwrite("output/practical-4-frame-capture.jpg", frame)

# Write a short clip (first 60 frames) to output
cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
fourcc = cv2.VideoWriter_fourcc(*"mp4v")
out = cv2.VideoWriter("output/practical-4-output.mp4", fourcc, fps,
                       (frame_width, frame_height))

for i in range(min(60, total_frames)):
    ret, frame = cap.read()
    if not ret:
        break
    out.write(frame)

cap.release()
out.release()
