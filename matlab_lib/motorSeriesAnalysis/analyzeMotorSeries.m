function [cwRunLengths, ccwRunLengths, cwBias, switchFreq] = analyzeMotorSeries(motorTrace, dt)
%  OBSOLETE - use analyzeMotorSeriesFast instead for the same results
%  at a fraction of the time.
%
%
%  Michael Sneddon

cwRunLengths = [];
ccwRunLengths = [];
switchCount = 0;


%Analyze the data...
lastState = motorTrace(1);
duration = 1;
for i=2:length(motorTrace)

    currentState = motorTrace(i);
    if(currentState==lastState)
        duration = duration + 1;
        continue;
    else
        if(currentState==0)
            %Then we switched from ccw to cw
            ccwRunLengths = [ccwRunLengths, duration];
        else
            %we switched from cw to ccw
            cwRunLengths = [cwRunLengths, duration];
        end;
        switchCount = switchCount + 1;
        duration = 1;
    end;
    lastState = currentState;
end;

%translate to seconds
cwRunLengths = cwRunLengths .* dt;
ccwRunLengths = ccwRunLengths .* dt;

cwBias = sum(cwRunLengths)/(sum(cwRunLengths)+sum(ccwRunLengths));
switchFreq = switchCount / (sum(cwRunLengths)+sum(ccwRunLengths));