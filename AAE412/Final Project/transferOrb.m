clear all; clc;close all
mu = 3.9860044189e5;
mo = 3900+92670+5900;
T = 801; 
Isp = 340;
g = 9.81;

rp = 317+6378;
vp = 10;
theta = 28.5;
options = odeset('RelTol',1e-5);
[T,Z] = ode45('OrbEq',[0 3600*15], [rp 0 0 0 vp*cosd(theta) vp*sind(-theta)],options);
for i =1:1
R = 6378; % radius of Earth. Used for plot
%pretty image
A=imread('earth2.jpg');
[mytext,map]=rgb2ind(A,256); %usable data for matlab
mytext=flipud(mytext);
hold on;
% Create the surface.
[xx,yy,zz] = sphere(100); % generates sphere data
colormap(map)
surface(R*xx,R*yy,R*zz,'CData',mytext,'FaceColor','texturemap','FaceLighting','phong','EdgeLighting','phong','EdgeColor','none');
%set the colormap. 
end
hold on;grid on
plot3(Z(:,1),Z(:,2),Z(:,3),'LineWidth',2,'Color','k')
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')
