% Problem 5
clear all; close all; clc

rp = 7000; % perigee radius
ra = 10000;  % apogee radius
dt = 1.5*3600;  % change in time
a =(ra+rp)/2; % semi major axis
e = (ra-rp)/(ra+rp);  % eccentricity
mu = 398600;  
T = 2*pi/sqrt(mu)*a^(3/2); % orbital period

Me = 2*pi*dt/T;  % Mean anamoly
if Me < pi  % prushing approx
    E = Me+e/2;
else
    E = Me-e/2;
end

diff_inital = (E-e*sin(E)- Me); % inital difference to track convergence
i=0;
tic
if E-e*sin(E)- Me < 1   % if difference is negative subtract 1e-04 for each step
    while E-e*sin(E)- Me > 0.0001
        i = i + 1;
        E = E - 0.0001;
    if i >10000
        diff_final = (E-e*sin(E)- Me);
        break
    end
    end
else % if difference is positive add 1e-04 for each step
    while E-e*sin(E)- Me < 0.0001
        i = i + 1;
        E = E + 0.0001;
    if i >10000
        diff_final = (E-e*sin(E)- Me);
        break
    end
    end
end

toc
true_an = 2*atan(((1+e)/(1-e))^(1/2)*tan(E/2))+2*pi; % new true anamoly

fprintf('Eccentricity: %0.3f \n', e)
fprintf('Eccentric Anomaly: %0.2f rad \n', E)
fprintf('Eccentric Anomaly: %0.0f deg \n', E*360/(2*pi))
fprintf('True Anomaly: %0.2f rad \n', true_an)
fprintf('True Anomaly: %0.0f deg \n', true_an*360/(2*pi))
