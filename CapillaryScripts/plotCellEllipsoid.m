
d0 = [0 0 1];
d1 = [-9.495942e-01   1.164501e-01    -2.910501e-01];


Zt = 1500;	%Z coordinate of the top of the tube
Zb = -200;	%Z coordinate of the base of the tube
Zc = 1000;   %Z coordinate of the mouth of the capillary
Re = 1000;	%Radius of the entire environment
Rc = 120;	%Radius of the capillary

figure;
set(gcf, 'color', 'white');

%First plot outside cyllindar and its base
[x, y, z] = cylinder(Re,50);
z = z*(Zt-Zb)+Zb;
l = round(size(x,2)/2);
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(1,1:end);z(1,1:end)], ...
  'FaceColor','red','EdgeColor','none','FaceAlpha',0.5,'FaceLighting','phong'); hold on;
camlight right
l = round(size(x,2)/1.3333);
surf(x(:,1:l), y(:,1:l), z(:,1:l), ...
   'FaceColor','red','EdgeColor','none','FaceAlpha',0.3,'FaceLighting','phong'); 

%Plot the actual capillary
offset = 10; %this offset draws the capillary by this many um larger so that 
             %any trajectories of cells that are thicker do not appear to
             %come through the surface of the capillary
[x, y, z] = cylinder(Rc+offset,30); 
z = z*(Zt+offset-Zc)+Zc;
surf(x, y, z,'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');





cell = surf(x,y,z,'FaceColor','blue','EdgeColor','none','FaceAlpha',1,'FaceLighting','phong'); hold on;
camlight left
material dull
grid on;
axis equal;
axis vis3d;
camlookat(cell);
camzoom(0.5);
%axis([-100,100,-100,100,-100,100]);





populationDirectory = '/home/msneddon/Desktop/swim_output/pop8_cap/';
cellCount = 5;
camlookat(gca);
sigInput = [];

currentDirectory = pwd;
cd(populationDirectory);
load(['c1/cellTrajectory.mat']);
cellSize = [2,1,1];
cellSize = cellSize.*1;

for i=1:10:length(data)
    d0=[1,0,0];
    d1 = [data(i,7), data(i,8), data(i,9)];
    angle  =(acos(dot(d0,d1))/pi)*180;
    crs = cross(d0,d1); crs = crs./norm(crs);
    if(data(i,6)==1) angle = angle+(rand*90-45); end;
    if(angle>0.01)
        [x,y,z]=ellipsoid(data(i,2),data(i,3),data(i,4),cellSize(1),cellSize(2),cellSize(3));
        delete(cell);
        cell = surf(x,y,z,'FaceColor','blue','EdgeColor','none','FaceAlpha',1,'FaceLighting','phong'); hold on;
        rotate(cell,cross(d0,d1),angle,[data(i,2),data(i,3),data(i,4)]);
     %    if(data(i,6)==0) camlookat(cell); end
        drawnow
    end
    drawnow
    
   % fprintf(['Time: ',num2str(data(i,1)),'\n']);
end


cd(currentDirectory);


