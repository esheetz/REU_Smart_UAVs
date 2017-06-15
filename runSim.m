% script to run simulation
% MUST DO ROSINIT FIRST

%% user defined parameters
% name of image to be read in
str = 'images/city.png'; % absolute path and extension needed
simStr = 'exploratory_journey'; % extension not needed

%% initialize needed parameters
initParam

%% create random paths
[posnX,posnY,posnZ] = genRandomPath;

%% read in image and initialize figure
img = imread(str);

close all
figure(1)
image(img)

%% run simulation
sim(simStr,'SrcWorkspace','current');

%% plot camera view at end of exploratory journey
drawSnapshot([Param.T posnX(end,2) posnY(end,2)],img)
