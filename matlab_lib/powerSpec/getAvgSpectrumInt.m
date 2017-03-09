function [ power, freq, segCount ] = getAvgSpectrumInt( series, dt, intervalLength )
%GETAVGSPECTRUM Takes a time series and generates the average 
%   power spectrum based on the given dt.
%
%   [power, freq, segCount] = getAvgSpectrumInt(series, dt, intervalLength) - Allows you to
%   specify the exact length of the segments you wish to split the series
%   into.  Series is your series of data.  dt is the time in seconds
%   between each event in the series.  intervalLength is the length in
%   seconds of each segment you want to average over.  This method returns
%   the power, freq, and the number of segments that were used to generate
%   the spectrum.  (Note: if intervalLength / dt is not an integer, this
%   function will round to the nearest integer)
%
%   6/01/2007
%   Michael Sneddon


interval = round(intervalLength / dt);

startIndex = 1;
endIndex = startIndex + interval - 1;
segCount = 0;
if endIndex>length(series)
    power = [];
    freq = [];
    return;
end;

while endIndex<=length(series)
    
    transformedSeries = fft(series(startIndex:endIndex));
    N = length(transformedSeries);
    transformedSeries(1) = [];
    segpower = abs(transformedSeries(1:round(N/2))).^2;
    
    if(size(segpower,2) > 1), segpower = segpower'; end;
    
    if(startIndex==1) 
        power = segpower; 
    else
        power = segpower + power;
    end;
    
    startIndex = startIndex + interval;
    endIndex = endIndex + interval;
    segCount = segCount + 1;
    
end;

power = power./segCount;

%Finish up and return the results
freq = (1:round(N/2))/(round(N/2))*(1/dt);
power = power./sum(power);