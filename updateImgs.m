% updates currCam and currSnap images
% calls script initParam.m:
%   Param.T, Param.deltaUpdate, Param.tol,
%   Param.snapDim
% inputs:
%   posnXYZ, a vector with 4 elements
%       posnXYZ(1) = simultion time
%       posnXYZ(2) = x position
%       posnXYZ(3) = y position
%       posnXYZ(4) = z position
% outputs:
%   none

function updateImgs(posnXYZ)

    %% define global variables
    global optimizedFlag
    
    %% initialize needed parameters
    initParam
    
    %% update currCam
    if (posnXYZ(1) > Param.T) && ...
            (mod(posnXYZ(1),Param.deltaUpdate) <= Param.tol)
        updateCam(posnXYZ)
    end
    
    %% update currSnap
    % call out to proper function based on optimization
    if optimizedFlag
        updateImgsPathOp(posnXYZ)
    else
        updateImgsNoPathOp(posnXYZ)
    end
    
end