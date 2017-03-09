	

clear;

Zt = 10000;	%Z coordinate of the top of the tube
Zb = 0;	%Z coordinate of the base of the tube
Zc = 7000;   %Z coordinate of the mouth of the capillary
Re = 4000;%2525;	%Radius of the entire environment
Rc = 250;	%Radius of the capillary
Co = 1e-2; %Molar
Da = 890;
offset = 20;

figure; hold on;
grid on;
axis equal;
axis vis3d;
set(gcf, 'color', 'white');
plotFoodGradient(gca,200,Co,Da,Rc+offset,Re, Zc,2,230);
return;

% Zt = 1500;	%Z coordinate of the top of the tube
% Zb = -200;	%Z coordinate of the base of the tube
% Zc = 1000;   %Z coordinate of the mouth of the capillary
% Re = 1000;	%Radius of the entire environment
% Rc = 120;	%Radius of the capillary
% Co = 2.0e-2; %Molar
% Da = 890;

%First plot outside cyllindar and its base
[x, y, z] = cylinder(Re,50);
z = z*(Zt-Zb)+Zb;
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(1,1:end);z(1,1:end)], ...
  'FaceColor','black','EdgeColor','none','FaceAlpha',0.5,'FaceLighting','phong'); hold on;
camlight right
l = round((size(x,2)/1.3333)+1);
surf(x(:,1:l), y(:,1:l), z(:,1:l), ...
   'FaceColor','black','EdgeColor','none','FaceAlpha',0.3,'FaceLighting','phong'); 

%Plot the actual capillary
offset = 20; %this offset draws the capillary by this many um larger so that 
             %any trajectories of cells that are thicker do not appear to
             %come through the surface of the capillary
[x, y, z] = cylinder(Rc+offset,300); 
z = z*(Zt+offset-Zc)+Zc;
surf(x, y, z,'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');


%surf([x(1,1:(1+end/2));zeros(1,1+size(x,2)/2)], [y(1,1:(1+end/2));zeros(1,1+size(y,2)/2)], [z(1,1:(1+end/2));z(1,1:(1+end/2))],'FaceColor','green','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');

hold on;




% %Plot attractant cloud






%%%%%function [hField] =plotFoodGradient(hAxis,t, Co, Da, Rc, Zc, density, angle)

plotFoodGradient(gca,200,Co,Da,Rc+offset,Re, Zc,2,230);
%surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','green','EdgeColor','none','FaceAlpha',0.25,'FaceLighting','none');
%surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(1,1:end);z(1,1:end)],'FaceColor','green','EdgeColor','none','FaceAlpha',0.25,'FaceLighting','none');














% 
% fontSize = 14;
% grid on;
% axis equal;
% axis vis3d;
% set(gcf, 'color', 'white');
% axis([-Re,Re,-Re,Re,Zb,Zt+100]);
% set(gca,'XTick',[-1000 -750 -500 -250 0 250 500 750 1000]);
% set(gca,'XTickLabel','-1||||0||||1|');
% xlabel('X (mm)','FontSize',fontSize,'FontWeight','b');
% 
% set(gca,'YTick',[-1000 -750 -500 -250 0 250 500 750 1000]);
% set(gca,'YTickLabel','-1||||0||||1|');
% ylabel('Y (mm)','FontSize',fontSize,'FontWeight','b');
% 
% set(gca,'ZTick',[0 250 500 750 1000 1250 1500]);
% set(gca,'ZTickLabel','0||0.5||1||1.5|');
% zlabel('Z (mm)','FontSize',fontSize,'FontWeight','b');
% set(gca,'FontSize',fontSize,'FontWeight','b');



fontSize = 14;
grid on;
axis equal;
axis vis3d;
set(gcf, 'color', 'white');
axis([-Re,Re,-Re,Re,Zb,Zt+100]);
set(gca,'XTick',[-4000 -3000 -2000 -1000 0 1000 2000 3000 4000]);
set(gca,'XTickLabel','||-2||0||2|||');
xlabel('X (mm)','FontSize',fontSize,'FontWeight','b');

set(gca,'YTick',[-4000 -3000 -2000 -1000 0 1000 2000 3000 4000]);
set(gca,'YTickLabel','||-2||0||2|||');
ylabel('Y (mm)','FontSize',fontSize,'FontWeight','b');

set(gca,'ZTick',[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000]);
set(gca,'ZTickLabel','0||2||4||6||8||10|');
zlabel('Z (mm)','FontSize',fontSize,'FontWeight','b');
set(gca,'FontSize',fontSize,'FontWeight','b');


















populationDirectory = '/home/msneddon/Desktop/swim_output/pop15_cap/';
i=1;

sigInput = [];

currentDirectory = pwd;
cd(populationDirectory);
load(['c',num2str(i),'/cellTrajectory.mat']);
plot3(data(:,2),data(:,3),data(:,4),'b','LineWidth',1); hold on; 
cd(currentDirectory);



populationDirectory = '/home/msneddon/Desktop/swim_output/pop15_cap/';
i=2;

sigInput = [];

currentDirectory = pwd;
cd(populationDirectory);
load(['c',num2str(i),'/cellTrajectory.mat']);
plot3(-data(:,2),data(:,3),data(:,4),'g','LineWidth',1); hold on; 
cd(currentDirectory);




















