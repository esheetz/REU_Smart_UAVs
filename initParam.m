% script initializes parameters for simulations

%% parameters related to simulations
Param.T = 180; % simulation run time in seconds
Param.deltaT = 0.1; % sample time in seconds
Param.numSamps = Param.T/Param.deltaT; % number of samples

%% parameters related to UAV position
Param.initX = 0; % initial x position (according to UAV)
Param.initY = 0; % initial y position (according to UAV)
Param.altitude = 70; % fixed altitude of UAV
Param.absInitX = 2500; % initial x position (in image)
Param.absInitY = 2500; % initial y position (in image)

%% parameters related to path planning
Param.numRandDirs = 5; % number of divisions of exploratory journey
Param.minRandSlope = -10; % minimum slope of random line
Param.maxRandSlope = 10; % maximum slope of random line
Param.minRandDir = -1; % unit for determining random directions
Param.maxRandDir = 1; % unit for determining random directions

%% parameters related to camera view and snapshots
Param.camAngView = 65; % angle (degrees) of camera view
Param.deltaS = 20; % take snapshot every deltaS seconds
Param.snapDim = floor(2 * ...
    (Param.altitude * tand(Param.camAngView))); % dim for snapshots
