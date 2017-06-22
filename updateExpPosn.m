% updates the position of the UAV
% updated position saved as time series in posn_exp
% calls script initParam.m:
%   Param.altitude
% inputs:
%   dirV, normalized 4x1 direction vector
%       dirV(1) = simulation time
%       dirV(2) = x direction
%       dirV(3) = y direction
%       dirV(4) = z direction
% outputs:
%   posnXYZ, a 4x1 vector
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position

function [posnXYZ] = updateExpPosn(dirV)
    %% define global variables
    global posn_exp
    
    %% initialize needed parameters
    initParam
    
    %% next timestamp
    ts_next = dirV(1);
    
    %% update position
    posnX_next = posn_exp(end,2) + dirV(2);
    posnY_next = posn_exp(end,3) + dirV(3);
    posnZ_next = Param.altitude;
    
    posnXYZ = [ts_next; posnX_next; posnY_next; posnZ_next];
    posn_exp = cat(1,posn_exp,posnXYZ');
    
end