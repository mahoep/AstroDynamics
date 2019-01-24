function [vecDeriv] = cowell(t,z)
% This function sets up the cowell method to be solved in ode45. 
% Cowell's method is very accurate way to determine burn trajectories.
% assumes the thrust vector is always aligned with the
% velocity vector 
mu = 3.9860044189e5;
mo = 3900+92670+5900;
T = 801; 
Isp = 340;
g = 9.81;
rho = sqrt(z(7)^2+z(8)^2+z(9)^2);

phi = -(z(7)*z(1)+z(8)*z(2)+z(9)*z(3))/rho^2;
F = 1-(1-2*phi)^(-3/2);
rx = z(1)+z(7);
ry = z(2)+z(8);
rz = z(3)+z(9);
r = sqrt(rx^2+ry^2+rz^2);
vx = z(4)+z(10);
vy = z(5)+z(11);
vz = z(6)+z(12);
v = sqrt(vx^2+vy^2+vz^2);

vecDeriv(1) = z(4);
vecDeriv(2) = z(5);
vecDeriv(3) = z(6);
vecDeriv(4) = mu/rho^3*(F*rx-z(1))+ T*(vx)/(v*z(13));
vecDeriv(5) = mu/rho^3*(F*ry-z(2))+ T*(vy)/(v*z(13));
vecDeriv(6) = mu/rho^3*(F*rz-z(3))+ T*(vz)/(v*z(13));
vecDeriv(7) = z(10);
vecDeriv(8) = z(11);
vecDeriv(9) = z(12);
vecDeriv(10) = -mu/rho^3*z(7);
vecDeriv(11) = -mu/rho^3*z(8);
vecDeriv(12) = -mu/rho^3*z(9);
vecDeriv(13) = -T/(Isp*g)*1000;
vecDeriv = vecDeriv.';

end

