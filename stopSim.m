% determine whether or not to stop the return simulation
% calls script initParam.m:
%   Param.homeThresh, Param.TStop
% inputs:
%   filler input
% outputs:
%   boolean corresponding to 0 or 1 value
% NOTE:
%   simulation will stop automatically at Param.TStop
%   simulation will stop when function outputs nonzero (true) value

function bool = stopSim(~)

    %% define global variables
    global snapIdx
    global posn_ret
    
    %% initialize needed parameters
    initParam
    
    %% compare current position to home
    if abs(posn_ret(end,2:3)) < Param.homeThresh
        homeBool = true;
    else
        homeBool = false;
    end
    
    %% check to see if simulation should stop
    % check index out of bounds
    if snapIdx < 1
        if posn_ret(end,1) < Param.TStop
            snapIdx = 1;
        else
            bool = 1;
        end
    % check position while homing
    elseif (snapIdx == 1) && homeBool
        bool = 1;
    % else, continue
    else
        bool = 0;
    end

end