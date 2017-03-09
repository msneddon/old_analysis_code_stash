function [c] = capField(x,y,z,t, Co, Da, Rc, Zc)


%first, calculate the radius^2 and radius (distance from mouth
%of cappillary)
diffX = -x;
diffY = -y;
diffZ = Zc-z;

r2 = diffX.*diffX+diffY.*diffY+diffZ.*diffZ;
r = sqrt(r2);

c=( (Co.*Rc.^2)./(2.*r.*(sqrt(pi.*Da.*t))) )  .*  (exp(-r2./(4.*Da.*t)))  ./  (1+((3.*Rc.*r)./(4.*Da.*t)));


c(isinf(c))=Co;

rFromCenter2 = diffX.*diffX+diffY.*diffY+0;
rFromCenter = sqrt(rFromCenter2);

c(rFromCenter<Rc & z>(Zc))=0;
c(r<Rc & z>(Zc))=0; %Co;
