% Problem 6
clear all; close all; clc

ri = [22000 -103000 -15000]; % inital state vectors
vi = [0.91 -4.5 -2.5];
mu = 398600;
dt = 3600*2; % time change in seconds
r_mag = norm(ri); % magnitude
v_mag = norm(vi);
vr = dot(ri,vi)/r_mag;  
alpha = 2/r_mag - v_mag^2/mu;  
a = 1./alpha;  % semi major axis, if negative = hyperbolic
chi_guess = sqrt(mu)/abs((a))*dt;  % Chobotov approx

chi = fzero('UniAn',chi_guess);  % fzero to brute force solution
% universal anamoly equations
z = alpha*chi^2;  
C_stu = (cosh(sqrt(-z)) - 1)/(-z);
S_stu = abs((sinh(sqrt(-z))-sqrt(-z))/(-z^(-3/2)));
%lagrange coefficents
f = 1-chi^2/r_mag*C_stu;
g = dt-1/sqrt(mu)*chi^3*S_stu;
%new vectors per lagrange
r_new = f*ri+g*vi;
r_new_mag = norm(r_new);
fdot = sqrt(mu)/(r_mag*r_new_mag)*(alpha*chi^3*S_stu-chi);
gdot = 1-chi^2/r_new_mag*C_stu;
v_new = fdot*ri +gdot*vi;

fprintf('Universal Anomaly: %0.2f \n', chi)
fprintf('Position: [%0.f, %0.f, %0.f] km \n', r_new)
fprintf('Velocity: [%0.2f, %0.2f, %0.2f] km/s \n', v_new)