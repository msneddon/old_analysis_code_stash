function [] = formatFigure(varargin)
%  FORMATFIGURE   Changes all the font sizes and font weights in the
%  current figure so that the figure is uniform.  If the figure has
%  subplots, use the FormatFigureS function instead.
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
else fontSize = 15; end;
if nargin>=2, fontWeight = varargin{2};
else fontWeight = 'b'; end;


% make things nice
set(gca, 'TickDir', 'out');
set(gca, 'Box', 'off' );
set(gcf, 'color', 'white');


% Set axis properties
set(gca, 'FontName', 'Arial');
set(gca, 'fontSize', fontSize);
%set(gca, 'fontWeight', fontWeight);

title = get(gca,'title');
yLab = get(gca, 'ylabel');
xLab = get(gca, 'xlabel');

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
