from PIL import Image

# open the image
img = Image.open("D:\\Vivado\\image.png")

# get the dimensions of the images
width, height = img.size

# create a text file to write the pixel values to
with open('D:\\Vivado\\pixel_values.txt', 'w') as f:

    # iterate over each pixel in the image
    for y in range(height):
        for x in range(width):

            # get the R, G, and B values for the pixel
            r, g, b = img.getpixel((x, y))[:3]

            # write the pixel values to the file
            f.write(f'{r} {g} {b} ' )
            # add a newline character after each row of pixels
            f.write('\n')
