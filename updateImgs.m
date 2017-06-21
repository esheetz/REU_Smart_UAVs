% updates currCam and currSnap images
% calls script initParam.m:
%   Param.absInitX, Param.absInitY,
%   Param.snapDim, Param.switchThresh
% inputs:
%   posnXYZ, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position
% outputs:
%   none

function updateImgs(posnXYZ)

    %% define global variables
    global pixOffset
    global currCam
    global currSnap
    global snapIdx
    global snapshots
    global waypointPosns
    
    %% update currCam
    posn = [posnXYZ(2) + Param.absInitX,...
            posnXYZ(3) + Param.absInitY];
    offset = Param.snapDim/2;
    snapPosn = [posn(1) - offset, posn(2) - offset];
    currCam = imcrop(img,[snapPosn Param.snapDim-1 Param.snapDim-1]);

    %% update currSnap if needed
    if pixOffset >= Param.switchThresh
        waypointPosns = cat(1,waypointPosns,posnXYZ');
        snapIdx = snapIdx - 1;
        currSnap = snapshots(:,:,((3*snapIdx)-2):(3*snapIdx));
    end
    
end