function [power, freq] = getspec(series, dt)
%GETSPEC - This function returns the raw power spectrum and its
%cooresponding frequencies and makes proper adjustments for dt and the
%length of the series so that power spectrums can be easily compared.
%
%   [power, freq] = getspec(series, dt) - where series is a one dimensional
%   array (either rows or cols) and dt is the length of time in seconds
%   betweeen each observation in the series.  This returns the power and
%   the frequency in seconds.
%
%
%   6/08/2007
%   Michael Sneddon


N = length(series);
if mod(N,2)==1, N = N-1; end;    %Adjust for odd series lengths

%take the absolute value (to remove complex numbers) of the 
%fourier transform of our series and normalize by N/2 so that we can
%compare spectrums computed from different lengthed intervals.
transformedSeries = abs(fft(series)) ./ (N/2);

%The transformed data at frequency 0 is simply the sum of the series,
%but we don't want to return that, so just get values starting at index 2.
%Then we can square it to get the power.

power = (2*transformedSeries(2:((N/2)+1))).^2;

%Figure out our frequency based on dt
freq = 1:((N/2));
freq = (freq./(N*dt))';