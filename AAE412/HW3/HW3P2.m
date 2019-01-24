%%% Problem 2
clear;clc;close all;
mu = 3.9860044189e5;
% parameters for Spacecraft A
A.e = 0.025;
A.W = 40*pi/180;
A.i = 60*pi/180;
A.w = 30*pi/180;
A.theta = 40*pi/180;
A.h = 52060;
% parameters for Spacecraft B
B.e = 0.007;
B.W = 40*pi/180;
B.i = 50*pi/180;
B.w = 120*pi/180;
B.theta = 40*pi/180;
B.h = 52360;
%find relative position, velocity, and acceleration of B relative to A

[rA, vA] = OrbElem2StateVec(A.h,A.e,A.i,A.w,A.W,A.theta);
[rB, vB] = OrbElem2StateVec(B.h,B.e,B.i,B.w,B.W,B.theta);


hA = cross(rA,vA);
ihat = rA/norm(rA);
khat = hA/norm(hA);
jhat = cross(khat,ihat);

W = hA/norm(rA)^2;
Wdot = -2*dot(vA,rA)/norm(rA)^2*W;

aA = -mu/norm(rA)^3*rA;
aB = -mu/norm(rB)^3*rB;
Rrel = rB-rA;
Vrel = vB - vA - cross(W,Rrel);
Arel = aB-aA - cross(Wdot,Vrel) - cross(W,cross(W,Rrel)) - 2*cross(W,Vrel);
QXx = [ihat(1) jhat(1) khat(1);
        ihat(2) jhat(2) khat(2);
        ihat(3) jhat(3) khat(3);
        ];
r_lvlh = QXx.'*Rrel;
v_lvlh = QXx.'*Vrel;
a_lvlh = QXx.'*Arel;

fprintf('Relative position, velocity, and acceleration of B, relative to A, in local vertical/ local horizontal of A \n')
fprintf('Relative position [%0.1f %0.1f %0.1f] km \n',r_lvlh)
fprintf('Relative velocity [%0.3f %0.3f %0.3f] km/s \n',v_lvlh)
fprintf('Relative acceleration [%0.3s %0.3s %0.3s] km/s^2 \n',a_lvlh)

