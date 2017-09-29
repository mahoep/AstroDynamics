function [r,v,f,g,fdot,gdot,rnew] = TwoBodyProblem_Perifocal(r0,v0,dtheta)
    % this function will output state vectors r and v when given some inital
    % r and v vector and a change in true anomaly
    % r = f*r0 + g*v0
    % v = fdot*r0 + gdot*v0 
    % f and g are the lagrange coefficents in terms of a change in true
    % anomaly 
    
    r0 = input('What is the inital position vector? ex: [x y z]  ')
    v0 = input('What is the inital velocity vector?  ')
    dtheta = input('What is the change in true anamoly?  ')
    
    mu = 3.9860044189e5;
    r0mag = norm(r0);  % magnitude of r0 vector
    v0mag = norm(v0);   % magnitude of v0 vector
    vr0mag = dot(r0,v0)/r0mag; % v0 vector in the radial direction
   
    hscalar = r0mag*sqrt((v0mag^2 - vr0mag^2)); %specific angular momentum in scalar form

    rnew = ((hscalar^2/mu)*1/(1+(hscalar^2/(mu*r0mag) - 1)*cosd(dtheta) - (hscalar*vr0mag/mu)*(sind(dtheta))));
    
    f = 1 - (mu*rnew/hscalar^2)*(1-cosd(dtheta));
    g = (rnew*r0mag/hscalar)*sind(dtheta);
    fdot = (mu/hscalar)*((1-cosd(dtheta))/sind(dtheta))*((mu/hscalar^2)*(1-cosd(dtheta)) - 1/r0mag-1/rnew);
    gdot = 1 - (mu*r0mag/hscalar^2)*(1-cosd(dtheta));
    
    r = f*r0 + g*v0;
    v = fdot*r0 + gdot*v0 ;

end