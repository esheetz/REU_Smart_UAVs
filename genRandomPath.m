% function to generate random path for UAV's exploratory journey
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.T, Param.deltaT, Param.numSamps
%   Param.initX, Param.initY, Param.altitude,
%   Param.numRandomDirs, Param.minRandSlope, Param.maxRandSlope
% inputs:
%   none
% outputs:
%   posnX, matrix of sample times and x position (pixels)
%   posnY, matrix of sample times and y position (pixels)
%   posnZ, matrix of sample times and z position (pixels)
% NOTES:
%   does not avoid edges of images
%   starting position (initParam.m) may run path off edge
%   UAV exploratory journey created by coordinates

function [posnX, posnY, posnZ] = genRandomPath

    %% initialize needed parameters
    initParam;

    %% sample times
    % initialize ts (vector of sample times)
    ts = zeros(Param.numSamps+1,1);
    
    % set sample times
    for i = 1:length(ts)
        ts(i) = Param.deltaT*(i-1);
    end
    
    % initialize posnX,Y,Z and set sample times
    posnX = ones(Param.numSamps+1,2);
    posnY = ones(Param.numSamps+1,2);
    posnZ = ones(Param.numSamps+1,2);
    
    posnX(:,1) = ts;
    posnY(:,1) = ts;
    posnZ(:,1) = ts;
    
    %% random path generation
    % determine random slopes
    diffSlope = Param.maxRandSlope - Param.minRandSlope;
    randXslopes = rand(Param.numRandDirs,1);
    randXslopes = diffSlope.*randXslopes;
    randXslopes = randXslopes + Param.minRandSlope;
    randYslopes = rand(Param.numRandDirs,1);
    randYslopes = diffSlope.*randYslopes;
    randYslopes = randYslopes + Param.minRandSlope;
    
    % determine length of paths
    divides = zeros(Param.numRandDirs,1);
    lenDiv = Param.numSamps/Param.numRandDirs;
    
    for i = 1:length(divides)
        divides(i) = (i * lenDiv) + 1;
    end
    
    %% create paths
    % create X,Y paths
    posnX(1,2) = Param.initX;
    posnY(1,2) = Param.initY;
    
    i = 2;
    j = 1;
    idx = i-1;
    xSlope = randXslopes(j);
    ySlope = randYslopes(j);
    slopes = zeros(Param.numSamps+1,2);
    
    while (i <= Param.numSamps+1) && (j <= length(divides))
        while i <= divides(j)
            posnX(i,2) = xSlope*(posnX(i,1) - posnX(idx,1)) + ...
                posnX(idx,2);
            posnY(i,2) = ySlope*(posnY(i,1) - posnY(idx,1)) + ...
                posnY(idx,2);
            slopes(i,:) = [xSlope ySlope];
            i = i+1;
        end
        j = j+1;
        if j <= length(divides)
            idx = i - 1;
            xSlope = randXslopes(j);
            ySlope = randYslopes(j);
        end
    end
    
    % fix altitude for duration of flight
    posnZ(:,2) = Param.altitude;

end