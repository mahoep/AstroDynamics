clear all; clc; close all;
mu = 3.9860044189e5;
Re = 6378;
r = [-2520 3875 -5560];
phi = -45*pi/180;
theta = 110*pi/180;
f =  0.003353;

r_site_xy = (Re/(sqrt(1-(1*f-f^2)*sin(phi)^2)))*cos(phi)*[cos(theta) sin(theta)];
r_site_z = (Re*(1-f)^2/sqrt((1-(2*f-f^2)*sin(phi)^2)))*[sin(phi)];

r_site = [r_site_xy r_site_z];
rho_X = r-r_site;
R1 = [1 0 0;
    0 -sin(phi) cos(phi);
    0 cos(phi) sin(phi);];
R3 = [-sin(theta) cos(theta) 0;
    cos(theta) sin(theta) 0;
    0 0 1;];
QXx = R1*R3;
rho_x = QXx*rho_X';
rho = rho_x/norm(rho_x);
range = norm(rho_x);
a = asind(rho(3));

fprintf('Range to Satellite: %0.1f km \n',range)
fprintf('Elevation Angle: %0.1f degrees \n',a)