function [vecDeriv] = OrbEq(t,z)

mu = 3.9860044189e5;
r = sqrt(z(1)^2+z(2)^2+z(3)^2);
v = sqrt(z(4)^2+z(5)^2+z(6)^2);
T = 12;
Isp = 291;
go = 9.81;
vecDeriv(1) = z(4);
vecDeriv(2) = z(5);
vecDeriv(3) = z(6);
vecDeriv(4) = -mu/r^3*z(1) + T*z(4)/(v*z(7));
vecDeriv(5) = -mu/r^3*z(2) + T*z(5)/(v*z(7));
vecDeriv(6) = -mu/r^3*z(3) + T*z(6)/(v*z(7));
vecDeriv(7) = -T/(Isp*go)*1000;
vecDeriv = vecDeriv.';

end

