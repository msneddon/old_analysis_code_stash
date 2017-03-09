




Zt = 15000;	%Z coordinate of the top of the tube
Zb = 0;	%Z coordinate of the base of the tube
Zc = 7000;   %Z coordinate of the mouth of the capillary
Re = 4000;%2525;	%Radius of the entire environment
Rc = 250;	%Radius of the capillary
Co = 1e-2; %Molar
Da = 890;

time = 10;
x=-500:10:500;
z=0:10:990;
time=300*1;%60;
conc = zeros(length(z),length(x));

[x,z] = meshgrid(-Re:10:Re,Zb:10:Zc);
y = zeros(size(x));




conc = capField(x,y,z,time,Co,Da,Rc,Zc)*1000;
conc(conc<1e-4)=1e-4;
time=time./60;


figure; hold on;
%mesh(x,z,log10(conc)); hold on;
surf(x,z,log10(conc),'FaceColor','interp','EdgeColor','none','FaceLighting','none'); hold on;
%set(gca, 'ZScale','log');

colormap(jet(1024));
colorbar_log([10^-4 10]);
title(['Time: ',num2str(time),' minutes']);
xlabel('X (mm)');
ylabel('Z (mm)');
%zlabel('log( [Asp] ) (mM)');

% 
% set(gcf, 'color', 'white');
% set(gca,'ZTick',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
% %set(gca,'ZTickLabel',{'10^-^5','10^-^4','10^-^3','pi10^-^2','10^-^1','1','10','10^2'});
% 
% set(gca,'YTick',[0 250 500 750 1000]);
% set(gca,'YTickLabel','0||500||1000|');
% 
% set(gca,'XTick',[-1000 -750 -500 -250 0 250 500 750 1000]);
% set(gca,'XTickLabel','-1000||-500||0||500||1000|');
% 
% 




set(gcf, 'color', 'white');
set(gca,'ZTick',[]);
%set(gca,'ZTickLabel',{'10^-^5','10^-^4','10^-^3','pi10^-^2','10^-^1','1','10','10^2'});

set(gca,'YTick',[0 1000 2000 3000 4000 5000 6000 7000]);
set(gca,'YTickLabel','0||2||4||6||');

set(gca,'XTick',[-4000 -3000 -2000 -1000 0 1000 2000 3000 4000]);
set(gca,'XTickLabel','||-2||0||2|||');

grid off;























% 
% 
% clear;
% 
% 
% zvector=0:10:990;
% timevector=1:10:3600;
% conc = zeros(length(zvector),length(timevector));
% 
% [z,time]=meshgrid(zvector,timevector);
% 
% conc = cappillary(0,0,z,time).*1000;
% 
% 
% conc(conc<1e-4)=1e-4;
% time=time./60;
% 
% 
% 
% %mesh(time,z,log10(conc)); hold on;
% figure;
% surf(time,z,log10(conc),'FaceColor','interp','EdgeColor','none','FaceLighting','phong'); hold on;
% 
% colormap(jet(1024));
% colorbar_log([10^-4 10]);
% xlabel('Time (m)');
% ylabel({'Distance from mouth';'of capillary (um)'});
% zlabel('log( [Asp] ) (mM)');
% set(gcf, 'color', 'white');
% 
% set(gca,'XTick',[0  15 30 45 60]);
% set(gca,'XTickLabel','0||15||30||45||60|');
% 
% set(gca,'YTick',[0  250 500 750 1000]);
% set(gca,'YTickLabel','1000||500||0|');
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% time = 10;
% x=-500:10:500;
% z=0:10:990;
% time=60;
% conc = zeros(length(z),length(x));
% 
% [z,x]=meshgrid(z,x);
% 
% conc = cappillary(x,0,z,time).*1000;
% 
% 
% conc(conc<1e-4)=1e-4;
% time=time./60;
% 
% 
% figure;
% %mesh(x,z,log10(conc)); hold on;
% surf(x,z,log10(conc),'FaceColor','interp','EdgeColor','none','FaceLighting','phong'); hold on;
% %set(gca, 'ZScale','log');
% 
% colormap(jet(1024));
% colorbar_log([10^-4 10]);
% xlabel('X Coordinate');
% ylabel('Z Coordinate');
% zlabel('log( [Asp] ) (mM)');
% 
% 
% set(gcf, 'color', 'white');
% set(gca,'ZTick',[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
% %set(gca,'ZTickLabel',{'10^-^5','10^-^4','10^-^3','pi10^-^2','10^-^1','1','10','10^2'});
% 
% set(gca,'YTick',[0 250 500 750 1000]);
% set(gca,'YTickLabel','0||500||1000|');
% 
% set(gca,'XTick',[-1000 -750 -500 -250 0 250 500 750 1000]);
% set(gca,'XTickLabel','-1000||-500||0||500||1000|');
% 
% 
% 
% 
% 
















%%%%%%%%%%%%%%%%%%%%%%%%%%5555
% % Your data set
% close all
% x=1:20:1000;
% y=1:20:1000;
% [xx,yy]=meshgrid(x,y);
% z=xx.^3+yy.^3;
% 
% % Open a large figure window
% figure('units', 'normalized', 'outerposition', [0.1 0.1 0.8 0.8]);
% % Your first attempt -
% % Linear Surface plot with linear colorbar
% subplot(3,1,1)
% pcolor(xx,yy,z)
% h1 = colorbar;
% title('Linear scale, Linear Colorbar (RIGHT, but not what you want)')
% 
% % Second attempt -
% % Linear Surface plot with log colorbar
% subplot(3,1,2)
% pcolor(xx,yy,z)
% h2 = colorbar;
% set(h2, 'YScale', 'log')
% title('Linear Scale, Log Colorbar (WRONG)!')
% 
% % A possible solution -
% % Log Surface Plot with log colorbar
% subplot(3,1,3)
% pcolor(xx,yy,log10(z)) % Note LOG10 command
% 
% % Trick MATLAB by first applying pseudocolor axis
% % on a linear scale. Choose pseudocolor limits manually.
% my_clim = [8e7 2e9];
% caxis(my_clim)
% 
% % Create a colorbar with log scale
% h3 = colorbar('Yscale', 'log');
% 
% % Now change the pseudocolor axis to a log scale.
% caxis(log10(my_clim));
% title('Log Scale, Log Colorbar (RIGHT, and what you want)')