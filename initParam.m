% script initializes parameters for simulations

%% parameters related to simulations
Param.T = 60; % simulation run time in seconds
Param.deltaT = 0.5; % sample time in seconds
Param.numSamps = Param.T/Param.deltaT; % number of samples

%% parameters related to UAV position
Param.initX = 500; % initial x position
Param.initY = 500; % initial y position
Param.altitude = 10; % fixed altitude of UAV

%% parameters related to path planning
Param.numRandDirs = 5; % number of divisions of exploratory journey
Param.minRandSlope = -5; % minimum slope of random line
Param.maxRandSlope = 5; % maximum slope of random line
