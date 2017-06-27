% script to run simulation for return journey
% MUST DO ROSINIT FIRST

%% user defined parameters
simStr = 'return_journey_features'; % extension not needed

%% initialize needed parameters
initParam

%% define global variables
% from exploratory journey
global posn_exp
global snapshotsG
global img
global imgStr

% for return journey
global dirV_ret
global posn_ret
global currCam
global currSnap
global snapIdx
global pixOffset
global waypointPosns

%% initialize return history
ts_next = dirV_exp(end,1) + Param.deltaT;
posn_ret = [ts_next posn_exp(end,2) posn_exp(end,3) posn_exp(end,4)];
waypointPosns = [Param.T, posn_exp(end,2),...
                    posn_exp(end,3), Param.altitude];

%% get initial direction vector
dir_prev = dirV_exp(end,:)';
dirV = turnAround(dir_prev);
dirV_ret = dirV';

%% update position and plot
posnXYZ = updateRetPosn(dirV);
drawRetPath(posnXYZ)

%% initialize currCam and currSnap
% currCam set when drawRetPath called
% currSnap
snapIdx = Param.T/Param.deltaS + 1;
currSnap = snapshotsG(:,:,snapIdx);
    %((3*snapIdx)-2):(3*snapIdx)); % for snapshotsRGB

% initialize pixOffset
pixOffset = 0;

%% run simulation
sim(simStr,'SrcWorkspace','current');
