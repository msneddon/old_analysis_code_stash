function [c] = capFieldCenter(x,y,z,t, Co, Da, Rc, Zc)


%first, calculate the radius^2 and radius (distance from mouth
%of cappillary)
diffX = -x;
diffY = -y;
diffZ = 0;

r2 = diffX.*diffX+diffY.*diffY+diffZ.*diffZ;
r = sqrt(r2);

c=( (Co.*Rc.^2)./(2.*r.*(sqrt(pi.*Da.*t))) )  .*  (exp(-r2./(4.*Da.*t)))  ./  (1+((3.*Rc.*r)./(4.*Da.*t)));


c(isinf(c))=Co;

%c=zeros(size(x));
c(r>Rc)=0;%maxValue;
