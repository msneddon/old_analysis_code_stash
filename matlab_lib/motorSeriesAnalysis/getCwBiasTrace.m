function [ time, cwBiasTrace ] = getCwBiasTrace( motorTrace, dt, timeResolution, windowSize )
%GETCWBIASTRACE Summary of this function goes here
%   Detailed explanation goes here



%Get parameters normalized by dt
timeStep = timeResolution / dt;
traceInterval = windowSize / dt;

%Init variables to set up the sliding window
startPos = 1;
endPos = startPos + traceInterval;


%Set up output variables
cwBiasTrace = [];
time = [];


while endPos<=length(motorTrace)
    
    cwBiasTrace = [cwBiasTrace, sum(motorTrace(startPos:endPos)) / traceInterval];
    time = [time, (((startPos + endPos) / 2) *dt )];
    
    startPos = startPos + timeStep;
    endPos = startPos + traceInterval;
    
end;