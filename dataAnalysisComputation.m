% script for analyzing data
% specifically details with computation

%% load data
load('data')

%% computations for suburb experiments

% percent of successful homing experiments
perCity = numHomeCity/numTests;

% percent of successful optimized homing experiments of successful homing
perOPCity = numHomeOPCity/numHomeCity;

% percent decrease in distance
sumExp = 0;
sumExpOP = 0;
sumRet = 0;
sumRetOP = 0;
for i = 1:numTests
    if homeCity(i)
        if homeOPCity(i)
            sumExpOP = sumExpOP + distExpCity(i);
            sumRetOP = sumRetOP + distRetOPCity(i);
        else
            sumExp = sumExp + distExpCity(i);
            sumRet = sumRet + distRetCity(i);
        end
    end
end

aveDistExp = sumExp/numHomeCity;
aveDistExpOP = sumExpOP/numHomeOPCity;
aveDistRet = sumRet/numHomeCity;
aveDistRetOP = sumRetOP/numHomeOPCity;

distDecCity = (aveDistExp - aveDistRet)/aveDistExp;
distDecOPCity = (aveDistExpOP - aveDistRetOP)/aveDistExpOP;

% average time difference
sumTime = 0;
for i = 1:numTests
    if homeCity(i) && homeOPCity(i)
        sumTime = sumTime + diffTimeOPCity(i);
    end
end

timeDecOPCity = sumTime/numHomeOPCity;

%% computations for desert environment

% percent of successful homing experiments
perDes = numHomeDes/numTests;

% percent of successful optimized homing experiments of successful homing
perOPDes = numHomeOPDes/numHomeDes;

% percent decrease in distance
sumExp = 0;
sumExpOP = 0;
sumRet = 0;
sumRetOP = 0;
for i = 1:numTests
    if homeDes(i)
        if homeOPDes(i)
            sumExpOP = sumExpOP + distExpDes(i);
            sumRetOP = sumRetOP + distRetOPDes(i);
        else
            sumExp = sumExp + distExpDes(i);
            sumRet = sumRet + distRetDes(i);
        end
    end
end

aveDistExp = sumExp/numHomeDes;
aveDistExpOP = sumExpOP/numHomeOPDes;
aveDistRet = sumRet/numHomeDes;
aveDistRetOP = sumRetOP/numHomeOPDes;

distDecDes = (aveDistExp - aveDistRet)/aveDistExp;
distDecOPDes = (aveDistExpOP - aveDistRetOP)/aveDistExpOP;

% average time difference
sumTime = 0;
for i = 1:numTests
    if homeDes(i) && homeOPDes(i)
        sumTime = sumTime + diffTimeOPDes(i);
    end
end

timeDecOPDes = sumTime/numHomeOPDes;

%% computations for forest environment

% percent of successful homing experiments
perFor = numHomeFor/numTests;

% percent of successful optimized homing experiments of successful homing
perOPFor = numHomeOPFor/numHomeFor;

% percent decrease in distance
sumExp = 0;
sumExpOP = 0;
sumRet = 0;
sumRetOP = 0;
for i = 1:numTests
    if homeFor(i)
        if homeOPFor(i)
            sumExpOP = sumExpOP + distExpFor(i);
            sumRetOP = sumRetOP + distRetOPFor(i);
        else
            sumExp = sumExp + distExpFor(i);
            sumRet = sumRet + distRetFor(i);
        end
    end
end

aveDistExp = sumExp/numHomeFor;
aveDistExpOP = sumExpOP/numHomeOPFor;
aveDistRet = sumRet/numHomeFor;
aveDistRetOP = sumRetOP/numHomeOPFor;

distDecFor = (aveDistExp - aveDistRet)/aveDistExp;
distDecOPFor = (aveDistExpOP - aveDistRetOP)/aveDistExpOP;

% average time difference
sumTime = 0;
for i = 1:numTests
    if homeFor(i) && homeOPFor(i)
        sumTime = sumTime + diffTimeOPFor(i);
    end
end

timeDecOPFor = sumTime/numHomeOPFor;

%% computations for overall experiments

% stitch data together
diffDistTotal = [diffDistCity ; diffDistDes ; diffDistFor];
diffDistOPTotal = [diffDistOPCity ; diffDistOPDes ; diffDistOPFor];
diffTimeOPTotal = [diffTimeOPCity ; diffTimeOPDes ; diffTimeOPFor];
distExpTotal = [distExpCity ; distExpDes ; distExpFor];
distRetTotal = [distRetCity ; distRetDes ; distRetFor];
distRetOPTotal = [distRetOPCity ; distRetOPDes ; distRetOPFor];
homeTotal = [homeCity ; homeDes ; homeFor];
homeOPTotal = [homeOPCity ; homeOPDes ; homeOPFor];
numSnapsOPTotal = [numSnapsOPCity ; numSnapsOPDes ; numSnapsOPFor];
numHomeTotal = numHomeCity + numHomeDes + numHomeFor;
numHomeOPTotal = numHomeOPCity + numHomeOPDes + numHomeOPFor;
numTestsTotal = 3*numTests;

% percent of successful homing experiments
perTotal = numHomeTotal/numTestsTotal;

% percent of successful optimized homing experiments of successful homing
perOPTotal = numHomeOPTotal/numHomeTotal;

% percent decrease in distance
sumExp = 0;
sumExpOP = 0;
sumRet = 0;
sumRetOP = 0;
for i = 1:numTestsTotal
    if homeTotal(i)
        if homeOPTotal(i)
            sumExpOP = sumExpOP + distExpTotal(i);
            sumRetOP = sumRetOP + distRetOPTotal(i);
        else
            sumExp = sumExp + distExpTotal(i);
            sumRet = sumRet + distRetTotal(i);
        end
    end
end

aveDistExp = sumExp/numHomeTotal;
aveDistExpOP = sumExpOP/numHomeOPTotal;
aveDistRet = sumRet/numHomeTotal;
aveDistRetOP = sumRetOP/numHomeOPTotal;

distDecTotal = (aveDistExp - aveDistRet)/aveDistExp;
distDecOPTotal = (aveDistExpOP - aveDistRetOP)/aveDistExpOP;

% average time difference
sumTime = 0;
for i = 1:numTestsTotal
    if homeTotal(i) && homeOPTotal(i)
        sumTime = sumTime + diffTimeOPTotal(i);
    end
end

timeDecOPTotal = sumTime/numHomeOPTotal;

% average snap optimization
sumSnap = 0;
for i = 1:numTestsTotal
    if homeTotal(i) && homeOPTotal(i)
        sumSnap = sumSnap + numSnapsOPTotal(i);
    end
end

snapDecTotal = sumSnap/numHomeOPTotal;
