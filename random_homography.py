###################
# import packages #
###################
from transform import four_point_transform
import numpy as np
import cv2
from random import randint
import scipy
import matplotlib.pyplot as plt


########################
# Set Image Parameters #
########################qr

# Load Image
image = cv2.imread("images/city.png")

# convert to grey scale
gImage = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Get image attributes
height, width, channels = image.shape

# Get Crop Size
crop_size = 640

t = 0

# Create the Text File to Write to
textfile = open("coordinates.txt", "w+")


while t < 100:

    # sets random Y origin
    while True:
        originY = randint(0, height - crop_size)

        if originY < (height - crop_size):
            break

   #print originY

    # sets random X origin
    while True:
        originX = randint(0, width - crop_size)

        if originX < (width - crop_size):
            break

    # creates points for Target Image
    botLX = originX
    botLY = originY + crop_size
    botRX = originX + crop_size
    botRY = originY + crop_size
    topRX = originX + crop_size
    topRY = originY

    # Creates numpy Array of Points
    pts = np.array(eval("[(originX, originY), (botLX, botLY), (botRX, botRY), (topRX, topRY)]"), dtype="float32")

    #########################################
    # Sets Second Cropped Image Coordinates #
    #########################################

    origin2X = originX + randint(0, crop_size / 2)
    origin2Y = originY + randint(0, crop_size / 2)

    while origin2X + crop_size > width:
        origin2X = originX + randint(0, crop_size / 2)

    while origin2Y + crop_size > height:
        origin2Y = originY + randint(0, crop_size / 2)

    bLY = origin2Y + crop_size
    bRX = origin2X + crop_size
    bRY = origin2Y + crop_size
    tRX = origin2X + crop_size

    pts2 = np.array(eval("[(origin2X, origin2Y), (origin2X, bLY), (bRX, bRY), (tRX, origin2Y)]"), dtype="float32")


    #########################################
    # Create Target Image and Warped Target #
    #########################################
    target = four_point_transform(gImage, pts, originX, originY)
    newCrop = four_point_transform(gImage, pts2, origin2X, origin2Y)

    # Copy Image to Draw Tagrget Area
    imageT = image.copy()
    #cv2.imwrite('newCrop.png', crop2)

    #newCrop = cv2.imread('newCrop.png')
    # Draw Box Around Target Area
    imageT = cv2.rectangle(imageT, (originX, originY), (botRX, botRY), (0, 255, 255), 5)
    imageT = cv2.rectangle(imageT, (origin2X, origin2Y), (bRX, bRY), (0, 255, 255), 5)

    ########################
    # Calculate Homography #
    ########################
    # Create ORB Object
    orb = cv2.ORB_create()

    # Create Detectors
    kp1, des1 = orb.detectAndCompute(newCrop,None)
    kp2, des2 = orb.detectAndCompute(target,None)

    # Build Matcher
    bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

    # Find Matches
    matches = bf.match(des1,des2)
    matches = sorted(matches, key = lambda x:x.distance)

    # Create Image with Drawn Matches
    img3 = cv2.drawMatches(newCrop,kp1,target,kp2,matches[:0],None, flags=2)

    # Initialize lists
    list_kp1 = []
    list_kp2 = []

    # For each match...
    for mat in matches:
        # Get the matching keypoints for each of the images
        img1_idx = mat.queryIdx
        img2_idx = mat.trainIdx

        # x - columns
        # y - rows
        # Get the coordinates
        (x1, y1) = kp1[img1_idx].pt
        (x2, y2) = kp2[img2_idx].pt

        # Append to each list
        list_kp1.append((x1, y1))
        list_kp2.append((x2, y2))

    #print list_kp1[0], list_kp1[1], list_kp1[2], list_kp1[3]
    #print list_kp2[0], list_kp2[1], list_kp2[2], list_kp2[3]

    nameTarget = "target" + str(t + 1) + ".jpg"
    nameShift = "shift" + str(t + 1) + ".jpg"

    print nameTarget, nameShift

    targetFilePath = "train_images/" + nameTarget
    shiftFilePath = "train_images/" + nameShift

    cv2.imwrite(targetFilePath, img3)
    #cv2.imwrite(shiftFilePath, newCrop)

    textfile.write(str(list_kp1[0]) + ", " + str(list_kp1[1]) + ", " + str(list_kp1[2]) + ", " + str(list_kp1[3]) + ", " +
                   str(list_kp2[0]) + ", " + str(list_kp2[1]) + ", " + str(list_kp2[2]) + ", " + str(list_kp2[3]) + "\n")


    #cv2.imwrite('gray_image.png', gray_image)
    ##################
    # Display Images #
    ##################
    # Display WHole Image with Draw Target Area
    #small = cv2.resize(imageT, (0,0), fx=0.20, fy=0.15)
    #cv2.namedWindow('Detected', cv2.WINDOW_AUTOSIZE)
    #cv2.imshow('Detected', small)
    #cv2.waitKey(0)

    # Display Homography
    #cv2.namedWindow('Homography', cv2.WINDOW_AUTOSIZE)
    #cv2.imshow('Homography', img3)
    #cv2.waitKey(0)

    t = t + 1

textfile.close()

