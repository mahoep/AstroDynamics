function [vecDeriv] = RelMotion(t,z)
% This function is derived from linear orbit theory. It tracks relative
% motion between two satellites in a co-moving frame. the distance between
% the objects must be much smaller than orbit radius.
mu = 3.9860044189e5;
r = 650+6378;
n = sqrt(mu/r^3);

vecDeriv(1) = z(4);
vecDeriv(2) = z(5);
vecDeriv(3) = z(6);
vecDeriv(4) = 3*n^2*z(1)+2*n*z(5);
vecDeriv(5) = -2*n*z(4);
vecDeriv(6) = -n^2*z(3);
vecDeriv = vecDeriv.';
end