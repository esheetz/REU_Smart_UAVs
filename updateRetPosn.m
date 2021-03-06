% updates the position of the UAV
% updated position saved as time series in posn_ret
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

function [posnXYZ] = updateRetPosn(dirV)
    %% define global variables
    global dirV_ret
    global posn_ret
    
    %% initialize needed parameters
    initParam
    
    %% update dirV_ret
    dirV_ret = cat(1,dirV_ret,dirV');
    
    %% next timestamp
    ts_next = dirV(1);
    
    %% update position
    posnX_next = posn_ret(end,2) + dirV(2);
    posnY_next = posn_ret(end,3) + dirV(3);
    posnZ_next = Param.altitude;
    
    posnXYZ = [ts_next; posnX_next; posnY_next; posnZ_next];
    posn_ret = cat(1,posn_ret,posnXYZ');
    
end