clear all; clc; close all;
mu = 3.9860044189e5;
Re = 6378;

A.ra = 16000;
A.rp = 8000;
B.ra = 21000;
B.rp = 7000;
eta = 25*pi/180;

A.e = (A.ra-A.rp)/(A.ra+A.rp);
B.e = (B.ra-B.rp)/(B.ra+B.rp);
A.h = sqrt(A.rp*mu*(1+A.e));
B.h = sqrt(B.rp*mu*(1+B.e));

a = A.e*B.h^2-B.e*A.h^2*cos(eta);
b = -B.e*A.h^2*sin(eta);
c = A.h^2 - B.h^2;
phi = atan(b/a);
theta1 = phi + acos(c/a*cos(phi));
theta2 = theta1-eta;
r11 = A.h^2/mu/(1+A.e*cos(theta1));
r22 = B.h^2/mu/(1+B.e*cos(theta2));
A.Vtheta = A.h/r11;
A.Vr = mu/A.h*A.e*sin(theta1);
A.V = sqrt(A.Vtheta^2 + A.Vr^2);
A.gamma = atan(A.Vr/A.Vtheta);
B.Vtheta = B.h/r22;
B.Vr = mu/B.h*B.e*sin(theta2);
B.gamma = atan(B.Vr/B.Vtheta);
B.V = sqrt(B.Vtheta^2 + B.Vr^2);
dV = sqrt(A.V^2 + B.V^2 -2*A.V*B.V*cos(B.gamma-A.gamma));
alpha = atan((A.Vr-B.Vr)/(A.Vtheta-B.Vtheta));

fprintf('Total delta V: %0.3f km/s \n',dV)
fprintf('Inital True Anomaly: %0.3f degrees \n',theta1*180/pi)
fprintf('Phi orientation: %0.1f degrees \n',alpha*180/pi+180)
