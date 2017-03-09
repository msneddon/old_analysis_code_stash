function [fPower] = flagellaFilter(power, freq, cwBias)




I = 0.1;   %The moment of inertia
K = 1;  %The torsion coefficient (torque per unit of rotation)
D = 0.1;   %The dissipation of energy from the system

N = 100;  %The number of beads in our chain




%If we assume N -> inf, then we have this transfer function
y = (abs(0.5-cwBias))*2*pi*sqrt(0.2);
f = (2*exp(sqrt(-freq.*(freq-i*y)))) ./ (1+exp(2*sqrt(-freq.*(freq-i*y))));
%pow = conj(f).*f;
f=cos(sqrt(freq.^2-i.*freq.*y));
transferFunction = 1./(conj(f).*f);





%sigma = (2 - ((freq.^2) ./ (K/I).^2) + i* (((freq.^2) * (D/K)) ./ ((K/I).^2))   );
%lambda = (1/2) .* (sigma + ((sigma.^2)-1).^(1/2));

%transferFunction = ((lambda.^N) .* (1+lambda)) ./ ((lambda.^(N+1)) + 1);

fPower = transferFunction.*power;