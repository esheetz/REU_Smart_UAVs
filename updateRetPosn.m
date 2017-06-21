% updates the position of the UAV
% updated position saved as time series in posnX_return and posnY_return
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

function [posnXYZ] = updateRetPosn(dirV)
    %% define global variables
    global posnX_ret
    global posnY_ret
    global posnZ_ret
    
    %% initialize needed parameters
    initParam
    
    %% next timestamp
    ts_next = dirV(1);
    
    %% update position
    posnX_next = posnX_ret(end,2) + dirV(2);
    posnY_next = posnY_ret(end,2) + dirV(3);
    posnZ_next = Param.altitude;
    
    posnX_ret = cat(1,posnX_ret,[ts_next posnX_next]);
    posnY_ret = cat(1,posnY_ret,[ts_next posnY_next]);
    posnZ_ret = cat(1,posnZ_ret,[ts_next posnZ_next]);
    
    posnXYZ = [ts_next posnX_next posnY_next posnZ_next];
    
end