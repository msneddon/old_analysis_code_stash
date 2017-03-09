function [ ] = nicePrint( filename, width)
%NICEPRINT Simple function which saves high quality (100) jpegs to the desktop
%          at 300dpi at the specified width and font size
%
%   [ ] = nicePrint(filename) - uses the given filename.
%
%   6/04/2007
%   Michael Sneddon



exportfig(gcf, ['//home/msneddon/Desktop/' filename], 'format', 'jpeg100', 'width', width, 'resolution', 300, 'linemode', 'scaled','fontmode','scaled');
%print(gcf, ['//home/msneddon/Desktop/' filename], '-djpeg100', '-r300');