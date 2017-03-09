function [c] = cappillary(x,y,z,t)


%position of the cappillary mouth in X, Y, Z
mX = 0; % uM
mY = 0; % uM
mZ = 1000; % uM



%initial concentration of aspartate in cappillary in molar
Co = 2.0e-2; %Molar

%Diffusion constant of aspartate
% = 0.89e-5 cm^2/s
% = 0.0000089 cm^2/s
% = 890 um^2 /s
Da = 890; % um^2 / s

%radius of cappillary
% = 0.01 cm
Rc = 120; % um


%first, calculate the radius^2 and radius (distance from mouth
%of cappillary)
diffX = mX-x;
diffY = mY-y;
diffZ = mZ-z;

r2 = diffX.*diffX+diffY.*diffY+diffZ.*diffZ;
r = sqrt(r2);

c=( (Co.*Rc.^2)./(2.*r.*(sqrt(pi.*Da.*t))) )  .*  (exp(-r2./(4.*Da.*t)))  ./  (1+((3.*Rc.*r)./(4.*Da.*t)));

c(isinf(c))=Co;


rFromCenter2 = diffX.*diffX+diffY.*diffY+0;
rFromCenter = sqrt(rFromCenter2);

c(rFromCenter<Rc & z>1000)=0;

