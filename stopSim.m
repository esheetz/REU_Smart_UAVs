% determine whether or not to stop the return simulation
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
    
    %% check to see if simulation should stop
    if snapIdx < 1
        bool = true; % corresponds to 1
    else
        bool = false; % corresponds to 0
    end

end