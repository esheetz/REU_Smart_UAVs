% script to run simulation for return journey
% MUST DO ROSINIT FIRST

%% user defined parameters
simStr = 'return_journey'; % extension not needed

%% initialize needed parameters
initParam

%% define global variables
global posnX_return
global posnY_return
global posnZ_return
global dirV
global waypointPosns

%% initialize return history
ts_next = posnX(end,1) + Param.deltaT;
posnX_return = [ts_next posnX(end,:)];
posnY_return = [ts_next posnY(end,:)];
posnZ_return = [ts_next Param.altitude];
waypointPosns = [posnX(end,1) posnX(end,2) posnY(end,2)];

%% get initial direction vector
dirV = turnAround(posnX,posnY,posnZ);

%% run simulation
sim(simStr,'SrcWorkspace','current');
