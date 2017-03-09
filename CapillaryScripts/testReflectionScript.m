
	Zt = 500;	%Z coordinate of the top of the tube
	Zb = -10;	%Z coordinate of the base of the tube
	Zc = 350;   %Z coordinate of the mouth of the capillary
	Re = 200;	%Radius of the entire environment
	Rc = 80;	%Radius of the capillary


figure;
[x, y, z] = cylinder(Re,30);
mesh(x, y, z*(Zt-Zb)+Zb); hold on; alpha(0);
[x, y, z] = cylinder(Rc,20); 
surf(x, y, z*(Zt-Zc)+Zc); alpha(0.3);

cappIndex = intersect(find(sqrt(p2(:,1).^2+p2(:,2).^2)<=Rc+0.0001), find(p2(:,3)>Zc));


plot3(p2(:,1),p2(:,2),p2(:,3),'k-', 'LineWidth',2); hold on; axis equal; axis vis3d; grid on;

segStart=1;
for i=2:length(cappIndex)
    if cappIndex(i)-cappIndex(i-1)>1
        plot3(p2(cappIndex(segStart:(i-1)),1),p2(cappIndex(segStart:(i-1)),2),p2(cappIndex(segStart:(i-1)),3),'r-', 'LineWidth',2);
        segStart = i;
    end
end
plot3(p2(cappIndex(segStart:(i)),1),p2(cappIndex(segStart:(i)),2),p2(cappIndex(segStart:(i)),3),'r-', 'LineWidth',2);


% 
% h=scatter3(p2(1,1),p2(1,2),p2(1,3),'ko');
% pause(2);
% for i=1:length(p2)
%     
%     delete(h);
%     h = scatter3(p2(i,1),p2(i,2),p2(i,3),'ko');
%     drawnow
%     pause(0.05);%pause(0.15);
%     
% end


return;







%plot3(p2(:,1),p2(:,2),p2(:,3),'r'); hold on; axis equal; axis vis3d; grid on;
scatter3(p2(1,1),p2(1,2),p2(1,3));
axis equal; axis vis3d; grid on;

h = plot3(pLong(1:2,1),pLong(1:2,2),pLong(1:2,3));

pause(2);
for i=4:length(p2)
    
    delete(h);
    h = plot3(p2(i-3:i,1),p2(i-3:i,2),p2(i-3:i,3), 'LineWidth',3);
    drawnow
    pause(0.25);
    
end

plot3(p2(:,1),p2(:,2),p2(:,3), 'LineWidth',3);
p2(:,1).^2+p2(:,2).^2
sqrt(p2(:,1).^2+p2(:,2).^2)