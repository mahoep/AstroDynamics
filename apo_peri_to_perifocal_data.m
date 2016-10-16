function [e,T,h,spec_E,vel_a,vel_p] = apo_peri_to_perifocal_data(apogee,perigee,body)
%This function will take perigee and apogee data from an orbit. The user
%will pick the orbital body (Earth, Moon, Mars, Europa, etc..) and receive
%eccentricity, period, specific angular momentum, specific mechanical
%energy, and min/max velocities. It will aslo return a perifocal plot of
%the orbit. 
% apogee and perigee need to be absolute NOT altitude
% this equation only works in a perifocal, elliptical orbit
% when calling the function have body = [];


% Gravitaional Paramters
% Body	? (km3 s?2) radius(km)
Sun	= [1.327124400189e11, 695700];
Mercury = [2.20329e4, 2439.7];
Venus =	[3.248599e5, 6051.8];
Earth = [3.9860044189e5, 6371];
Moon = [4.90486959e3, 1737.1];
Mars = [4.2828372e4, 3389.5];
Ceres = [6.26325e1, 473];
Jupiter	= [1.266865349e8, 69911];
Saturn = [3.79311879e7, 58232];
Uranus = [5.7939399e6, 25362];
Neptune = [6.8365299e6, 24622];
Pluto = [8.719e2, 1187];
Eris = [1.1089e3, 1163];
Europa = [3.20345e3 1560.8];

body = input('What is the parent orbital body?')
radius = body(2);

semi_major_axis = (apogee + perigee)/2;
e = (apogee-perigee)/(apogee+perigee); %eccentricity
semi_latus_rectum = semi_major_axis*(1-e^2);  
h = sqrt(semi_latus_rectum*body(1));  % specific angular momentum
spec_E = -body(1)/(2*semi_major_axis);  % specific mechanical engery
T = 2*pi/sqrt(body(1))*semi_major_axis^(3/2); % period in seconds

vel_a = h/apogee;  % velocity at perigee when true anomaly = pi rad 
vel_p = h/perigee;  % velocity at perigee when true anomaly = 0 rad 

xCenter = (apogee + perigee)/2-perigee;  % off set distance from focus to body
yCenter = 0;
xRadius = (apogee + perigee)/2; % semi major axis
yRadius = sqrt(apogee*perigee); % semi minor axis
theta = 0 : 0.01 : 2*pi;
x = xRadius * cos(theta) + xCenter;
y = yRadius * sin(theta) + yCenter;
plot(x, y, 'LineWidth', 3, 'Color', [0,0,0]);
axis square;
xlim([-apogee-5000 apogee+5000]);
ylim([-apogee-5000 apogee+5000]);
grid on;
hold on;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

xCenter2 = 0;
yCenter2 = 0;
xRadius2 = body(2);
yRadius2 = body(2);
theta2 = 0 : 0.01 : 2*pi;
x2 = xRadius2 * cos(theta2) + xCenter2;
y2 = yRadius2 * sin(theta2) + yCenter2;
plot(x2, y2, 'LineWidth', 3, 'Color', [0,0,1]);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

end

