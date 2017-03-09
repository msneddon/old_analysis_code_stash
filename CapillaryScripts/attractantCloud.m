
%Plot attractant cloud
figure; hold on;
[x,y,z] = meshgrid(-1000:20:1000,-1000:20:1000,-200:20:1500);


conc = cappillary(x,y,z,200);
conc(conc<1e-5)=1e-5;

colormap(flipdim(gray,1))
s = slice(x,y,z,log(conc),[0],[],[]);
for i=1:size(s,1)
    set(s(i),'AlphaData',get(s(i),'CData'));
end
set(s,'EdgeColor','none','FaceColor','interp','FaceAlpha','interp');
%alphamap('decrease',.3)



populationDirectory = '/home/msneddon/Desktop/swim_output/pop8_cap/';
i=1;

sigInput = [];

currentDirectory = pwd;
cd(populationDirectory);
load(['c',num2str(i),'/cellTrajectory.mat']);
plot3(data(:,2),data(:,3),data(:,4),'b','LineWidth',1); hold on; 
cd(currentDirectory);

axis vis3d;
axis equal;
grid on;