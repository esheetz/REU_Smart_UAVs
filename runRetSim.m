% script to run simulation for return journey
% MUST DO ROSINIT FIRST

%% user defined parameters
simStr = 'return_journey'; % extension not needed

%% initialize needed parameters
initParam

%% define global variables
% from exploratory journey
global posnX_exp
global posnY_exp
global posnZ_exp
global snapshots

% for return journey
global posnX_ret
global posnY_ret
global posnZ_ret
global currCam
global currSnap
global snapIdx
global pixOffset
global waypointPosns

%% initialize return history
ts_next = dirX(end,1) + Param.deltaT;
posnX_ret = [ts_next posnX_exp(end,2)];
posnY_ret = [ts_next posnY_exp(end,2)];
posnZ_ret = [ts_next posnZ_exp(end,2)];
waypointPosns = [Param.T, posnX_exp(end,2),...
                    posnY_exp(end,2), Param.altitude];

%% get initial direction vector
dir_prev = [dirX(end,1); dirX(end,2); dirY(end,2); dirZ(end,2)];
dirV = turnAround(dir_prev);

%% update position and plot
posnXYZ = updateRetPosn(dirV);
drawRetPath(posnXYZ)

%% initialize currCam and currSnap
% currSnap
snapIdx = Param.T/Param.deltaS + 1;
currSnap = snapshots(:,:,((3*snapIdx)-2):(3*snapIdx));

% currCam
posn = [posnXYZ(2) + Param.absInitX, posnXYZ(3) + Param.absInitY];
offset = Param.snapDim/2;
snapPosn = [posn(1) - offset, posn(2) - offset];
currCam = imcrop(img,[snapPosn Param.snapDim-1 Param.snapDim-1]);

% initialize pixOffset
pixOffset = 0;

%% run simulation
sim(simStr,'SrcWorkspace','current');
