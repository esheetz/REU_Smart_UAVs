% function to draw snapshot along path and crop snapshot
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.altitude, Param.camAngView, Param.deltaS,
%   Param.snapDim, Param.absInitX, Param.absInitY
% inputs:
%   posnXYZ, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position
% outputs:
%   none

function drawSnapshot(posnXYZ)
    %% define global variables
    global img
    global snapshotsRGB
    global snapshotsG
    global snapshotPosns

    %% initialize needed parameters
    initParam
    
    %% check to see if snapshot should be taken
    if (posnXYZ(1) > 0) && (mod(posnXYZ(1),Param.deltaS) == 0)
        % find posn and radius
        posn = [posnXYZ(2) + Param.absInitX,...
            posnXYZ(3) + Param.absInitY];
        r = Param.altitude * tand(Param.camAngView);
        posnXYZ(1)

        % plot snapshot catchment area
        hold on
        figure(1)
        viscircles(posn,r,'Color','g');
        
        % plot snapshots
        % find upper left corner of snapshot
        offset = Param.snapDim/2;
        snapPosn = [posn(1) - offset, posn(2) - offset];

        % take snapshot
        snap = imcrop(img,[snapPosn Param.snapDim-1 Param.snapDim-1]);
        
        % store snapshot in array
        snapshotsRGB = cat(3,snapshotsRGB,snap);
        snapshotsG = cat(3,snapshotsG,rgb2gray(snap));
        snapshotPosns = cat(1,snapshotPosns,posnXYZ');
        
        % plot snapshot
        figure
        image(snap)
        title(sprintf('Snapshot at %d seconds',posnXYZ(1)));
        
    end
    
end