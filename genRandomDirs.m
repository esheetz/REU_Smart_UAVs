% function to generate directions for UAV's exploratory journey
% can alter parameters in initParam.m
% calls script initParam.m:
%   Param.deltaT, Param.numSamps,
%   Param.numRandomDirs, Param.minRandDir, Param.maxRandDir
% inputs:
%   none
% outputs:
%   dirV_exp, matrix of sample times and x,y,z direction
% NOTES:
%   does not avoid edges of images
%   starting position (initParam.m) may run path off edge
%   UAV exploratory journey created by coordinates

function dirV_exp = genRandomDirs

    %% initialize needed parameters
    initParam;

    %% sample times
    % initialize ts (vector of sample times)
    ts = zeros(Param.numSamps+1,1);
    
    % set sample times
    for i = 1:length(ts)
        ts(i) = Param.deltaT*(i-1);
    end
    
    % initialize dirV_exp and set sample times
    dirV_exp = zeros(Param.numSamps+1,4); %dirZ complete
    
    dirV_exp(:,1) = ts;
    
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
        dirV_exp(init:init+lenDiv,2) = randXdirs(i);
        dirV_exp(init:init+lenDiv,3) = randYdirs(i);
        init = init + lenDiv;
        i = i + 1;
    end

end