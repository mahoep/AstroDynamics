function [vecDeriv] = OrbEq(t,z)
% This function solves the orbital equation of motion with no pertubations
% with earth as the focus. For use with ode45
mu = 3.9860044189e5;
r = sqrt(z(1)^2+z(2)^2+z(3)^2);
vecDeriv(1) = z(4);
vecDeriv(2) = z(5);
vecDeriv(3) = z(6);
vecDeriv(4) = -mu/r^3*z(1);
vecDeriv(5) = -mu/r^3*z(2);
vecDeriv(6) = -mu/r^3*z(3);
vecDeriv = vecDeriv.';

end

