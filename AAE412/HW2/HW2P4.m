clear all; clc; close all;
mu = 3.9860044189e5;
R1 = [3286 5010 9787];
R2 = [-3259 260 13009];
R3 = [-11787 -7674 9628];

r1 = norm(R1);
r2 = norm(R2);
r3 = norm(R3);
N = r1*(cross(R2,R3)) + r2*(cross(R3,R1)) + r3*(cross(R1,R2));
D = cross(R2,R3) + cross(R3,R1) + cross(R1,R2);
S = R1*(r2-r3) + R2*(r3-r1) + R3*(r1-r2);

V2 = sqrt(mu/(dot(N,D)))*(cross(D,R2)/norm(R2)+S);

r = R2;
v = V2;
[h,e,i,w,W,true_ana] = stateVec2OrbElem(r,v);

v2 = sqrt(mu/(dot(N,D)))*(cross(D,R2)/norm(R2)+S);

rp = norm(h)^2/mu*1/(1+norm(e))-6378;
fprintf('True Anamoly: %0.3f  degrees \n', true_ana)
fprintf('Specific Angular Momentum: %0.0f km^2/s \n', norm(h))
fprintf('Eccentricity: %0.3f \n', norm(e))
fprintf('Inclination: %0.3f  degrees \n', i)
fprintf('Right ascesnsion of the ascending Node: %0.3f degrees \n', W)
fprintf('Argument of perigee %0.3f degrees \n', w)

if i <90
    fprintf('The orbit is Prograde: i<90 \n')
else
    fprintf('The orbit is Retrograde: i>90 \n')
end
if true_ana >180
    fprintf('The satellite is approaching perigee \n')
else
    fprintf('The satellite is going away perigee \n')
end
fprintf('Perigee Altitude %0.3f km \n', rp)


