clear all; clc; close all;
%%% Problem 6

m = 145;
psidot = 240*2*pi/60;
B = 9.5*pi/180;
D = 1200;
c = 0.6;

kz = 0.76;
kx = 0.42;
ky = kx;

Iz = kz^2*m;
Ix = kx^2*m;
Iy = Ix;

%forced precession 
lhs = c*D*sin(B); %solve quadratic eq for roots of B
p = [(Iz-Ix)*sin(B)*cos(B) Iz*psidot*sin(B) -c*D*sin(B)];
phidot = roots(p);
fprintf('Spin Rate 1: %.1f rad/s \n', phidot(1))
fprintf('Spin Rate 2: %.1f rad/s \n', phidot(2))
fprintf('Spin Rate 1: %.1f rpm \n', phidot(1)*60/(2*pi))
fprintf('Spin Rate 2: %.1f rpm \n', phidot(2)*60/(2*pi))