function func = lambert(z)
% This funciton is used to solve the lamber problem. This sub function
% finds the zeros for the stumpf functions
mu = 3.9860044189e5;
R1 = [5500 -2505 -3000];
R2 = [-3100 6910 -8850];
dt = 30*60;

r1 = norm(R1);
r2 = norm(R2);

dt_cond = cross(R1,R2);
if dt_cond(3) > 0 
    dtheta = acos(dot(R1,R2)/(r1*r2));
else 
    dtheta = (360 - acosd(dot(R1,R2)/(r1*r2)))*pi/180;
end

A = sin(dtheta)*sqrt((r1*r2)/(1-cos(dtheta)));
C_stu = (cosh(sqrt(-z)) - 1)/(-z);
S_stu = abs((sinh(sqrt(-z))-sqrt(-z))/(sqrt(-z)^3));
y = r1+r2+A*(z*S_stu-1)/sqrt(C_stu);
func = (y/C_stu)^1.5*S_stu+A*sqrt(y)-sqrt(mu)*dt;
end