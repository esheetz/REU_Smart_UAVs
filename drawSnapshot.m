% function to draw snapshot
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.altitude, Param.camAngView,
%   Param.absInitX, Param.absInitY
% inputs:
%   posnXY, a vector with 2 elements
%       posnXY(1) = x position
%       posnXY(2) = y position
% outputs:
%   none

function drawSnapshot(posnXY)

    % initialize needed parameters
    initParam
    
    % find posn and radius
    posn = [posnXY(1) + Param.absInitX,...
        posnXY(2) + Param.absInitY];
    r = Param.altitude * tand(Param.camAngView)
    
    % plot snapshot
    hold on
    figure(1)
    viscircles(posn,r,'Color','g');
    
end