clear all; clc; close all;
mu = 3.9860044189e5;
Re = 6378;
SatA.rp = 8525;
SatA.ra = 18000;
SatB.rp = 8525;
SatB.ra = 18000;
theta = 90*pi/180;

h1 = sqrt(2*mu)*sqrt(SatA.ra*SatA.rp/(SatA.ra+SatA.rp));
e1 = (SatA.ra - SatA.rp)/(SatA.rp + SatA.ra);
a = (SatA.rp + SatB.ra)/2;
v1 = h1/SatA.rp;
T = 2*pi/sqrt(mu)*a^(3/2);
E = 2*atan((tan(theta/2)*((1+e1)/(1-e1))^(-1/2)));
Me = E-e1*sin(E);
dt = Me*T/(2*pi);
T2 = T-dt;
a2 = (sqrt(mu)*T2/(2*pi))^(2/3);
r_new = 2*a2-SatA.rp;
h_new = sqrt(2*mu)*sqrt(SatA.rp*r_new/(SatA.rp+r_new));
v_new = h_new/SatA.rp;
dV = 2*abs(v_new - v1);


fprintf('Total delta V: %0.3f km/s \n',dV)

