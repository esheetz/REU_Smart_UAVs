% script initializes parameters for simulations

%% parameters related to homing
Param.homeThresh = 15; % pixels of acceptable error from home position

%% parameters related to simulations
Param.T = 180; % exploratory simulation run time in seconds
Param.TStop = 2*Param.T; % return simulation run time in seconds
Param.deltaT = 0.1; % sample time in seconds
Param.numSamps = Param.T/Param.deltaT; % number of samples

%% parameters related to UAV position
Param.initX = 0; % initial x position (according to UAV)
Param.initY = 0; % initial y position (according to UAV)
Param.altitude = 93.3; %81.75; % fixed altitude of UAV
Param.absInitX = 3500; % initial x position (in image)
Param.absInitY = 3500; % initial y position (in image)
% tested absInitPosns:
% (2500, 2500)
% (3500, 1500)
% (1500, 1500)
% (1500, 3500)
% (3500, 3500)

%% parameters related to path planning
Param.numRandDirs = 6; % number of divisions of exploratory journey
Param.minRandSlope = -10; % minimum slope of random line
Param.maxRandSlope = 10; % maximum slope of random line
Param.minRandDir = -1; % unit for determining random directions
Param.maxRandDir = 1; % unit for determining random directions

%% parameters related to camera view and snapshots
Param.camAngView = 65; % angle (degrees) of camera view
Param.deltaS = 30; % take snapshot every deltaS seconds
Param.snapDim = floor(2 * ...
    (Param.altitude * tand(Param.camAngView))); % dim for snapshots
Param.deltaUpdate = 5; % seconds between return currCam updates
Param.switchThresh = 30; % pixel offset indicates snapshot switch
Param.tol = 0.00005; % tolerance for comparisons when updating images

%% paremters related to path optimization
Param.opThresh = 15; % threshold for distance between matched points
