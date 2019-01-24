function [vecDeriv] = Launch(t,z)
%LAUNCH steps up the governing equations of motion for the launch phase
%   solve with ode45
R = 6378*1000;
mo = 68000; %inital masss of vehicle in kg
T = 930*1000; % trust of motor kN
Isp = 400;
d = 4.75;
y = 90;
go = 9.807;
g = go/(1+z(2)/R)^2;
A = pi/4*d^2;
ho = 7.5*1000;
rho = 1.225*exp(-z(2)/ho);
Cd = 0.52;
D = 1/2*rho*z(1)^2*A*Cd;

vecDeriv(1) = T/z(4) - D/z(4) - g*sind(y);
vecDeriv(2) = z(1)*sind(y);
vecDeriv(3) = z(1)*R*cosd(y)/(R+z(2));
vecDeriv(4) = -T/(Isp*go);

vecDeriv = vecDeriv.';
end

