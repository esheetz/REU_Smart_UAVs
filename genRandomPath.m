% function to generate random path for UAV's exploratory journey
% inputs:
%   T, total simulation run time in seconds
%   deltaT, sample time in seconds
% outputs:
%   posnX, matrix of sample times and x position (pixels)
%   posnY, matrix of sample times and y position (pixels)
%   posnZ, matrix of sample times and z position (pixels)

function [posnX, posnY, posnZ] = genRandomPath

    initParam;

    % compute number of samples
    numSamps = Param.T/Param.deltaT;
    
    % initialize ts (vector of sample times)
    ts = zeros(numSamps+1,1);
    
    % set sample times
    for i = 1:length(ts)
        ts(i) = Param.deltaT*(i-1);
    end
    
    % initialize posnX,Y,Z and set sample times
    posnX = ones(numSamps+1,2);
    posnY = ones(numSamps+1,2);
    posnZ = ones(numSamps+1,2);
    
    posnX(:,1) = ts;
    posnY(:,1) = ts;
    posnZ(:,1) = ts;
    
    % fix altitude for duration of flight
    posnZ(:,2) = Param.altitude;
    
    % create X,Y paths
    posnX(1,2) = 15;
    posnY(1,2) = 15;
    
    for i = 2:length(posnX)
        posnX(i,2) = 3*posnX(i,1) + posnX(1,2);
    end
    
    for i = 2:length(posnY)
        posnY(i,2) = 2*posnY(i,1) + posnY(1,2);
    end

end