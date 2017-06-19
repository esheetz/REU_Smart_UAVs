% updates the position of the UAV
% updated position saved as time series in posnX_return and posnY_return
% inputs:
%   dirV, normalized direction vector
% outputs:
%   posnXY, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position

function [posnXYZ] = updatePosn(dirV)
    %% define global variables
    global posnX_return
    global posnY_return
    global posnZ_return
    
    %% initialize needed parameters
    initParam
    
    %% next timestamp
    ts_next = posnX_return(end,1) + Param.deltaT;
    
    %% update position
    posnX_next = posnX_return(end,2) + dirV(1);
    posnY_next = posnY_return(end,2) + dirV(2);
    posnZ_next = Param.altitude;
    
    posnX_return = cat(1,posnX_return,[ts_next posnX_next]);
    posnY_return = cat(1,posnY_return,[ts_next posnY_next]);
    posnZ_return = cat(1,posnZ_return,[ts_next posnZ_next]);
    
    posnXYZ = [ts_next posnX_next posnY_next posnZ_next];
    
end