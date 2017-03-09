clear;

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
l = round((size(x,2)/1.8)+1);
surf(x(:,1:l), y(:,1:l), z(:,1:l), ...
   'FaceColor','black','EdgeColor','none','FaceAlpha',0.3,'FaceLighting','phong'); 

%Plot the actual capillary
offset = 30; %this offset draws the capillary by this many um larger so that 
             %any trajectories of cells that are thicker do not appear to
             %come through the surface of the capillary
[x, y, z] = cylinder(Rc+offset,30); 
z = z*(Ztc+offset-Zc)+Zc;
surf(x, y, z,'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
surf([x(1,1:end);zeros(1,size(x,2))], [y(1,1:end);zeros(1,size(y,2))], [z(2,1:end);z(2,1:end)],'FaceColor','yellow','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');

axis equal
axis vis3d
axis off
%set(gca,'XTick',[-4000 -3000 -2000 -1000 0 1000 2000 3000 4000]);
%set(gca,'XTickLabel','||-2||0||2|||');

%set(gca,'YTick',[-4000 -3000 -2000 -1000 0 1000 2000 3000 4000]);
%set(gca,'YTickLabel','||-2||0||2|||');

%set(gca,'ZTick',[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000]);
%set(gca,'ZTickLabel','0||2||4||6||8||10|');
hold on;



%%%%%%%%%%%%%%%%%%%%%%%5
% ReadData

step =6050;  %1 step per minute
%step = 100;

populationDirectory = '/home/msneddon/Desktop/bullDog_Results/allSwimmers/wt/';
cellCount = 200; %140;
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


gradient = plotFoodGradient(gca,alldata{1}(1,1),Co,Da,Rc+offset,Re, Zc,2,60);


totalDistSum = zeros(length(alldata{1}),1);

for c=1:1:cellCount;
    totalDistSum(:)=totalDistSum(:) + sqrt(alldata{c}(:,2).^2 + alldata{c}(:,3).^2 + (Zc-alldata{c}(:,4)).^2);
end

totalDistSum=totalDistSum./cellCount;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear allDataArray;
for i=1:cellCount
allDataArray(:,:,i)=alldata{i};
end;
figure;
ti=35; [val,cent] = hist(sqrt(allDataArray(ti,2,:).^2+allDataArray(ti,3,:).^2+(7000-allDataArray(ti,4,:)).^2),20);
h=area(cent,val); hold on;
set(h,'FaceColor','r'); 
ti=15; [val,cent] = hist(sqrt(allDataArray(ti,2,:).^2+allDataArray(ti,3,:).^2+(7000-allDataArray(ti,4,:)).^2),20);
h=area(cent,val); set(h,'FaceColor','g'); hold on; 
ti=5; [val,cent] = hist(sqrt(allDataArray(ti,2,:).^2+allDataArray(ti,3,:).^2+(7000-allDataArray(ti,4,:)).^2),20);
h=area(cent,val); set(h,'FaceColor','b'); 
ti=2; [val,cent] = hist(sqrt(allDataArray(ti,2,:).^2+allDataArray(ti,3,:).^2+(7000-allDataArray(ti,4,:)).^2),20);
h=area(cent,val); set(h,'FaceColor','k'); 







figure; hold on; axis([0,4000,0,150]);
movieLength = 20; %seconds;
h=0;
for i=1:length(alldata{1})
   
    distanceToMouth = squeeze(sqrt(allDataArray(i,2,:).^2+allDataArray(i,3,:).^2+(Zc-allDataArray(i,4,:)).^2));
    
    isInCap = squeeze(sqrt(allDataArray(i,2,:).^2+allDataArray(i,3,:).^2)<Rc & allDataArray(i,4,:)>Zc);
    fprintf(['Number in Capillary: ',num2str(sum(isInCap)),'\n']);
    
    distanceToMouth(isInCap) = 0;
    
   [val,cent] = hist(distanceToMouth);
   if(i~=1) delete(h); end;
   h=area(cent,val); set(h,'FaceColor','g');
   %Save the figure for a movie
   pause(movieLength/length(alldata{1}));
   fprintf(['Elapsed Time: ', num2str(floor(alldata{c}(i,1)/60)), ' minute']);
   drawnow
end

drawnow








figure; hold on; 

i=35+1;
distanceToMouth = squeeze(sqrt(allDataArray(i,2,:).^2+allDataArray(i,3,:).^2+(Zc-allDataArray(i,4,:)).^2));
    
isInCap = squeeze(sqrt(allDataArray(i,2,:).^2+allDataArray(i,3,:).^2)<Rc & allDataArray(i,4,:)>Zc);
distanceToMouth(isInCap) = 0;
dx=250;
edges = [0:dx:4000];
[val,cent] = histc(distanceToMouth,edges);
centers = edges+(edges(2)-edges(1))./2;
h=area(centers,(val./sum(val))); set(h,'FaceColor','b','EdgeColor','none');
axis([min(centers),4000,0,0.7]);

formatFigure();
set(gca,'YTick',[0 0.2,0.4,0.6]);
set(gca,'YTickLabel','0|0.2|0.4|0.6');

set(gca,'XTick',[1000 2000 3000 4000]);
set(gca,'XTickLabel','1|2|3|4');

set(gca,'LineWidth',3);
set(gca, 'TickDir', 'out');
set(gca,'FontSize',30);



fprintf(['Number in Capillary: ',num2str(sum(isInCap)),'\n']);
fprintf(['Elapsed Time: ', num2str(floor(alldata{c}(i,1)/60)), ' minute']);

drawnow








input('Press any key to continue >>');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
































figure;








%%%%%%%%%%%%%%%%%%%%%%%
% Animate
flyby = 0;

set(gcf, 'color', 'white');
set(movieFig,'Position',[50 50 450*1.5 480*1.5]);
%axis equal
%axis vis3d

%camproj perspective;

campos([-2.3628e4   -5.1e4    1.9353e4]);
%campos([-2.3658e4,-5.3450e4, 1.8908e4]);
camtarget([0,0, 6.1311e3]);
hlight = camlight('headlight');

winsize = get(movieFig,'Position');
A=moviein(length(alldata{1}));


if(flyby>0)
    t=[0:(3.5*pi)/length(alldata{1}):3.5*pi]';
    startRad = 1e4; midRad=4e4; endRad=4e4;
    radius=[startRad:((midRad-startRad))/length(alldata{1}):midRad, midRad, midRad:((endRad-midRad))/length(alldata{1}):endRad]';
    camposArray = [radius(1:length(t)).*cos(t),radius(1:length(t)).*sin(t),zeros(length(t),1)+1.8908e4];
    campos(camposArray(i,:));
    camtarget([0,0, 5.8311e3]);
    camlight(hlight,'headlight');
end


%scatter3([0],[0],[5000],'kx');
gradientRedrawStep = 1;


cellSize = [2,1,1];
cellSize = cellSize.*18;
theta = 0;

set(gca,'Position',[-0.15 0 1.3 1.15]);
cellGraphics = zeros(size(alldata));
if(flyby==0)
    textHandle = text(-2700,0,1700, ['Elapsed Time: ', num2str(floor(alldata{c}(1,1)/60)), ' minutes']);
    set(textHandle,'FontName','Arial');
    set(textHandle,'FontSize',28);
    set(textHandle,'FontWeight','b');
    set(textHandle,'Color','k');
end;
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
            cellGraphics(c,1) = surf(x,y,z,'FaceColor','blue','EdgeColor','none','FaceAlpha',1,'FaceLighting','phong'); 
            hold on;
            rotate(cellGraphics(c,1),cross(d0,d1),angle,[alldata{c}(i,2),alldata{c}(i,3),alldata{c}(i,4)]);
            
        end
        
    end;
        
    %Animate Gradient
    if mod(i,gradientRedrawStep)==0 || i<gradientRedrawStep
        if(gradient~=0) delete(gradient); end
        gradient = plotFoodGradient(gca,alldata{1}(i,1),Co,Da,Rc+offset,Re, Zc,2,60);
    end;


    if(flyby>0)
        if(i<=(3/5)*length(alldata{1}))
            %Fly the camera
            campos(camposArray(i,:));
            camtarget([0,0, 5.8311e3]);
            camlight(hlight,'headlight');
        end
    end
    
    if(flyby==0)
        %update the timer text
        if(floor(alldata{c}(i,1)/60)==1)
            set(textHandle,'String',['Elapsed Time: ', num2str(floor(alldata{c}(i,1)/60)), ' minute']);
        else
            set(textHandle,'String',['Elapsed Time: ', num2str(floor((alldata{c}(i,1))/60)), ' minutes']);
        end
    end

   fprintf(['second: ', num2str(alldata{c}(i,1)),'\n']);
   
   %Save the figure for a movie
   drawnow
   input('Press any key to step >>');
  % A(:,i)=getframe(gcf); 
    
   % fprintf(['Time: ',num2str(data(i,1)),'\n']);
end

%Draw one last time
if(flyby==0)
    set(textHandle,'String',['Elapsed Time: ', num2str(40), ' minutes']);
end
drawnow
A(:,i)=getframe(gcf); 


% To encode the movie into AVI format (takes a long time and lots of disk
% space!)
%movie2avi(A,'lotsOCellsCapMovie.avi','fps',24);

%At the command prompt use this to convert from avi to much smaller mpeg
% Note: this will play right side up in linux, but upside down in windows.
% To encode properly for windows, take out the 'flip' command
% > mencoder goodCapMovie.avi -of mpeg -ovc lavc -lavcopts vcodec=mpeg2video -vf flip -o goodCapMovie3.mpg



