function [ number ] = conc2num( concentration )
%CONC2NUM Converts a concentration (in um) to # of Molecules in a single
%   E.Coli cell assuming the cell has a volume of 1.41x10^-15 L.
%
%   Date: 05/01/2007
%   Author: Michael Sneddon


% eColiVolume = 1.41e-15; Liters
% avogado = 6.02214179e23; per mole
% 1uM = 10^-6 mole / L
% factor = eColiVolume*avogado*10^6 mole/L = 849.122
% then we just multiply the factor times the concentration to get
% the number of molecules

number = round(concentration.*849.122);