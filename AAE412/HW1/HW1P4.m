%%% Problem 4
clear all; close all; clc

ri = [8900 7200 0];  % intial state vectors
vi = [1.5 6.1 0];
hi = cross(ri,vi); % specific angular momentum
true_an = atand(ri(2)/ri(1));  % inital true anamoly
dTheta = 80*(2*pi)/360;  % change in theta

mu = 398600;
ro = sqrt(dot(ri,ri)); %inital postion magnitude
vo = sqrt(dot(vi,vi)); % inital velocity magnitude
vro = dot(ri,vi)/ro;  % inital radial velocity
h = ro*sqrt(vo^2-vro^2);  % angular momentum magnitude
% new radial distance magnitdue
r = h^2/mu*(1+(h^2/(mu*ro)-1)*cos(dTheta)-h*vro/mu*sin(dTheta))^-1; 

f = 1- mu*r/h^2*(1-cos(dTheta)); % lagrange coefficents
g = r*ro/h*sin(dTheta);
fdot = mu/h*(1-cos(dTheta))/sin(dTheta)*(mu/h^2*(1-cos(dTheta))-1/ro-1/r);
gdot = 1-mu*ro/h^2*(1-cos(dTheta));

r_new = f*ri + g*vi;  % new r vector per lagrange defintion
v_new = fdot*ri + gdot*vi;
h_new = cross(r_new,v_new);
theta_new = atand(r_new(2)/r_new(1))+180;  % new theta, add 180 because answer would be negative
e = norm(cross(v_new,h_new)/mu - r_new/(norm(r_new)));  % eccentricity magnitude from vector definition

fprintf('Inital True Anamoly: %0.3f \n', true_an)
fprintf('New Position Vector: [%.f, %0.f, %0.f] km \n', r_new)
fprintf('New Velocity Vector: [%0.3f, %0.3f, %0.3f] km/s \n', v_new)
fprintf('Eccentricity: %0.3f \n', e)