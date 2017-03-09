function [] = plotTube()


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

