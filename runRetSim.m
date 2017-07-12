% script to run simulation for return journey
% MUST DO ROSINIT FIRST

%% user defined parameters
simStr = 'return_journey'; % extension not needed

%% initialize needed parameters
initParam

%% define global variables
% from exploratory journey
global posn_exp
global snapshotsG
global snapshotPosns
global img
global imgStr

% for return journey
global dirV_ret
global posn_ret
global dirV
global currCam
global currSnap
global currCamPosn
global currSnapPosn
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
dir = turnAround(dir_prev);
dirV_ret = dir';
dirV = dir(2:4);
dirV'

%% update position and plot
posnXYZ = updateRetPosn(dir);
drawRetPath(posnXYZ)

%% initialize currCam and currSnap
% currCam set when drawRetPath called
currCamPosn = posnXYZ(2:3)';
posn = [posnXYZ(2) + Param.absInitX,...
        posnXYZ(3) + Param.absInitY];
offset = Param.snapDim/2;
snapPosn = [posn(1) - offset, posn(2) - offset];
cam = imcrop(img,[snapPosn Param.snapDim-1 Param.snapDim-1]);
currCam = rgb2gray(cam);

% currSnap
snapIdx = length(snapshotsG(1,1,:)) - 1
currSnap = snapshotsG(:,:,snapIdx);
    %((3*snapIdx)-2):(3*snapIdx)); % for snapshotsRGB
currSnapPosn = snapshotPosns(snapIdx,2:3);

% initialize pixOffset
pixOffset = 0;

%% run simulation
sim(simStr,'SrcWorkspace','current');

%% add home to waypoint positions
home = posn_ret(end,:);
waypointPosns = cat(1,waypointPosns,home);

start_posn = posn_exp(1,2:4);
stop_posn = posn_ret(end,2:4);
homeErr = abs(start_posn - stop_posn)

%% evaluate if home or not
if homeErr < Param.homeThresh
    message = 'UAV IS HOME'
else
    message = 'UAV IS TOO FAR FROM HOME'
end
