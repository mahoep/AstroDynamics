clear all; clc; close all;
%%% Problem 4

i = [0.7082 -0.2082 .6165];
j = [-0.1090 -0.6091 -0.7348];
k = [0.9073 0.0825 -0.4124];

W = [-2 1.5 4.6];

Q = [i;j;k];

phi = atan(Q(3,1)/-Q(3,2));
if phi<0
    phi = phi + pi;
end
theta = acos(Q(3,3));
psi = atan(Q(1,3)/Q(2,3));
if psi<0
    psi = psi + pi;
end
w = Q*W';
wp = (w(1)*sin(psi) + w(2)*cos(psi))/sin(theta);
wn = w(1)*cos(psi) - w(2)*sin(psi);
ws = -(w(1)*sin(psi) + w(2)*cos(psi))/tan(theta) + w(3);

fprintf('Phi: %.3f deg \n', phi*180/pi)
fprintf('Theta: %.3f deg \n', theta*180/pi)
fprintf('Psi: %.3f deg \n', psi*180/pi)

fprintf('Precession Rate: %.3f rad/s \n', wp)
fprintf('Nutation Rate: %.3f rad/s \n', wn)
fprintf('Spin Rate: %.3f rad/s \n', ws)