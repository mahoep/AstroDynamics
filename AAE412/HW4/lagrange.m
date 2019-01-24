function func = lagrange(lamda)
%FZERO Summary of this function goes here
%   Detailed explanation goes here
go = 9.807;
 vbo = 6.7*1000;
 e1 = 0.30;
Isp1 = 340;
e2 = 0.25;
Isp2 = 250;
c1 = Isp1*go;
c2 = Isp2*go;

func = c1*log(c1*lamda-1) - c1*log(c1*lamda*e1) + c2*log(c2*lamda-1) - c2*log(c2*lamda*e2) - vbo;

end

