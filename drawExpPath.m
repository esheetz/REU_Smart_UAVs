% function to draw path
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.absInitX, Param.absInitY
% calls function drawSnapshot(posnXY)
% inputs:
%   posnXY, a 3x1 vector with elements:
%       posnXY(1) = simultion time
%       posnXY(2) = x position
%       posnXY(3) = y position
% outputs:
%   none

function drawExpPath(posnXY)
    % initialize needed parameters
    initParam
    
    % plot points
    hold on
    figure(1)
    plot(posnXY(2) + Param.absInitX,...
        posnXY(3) + Param.absInitY, 'bo')
    drawSnapshot(posnXY);

end