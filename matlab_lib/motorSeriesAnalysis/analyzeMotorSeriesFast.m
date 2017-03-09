function [cwIntervals, ccwIntervals, cwBias, switchFreq] = analyzeMotorSeriesFast(motorTrace, dt)
% ANALYZEMOTORSERIESFAST - A fast version (which does not use any loops) 
% of analyzing a motor trace where 0 is CW and 1 is CCW.
%
%  [cwIntervals, ccwIntervals, cwBias, switchFreq] = analyzeMotorSeriesFast(motorTrace, dt) - 
%       - motorTrace is a one dimensional column array that contains the trace 
%         of states in 0 or 1.  dt is the length of time between each observation 
%         in the trace.  This method then returns cwIntervals and ccwIntervals 
%         which are arrays of the lengths of CW and CCW intervals in seconds.  
%         The cwBias and switching frequency (in hertz) are also given.
%
%  6/13/07
%  Michael Sneddon

% first, shift the motorTrace by one, and take the difference.  Thus,
% whenever we switch from 0 to 1 we should get a positive 1 and whenever we
% switch from 1 to 0 we should get a negative 1 in s.
s = [motorTrace; motorTrace(end)] - [motorTrace(1); motorTrace];

%let's just find where we switch by finding the index of 1 and -1,
%everything else should be zero so we can just call find(s)
switchIndex = find(s);

%calculate switch freq while we're at it
switchFreq = sum(abs(s)) ./ (length(motorTrace)*dt);

%subtract the switchIndex array from itself to get a list of the lengths of
%all the intervals, both of 0 and 1.
lengths = [switchIndex;length(switchIndex)] - [1;switchIndex];

%now, based on where we started, we can figure out which lengths
%correspond to state 0 and which correspond to state 1
if(motorTrace(1)==0)  
    %then we started in 0, so odd indexes of lengths are 0 intervals
    intervals_0 = lengths(1:2:end);
    intervals_1 = lengths(2:2:end);
    
else  
    %otherwise, we started in 1, so odd indexes of lengths are 1 intervals
    intervals_0 = lengths(2:2:end);
    intervals_1 = lengths(1:2:end);
 
end;

%normalize intervals by dt, and we're done
intervals_0 = intervals_0.*dt;
intervals_1 = intervals_1.*dt;

%throw out the first and last interval, because those intervals were cut
cwIntervals = intervals_0(2:(end-1));
ccwIntervals = intervals_1(2:(end-1));

%calculate cwBias from the motorTrace, and we're done, in no time at all!
cwBias = 1-(sum(motorTrace) ./ length(motorTrace));
