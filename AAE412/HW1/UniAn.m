function func = UniAn(chi)
ri = [22000 -103000 -15000];
vi = [0.91 -4.5 -2.5];
mu = 398600;
dt = 3600*2;
r_mag = norm(ri);
v_mag = norm(vi);
vr = dot(ri,vi)/r_mag;

alpha = 2./r_mag - v_mag.^2/mu;
a = 1./alpha;
h = cross(ri,vi);
z = alpha*chi^2;
C_stu = (cosh(sqrt(-z)) - 1)/(-z);
S_stu = abs((sinh(sqrt(-z))-sqrt(-z))/(sqrt(-z)^3));
func = r_mag*vr/sqrt(mu)*chi^2*C_stu + ...
  (1-alpha*r_mag)*chi^3*S_stu+r_mag*chi - sqrt(mu)*dt;
end
