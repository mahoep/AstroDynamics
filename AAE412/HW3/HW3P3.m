%%% Problem 3;
clear;clc;close all;

Vxo = -0.18;
Vyo = -0.07;
Vzo = -0.08;
dt_1 = 5*60;
dt_2 = 60*60;

options = odeset('RelTol',1e-5); 
[~,Z] = ode45('RelMotion',[0 dt_1],[0 0 0 Vxo Vyo Vzo],options);
fprintf('Cygnus distance from the STS after 5 min %.1f m \n',norm(Z(end,(1:3))))
[~,Z] = ode45('RelMotion',[0 dt_2],[0 0 0 Vxo Vyo Vzo],options);
fprintf('Cygnus distance from the STS after 60 min %.1f m \n',norm(Z(end,(1:3))))