function [] = formatFigureS(varargin)
%  FORMATFIGURES   Changes all the font sizes and font weights in the
%  current figure so that the figure is uniform if the figure has a
%  subplot.  If the figure does not have subplots, use the FormatFigure
%  method instead.
%
%   [] = formatFigure() - Sets font size = 12 and font weight = 'b'
%
%   [] = formatFigure(fontSize) - Sets font size to the specified value 
%        and the font weight = 'b'
%
%   [] = formatFigure(fontSize, fontWeight) - Sets font size and the font
%        weight to the specified values
%
%   6/07/07
%   Michael Sneddon



% Options
if nargin>=1, fontSize = varargin{1};
else fontSize = 12; end;
if nargin>=2, fontWeight = varargin{2};
else fontWeight = 'b'; end;



ax = get(gcf,'Children');


% Set axis properties
set(ax, 'fontSize', fontSize);
set(ax, 'fontWeight', fontWeight);

ti = get(ax,'title');
yL = get(ax, 'ylabel');
xL = get(ax, 'xlabel');

title = zeros(length(ti),1);
for i=1:length(ti), title(i) = ti{i}; end;

yLab = zeros(length(yL),1);
for i=1:length(yL), yLab(i) = yL{i}; end;
xLab = zeros(length(xL),1);
for i=1:length(xL), xLab(i) = xL{i}; end;

set(title, 'fontSize', fontSize);
set(title, 'fontWeight', fontWeight);

set(yLab, 'fontSize', fontSize);
set(xLab, 'fontSize', fontSize);
set(yLab, 'fontWeight', fontWeight);
set(xLab, 'fontWeight', fontWeight);



%Adjust legend properties
[leg, lin] = legend();
set(leg, 'fontSize', fontSize);
set(leg, 'fontWeight', fontWeight);
