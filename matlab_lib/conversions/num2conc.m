function [ conc ] = num2conc( number )
%CONC2NUM Converts  # of Molecules in a single E.Coli cell to the
%   concentration in uM assuming the cell has a volume of 1.41x10^-15 L.
%
%   Date: 05/01/2007
%   Author: Michael Sneddon


% eColiVolume = 1.41e-15; Liters
% avogado = 6.02214179e23; per mole
% 1uM = 10^-6 mole / L
% factor = eColiVolume*avogado*10^-6 mole/L = 849.122
% then we just divide the number by the factor to get
% the concentration of molecules

conc = number./849.122;