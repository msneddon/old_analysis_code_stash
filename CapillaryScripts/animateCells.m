

movieFig = figure;

%%%%%%%%%%%%%%%%%%%%%%%5
% Plot Tube

Ztc = 9500; %Z coordinate of teh top of the capillary tube (for drawing only
Zt = 8500;	%Z coordinate of the top of the tube
Zb = 3000;	%Z coordinate of the base of the tube
Zc = 7000;   %Z coordinate of the mouth of the capillary
Re = 4000;	%Radius of the entire environment
Rc = 250;	%Radius of the capillary
Co = 1e-2; %Molar
Da = 890;


%First plot outside cyllindar and its base
[x, y, z] = cylinder(Re,50);
z = z*(Zt-Zb)+Zb;
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(1,1:end);z(1,1:end)], ...
  'FaceColor','black','EdgeColor','none','FaceAlpha',0.5,'FaceLighting','phong'); hold on;
camlight right
l = round((size(x,2)/2)+1);
surf(x(:,1:l), y(:,1:l), z(:,1:l), ...
   'FaceColor','black','EdgeColor','none','FaceAlpha',0.3,'FaceLighting','phong'); 

%Plot the actual capillary
offset = 10; %this offset draws the capillary by this many um larger so that 
             %any trajectories of cells that are thicker do not appear to
             %come through the surface of the capillary
[x, y, z] = cylinder(Rc+offset,30); 
z = z*(Ztc+offset-Zc)+Zc;
surf(x, y, z,'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');

axis equal
axis vis3d
axis off

hold on;



%%%%%%%%%%%%%%%%%%%%%%%5
% ReadData

step =100;

populationDirectory = '/home/msneddon/Desktop/bullDog_Results/swim4/pop3_cap_wt/';
cellCount = 6;
alldata = cell(cellCount,1);

currentDirectory = pwd;
for c=1:1:cellCount;
    fprintf(['  -Processing Cell #',num2str(c), ' ...  ']);
    cd(populationDirectory);
    load(['c',num2str(c),'/cellTrajectory.mat']);
    alldata{c} = data(1:step:end,:);
    fprintf('Done.\n');
end
cd(currentDirectory);

offset=0;
gradient = plotFoodGradient(gca,alldata{1}(1,1),Co,Da,Rc+offset,Re, Zc,2,60);


totalDistSum = zeros(length(alldata{1}),1);

for c=1:1:cellCount;
    totalDistSum(:)=totalDistSum(:) + sqrt(alldata{c}(:,2).^2 + alldata{c}(:,3).^2 + (Zc-alldata{c}(:,4)).^2);
end

totalDistSum=totalDistSum./cellCount;





%%%%%%%%%%%%%%%%%%%%%%%
% Animate

set(movieFig,'Position',[0,0,1000,800]);
campos([-2.3658e4,-5.3450e4, 2.8908e4]);
camtarget([0,0, 5.8311e3]);

winsize = get(movieFig,'Position');
A=moviein(length(alldata{1}));



scatter3([0],[0],[5000],'kx');
gradientRedrawStep = 100;


cellSize = [2,1,1];
cellSize = cellSize.*20;
theta = 0;

cellGraphics = zeros(size(alldata));
textHandle = text(-2000,0,['Elapsed Time: ', num2str(floor(alldata{c}(1,1)/60)), ' minutes']);
set(textHandle,'FontName','Arial');
set(textHandle,'FontSize',20);

for i=1:length(alldata{1})
    for c=1:size(alldata,1)
        
        d0=[1,0,0];
        d1 = [alldata{c}(i,7), alldata{c}(i,8), alldata{c}(i,9)];
        angle  =(acos(dot(d0,d1))/pi)*180;
        crs = cross(d0,d1); crs = crs./norm(crs);
        if(alldata{c}(i,6)==1) angle = angle+(rand*90-45); end;
        if(angle>0.01)
            [x,y,z]=ellipsoid(alldata{c}(i,2),alldata{c}(i,3),alldata{c}(i,4),cellSize(1),cellSize(2),cellSize(3));
            if(cellGraphics(c,1)~=0) delete(cellGraphics(c,1)); end
            cellGraphics(c,1) = surf(x,y,z,'FaceColor','blue','EdgeColor','none','FaceAlpha',1,'FaceLighting','phong'); hold on;
            rotate(cellGraphics(c,1),cross(d0,d1),angle,[alldata{c}(i,2),alldata{c}(i,3),alldata{c}(i,4)]);
     %    if(data(i,6)==0) camlookat(cell); end
            
        end
        
       % campos([sin(theta)*20,cos(theta)*20,3000]); theta = theta+1;
       % camtarget([0,0,3000])
        %camlight(hlight,'headlight')
        
        
        %Animate Gradient        
        if mod(i,gradientRedrawStep)==0 || i<gradientRedrawStep
             if(gradient~=0) delete(gradient); end
             gradient = plotFoodGradient(gca,alldata{1}(i,1),Co,Da,Rc+offset,Re, Zc,2,60);
        end;
        
        
        %update the timer text
        if(floor(alldata{c}(i,1)/60)==1)
            set(textHandle,'String',['Elapsed Time: ', num2str(floor(alldata{c}(i,1)/60)), ' minute']);
        elseif(i==length(alldata{1}))
            set(textHandle,'String',['Elapsed Time: ', num2str(40), ' minutes']);
        else
            set(textHandle,'String',['Elapsed Time: ', num2str(floor((alldata{c}(i,1))/60)), ' minutes']);
        end

    end
    
        %Save the figure for a movie
        drawnow
        A(:,i)=getframe(gcf); 
   % fprintf(['Time: ',num2str(data(i,1)),'\n']);
end
set(textHandle,'String',['Elapsed Time: ', num2str(floor(alldata{c}(i,1)/60)), ' minutes']);









