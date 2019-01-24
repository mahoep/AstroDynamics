clear all; clc; close all;
%%% Problem 1
mu = 3.9860044189e5;
mi = 68000; %inital masss of vehicle in kg
T = 930; % trust of motor
Isp = 400;
D = 4.75;

dt = 8.1;
tbo = 270;
ho = 130;
i =1;
options = odeset('RelTol',1e-8);
while 1
    [T,Z] = ode45('Launch',[0 dt],[0 0 0 mi],options);
    if max(Z(:,2)) < ho
        dt = dt+0.0001;
    else max(Z(:,2)) > ho;
        dt = dt-0.0001;
    end
    
    if abs(max(Z(:,2))-ho) < 0.002
        break
    end
    i = i+1;

end
fprintf('Speed at 130 m: %.1f m/s \n',Z(end,1))
fprintf('Time to 130 m: %.3f s \n',dt)
vo = Z(end,1);
ho = Z(end,2);
xo = Z(end,3);
mo = Z(end,4);
yo = 89.85*pi/180;
[T2,Z2] = ode45('Launch2',[dt tbo],[vo ho xo mo yo],options);

v = [Z(:,1)'  Z2(:,1)'];
h = [Z(:,2)'  Z2(:,2)'];
x = [Z(:,3)'  Z2(:,3)'];
m = [Z(:,4)'  Z2(:,4)'];
T = [T'  T2'];
fprintf('Speed at burnout: %.1f m/s \n',Z2(end,1))
fprintf('Altitude at burnout: %.1f m \n',Z2(end,2))
fprintf('Mass expended: %.1f kg \n',mi - Z2(end,4))
plot(x/1000,h/1000);grid on
% axis([-50 450 0 200])
xlabel('Range (km)');ylabel('Altitude (km)')
title('Boost Trajectory')

rho = 1.225*exp(-h/7500);
dynP = 1/2*rho.*v.^2/1000;
[MaxQ,j] = max(dynP);figure
plot(T,dynP); grid on
xlabel('Time (s)');ylabel('Dynamic Pressure (s)')
title('Dynamic Pressure')
fprintf('Max Q: %.3f kPa \n',MaxQ)
fprintf('Time of Max Q: %.1f s \n',T(j))

