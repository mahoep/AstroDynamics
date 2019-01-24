%%% Problem 1
%%%%%%
clear all; clc; close all

mu = 3.9860044189e5;
Re = 6378; %radius of earth
mo = 1800; %kg
rp_1 = 520 + Re;
ra_1 = 900 + Re;
e1 = (ra_1-rp_1)/(ra_1+rp_1);
h1 = sqrt(rp_1*mu*(1+e1));
vp_1 = h1/rp_1;
va_1 = h1/ra_1;

rp_2 = 520+Re;
ra_2 = 14000+Re;
e2 = (ra_2-rp_2)/(ra_2+rp_2);
h2 = sqrt(rp_2*mu*(1+e2));
vp_2 = h2/rp_1;
T = 12; % thrust in kN
Isp = 291;
g=9.81;
options = odeset('RelTol',1e-6); 
dv = vp_2 - vp_1;
dt = 150;
i = 0;
while 1
    [T,Z] = ode45('OrbEq_thrust',[0 dt],[ra_1 0 0 0 va_1 0 mo], options);
    deltaV = -Isp*g*log(Z(end,7)/mo)/1000;
    dm = mo*(1-exp(-deltaV*1000/(Isp*g)));
    if dv-deltaV>0
        dt = dt + 0.1;
    else 
        dt = dt - 0.1;
    end
    if abs(dv-deltaV)<.001
        break
    end
    i = i+1;
end

fprintf('Burn time: %0.1f s \n',dt)
fprintf('Total mass expended: %0.0f kg \n',dm)
fprintf('New eccentricity %0.2f \n',e2)
    
