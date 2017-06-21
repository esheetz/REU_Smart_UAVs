% script to run simulation for exploratory journey
% MUST DO ROSINIT FIRST

%% user defined parameters
% change image in runExpSim.m
figName = 'citySim01';
ext = '.jpg';
dataName = 'cityDataSim01';

%% run exploratory simulation
runExpSim

% save exploratory journey figure
saveas(figure(1),strcat(figName,'_exp',ext));

%% run return simulation
runRetSim

%% save data to .mat file for later preprocessing
saveas(figure(1),strcat(figName,'_ret',ext));
save(dataName,'str','dirX','dirY','dirZ',...
    'posnX_exp','posnY_exp','posnZ_exp','snapshots','snapshotPosns',...
    'posnX_ret','posnY_ret','posnZ_ret','waypointPosns');