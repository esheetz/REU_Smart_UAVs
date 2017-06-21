% function to draw path
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.absInitX, Param.absInitY
% calls function drawSnapshot(posnXY)
% inputs:
%   posnXYZ, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position
% outputs:
%   none

function drawRetPath(posnXYZ)
    % initialize needed parameters
    initParam
    
    % plot points
    hold on
    figure(1)
    plot(posnXYZ(2) + Param.absInitX,...
        posnXYZ(3) + Param.absInitY, 'ro')

end