function [] = orbits(action);
% This function plots an Earth orbit based on
% the following orbtial elements:
% perigee = altitude at perigee (miles)
% apogee = altitude at apogee (miles)
% i = inclination of orbital plane to equatorial plane (degrees)
% Omega = argument of ascending node (degrees)
% omega = argument of periapsis (degrees)
%
% Written with Matlab 5.3 by: 
% Michael Hanchak  (mhanchak AT yahoo DOT com) 
% Dayton, Ohio 
% August 9, 2001
%
% Reference Text:
% Fundamentals of Astrodynamics
% Published by Dover Press, 1971
%
% Users of this function assume all risk in using the calculations
% contained within. This function is not to be distributed without 
% the author's full consent.
%
% For best results, requires "coast.mat" and "topo.mat"

% standard switchyard programming logic
if nargin == 0;
   action = 'build';
end

% Earth radius (miles)
rad = 6378136/1000/1.6;
colors = [.6 .7 .8];
colors2 = 'k';
switch action
   
   % build GUI
case 'build'
   
   strings = {'w','W','i','Apogee','Perigee'};
   tags = {'o','O','i','alt_a','alt_p'};
   values = {'45','45','30','345','115'};
   strings2 = {'Plot Orbit','Clear Orbits','Center Earth',...
         'Zoom All','Flyby','Help','Toggle Earth','Quit'};
   callbacks = {'orbits(''plot'')','orbits(''clear'')',...
         'camva(15);view(120,30);camlookat(findobj(''tag'',''earth''));',...
         'camva(15);camlookat','orbits(''flyby'')','help orbits',...
         'orbits(''earth'')','close(gcf)'};
   
   if isempty(findobj('tag','orbits'))
      www = figure('tag','orbits');
   else
      www = findobj('tag','orbits');
      figure(www);
      clf
   end
   set(www,'position',[25   75   600   500],'color',colors2);

   for kk = 1:length(strings),
      ppp = uicontrol('Units','pixels','Position',[2 (20*(kk-1)+16) 50 20],...
         'String',strings{kk},'style','text','backgroundcolor',colors2,...
         'foregroundcolor','w','fontsize',9);
      uicontrol('Units','pixels','Position',[55 (20*(kk-1)+16) 50 20],...
         'tag',tags{kk},'style','edit','string',values{kk},'backgroundcolor',[1 1 1]);
      if kk <=2
         set(ppp,'fontname','symbol','fontsize',12);
      end
   end
   for kk =1:length(strings2),
      uicontrol('Units','pixels','Position',[10 (25*(kk-1)+150) 70 22],...
         'string',strings2{kk},'callback',callbacks{kk},'backgroundcolor',colors);
   end
   uicontrol('Units','pixels','Position',[10 370 100 80],...
      'string',['Left click and drag Earth for dynamic viewing.',...
         ' Right click for zooming. Double-Click to center. '],...
      'style','text','backgroundcolor',colors2,'fontsize',8,...
      'HorizontalAlignment','left','foregroundcolor','w');
   axes('position',[.2 .05 .75 .9],'units','normalized')
   axis equal
   axis off
   axis vis3d
   hold on

   % Plot reference frame axes
   h1 = plot([0 rad+500],[0 0],'r-');
   h2 = plot([0 0],[0 rad+500],'g-');
   h3 = plot3([0 0],[0 0],[0 rad+500],'color',[0 0 .8]);
   set([h1 h2 h3],'linewidth',4);
   
   view(120,30);
   camva(15);
   rot3d;
   data.simple = 1;
   data.handles = [];
   data.earthhandle = [];
   set(gcf,'userdata',data);
   
   orbits('earth') % call routine to draw earth
   camlookat(findobj('tag','earth'));
   
case 'earth'   
      % determine level of graphics
  
   data = get(gcf,'userdata');   
   simple = data.simple;
   delete(data.earthhandle);
   data.earthhandle = [];
   % Plot the earth (texture map or simple)
   if simple == 0 & ~isempty(which('topo.mat'))
      
      [X,Y,Z] = sphere(50);
      load topo
      topo = [topo(:,181:360) topo(:,1:180)];
      mat.dull.AmbientStrength = 0.4;
      mat.dull.DiffuseStrength = .6;
      mat.dull.SpecularColorReflectance = .5;
      mat.dull.backfacelighting = 'reverselit';
      mat.dull.SpecularExponent = 20;
      mat.dull.SpecularStrength = .8;
      data.earthhandle(1) = surface(rad*X,rad*Y,rad*Z, ...
         mat.dull, ...
         'FaceColor','texturemap',...
         'EdgeColor','none',...
         'FaceLighting','phong',...
         'Cdata',topo,'tag','earth');   
      colormap(topomap1)
      data.earthhandle(2) = light('position',rad*[10 10 10]);
      %light('position',rad*[-10 -10 -10], 'color', [.6 .2 .2]);
      %set(gcf,'renderer','opengl');
      data.simple = 1;
   else
      
      [X,Y,Z] = sphere(24);
      data.earthhandle(1) = mesh(rad*X,rad*Y,rad*Z);
      %set(data.earthhandle,'tag','earth','facecolor',[.6 .7 .9],'edgecolor',[1 1 1]);
		set(data.earthhandle(1),'tag','earth','facecolor',[0 0 1],'edgecolor',[.3 .3 1]);
      if ~isempty(which('coast.mat'))
         
         load coast
         ncst = ncst *pi/180;
         all =zeros(length(ncst),3);
         for j = 1:length(ncst)
            theta = ncst(j,1);
            phi = ncst(j,2);
            all(j,:) = [cos(theta)*cos(phi),...
                  sin(theta)*cos(phi),...
                  -sin(phi)];
         end
         
         data.earthhandle(2) = plot3(rad*all(:,1),rad*all(:,2),-rad*all(:,3));
         set(data.earthhandle(2),'color',[0 .9 0]);
         
      end
      data.simple = 0;
   end
   
   
   set(gcf,'userdata',data);
   
   % plot orbits      
case 'plot'
   deg2rad = pi/180;
   
   data = get(gcf,'userdata');
   handles = data.handles;
   
   % get orbital elements from GUI
   alt_p = str2num(get(findobj('tag','alt_p'),'string'));
   alt_a = str2num(get(findobj('tag','alt_a'),'string'));
   inc = str2num(get(findobj('tag','i'),'string'));
   Omega = str2num(get(findobj('tag','O'),'string'));
   omega = str2num(get(findobj('tag','o'),'string'));
   
   % check for correctness of input data
   if alt_p > alt_a
      error1 = errordlg('Perigee must be smaller than apogee');
      waitfor(error1);
   else
      
      % Orbital elements
      a = (alt_p + alt_a + 2*rad)/2;
      c = a - alt_p - rad;
      e = c/a;
      p = a*(1 - e^2);
      
      th = linspace(0,2*pi,200);
      r = p./(1 + e*cos(th));
      xx = r.*cos(th);
      yy = r.*sin(th);
      
      Omega = Omega*deg2rad;
      inc = inc*deg2rad; 
      omega = omega*deg2rad; 
      
      % Coordinate Transformations
      ZZ = [cos(Omega) -sin(Omega) 0;
         sin(Omega) cos(Omega) 0;
         0 0 1];
      XX = [1 0 0;
         0 cos(inc) -sin(inc);
         0 sin(inc) cos(inc)];
      ZZ2 = [cos(omega) -sin(omega) 0;
         sin(omega) cos(omega) 0;
         0 0 1];
      
      % actual plot
      vec = ZZ*XX*ZZ2*[xx;yy;zeros(1,length(xx))];
      h1 = plot3(vec(1,:),vec(2,:),vec(3,:));
      set([h1],'linewidth',1,'color',[1 1 1]);
      
      % line of ascending node
      vec1 = ZZ*[rad+600;0;0];
      h2 = plot([0 vec1(1)],[0 vec1(2)],'r-');
      % line of periapsis
      vec2 = ZZ*XX*ZZ2*[rad+600;0;0];
      h3 = plot3([0 vec2(1)],[0 vec2(2)],[0 vec2(3)],'color',...
         [1 1 0]);
      % line of inclination
      vec3 = ZZ*XX*[0;0;rad+600];
      h4 = plot3([0 vec3(1)],[0 vec3(2)],[0 vec3(3)],...
         'color',[0 0 .8]);
      set([h2 h3 h4],'linewidth',2);
      
      data.handles = [data.handles h1 h2 h3 h4];
      set(gcf,'userdata',data);
      %camlookat;
   end
   
case 'clear'
   data = get(gcf,'userdata');
   handles = data.handles;
   for rr = 1:length(handles)
      if ishandle(handles(rr))
         delete(handles(rr));
      end
   end
   data.handles = [];
   set(gcf,'userdata',data);
   
case 'flyby'
   camlookat(findobj('tag','earth'));
   camva(15);
   camup([0 0 1]);
   for x = -300000:1000:60000
      campos([x,30000,30000])
      drawnow
   end
   
   % here are the recursive callbacks for the rotation of the axes
case 'rot'
   rot3d('rot');
case 'down'
   rot3d('down');
case 'up'
   rot3d('up');
case 'zoom'
   rot3d('zoom');
   
end

% this function below allows for dynamics "click and drag"
%  rotation of the plot.
function rot3d(huh)

if nargin<1
   set(gcf,'WindowButtonDownFcn','orbits(''down'')');
   set(gcf,'WindowButtonUpFcn','orbits(''up'')');
   set(gcf,'WindowButtonMotionFcn','');
else
   
   switch huh
   case 'down'
      if strcmp(get(gcf,'SelectionType'),'normal')
         set(gcf,'WindowButtonMotionFcn','orbits(''rot'')');
      elseif strcmp(get(gcf,'SelectionType'),'alt')
         set(gcf,'WindowButtonMotionFcn','orbits(''zoom'')');
      elseif strcmp(get(gcf,'SelectionType'),'open') %center point
         temp1 = get(gca,'currentpoint');
         temp1 = (temp1(1,:) + temp1(2,:))/2; % average points
         %newvec = temp1 - campos
         %oldvec = camtarget-campos
         %dir = cross(oldvec,newvec)
         %ang = atan2(norm(dir),dot(oldvec,newvec))+2
         %campan(-ang,0,'data',dir);
         camtarget([temp1]);
      end
      rdata.oldpt = get(0,'PointerLocation');
      set(gca,'userdata',rdata);
   case 'up'
      set(gcf,'WindowButtonMotionFcn','');
   case 'rot'
      rdata = get(gca,'userdata');
      oldpt = rdata.oldpt;
      newpt = get(0,'PointerLocation');
      dx = (newpt(1) - oldpt(1))*.5;
      dy = (newpt(2) - oldpt(2))*.5;
      
      %direction = [0 0 1];
      %coordsys  = 'camera';
      %pos  = get(gca,'cameraposition' );
      %targ = get(gca,'cameratarget'   );
      %dar  = get(gca,'dataaspectratio');
      %up   = get(gca,'cameraupvector' );
      %[newPos newUp] = camrotate(pos,targ,dar,up,-dx,-dy,coordsys,direction);
      %set(gca,'cameraposition', newPos, 'cameraupvector', newUp);
      
      camorbit(gca,-dx,-dy,'camera');
      
      rdata.oldpt = newpt;
      set(gca,'userdata',rdata);
   case 'zoom'
      rdata = get(gca,'userdata');
      oldpt = rdata.oldpt;
      newpt = get(0,'PointerLocation');
      dy = (newpt(2) - oldpt(2))/abs(oldpt(2));
      camzoom(gca,1+dy)
      rdata.oldpt = newpt;
      set(gca,'userdata',rdata)
   end
   
end
