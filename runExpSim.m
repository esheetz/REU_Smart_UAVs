% script to run simulation for exploratory journey
% MUST DO ROSINIT FIRST

%% user defined parameters
% name of image to be read in
str = 'images/city.png'; % absolute path and extension needed
simStr = 'exploratory_journey'; % extension not needed

%% initialize needed parameters
initParam

%% define global variables
global img
global snapshots
global snapshotPosns

%% create random paths
[posnX,posnY,posnZ] = genRandomPath;

%% read in image and initialize figure
img = imread(str);

close all
figure(1)
image(img)

%% plot first snapshot and save in snapshots

% find posn and radius
posn = [Param.absInitX, Param.absInitY];
r = Param.altitude * tand(Param.camAngView);
0

% plot snapshot catchment area
hold on
figure(1)
viscircles(posn,r,'Color','g');

% find upper left corner of snapshot
offset = Param.snapDim/2;
snapPosn = [posn(1) - offset, posn(2) - offset];

% take snapshot
snap = imcrop(img,[snapPosn Param.snapDim-1 Param.snapDim-1]);

% store snapshot in array
snapshots = snap;
snapshotPosns = [0 0 0];

% plot snapshot
figure
image(snap)
title(sprintf('Snapshot at %d seconds',0));

%% run simulation
sim(simStr,'SrcWorkspace','current');

%% plot camera view at end of exploratory journey
drawSnapshot([Param.T ; posnX(end,2) ; posnY(end,2)]);
