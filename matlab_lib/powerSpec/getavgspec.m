function [ power, freq, segLength ] = getavgspec( series, dt, segments )
%GETAVGSPEC - This function returns the average power spectrum and its
%cooresponding frequencies and makes proper adjustments for dt and the
%length of the series so that power spectrums can be easily compared.
%   
%   [power, freq, segLength] = getspec(series, dt, segments) - where series 
%   is a one dimensional array (either rows or cols) and dt is the length 
%   of time in seconds betweeen each observation in the series.  Segments
%   is the number of segments you want your series divided into.  If series
%   cannot be evenly divided into the number of segments requested, then
%   this method will still create and average with the requested number of
%   segments, but will ignore the very end of the series that could not
%   be fit into a segment.  This method returns the averaged power and
%   frequency in seconds and the length of the segments it created also in
%   seconds.
%
%   6/08/2007
%   Michael Sneddon

%Split up the series into equal parts and do the math
series = series(1:(end-mod(length(series),segments)));
stateCount = length(series)/segments;
power = [];

%Get a power spectrum for each segment
for i = 0:(segments-1)
    
    startIndex = round(i*stateCount)+1;
    endIndex = round((i+1)*stateCount);
    
    [p,f] = getspec(series(startIndex:endIndex),dt);
    
    if(i==0) 
        power = p; 
    else
        power = p + power;
    end;
    
    
end;

%Finish up and return the results
segLength = (endIndex - startIndex + 1)*dt;
power = power./segments;
freq = f;

%freq = (1:round(N/2))/(round(N/2))*(1/dt)*1/2;   %added *1/2
%power = power*dt/stateCount; 

