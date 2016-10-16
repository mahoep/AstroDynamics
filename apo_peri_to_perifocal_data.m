function [e,T,h,spec_E,vel_a,vel_p] = apo_peri_to_perifocal_data(apogee,perigee,body)
%This function will take perigee and apogee data from an orbit. The user
%will pick the orbital body (Earth, Moon, Mars, Europa, etc..) and receive
%eccentricity, period, and specific angular momentum
% apogee and perigee need to be absolute NOT altitude
% this equation only works in a perifocal, elliptical orbit
% when calling the function have body = [];


% Gravitaional Paramters
% Body	? (km3 s?2)
Sun	 = 1.327124400189e11;
Mercury = 2.20329e4;
Venus =	3.248599e5;
Earth = 3.9860044189e5;
Moon = 4.90486959e3;
Mars = 4.2828372e4;
Ceres = 6.26325e1;
Jupiter	= 1.266865349e8;
Saturn = 3.79311879e7;
Uranus = 5.7939399e6;
Neptune = 6.8365299e6;
Pluto = 8.719e2;
Eris = 1.1089e3;
Europa = 3.20345e3;

% prompt = 
body = input('What is the parent orbital body?')


semi_major_axis = (apogee + perigee)/2;
e = (apogee-perigee)/(apogee+perigee);
semi_latus_rectum = semi_major_axis*(1-e^2);
h = sqrt(semi_latus_rectum*body);
spec_E = -body/(2*semi_major_axis);
T = 2*pi/sqrt(body)*semi_major_axis^(3/2);

vel_a = h/apogee;
vel_p = h/perigee;


end

