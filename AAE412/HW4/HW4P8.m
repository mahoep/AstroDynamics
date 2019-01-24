clear all; clc; close all;
%%% Problem 8

m = 240;
wo = 1.5;
m_ast = 0.03;
vo = [-576 -432 960];
ro = [0.3 0.375 0];
kx = 0.3; ky = 0.40; kz = ky;
Ix = kx^2*m;
Iy = ky^2*m;
Iz = Iy;
wrb = [wo 0 0];
I = [Ix 0 0; 0 Iy 0; 0 0 Iz;];
Hg = I*wrb';

Hg2 = Hg + m_ast*cross(ro,vo)';
wx = Hg2(1)/Ix;
wy = Hg2(2)/Iy;
wz = Hg2(3)/Iz;
w = [wx wy wz];
K = Hg2/norm(Hg2);
theta = [acos(K(1)) acos(K(2)) acos(K(3))];
y = acos(wx/norm(w));
psidot = norm(w)/sin(pi - theta(1))*sin(theta(1)-y);
phidot = norm(w)/sin(pi - theta(1))*sin(y);


fprintf('Angular Velocity after impact: [%.3f %.3f %.3f] rad/s \n', w)
fprintf('Spin rate: %.2f rad/s \n', psidot)
fprintf('Precession rate: %.2f rad/s \n', phidot)
