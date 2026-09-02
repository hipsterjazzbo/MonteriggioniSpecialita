# -*- coding: utf-8 -*-

#####################################################
#                                                   #
# Running program:                                  #
#                                                   #
# Translation of "densityMap_height"                #
# when updating from 12 6 to 14 7                   #
# enabling to increase height channel resolution.   #
#                                                   #
#####################################################

from PIL import Image
import os

# Path and input file
MASTER_PATH = os.path.dirname(__file__) + "/"
INPUT_FILE = "densityMap_height"

def transform(pxl):
    R = bin(pxl[0])[2:].zfill(8)[::-1]
    G = bin(pxl[1])[2:].zfill(8)[::-1]
    B = bin(pxl[2])[2:].zfill(8)[::-1]

    RGB = R + G + B

    # Insert one new bit after 6 bits → 6→7 channels (12→14 total)
    newRGB = RGB[:6] + '0' + RGB[6:24]

    newR = int(newRGB[:8][::-1], 2)
    newG = int(newRGB[8:16][::-1], 2)
    newB = int(newRGB[16:24][::-1], 2)

    return (newR, newG, newB)

def main():
    img = Image.open(MASTER_PATH + INPUT_FILE + ".png")
    imgW, imgH = img.size
    print(f"Translating a {imgW} x {imgH} pixels file ...")

    pixels = list(img.getdata())
    pixels_t = list(map(transform, pixels))

    imgNEW = Image.new("RGB", (imgW, imgH))
    imgNEW.putdata(pixels_t)
    output_file = MASTER_PATH + INPUT_FILE + "_14x7.png"
    imgNEW.save(output_file)

    print("Finished! Saved as", output_file)

if __name__ == "__main__":
    main()
