% script initializes parameters for simulations

%% parameters related to simulations
Param.T = 60; % simulation run time in seconds
Param.deltaT = 0.2; % sample time in seconds
Param.numSamps = Param.T/Param.deltaT; % number of samples

%% parameters related to UAV position
Param.initX = 0; % initial x position (according to UAV)
Param.initY = 0; % initial y position (according to UAV)
Param.altitude = 70; % fixed altitude of UAV
Param.absInitX = 2500; % initial x position (in image)
Param.absInitY = 2500; % initial y position (in image)

%% parameters related to path planning
Param.numRandDirs = 5; % number of divisions of exploratory journey
Param.minRandSlope = -5; % minimum slope of random line
Param.maxRandSlope = 5; % maximum slope of random line

%% parameters related to camera view
Param.camAngView = 65; % angle (degrees) of camera view
