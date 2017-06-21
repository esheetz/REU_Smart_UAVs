% function to generate directions for UAV's exploratory journey
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.deltaT, Param.numSamps,
%   Param.numRandomDirs, Param.minRandDir, Param.maxRandDir
% inputs:
%   none
% outputs:
%   dirX, matrix of sample times and x direction
%   dirY, matrix of sample times and y direction
%   dirZ, matrix of sample times and z direction
% NOTES:
%   does not avoid edges of images
%   starting position (initParam.m) may run path off edge
%   UAV exploratory journey created by coordinates

function [dirX, dirY, dirZ] = genRandomDirs

    %% initialize needed parameters
    initParam;

    %% sample times
    % initialize ts (vector of sample times)
    ts = zeros(Param.numSamps+1,1);
    
    % set sample times
    for i = 1:length(ts)
        ts(i) = Param.deltaT*(i-1);
    end
    
    % initialize dirX,Y,Z and set sample times
    dirX = zeros(Param.numSamps+1,2);
    dirY = zeros(Param.numSamps+1,2);
    dirZ = zeros(Param.numSamps+1,2); % dirZ complete
    
    dirX(:,1) = ts;
    dirY(:,1) = ts;
    dirZ(:,1) = ts;
    
    %% random direction generation
    % determine random slopes
    diffSlope = Param.maxRandDir - Param.minRandDir;
    randXdirs = rand(Param.numRandDirs,1);
    randXdirs = diffSlope.*randXdirs;
    randXdirs = randXdirs + Param.minRandDir;
    randYdirs = rand(Param.numRandDirs,1);
    randYdirs = diffSlope.*randYdirs;
    randYdirs = randYdirs + Param.minRandDir;
    
    % normalize
    for i = 1:Param.numRandDirs
        len = norm([randXdirs(i) randYdirs(i)]);
        randXdirs(i) = (1/len) * randXdirs(i);
        randYdirs(i) = (1/len) * randYdirs(i);
    end
    
    % determine length of paths
    lenDiv = Param.numSamps/Param.numRandDirs;
    
    %% create directions
    % create X,Y directions
    init = 1;
    i = 1;
    while (init < Param.numSamps + 1) && (i <= Param.numRandDirs)
        dirX(init:init+lenDiv,2) = randXdirs(i);
        dirY(init:init+lenDiv,2) = randYdirs(i);
        init = init + lenDiv;
        i = i + 1;
    end

end