%%% Problem 5;
clear;clc;close all;
mu = 3.9860044189e5;
Wo = 45*pi/180;
io = 30*pi/180;
wo = 30*pi/180;
thetao = 40*pi/180;
rp = 400+6378;
ra = 3800+6378;
dt = 48*3600;
eo = (ra-rp)/(ra+rp);
a = (rp+ra)/2;
ho = sqrt(a*mu*(1-eo^2));

[r,v] = OrbElem2StateVec(ho,eo,io,wo,Wo,thetao);

options = odeset('RelTol',1e-6); 
[T,Z] = ode45('J3',[0 dt],[r v],options);
for k = 1:length(T)
    [h,e,i,w,W,true_ano] = stateVec2OrbElem(Z(k,(1:3)),Z(k,(4:6)));
    W_k(k) = W;
    w_k(k) = w;
    i_k(k) = i;
    e_k(k) = norm(e);
end

plot(T,W_k-Wo*180/pi); grid on
title('Right Ascension of the Ascending Node over 48 hrs')
xlabel('Time(s)');ylabel('Right Ascension of the Ascending Node')

figure
plot(T,w_k-wo*180/pi);grid on
title('Argument of Perigee over 48 hrs')
xlabel('Time(s)');ylabel('Argument of Perigee')

figure
plot(T,i_k-io*180/pi);grid on
title('Inclination over 48 hrs')
xlabel('Time(s)');ylabel('Inclination')

figure
plot(T,e_k-eo);grid on
title('Eccentricity over 48 hrs')
xlabel('Time(s)');ylabel('Eccentricity')