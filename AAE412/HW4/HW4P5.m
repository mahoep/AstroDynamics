clear all; clc; close all;
%%% Problem 5

m = 500;
w = [0.08 -0.06 -0.03];

dx = 1;
dy = 0.5;
dz = 3;

Ixx = 1/12*m*(dz^2+dy^2);
Iyy = 1/12*m*(dz^2+dx^2);
Izz = 1/12*m*(dx^2+dy^2);
I = [Ixx 0 0; 0 Iyy 0; 0 0 Izz];
Hg = I*w';

vecDeriv = cross(w,Hg);
wdot = -vecDeriv/I;

fprintf('Angular Acceleration in X: %.3s rad/s \n', wdot(1))
fprintf('Angular Acceleration in Y: %.3s rad/s \n', wdot(2))
fprintf('Angular Acceleration in Z: %.3s rad/s \n', wdot(3))