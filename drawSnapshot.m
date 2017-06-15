% function to draw snapshot
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.altitude, Param.camAngView, Param.deltaS,
%   Param.absInitX, Param.absInitY
% inputs:
%   posnXY, a vector with 3 elements
%       posnXY(1) = simultion time
%       posnXY(2) = x position
%       posnXY(3) = y position
% outputs:
%   none

function drawSnapshot(posnXY,img)

    % initialize needed parameters
    initParam
    
    % check to see if snapshot should be taken
    if mod(posnXY(1),Param.deltaS) == 0
        % find posn and radius
        posn = [posnXY(2) + Param.absInitX,...
            posnXY(3) + Param.absInitY];
        r = Param.altitude * tand(Param.camAngView);
        posnXY(1)

        % plot snapshot catchment area
        hold on
        figure(1)
        viscircles(posn,r,'Color','g');
        
        %% plot snapshots
        % find upper left corner of snapshot
        snapPosn = [posn(1) - r, posn(2) - r];

        % plot snapshot
        imcrop(img,[snapPosn 2*r 2*r])
        title(sprintf('Snapshot at Time %d',posnXY(1)));
        
    end
    
end