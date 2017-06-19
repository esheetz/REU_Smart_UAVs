% function to draw snapshot along path and crop snapshot
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.altitude, Param.camAngView, Param.deltaS,
%   Param.absInitX, Param.absInitY
% global variables img, snapshots, snapshotPosns
% inputs:
%   posnXY, a 3x1 vector with elements:
%       posnXY(1) = simultion time
%       posnXY(2) = x position
%       posnXY(3) = y position
% outputs:
%   none

function drawSnapshot(posnXY)
    %% define global variables
    global img
    global snapshots
    global snapshotPosns

    %% initialize needed parameters
    initParam
    
    %% check to see if snapshot should be taken
    if (posnXY(1) > 0) && (mod(posnXY(1),Param.deltaS) == 0)
        % find posn and radius
        posn = [posnXY(2) + Param.absInitX,...
            posnXY(3) + Param.absInitY];
        r = Param.altitude * tand(Param.camAngView);
        posnXY(1)

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
        snapshots = cat(3,snapshots,snap);
        snapshotPosns = cat(1,snapshotPosns,posnXY');
        
        % plot snapshot
        figure
        image(snap)
        title(sprintf('Snapshot at %d seconds',posnXY(1)));
        
    end
    
end