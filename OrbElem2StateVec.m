function [RX,VX,r,v,QXx] = OrbElem2StateVec(h,e,i,w,W,true_ano)
%This function will take orbital elements and compute two state vectors r and v
% r and v must be 3-D vectors
mu = 3.9860044189e5;
r = (h^2/mu)/(1+e*cos(true_ano))*[cos(true_ano) sin(true_ano) 0]';
v = mu/h*[-sin(true_ano) (e+cos(true_ano)) 0]';
R3_W = [cos(W)  sin(W) 0;
      -sin(W) cos(W) 0;
      0       0      1;];
R1_i = [1 0 0;
        0 cos(i) sin(i);
        0 -sin(i) cos(i);];
R3_w = [ cos(w) sin(w) 0;
        -sin(w) cos(w) 0 
        0 0 1;];
QXx = (R3_w) *(R1_i) *(R3_W);

RX = QXx.'*r;
VX = QXx.'*v;

end

