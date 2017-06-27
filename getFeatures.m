% gets feature points and arranges into vector form of H4point
% calls features.py
% simulates neural network output
% if there is a problem, see usePythonModules.m
% inputs:
%   filler input
% outputs:
%   nnOut, an 8x1 vector of the neural network output
%       [[ deltaX1 ]
%        [ deltaY1 ]
%        [ deltaX2 ]
%        [ deltaY2 ]
%        [ deltaX3 ]
%        [ deltaY3 ]
%        [ deltaX4 ]
%        [ deltaY4 ]]

function nnOut = getFeatures(~)

    %% define global variables
    global snapIdx
    global snapshotPosns
    global posn_ret
    global imgStr
    %global currCam
    %global currSnap
    
    %% initialize needed parameters
    initParam
    
    %% get coordinates for upper left corner of currCam and currSnap
    offset = Param.snapDim/2;
    
    % get relative positions of image centers
    currCamPosn = posn_ret(end,2:3);
    currSnapPosn = snapshotPosns(snapIdx,2:3);
    
    % get absolute positions of image centers
    currCamPosn = currCamPosn + [Param.absInitX Param.absInitY];
    currSnapPosn = currSnapPosn + [Param.absInitX Param.absInitY];
    
    % get absolute positions of upper left corners
    currCamPosn = currCamPosn - offset;
    currSnapPosn = currSnapPosn - offset;
    
    % separate coordinates
    currCamX = currCamPosn(1);
    currCamY = currCamPosn(2);
    currSnapX = currSnapPosn(1);
    currSnapY = currSnapPosn(2);
    
    %% call features.py
    pnts = py.features.feature_points(imgStr,currCamX,currCamY,currSnapX,currSnapY,Param.snapDim);
    
    %% arrange feature points into vector H4point

end