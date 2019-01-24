clear all; clc; close all;

h = 75000 ;
e = 0.3;
i = 95*pi/180;
W = 30*pi/180;
w = 50*pi/180;
true_ana = 40*pi/180;


[ro,vo] = OrbElem2StateVec(h,e,i,w,W,true_ana);

fprintf('Position Vector: [%0.0f %0.0f %0.0f] km \n', ro)
fprintf('Velocity Vector: [%0.3f %0.3f %0.3f] km/s \n', vo)

