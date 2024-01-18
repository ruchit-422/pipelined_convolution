import numpy as np
from PIL import Image

# Open the input text file
with open("D:/Vivado/result_values.txt", 'r') as f:
    # Read the file contents and split into a list of values
    values = f.read().split()

# Convert the values to a numpy array and replace non-decimal values with 0
values = np.array([float(v) if v.replace('.', '', 1).isdigit() else 0 for v in values])
values = np.append(values, np.zeros(345+1020))
# Normalize the values to the range 0-255
values = (values - np.min(values)) / (np.max(values) - np.min(values)) * 255

# Reshape the values into a 2D array with a width of 100 (you can adjust this as needed)
values_2d = values.reshape(512,512)

# Convert the numpy array to a PIL Image object and save it to a file
img = Image.fromarray(values_2d.astype(np.uint8))
img.save('D:/Vivado/output.png')
