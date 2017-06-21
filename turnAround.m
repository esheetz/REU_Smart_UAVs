% computes the initial normalized direction vector for return journey
% calls script initParam.m:
%   Param.deltaT
% inputs:
%   dir_prev, normalized 4x1 direction vector
%       dir_prev(1) = simulation time
%       dir_prev(2) = x direction
%       dir_prev(3) = y direction
%       dir_prev(4) = z direction
% outputs:
%   dirV, normalized 4x1 direction vector for return journey
%       dirV(1) = simulation time
%       dirV(2) = x direction
%       dirV(3) = y direction
%       dirV(4) = z direction

function dirV = turnAround(dir_prev)

    % initialize needed parameters
    initParam
    
    % initialize dirV
    dirV = zeros(4,1);
    
    % set values
    dirV(1) = dir_prev(1) + Param.deltaT;
    dirV(2) = -dir_prev(2);
    dirV(3) = -dir_prev(3);
    dirV(4) = -dir_prev(4);

end