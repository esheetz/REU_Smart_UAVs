###################
# import packages #
###################
import numpy as np
import cv2

###################
# Sets New Points #
###################

def order_points(pts):

    # create a list of coordinates
    rect = np.zeros((4, 2), dtype="float32")
    s = pts.sum(axis=1)
    rect[0] = pts[np.argmin(s)]
    rect[2] = pts[np.argmax(s)]

    # find the difference between the points
    diff = np.diff(pts, axis=1)
    rect[1] = pts[np.argmin(diff)]
    rect[3] = pts[np.argmax(diff)]

    return rect

#####################
# Sets Cropped Area #
#####################

def four_point_transform(image, pts, originX, originY):

    # Use the points
    rect = order_points(pts)
    (tl, tr, br, bl) = rect

    # New Width
    widthA = np.sqrt(((br[0] - bl[0]) ** 2) + ((br[1] - bl[1]) ** 2))
    widthB = np.sqrt(((tr[0] - tl[0]) ** 2) + ((tr[1] - tl[1]) ** 2))
    maxWidth = max(int(widthA), int(widthB))

    # New Height
    heightA = np.sqrt(((tr[0] - br[0]) ** 2) + ((tr[1] - br[1]) ** 2))
    heightB = np.sqrt(((tl[0] - bl[0]) ** 2) + ((tl[1] - bl[1]) ** 2))
    maxHeight = max(int(heightA), int(heightB))

    # Create the Cropped Area
    dst = np.array([
        [0, 0],
        [maxWidth - 1, 0],
        [maxWidth - 1, maxHeight - 1],
        [0, maxHeight - 1]], dtype="float32")

    # Determines how to warp image
    M = cv2.getPerspectiveTransform(rect, dst)

    ##################
    # Creates Images #
    ##################

    # Cropped but not warped image
    G = image[originY:originY + maxHeight, originX:originX + maxWidth]

    # Creates Warped Image


    # return cropped
    return G