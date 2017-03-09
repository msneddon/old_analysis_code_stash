
f1 = figure;
f2 = figure;

color = ['b';'r';'g';'y';'c';'b';'r';'g';'y';'c';'b';'r';'g';'y';'c';'b';'r';'g';'y';'c';];





%populationDirectory = '/home/msneddon/Desktop/swim_output/pop2_cap/';
populationDirectory = '/home/msneddon/Desktop/bullDog_Results/swim3/pop1_cap_wt/';
cellCount = 9;

sigInput = [];


currentDirectory = pwd;
for i=1:1:cellCount;
    fprintf(['Processing Cell #',num2str(i), ' ...  ']);
    cd(populationDirectory);
    load(['c',num2str(i),'/cellTrajectory.mat']);
    
    figure(f1); hold on;
    plot3(data(:,2),data(:,3),data(:,4),color(i)); hold on; xlabel('x'); ylabel('y'); zlabel('z'); axis vis3d;
    scatter3(data(1,2),data(1,3), data(1,4),'ro');

    figure(f2); hold on;
    plot(data(:,1),data(:,5)*1000,color(i)); xlabel('Time (s)'); ylabel('Concentration[mM]');
    %set(gca,'YScale','Log');
    fprintf('Done.\n');
    sigInput = [sigInput,data(:,5)*1000];
end
cd(currentDirectory);

%For plotting delta L over L
% circshift(x,1);
% circshift(x,1)
% circshift(x,2)
% circshift(x',2)
% circshift(x',1)
% abs(x-circshift(x',1))
% abs(x'-circshift(x',1))
% figure;
% ligand=data(:,5);
% ligand = abs(ligand-circshift(ligand,1));
% ligand(1:5)
% ligand(1)=0;
% plot(data(:,1),ligand)
% figure;  plot(data(:,1),ligand);
% figure;  plot(data(1:2000*0.01,1),ligand(1:2000*0.01));
% figure;  plot(data(1:2000*0.01,1),ligand(1:2000*0.01)./data(1:2000*0.01,5));



figure(f1);
grid on;
axis equal;
axis vis3d;


Zt = 10000;	%Z coordinate of the top of the tube
Zb = 0;	%Z coordinate of the base of the tube
Zc = 7000;   %Z coordinate of the mouth of the capillary
Re = 4000;	%Radius of the entire environment
Rc = 250;	%Radius of the capillary
Co = 1e-2; %Molar
Da = 890;



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
offset = 10; %this offset draws the capillary by this many um larger so that 
             %any trajectories of cells that are thicker do not appear to
             %come through the surface of the capillary
[x, y, z] = cylinder(Rc+offset,30); 
z = z*(Zt+offset-Zc)+Zc;
surf(x, y, z,'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');

hold on;

clear f1 f2 populationDirectory cellCount data dataColNames