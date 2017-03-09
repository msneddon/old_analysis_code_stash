function [hField] =plotFoodGradient(hAxis,t, Co, Da, Rc, Re, Zc, density, angle)

if(t==0) hField=0; return; end
top = 9500;
[x,y,z] = meshgrid([-Re:200:(-Rc-2), (-Rc-1), (-Rc+1):50:(Rc-2), (Rc-2), (Rc+1):200:(Re-1), Re], ...
    [-Re:200:(-Rc-2), (-Rc-1), (-Rc+1):50:(Rc-2), (Rc-2), (Rc+1):200:(Re-1), Re], ... 
    [3000:250:Zc-1, Zc, Zc+1:10:Zc+500, Zc+501:250:top]);


[xa,ya,za] = meshgrid([-Rc:5:Rc], [0:5:Rc], [Zc-5,Zc+5]);


conc = capField(x,y,z,t,Co,Da,Rc,Zc);
conc(conc<0.2e-4)=0.2e-4;

[ca] = capFieldCenter(xa,ya,za,t,Co,Da,Rc,Zc);

g = gray;

cm = [
    1.0000    0.7000    0.7000;
    1.0000    0.6611    0.6611;
    1.0000    0.6222    0.6222;
    1.0000    0.5833    0.5833;
    1.0000    0.5444    0.5444;
    1.0000    0.5056    0.5056;
    1.0000    0.4667    0.4667;
    1.0000    0.4278    0.4278;
    1.0000    0.3889    0.3889;
    1.0000    0.3500    0.3500;
    1.0000    0.3111    0.3111;
    1.0000    0.2722    0.2722;
    1.0000    0.2333    0.2333;
    1.0000    0.1944    0.1944;
    1.0000    0.1556    0.1556;
    1.0000    0.1167    0.1167;
    1.0000    0.0778    0.0778;
    1.0000    0.0389    0.0389;
    1.0000         0         0;
    0.9957         0         0;
    0.9914         0         0;
    0.9871         0         0;
    0.9828         0         0;
    0.9786         0         0;
    0.9743         0         0;
    0.9700         0         0;
    0.9657         0         0;
    0.9614         0         0;
    0.9571         0         0;
    0.9528         0         0;
    0.9485         0         0;
    0.9442         0         0;
    0.9400         0         0;
    0.9357         0         0;
    0.9314         0         0;
    0.9271         0         0;
    0.9228         0         0;
    0.9185         0         0;
    0.9142         0         0;
    0.9099         0         0;
    0.9056         0         0;
    0.9014         0         0;
    0.8971         0         0;
    0.8928         0         0;
    0.8885         0         0;
    0.8842         0         0;
    0.8799         0         0;
    0.8756         0         0;
    0.8713         0         0;
    0.8670         0         0;
    0.8628         0         0;
    0.8585         0         0;
    0.8542         0         0;
    0.8499         0         0;
    0.8456         0         0;
    0.8413         0         0;
    0.8370         0         0;
    0.8327         0         0;
    0.8284         0         0;
    0.8242         0         0;
    0.8199         0         0;
    0.8156         0         0;
    0.8113         0         0;
    0.8070         0         0;];     
     
%cm2 = cm;
%cm(:,3) = cm(:,2);
%cm(:,2) = cm(:,3);

colormap(cm);
     
     
%colormap([zeros(length(g),1),g(:,1),zeros(length(g),1)]);
%colormap([flipdim(g(:,1),1),ones(length(g),1),flipdim(g(:,1),1)]);
%colormap([flipdim(g(:,1),1),g(:,1),flipdim(g(:,1),1)]);
%colormap(hsv);
%colormap(flipdim(gray,1))


conc2 = conc;
conc2(x<0)=0;

s=[];
for i=1:density

s = [s,slice(hAxis,x,y,z,log(conc),[0],[],[])];
%for i=1:size(s,1)
   set(s(end),'AlphaData',get(s(end),'CData'));
   set(s(end),'BackFaceLighting','Lit');
   set(s(end),'FaceLighting','none');
   % set(s(i),'AlphaData',get(s(i),'AlphaData')
%end
rotate(s(end),[0,0,1],angle);
set(s(end),'EdgeColor','none','FaceColor','interp','FaceAlpha','interp');




s = [s,slice(hAxis,x,y,z,log(conc2),[],[],[top])];
%for i=1:size(s,1)
    set(s(end),'AlphaData',get(s(end),'CData'));
    set(s(end),'BackFaceLighting','Lit');
    set(s(end),'FaceLighting','none');
   % set(s(i),'AlphaData',get(s(i),'AlphaData')
%end
rotate(s(end),[0,0,1],angle);
set(s(end),'EdgeColor','none','FaceColor','interp','FaceAlpha','interp');


%lCa = log(ca)
%lCa(isinf(lCa))=0
ca(ca<min(min(min(conc))))=min(min(min(conc)));
s = [s,slice(hAxis,xa,ya,za,log(ca),[],[],[Zc]) ];
set(s(end),'AlphaData',get(s(end),'CData'));
set(s(end),'BackFaceLighting','Lit');
set(s(end),'FaceLighting','none');
rotate(s(end),[0,0,1],angle-90);
set(s(end),'EdgeColor','none','FaceColor','interp','FaceAlpha','interp');
    
 %[xa, ya, za] = cylinder(Rc,300); 
 %za = za*(top-Zc)+Zc;
 %k = surf([xa(1,1:(1+end/2));zeros(1,1+size(xa,2)/2)], [ya(1,1:(1+end/2));zeros(1,1+size(ya,2)/2)], [za(1,1:(1+end/2));za(1,1:(1+end/2))], ...
 %    'FaceColor','red','EdgeColor','none','FaceAlpha',0.6,'FaceLighting','phong');
 %rotate(k,[0,0,1],angle+90);




end;

hField=s;















