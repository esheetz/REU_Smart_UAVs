% script to run simulation for exploratory journey
% MUST DO ROSINIT FIRST

%% user defined parameters
% change image in runExpSim.m
figName = 'forestSim15';
ext = '.jpg';
optimized = 1;

%% run exploratory simulation
runExpSim

%% save exploratory journey figure
saveas(figure(1),strcat(figName,'_exp',ext));

%% optimize path
global optimizedFlag
global idxCut

if optimized
    pathOptimization
else
    noPathOptimization
end

%% run return simulation
runRetSim

%% save data to .mat file for later preprocessing
if optimized
    saveas(figure(1),strcat(figName,'_retOP',ext));
    save(strcat(figName,'_dataOP'),'Param','imgStr','dirV_exp','posn_exp',...
        'snapshotsRGB','snapshotsG','snapshotsGorig','snapshotPosns',...
        'dirV_ret','posn_ret','waypointPosns','homeErr','message');
else
    saveas(figure(1),strcat(figName,'_ret',ext));
    save(strcat(figName,'_data'),'Param','imgStr','dirV_exp','posn_exp',...
        'snapshotsRGB','snapshotsG','snapshotPosns',...
        'dirV_ret','posn_ret','waypointPosns','homeErr','message');
end
