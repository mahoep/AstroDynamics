%% Problem 2
clear all; close all; clc
a = 2500; %apogee altitude
p = 500;  % perigee altitude
Re = 6378; % radius of earth
mu = 398600;
ra = Re+a; %actual apogee radius
rp = Re+p;
e = (ra-rp)/(ra+rp); %eccentricity
a=(ra+rp)/2;  % semi major axis
h = sqrt(a*mu*(1-e^2));  % specific angular momentum

Vp = h/rp;  % velocity at perigee
Va = h/ra;  %  velocity at apogee

T = 2*pi/sqrt(mu)*a^(3/2);  % Period of orbit
T = T/60;  % change period into minutes

fprintf('Eccentricity: %0.3f \n', e)
fprintf('Velocity at Perigee: %0.3f km/s \n', Vp)
fprintf('Velocity at Apogee: %0.3f km/s \n', Va)
fprintf('Orbital Period: %0.2f Minutes \n', T)