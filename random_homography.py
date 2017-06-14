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
########################

# Load Image
image = cv2.imread("images/desertOG.jpg")

# Get image attributes
height, width, channels = image.shape

# Get Crop Size
crop_size = 640

t = 0

while t < 15:
    # sets random Y origin
    while True:
        originY = randint(0, height - crop_size)

        if originY < (height - crop_size):
            break

    print originY

    # sets random X origin
    while True:
        originX = randint(0, width - crop_size)

        if originX < (width - crop_size):
            break

    print originX

    # sets random point 2
    while True:
        mover = randint(crop_size / 2, crop_size)

        if originY + mover < height:
            break

    botLX = originX
    botLY = originY + mover

    # sets random point 3
    while True:
        mover = randint(crop_size / 2, crop_size)

        if originY + mover < height and originX + mover < width:
            break
    botRX = originX + mover
    botRY = originY + mover

    # sets random point 4
    while True:
        mover = randint(crop_size / 2, crop_size)

        if originX + mover < width:
            break
    topRX = originX + mover
    topRY = originY

    # Creates numpy Array of Points
    pts = np.array(eval("[(originX, originY), (botLX, botLY), (botRX, botRY), (topRX, topRY)]"), dtype="float32")

    #########################################
    # Create Target Image and Warped Target #
    #########################################
    warped, target = four_point_transform(image, pts, originX, originY)

    # Copy Image to Draw Tagrget Area
    imageT = image.copy()

    # Draw Box Around Target Area
    imageT = cv2.rectangle(imageT, (originX, originY), (botRX, botRY), (0, 255, 255), 5)

    ########################
    # Calculate Homography #
    ########################
    # Create ORB Object
    orb = cv2.ORB_create()

    # Create Detectors
    kp1, des1 = orb.detectAndCompute(warped,None)
    kp2, des2 = orb.detectAndCompute(target,None)

    # Build Matcher
    bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

    # Find Matches
    matches = bf.match(des1,des2)
    matches = sorted(matches, key = lambda x:x.distance)

    # Create Image with Drawn Matches
    img3 = cv2.drawMatches(warped,kp1,target,kp2,matches[:4],None, flags=2)

    ##################
    # Display Images #
    ##################
    # Display WHole Image with Draw Target Area
    small = cv2.resize(imageT, (0,0), fx=0.20, fy=0.15)
    cv2.namedWindow('Detected', cv2.WINDOW_AUTOSIZE)
    cv2.imshow('Detected', small)
    cv2.waitKey(0)

    # Display the Target Area
    cv2.namedWindow('Target', cv2.WINDOW_AUTOSIZE)
    cv2.imshow('Target', target)
    cv2.waitKey(0)

    # Display Warped Target Area
    cv2.namedWindow('Warped', cv2.WINDOW_AUTOSIZE)
    cv2.imshow('Warped', warped)
    cv2.waitKey(0)

    # Display Homography
    cv2.namedWindow('Homography', cv2.WINDOW_AUTOSIZE)
    cv2.imshow('Homography', img3)
    cv2.waitKey(0)
    t = t + 1