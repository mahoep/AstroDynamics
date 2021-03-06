function [h,e,i,w,W,true_ano,N] = stateVec2OrbElem(r,v)
%This function will take two state vectors r and v and compute the six orbital elements 
% r and v must be 3-D vectors
% Currently this is only for Geocentric orbits
mu = 3.9860044189e5;

h = cross(r,v); % specific angular momentum
i = acosd(h(3)/norm(h));  % inclination is hz divided by the magnitude of h
N = cross([0 0 1],h); % line of nodes is the unit vector k cross h

    if N(2) >= 0 
        % Right ascesnsion of the ascending Node
        W = acosd(N(1)/norm(N));
    else
        W = 360-acosd(N(1)/norm(N));
    end
 % eccentricity vector   
    vr = dot(r,v)/norm(r);
    e = ((norm(v)^2 - mu/norm(r))*r - norm(r)*vr*v)/mu; 
        
    if e(3) >= 0 
        % argument of perigee
        w = acosd(dot(N,e)/(norm(N)*norm(e)));
    else
        w = 360-acosd(dot(N,e)/(norm(N)*norm(e)));
    end
    
    if vr >= 0 
        %true anomaly
        true_ano = acosd(dot(e,r)/(norm(e)*norm(r)));
    else
        true_ano = 360-acosd(dot(e,r)/(norm(e)*norm(r)));
    end
    
    
end
    
