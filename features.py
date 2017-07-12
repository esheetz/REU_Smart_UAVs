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
#   pnts, a 1x2 tuple of the feature points in each image
#       [pnts1 pnts2]
#       pnts1:
#           [x1 y1 x2 y2 x3 y3 x4 y4]
#       pnts2:
#           [x1 y1 x2 y2 x3 y3 x4 y4]

def feature_points(imStr,x1,y1,x2,y2,snapDim):
    
    ##################################
    # Get Camera and Snapshot Images #
    ##################################
    
    # read environment image
    img = cv2.imread(imStr)
    
    # get crops
    img1 = img[int(y1):int(y1+snapDim), int(x1):int(x1+snapDim)]
    img2 = img[int(y2):int(y2+snapDim), int(x2):int(x2+snapDim)]
    
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
    
    # initialize pnts
    pnts1 = []
    pnts2 = []
    i = 0
    
    while i < 4:
        img1_idx = matches[i].queryIdx
        img2_idx = matches[i].trainIdx
        
        # get the coordinates of matching feature points
        (x1, y1) = kp1[img1_idx].pt
        (x2, y2) = kp2[img2_idx].pt
        
        # store feature point in pnts
        pnts1.append(x1)
        pnts1.append(y1)
        pnts2.append(x2)
        pnts2.append(y2)
        
        # increment loop
        i = i + 1
        
    return pnts1,pnts2



# evaluates the matches between two snapshots
# used for path optimization
# lower outputs signal better matches
# inputs:
#   imStr, the name of the environment image (full path with extension)
#   x1, the x-coordinate of the first crop (upper left hand corner)
#   y1, the y-coordinate of the first crop (upper left hand corner)
#   x2, the x-coordinate of the second crop (upper left hand corner)
#   y2, the y-coordinate of the second crop (upper left hand corner)
#   snapDim, the dimensions of the snapshot
# outputs:
#   match_eval, a 1x4 tuple of distances
#   lower distance values indicates better matches

def eval_matches(imStr,x1,y1,x2,y2,snapDim):
    
    ##################################
    # Get Camera and Snapshot Images #
    ##################################
    
    # read environment image
    img = cv2.imread(imStr)
    
    # get crops
    img1 = img[int(y1):int(y1+snapDim), int(x1):int(x1+snapDim)]
    img2 = img[int(y2):int(y2+snapDim), int(x2):int(x2+snapDim)]
    
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
    
    ####################
    # Evaluate Matches #
    ####################
    
    match_eval = []
    i = 0
    
    while i < 8:
        match_eval.append(matches[i].distance)
        i = i + 1
    
    return match_eval
        
