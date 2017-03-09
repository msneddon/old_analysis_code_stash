function [cwDist, ccwDist, centers] = getDistNorm(cwRuns, ccwRuns, binSize)

if(isempty(cwRuns) || isempty(ccwRuns))
    cwDist = 1; ccwDist = 1; centers = 1;
end;

maxLength = max(5, ( max(max(cwRuns),max(ccwRuns)) ) );
edges = 0:binSize:maxLength;
if(isempty(edges))
    edges = 0:binSize:binSize*3;
end;
centers = edges + ((edges(2)-edges(1))/2);

cwDist = histc(cwRuns,edges);
ccwDist = histc(ccwRuns,edges);
cwDist = (cwDist./sum(cwDist));
ccwDist = (ccwDist./sum(ccwDist));