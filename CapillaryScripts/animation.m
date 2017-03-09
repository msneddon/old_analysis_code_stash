% -------------------------------------------------------------------------
% animate a missile launch
% -------------------------------------------------------------------------

% plotting parameters
feature('UseGenericOpenGL', 1);
set(gcf, 'Renderer', 'OpenGL');

% viewing parameters
hold off; newplot; hold on;
light( ...
  'Position', [20 -20 20], 'Style', 'local', ...
  'Color', [1.0 0.5 0.0] ...
);
view(50, 25); axis([-20 60 -40 40 0 80], 'square');
grid on;

% video parameters
FileName = 'missile.avi';
FrameRate = 10; % frames per second
KeyRate = 10; % key frames per second (=FrameRate => no interpolation)
Duration = 25; % total duration of the animation in seconds
nFrames = Duration * FrameRate; % number of frames after the initial one

% create the avi file and set its parameters
video = avifile( ...
  FileName,'fps', FrameRate, 'keyframe', KeyRate, ...
  'quality', 100, 'compression', 'None' ...
);

% -------------------------------------------------------------------------
% define the geometry of the missile

fin = [ % one tail fin
   0  4  4  0
   2  0  2  7
   0  0  0  0
   1  1  1  1
];
nfins = 3; % number of tail fins on the missile

bcpn = [ % Bezier control polygon for the nose section
  25  19  17  11
   0   2   1   1
   0   0   0   0
   1   1   1   1
];
xmax = max(bcpn(1,:));

bcpt = [ % Bezier control polygon for the tail section
  11   5   4   2   0
   1   1 1.5 1.5   1
   0   0   0   0   0
   1   1   1   1   1
];
xmin = min(bcpt(1,:));

cl = [ % center line of the missile
   0   0
   0   0
   0  25
   1   1
];

nti = 21; % number of values of t at which the Bezier curve gets evaluated
nxi = 101; % number of gridlines along the length of the cylinder
nyi = 51; % number of gridlines around the circumference of the cylinder
dx = xmax - xmin; % extent of the curve along the x axis
xi = [xmin:dx/(nxi-1):xmax]; % nxi evenly spaced values from xmin to xmax
nxy = nxi * nyi; % total number of grid points

% -------------------------------------------------------------------------
% define and place the body of the missile

% define the two Bezier curves and concatenate them to make a single curve
% which will form the contour of the missile body
P1 = BezierCurve(bcpn, nti); P2 = BezierCurve(bcpt, nti);
rb = [P1(1:nti,1:2); P2(2:nti,1:2)]';

% since the curves are evaluated at evenly spaced intervals in 0 <= t <= 1,
% and the cylinder function expects evenly spaced intervals in 0 <= x <= 1,
% we need to resample the curve and rescale by 1/dx.
rb = interp1(rb(1,:), rb(2,:), xi) / dx;

% use cylinder() to define the missile body as a surface of revolution
[x, y, z] = cylinder(rb, nyi-1);
% we now have a surface, ruled with nxi x nyi grid lines, and embedded
% in space such that the grid point p(i,j) = [x(i,j) y(i,j) z(i,j)]'
% so x, y and z are nxi x nyi matrices of coordinates at the grid points
% now, to use our transformation matrices, we need a matrix of vertices,
% so we must make such a matrix out of the x, y and z matrices
fvc = surf2patch(x, y, z);
% we now have a structure of the form
%   fvc = struct( ...
%     'faces',[(nxi-1)*(nyi-1) x 4, double], ...
%     'vertices',[(nxi*nyi) x 3, double] ...
%   )
% which can be passed to the patch function for drawing the missile body

% since the cylinder function has scaled the surface of revolution
% to 0 <= z <= 1, we must scale it back to its original size
S = ConstructScaling(dx, dx, dx);
% and we decide to lift the tail off the ground a bit
T = ConstructTranslation(0, 0, 1);
% fvc.vertices stores vertices in rows, so transform it by postmultiplying
vb = [fvc.vertices ones(size(fvc.vertices,1),1)] * S' * T';
fvc.vertices = vb(:,1:3);
% fnally, calculate the center line and center point for later use
cl = T * cl; cp = cl(:,1); % cp = (cl(:,1) + cl(:,2))/2;

% -------------------------------------------------------------------------
% place the fins

% place the first fin
R = ConstructRotation('x', pi/2); % by rotating it out of the xy plane
T = ConstructTranslation(1, 0, 0); % and translating it into position
vf = T * R * fin;

% place the remaining fins by rotating the first one about the center line
R = ConstructRotation('z', 2*pi/nfins); % z axis is initial center line
% accumulate vertices for the patch object which defines the fins
xf = []; yf = []; zf = []; cf = [];
xf = [xf vf(1,:)']; yf = [yf vf(2,:)']; zf = [zf vf(3,:)']; cf(1,1,:) = [1 1 1];
for i = 2:nfins
  vf = R * vf;
  xf = [xf vf(1,:)']; yf = [yf vf(2,:)']; zf = [zf vf(3,:)']; cf(1,i,:) = [1 1 1];
end

% -------------------------------------------------------------------------
% draw the initial frame of the animation

% draw the body and extract the vertices
hb = patch(fvc);
set(hb, ...
  'FaceLighting', 'phong', 'FaceColor', [0.9 1.0 1.0], ...
  'EdgeLighting', 'phong', 'EdgeColor', 'none', ...
  'AmbientStrength', 0.65, 'DiffuseStrength', 0.4, ...
  'SpecularStrength', 1.0, 'SpecularExponent', 7.0, ...
  'SpecularColorReflectance', 1.0 ...
);
vb = get(hb, 'Vertices'); vb = [vb ones(size(vb,1),1)]';

% draw the fins and extract the vertices
hf = patch(xf, yf, zf, cf);
set(hf, ...
  'FaceLighting', 'phong', 'FaceColor', .9*[.6 .7 1], ...
  'EdgeLighting', 'phong', 'EdgeColor', .6*[.6 .7 1], ...
  'AmbientStrength', 0.65, 'DiffuseStrength', 0.4, ...
  'SpecularStrength', 1.0, 'SpecularExponent', 7.0, ...
  'SpecularColorReflectance', 0.0 ...
);
vf = get(hf, 'Vertices'); vf = [vf ones(size(vf,1),1)]';

video = addframe(video, getframe); % capture the frame
% getframe; % capture the initial frame

% kinematics parameters
dt = 1 / FrameRate; % time increment per frame
r = cp(1:3); % initial position of center of missile
v = [0.0 0.0 0.0]'; % initial velocity of missile
a = [.04 0.0 .45]'; % initial acceleration of missile
phi = 0; % initial angle between missile's center line and z axis
SpinRate = .2; % rate at which fins spin about center line
dtheta = 2 * pi * SpinRate / FrameRate; % per frame rotation of the fins

% -------------------------------------------------------------------------
% draw the subsequent frames of the animation

for i = 1:nFrames
  % translation from r(t) to the origin
  To = ConstructTranslation(-r(1), -r(2), -r(3));

  % update position, velocity and orientation
  r = r + v * dt; v = v + a * dt;
  psi = atan2(v(1), v(3)); dphi = psi - phi; phi = psi;

  % translation from the origin to r(t+dt)
  Ti = ConstructTranslation(r(1), r(2), r(3));
  % rotation from parallel to v(t) to parallel to v(t+dt)
  R = ConstructRotation('y', dphi);
  % update the acceleration
  a = R(1:3,1:3) * a;
  % scale to make in bigger as it approaches
  S = ConstructScaling(1.003,1.003,1.003);

  % composite transform to update position, velocity and orientation
  At = Ti * S * R * To;
  % composite transform to make the fins spin about the center line
  cl = At * cl; As = ConstructRotArbLine(cl, dtheta);

  % move the missile body along the trajectory
  vb = At * vb; set(hb, 'Vertices', vb(1:3,:)');
  % move the fins along with it and simultaneously spin them
  vf = As * At * vf; set(hf, 'Vertices', vf(1:3,:)');

  video = addframe(video, getframe); % capture the frame
%  getframe; % capture the frame
end
video = close(video);
hold off;
