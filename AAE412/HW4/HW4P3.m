clear all; clc; close all;
%%% Problem 3

Pt = 2.04e06;
Tt = 2266;
Prec = .1013e06;
R = 365;
k = 1.3;
n_eff = 0.97;
g = 9.80665;
ratio = Prec/Pt;
M = [0:0.00001:20];

for i = 1:length(M)
    P_ratio(i) = (1+0.5*(k-1)*M(i)^2)^(k/(k-1));
    P_ratio(i) = P_ratio(i)^-1;
    T_ratio(i) = (1+0.5*(k-1)*M(i)^2);
    T_ratio(i) = T_ratio(i)^-1;
end
 
[~,j] = find(ratio==P_ratio);
Me = M(j);

if isempty(Me) == 1
    [~,j] = min(abs(ratio-P_ratio));
    Me = M(j);
end

Te = T_ratio(j)*Tt;
sonic_ext = sqrt(k*R*Te);
Ve = Me*sonic_ext;

Cf = (2*k^2/(k-1)*(2/(k+1))^((k+1)/(k-1))*(1-(ratio)^((k-1)/k)))^0.5;
Isp = n_eff*Ve*Cf/g;
fprintf('Exit Mach: %.3f  \n', Me)
fprintf('Nozzle Exit Velocity: %.1f m/s \n', Ve)
fprintf('Thrust Coefficent: %.3f \n', Cf)
fprintf('Specific Impulse: %.1f s \n', Isp)

