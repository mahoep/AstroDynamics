function [vecDeriv] = Apollo(t,z)
mustar = 0.01214;

r1 = sqrt((z(1)+mustar)^2+z(2)^2);
r2 = sqrt((z(1)+mustar-1)^2+z(2)^2);
vecDeriv(1) = z(3);
vecDeriv(2) = z(4);
vecDeriv(3) = -(1-mustar)*(z(1)+mustar)/(r1^3)-mustar*(z(1)-1+mustar)/r2^3+z(1)+2*z(4);
vecDeriv(4) = -(1-mustar)*z(2)/r1^3 - mustar*z(2)/r2^3+z(2)-2*(z(3));
vecDeriv = vecDeriv.';
end