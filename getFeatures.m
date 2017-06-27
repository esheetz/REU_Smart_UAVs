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
    pnts = py.features.feature_points(imgStr,...
        currCamX,currCamY,currSnapX,currSnapY,Param.snapDim);
    
    % NOTE: SUBTRACTION HERE MAY AFFECT DIRECTION OF VECTOR
    % IF VECTOR IS GOING WRONG WAY, SWITCH CAM/SNAP INPUTS INTO PY
    % NAMES WILL HAVE TO CHANGE ACCORDINGLY IN REST OF FUNCTION
    
    %% arrange feature points into nnOut
    camPnts = pnts{1};
    snapPnts = pnts{2};
    
    pcs = zeros(8,1);
    pcs(1) = camPnts{1};
    pcs(2) = camPnts{2};
    pcs(3) = camPnts{3};
    pcs(4) = camPnts{4};
    pcs(5) = camPnts{5};
    pcs(6) = camPnts{6};
    pcs(7) = camPnts{7};
    pcs(8) = camPnts{8};
    
    prs = zeros(8,1);
    prs(1) = snapPnts{1};
    prs(2) = snapPnts{2};
    prs(3) = snapPnts{3};
    prs(4) = snapPnts{4};
    prs(5) = snapPnts{5};
    prs(6) = snapPnts{6};
    prs(7) = snapPnts{7};
    prs(8) = snapPnts{8};
    
    nnOut = prs - pcs;
    
end