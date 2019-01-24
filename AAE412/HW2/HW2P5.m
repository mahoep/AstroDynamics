clear all; clc; close all;
mu = 3.9860044189e5;

R1 = [5500 -2505 -3000];
R2 = [-3100 6910 -8850];
dt = 30*60;

r1 = norm(R1);
r2 = norm(R2);

dt_cond = cross(R1,R2);
if dt_cond(3) > 0 
    dtheta = acos(dot(R1,R2)/(r1*r2));
else 
    dtheta = (360 - acos(dot(R1,R2)/(r1*r2)))*pi/180;
end

A = sin(dtheta)*sqrt((r1*r2)/(1-cos(dtheta)));
zguess = 1.5;

z=fzero('lambert',zguess);

A = sin(dtheta)*sqrt((r1*r2)/(1-cos(dtheta)));
C_stu = (cosh(sqrt(-z)) - 1)/(-z);
S_stu = abs((sinh(sqrt(-z))-sqrt(-z))/(sqrt(-z)^3));
y = r1+r2+A*(z*S_stu-1)/sqrt(C_stu);

f = 1-y/r1;
g = A*sqrt(y/mu);
fdot = sqrt(mu/(r1*r2))*sqrt(y/C_stu)*(z*S_stu-1);
gdot = 1-y/r2;
V1 = 1/g*(R2-f*R1);
V2 = 1/g*(gdot*R2-R1);

[h,e,i,w,W,true_ano] = stateVec2OrbElem(R1,V1);

vr2 = mu/(norm(h))*norm(e)*sin(true_ano);
rp = norm(h)^2/mu*1/(1+norm(e))-6378;

fprintf('True Anomaly: %0.3f  degrees \n', true_ano)
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
fprintf('Perigee Altitude %0.3f km \n', rp)

