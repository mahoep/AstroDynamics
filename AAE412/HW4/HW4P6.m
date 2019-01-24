clear all; clc; close all;
%%% Problem 6

phidot = 1.5*2*pi/3600;
R = 3;
L = 30;
theta = 30*pi/180;
m = 1;
Ixx = m*(1/12*L^2 + 1/4*R^2);
Iyy = Ixx;
Izz = 1/2*m*R^2;
psidot = (Iyy-Izz)/(Izz)*phidot*cos(theta);

fprintf('Spin Rate: %.1f rev/hr \n', psidot/(2*pi)*3600)



