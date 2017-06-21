% updates the position of the UAV
% updated position saved as time series in posnX,Y,Z_exp
% inputs:
%   dirV, normalized 4x1 direction vector
%       dirV(1) = simulation time
%       dirV(2) = x direction
%       dirV(3) = y direction
%       dirV(4) = z direction
% outputs:
%   posnXYZ, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position

function [posnXYZ] = updateExpPosn(dirV)
    %% define global variables
    global posnX_exp
    global posnY_exp
    global posnZ_exp
    
    %% initialize needed parameters
    initParam
    
    %% next timestamp
    ts_next = dirV(1);
    
    %% update position
    posnX_next = posnX_exp(end,2) + dirV(2);
    posnY_next = posnY_exp(end,2) + dirV(3);
    posnZ_next = Param.altitude;
    
    posnX_exp = cat(1,posnX_exp,[ts_next posnX_next]);
    posnY_exp = cat(1,posnY_exp,[ts_next posnY_next]);
    posnZ_exp = cat(1,posnZ_exp,[ts_next posnZ_next]);
    
    posnXYZ = [ts_next posnX_next posnY_next posnZ_next];
    
end