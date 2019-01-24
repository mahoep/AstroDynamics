clear all; clc; close all;

ro = [7000 2900 -3800];
vo = [7.11 1.52 2.69];

[h,e,i,w,W,true_ana] = stateVec2OrbElem(ro,vo);

fprintf('True Anomaly: %0.3f  degrees \n', true_ana)
fprintf('Specific Angular Momentum: %0.0f km^2/s \n', norm(h))
fprintf('Eccentricity: %0.3f \n', norm(e))
fprintf('Inclination: %0.3f  degrees \n', i)
fprintf('Right ascension of the ascending Node: %0.3f degrees \n', W)
fprintf('Argument of perigee %0.3f degrees \n', w)

