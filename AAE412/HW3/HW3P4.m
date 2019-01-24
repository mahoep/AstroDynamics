%%% Problem 4;
clear;clc;close all;
mu = 3.9860044189e5;

ri = 7800;
options = odeset('RelTol',1e-5);
h = sqrt(ri*mu);
vp = h/ri;
[To,Zo] = ode45('OrbEq',[0 3600*5], [ri 0 0 0 vp 0],options);
hold on
t = linspace(0,2*pi);plot(6378*cos(t),6378*sin(t));

    k = 1;
    dt = 0.87*3600;
while 1

    mo = 1740;
    T = 0.8; 
    Isp = 220;
    delta_IC = [0 0 0 0 0 0];
    rho_IC = [ri 0 0 0 vp 0];
    IC = [delta_IC rho_IC mo];
    [T,Z] = ode45('cowell',[0 dt],IC,options);
   
    r = [Z(end,1)+Z(end,7) Z(end,2)+Z(end,8) Z(end,3)+Z(end,9)];
    v = [Z(end,4)+Z(end,10) Z(end,5)+Z(end,11) Z(end,6)+Z(end,12)];
    [~,e,~,~,~,~] = stateVec2OrbElem(r,v);
    e = norm(e);
    
    dt = dt + .1 ;
    k = k + 1;
    if (abs(e - 0.6) < 0.0001 ) || (k == 25000)
        break
    end
end

[Tf,Zf] = ode45('OrbEq',[0 50*3600],[r v],options);
plot(Zo(:,1),Zo(:,2),'LineWidth',2,'Color','b'); grid on; axis equal
plot(Zf(:,1),Zf(:,2),'r','LineWidth',2)
plot(Z(:,1)+Z(:,7),Z(:,2)+Z(:,8),'--','LineWidth',2,'Color','b')
title('Orbital Displacement');xlabel('X-axis')
ylabel('Y-axis'); 
legend('Earth','Original Orbit','Oscultating Orbit','Final Orbit')
burnT = dt/3600;
dm = Z(1,13)-Z(end,13);
for i = 1:length(T)
    r(i) = sqrt(Zf(i,1)^2 + Zf(i,2)^2);
end
ra = max(r)-6378;

fprintf('Burn Time %.4f hrs \n',burnT);
fprintf('Mass expended %.1f kg \n',dm);
fprintf('New apogee altitude %.1f m \n',ra);
