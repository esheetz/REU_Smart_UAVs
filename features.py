import cv2
import numpy as np

# computes matched feature points of two images
# inputs:
#   imStr, the name of the environment image (full path with extension)
#   x1, the x-coordinate of the first crop (upper left hand corner)
#   y1, the y-coordinate of the first crop (upper left hand corner)
#   x2, the x-coordinate of the second crop (upper left hand corner)
#   y2, the y-coordinate of the second crop (upper left hand corner)
#   snapDim, the dimensions of the snapshot
# outputs:
#   pnts, a 8x2 matrix of the feature points in each image
#       [[img1_kp1x img1_kp1y]
#        [img1_kp2x img1_kp2y]
#        [img1_kp3x img1_kp3y]
#        [img1_kp4x img1_kp4y]
#        [img2_kp1x img2_kp1y]
#        [img2_kp2x img2_kp2y]
#        [img2_kp3x img2_kp3y]
#        [img2_kp4x img2_kp4y]]

def feature_points(imStr,x1,y1,x2,y2,snapDim):
    
    ##################################
    # Get Camera and Snapshot Images #
    ##################################
    
    # read environment image
    img = cv2.imread(imStr)
    
    # get crops
    img1 = img[y1:y1+snapDim, x1:x1+snapDim]
    img2 = img[y2:y2+snapDim, x2:x2+snapDim]
    
    #######################
    # Find Feature Points #
    #######################
    
    # create orb object
    orb = cv2.ORB_create()

    # create detectors
    kp1, des1 = orb.detectAndCompute(img1,None)
    kp2, des2 = orb.detectAndCompute(img2,None)

    # build matcher
    bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

    # find matches
    matches = bf.match(des1,des2)
    matches = sorted(matches, key = lambda x:x.distance)

    # initialize lists
    list_kp1 = []
    list_kp2 = []
    
    # initialize pnts
    pnts = np.zeros((8,2), dtype="float32")
    i = 0
    
    # for each match...
    for mat in matches:
        # get the matching keypoints for each of the images
        img1_idx = mat.queryIdx
        img2_idx = mat.trainIdx

        # x - columns
        # y - rows
        # get the coordinates of matching feature points
        (x1, y1) = kp1[img1_idx].pt
        (x2, y2) = kp2[img2_idx].pt
        
        # Append to each list
        list_kp1.append((x1, y1))
        list_kp2.append((x2, y2))
    
        # store four best feature points in pnts
        if i < 4:
            pnts[i] = [x1, y1]
            pnts[4+i] = [x2, y2]
            i = i + 1
        
    return pnts
