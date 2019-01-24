clear all; clc; close all;
e = 4.81e-05;
i = 0.1091*pi/180;
w = 52.8878*pi/180;
W = 278.5475*pi/180;
true_ano = 0;
ra = 6378+35789;
rp = 6378+35785;
mu = 3.9860044189e5;
h = sqrt(rp*mu*(1+e));


[RX,VX] = OrbElem2StateVec(h,e,i,w,W,true_ano);
options = odeset('RelTol',1e-6);
[T,Z] = ode45('OrbEq',[0 3600*24],[RX VX],options);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%XY PLANE
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
hold on;
F = plot3(Z(:,1),Z(:,2),Z(:,3),'LineWidth',2,'Color','k') % plots the x,y,z vectors from ode45
axis equal
axis([-4.5e04 4.5e04 -4.5e04 4.5e04 -1.5e04 1.5e04])  % axis size to keep sphere spherical
view( [0 90])  % specific view point
grid on
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')


rp = [319+6378 0 0];
vp = 10.13;
theta = 28.5;

options = odeset('RelTol',1e-5);
[T2,Z2] = ode45('OrbEq',[0 3600*15], [rp 0 vp*cosd(theta) vp*sind(-theta)],options);
hold on;grid on
Tr = plot3(Z2(:,1),Z2(:,2),Z2(:,3),'LineWidth',2,'Color','b')
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')
legend([F Tr],{'Final Orbit','Transfer Orbit'})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%YZ PLANE

figure 
hold on;
% Create the surface.
[xx,yy,zz] = sphere(100); % generates sphere data
colormap(map)
surface(R*xx,R*yy,R*zz,'CData',mytext,'FaceColor','texturemap','FaceLighting','phong','EdgeLighting','phong','EdgeColor','none');
F = plot3(Z(:,1),Z(:,2),Z(:,3),'LineWidth',2,'Color','k') % plots the x,y,z vectors from ode45
axis equal
axis([-4.5e04 4.5e04 -4.5e04 4.5e04 -1.5e04 1.5e04])  % axis size to keep sphere spherical
view( [0 0])  % specific view point
grid on
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')

options = odeset('RelTol',1e-5);
[T2,Z2] = ode45('OrbEq',[0 3600*15], [rp 0 vp*cosd(theta) vp*sind(-theta)],options);
hold on;grid on
Tr = plot3(Z2(:,1),Z2(:,2),Z2(:,3),'LineWidth',2,'Color','b')
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')
% legend([F Tr],{'Final Orbit','Transfer Orbit'})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%XZ PLANE
figure 
hold on;
% Create the surface.
[xx,yy,zz] = sphere(100); % generates sphere data
colormap(map)
surface(R*xx,R*yy,R*zz,'CData',mytext,'FaceColor','texturemap','FaceLighting','phong','EdgeLighting','phong','EdgeColor','none');
F = plot3(Z(:,1),Z(:,2),Z(:,3),'LineWidth',2,'Color','k') % plots the x,y,z vectors from ode45
axis equal
axis([-4.5e04 4.5e04 -4.5e04 4.5e04 -1.5e04 1.5e04])  % axis size to keep sphere spherical
view( [90 0])  % specific view point
grid on
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')

 
options = odeset('RelTol',1e-5);
[T2,Z2] = ode45('OrbEq',[0 3600*15], [rp 0 vp*cosd(theta) vp*sind(-theta)],options);
hold on;grid on
Tr = plot3(Z2(:,1),Z2(:,2),Z2(:,3),'LineWidth',2,'Color','b')
xlabel('X-axis (km)');ylabel('Y-axis (km)'),zlabel('Z-axis (km)')
% legend([F Tr],{'Final Orbit','Transfer Orbit'})

