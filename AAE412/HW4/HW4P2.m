clear all; clc; close all;
%%% Problem 2
mu = 3.9860044189e5;
go = 9.807;
vbo = 6.7*1000;
mpl = 10;
e1 = 0.30;
Isp1 = 340;
e2 = 0.25;
Isp2 = 250;
c1 = Isp1*go;
c2 = Isp2*go;

lamda_guess = 7.716197e-3;
lamda = fzero('lagrange',lamda_guess);

n1 = (c1*lamda-1)/(c1*lamda*e1);
n2 = (c2*lamda-1)/(c2*lamda*e2);
check_1 = lamda*c1*(e1*n1 - 1)^2 + 2*e1*n1 - 1;
check_2 = lamda*c2*(e2*n2 - 1)^2 + 2*e2*n2 - 1;

m2 = mpl*(n2-1)/(1-n2*e2);
m1 = (m2+mpl)*(n1-1)/(1-n1*e1);
me1 = e1*m1;
me2 = e2*m2;
mp1 = m1-me1;
mp2 = m2-me2;
mo = m1+m2+mpl;

fprintf('Optimum mass for stage 1: %.1f kg \n', m1)
fprintf('Optimum mass for stage 2: %.1f kg \n', m2)
fprintf('Total mass: %.1f kg \n', mo)
fprintf('Propellant mass for stage 1: %.1f kg \n', mp1)
fprintf('Propellant mass for stage 2: %.1f kg \n', mp2)