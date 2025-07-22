import numpy as np
import matplotlib.pyplot as plt
from skimage import io


# a.Citiți imaginile din aceste fișiere și salvați-le într-un np.array (va avea dimensiunea 9x400x600).

base_path = "lab1ia/images/"

images = np.zeros((9, 400, 600))

# Read each image and store it in the array
for i in range(9):
    file_path = f"{base_path}car_{i}.npy"
    images[i] = np.load(file_path)

print(f"Loaded images array with shape: {images.shape}")

# b. Calculați suma valorilor pixelilor tuturor imaginilor. 
total_sum = np.sum(images)
print(f"b. Sum of all pixel values across all images: {total_sum}")

# c. Calculați suma valorilor pixelilor pentru fiecare imagine în parte.
image_sums = np.sum(images, axis=(1, 2))
print("c. Sum of pixel values for each image:")
for i, img_sum in enumerate(image_sums):
    print(f"   Image {i}: {img_sum}")

# d. Afișați indexul imaginii cu suma maximă. 
max_sum_idx = np.argmax(image_sums)
print(f"d. The image with the maximum sum is at index {max_sum_idx} with a sum of {image_sums[max_sum_idx]}")

# Display all images on the same "tab"
fig, axes = plt.subplots(3, 3, figsize=(15, 10))

for i, ax in enumerate(axes.flat):
    ax.imshow(images[i], cmap='gray')
    ax.set_title(f'Car {i}')
    ax.axis('off')

plt.tight_layout()
plt.show()

# Maxsum image
plt.figure(figsize=(10, 6))
plt.imshow(images[max_sum_idx], cmap='gray')
plt.title(f'Car {max_sum_idx} - Maximum Sum')
plt.axis('off')
plt.show()

# e. Calculați imaginea medie și afișati-o
mean_image = np.mean(images, axis=0)
io.imshow(mean_image.astype(np.uint8))  # Convert to unsigned int for display
io.show()

# f. Calculați deviația standard a imaginilor
std_image = np.std(images)
print(f"f. Standard deviation of all images: {std_image}")

# g. Normalizați imaginile (se scade imaginea medie și se împarte la deviația standard)
if std_image == 0:
    raise ValueError("Standard deviation is zero, normalization cannot be performed.")
normalized_images = (images - mean_image) / std_image
print(f"g. Normalized images array shape: {normalized_images.shape}")

for i, img in enumerate(normalized_images):
    print(f"Displaying Normalized Car {i}")
    io.imshow(img.astype(np.uint8))  # Convert to unsigned int for display
    plt.title(f'Normalized Car {i}')
    io.show()

# h. Decupați imaginile (liniile 200-300, coloanele 280-400)
cropped_images = images[:, 200:300, 280:400]
print(f"h. Cropped images array shape: {cropped_images.shape}")

# Display the cropped images
fig, axes = plt.subplots(3, 3, figsize=(15, 10))
for i, ax in enumerate(axes.flat):
    ax.imshow(cropped_images[i], cmap='gray')
    ax.set_title(f'Cropped Car {i}')
    ax.axis('off')
plt.tight_layout()
plt.show()