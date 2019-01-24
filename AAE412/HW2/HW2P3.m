clear all; clc; close all;

rp = 500+6378;
mu = 3.9860044189e5;
e = 1.5;
i = 35*pi/180;
W = 150*pi/180;
w = 115*pi/180;
true_ana = 0*pi/180;
h = sqrt(rp*mu*(1+e*cos(true_ana)));

dt = 3600*2;
Me = mu^2/h^3*(e^2-1)^1.5*dt;
F_guess = 1.8;
func = @(F) e*sinh(F)-F-Me;
F = fzero(func,F_guess);
true_ana = 2*atan(sqrt((e+1)/(e-1))*tanh(F/2));

[ro,vo,r,v,QXx] = OrbElem2StateVec(h,e,i,w,W,true_ana);

fprintf('Position Vector: [%0.0f %0.0f %0.0f] km \n', ro)
fprintf('Velocity Vector: [%0.3f %0.3f %0.3f] km/s \n', vo)