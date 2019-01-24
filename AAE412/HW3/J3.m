function [vecDeriv] = J3(t,z)
% This function sets up the problem of solving the obrital equation of
% motion with gravitationl pertubations. Namely, J3 zonal harmonic
mu = 3.9860044189e5;
r=sqrt(z(1)^2+z(2)^2+z(3)^2);
R = 6378;
J2 = 0.00108263;
J3 = -2.33936*10^(-3)*J2;

C = (1/2)*((J3*mu*R^3)/r^5);

apx = C*((5*z(1)/r)*((7*z(3)^3/r^3)-(3*z(3)/r)));
apy = C*((5*z(2)/r)*((7*z(3)^3/r^3)-(3*z(3)/r)));
apz = C*((35*z(3)^4/r^4)-(30*z(3)^2/r^2)+3);

vecDeriv(1) = z(4);
vecDeriv(2) = z(5);
vecDeriv(3) = z(6);
vecDeriv(4) = -mu/r^3*z(1) + apx;
vecDeriv(5) = -mu/r^3*z(2) + apy;
vecDeriv(6) = -mu/r^3*z(3) + apz;

vecDeriv = vecDeriv';

end