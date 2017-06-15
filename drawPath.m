% function to draw path
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.absInitX, Param.absInitY
% inputs:
%   posnXY, a vector with 2 elements
%       posnXY(1) = x position
%       posnXY(2) = y position
% outputs:
%   none

function drawPath(posnXY)

    % initialize needed parameters
    initParam
    
    % plot points
    hold on
    figure(1)
    plot(posnXY(1) + Param.absInitX,...
        posnXY(2) + Param.absInitY, 'bo')

end