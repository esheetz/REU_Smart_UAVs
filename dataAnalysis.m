% script for getting data from .mat files collected during experiments

%% initialize needed parameters
initParam
numTests = 15;

%% get data from city experiments
% initialize vectors for data
distExpCity = zeros(numTests,1); % distance travelled in exp journey
distRetCity = zeros(numTests,1); % distance travelled in ret journey
homeCity = zeros(numTests,1); % boolean for home in ret journey
distRetOPCity = zeros(numTests,1); % distance travelled in retOP journey
homeOPCity = zeros(numTests,1); % boolean for home in retOP journey
numSnapsOPCity = zeros(numTests,1); % number of snaps optimized
diffTimeOPCity = zeros(numTests,1); % amount of time optimized

% cycle through experiments
for i = 1:numTests
    %% load data from return journey
    if i < 10
        load(strcat('experiments/citySim0',num2str(i),'_data'))
    else
        load(strcat('experiments/citySim',num2str(i),'_data'))
    end
    
    %% compute necessary information
    % distance travelled in exploratory journey
    distExp = 0;
    for j = 2:length(snapshotPosns(:,1))
        distExp = distExp + ...
            sqrt((snapshotPosns(j,2) - snapshotPosns(j-1,2))^2 + ...
            (snapshotPosns(j,3) - snapshotPosns(j-1,3))^2);
    end
    distExpCity(i) = distExp;
    
    % distance travelled in return journey
    distRet = 0;
    for j = 2:length(waypointPosns(:,1))
        distRet = distRet + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetCity(i) = distRet;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeCity(i) = 1;
    else
        homeCity(i) = 0;
    end
    
    retTime = posn_ret(end,1);
    
    %% load data from optimized return journey
    if i < 10
        load(strcat('experiments/citySim0',num2str(i),'_dataOP'))
    else
        load(strcat('experiments/citySim',num2str(i),'_dataOP'))
    end
    
    %% compute necessary information
    % distance travelled in optimized return journey
    distRetOP = 0;
    for j = 2:length(waypointPosns(:,1))
        distRetOP = distRetOP + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetOPCity(i) = distRetOP;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeOPCity(i) = 1;
    else
        homeOPCity(i) = 0;
    end
    
    % number of snaps optimized
    numSnapsOPCity(i) = 7 - length(snapshotsG(1,1,:));
    
    % amount of time optimized
    diffTimeOPCity(i) = retTime - posn_ret(end,1);
    
end

%% get data from desert experiments
% initialize vectors for data
distExpDes = zeros(numTests,1); % distance travelled in exp journey
distRetDes = zeros(numTests,1); % distance travelled in ret journey
homeDes = zeros(numTests,1); % boolean for home in ret journey
distRetOPDes = zeros(numTests,1); % distance travelled in retOP journey
homeOPDes = zeros(numTests,1); % boolean for home in retOP journey
numSnapsOPDes = zeros(numTests,1); % number of snaps optimized
diffTimeOPDes = zeros(numTests,1); % amount of time optimized

% cycle through experiments
for i = 1:numTests
    %% load data from return journey
    if i < 10
        load(strcat('experiments/desertSim0',num2str(i),'_data'))
    else
        load(strcat('experiments/desertSim',num2str(i),'_data'))
    end
    
    %% compute necessary information
    % distance travelled in exploratory journey
    distExp = 0;
    for j = 2:length(snapshotPosns(:,1))
        distExp = distExp + ...
            sqrt((snapshotPosns(j,2) - snapshotPosns(j-1,2))^2 + ...
            (snapshotPosns(j,3) - snapshotPosns(j-1,3))^2);
    end
    distExpDes(i) = distExp;
    
    % distance travelled in return journey
    distRet = 0;
    for j = 2:length(waypointPosns(:,1))
        distRet = distRet + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetDes(i) = distRet;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeDes(i) = 1;
    else
        homeDes(i) = 0;
    end
    
    retTime = posn_ret(end,1);
    
    %% load data from optimized return journey
    if i < 10
        load(strcat('experiments/desertSim0',num2str(i),'_dataOP'))
    else
        load(strcat('experiments/desertSim',num2str(i),'_dataOP'))
    end
    
    %% compute necessary information
    % distance travelled in optimized return journey
    distRetOP = 0;
    for j = 2:length(waypointPosns(:,1))
        distRetOP = distRetOP + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetOPDes(i) = distRetOP;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeOPDes(i) = 1;
    else
        homeOPDes(i) = 0;
    end
    
    % number of snaps optimized
    numSnapsOPDes(i) = 7 - length(snapshotsG(1,1,:));
    
    % amount of time optimized
    diffTimeOPDes(i) = retTime - posn_ret(end,1);
    
end

% script for analyzing data

%% initialize needed parameters
initParam
numTests = 15;

%% get data from forest experiments
% initialize vectors for data
distExpFor = zeros(numTests,1); % distance travelled in exp journey
distRetFor = zeros(numTests,1); % distance travelled in ret journey
homeFor = zeros(numTests,1); % boolean for home in ret journey
distRetOPFor = zeros(numTests,1); % distance travelled in retOP journey
homeOPFor = zeros(numTests,1); % boolean for home in retOP journey
numSnapsOPFor = zeros(numTests,1); % number of snaps optimized
diffTimeOPFor = zeros(numTests,1); % amount of time optimized

% cycle through experiments
for i = 1:numTests
    %% load data from return journey
    if i < 10
        load(strcat('experiments/forestSim0',num2str(i),'_data'))
    else
        load(strcat('experiments/forestSim',num2str(i),'_data'))
    end
    
    %% compute necessary information
    % distance travelled in exploratory journey
    distExp = 0;
    for j = 2:length(snapshotPosns(:,1))
        distExp = distExp + ...
            sqrt((snapshotPosns(j,2) - snapshotPosns(j-1,2))^2 + ...
            (snapshotPosns(j,3) - snapshotPosns(j-1,3))^2);
    end
    distExpFor(i) = distExp;
    
    % distance travelled in return journey
    distRet = 0;
    for j = 2:length(waypointPosns(:,1))
        distRet = distRet + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetFor(i) = distRet;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeFor(i) = 1;
    else
        homeFor(i) = 0;
    end
    
    retTime = posn_ret(end,1);
    
    %% load data from optimized return journey
    if i < 10
        load(strcat('experiments/forestSim0',num2str(i),'_dataOP'))
    else
        load(strcat('experiments/forestSim',num2str(i),'_dataOP'))
    end
    
    %% compute necessary information
    % distance travelled in optimized return journey
    distRetOP = 0;
    for j = 2:length(waypointPosns(:,1))
        distRetOP = distRetOP + ...
            sqrt((waypointPosns(j,2) - waypointPosns(j-1,2))^2 + ...
            (waypointPosns(j,3) - waypointPosns(j-1,3))^2);
    end
    distRetOPFor(i) = distRetOP;
    
    % home in return journey
    if homeErr < Param.homeThresh
        homeOPFor(i) = 1;
    else
        homeOPFor(i) = 0;
    end
    
    % number of snaps optimized
    numSnapsOPFor(i) = 7 - length(snapshotsG(1,1,:));
    
    % amount of time optimized
    diffTimeOPFor(i) = retTime - posn_ret(end,1);
    
end