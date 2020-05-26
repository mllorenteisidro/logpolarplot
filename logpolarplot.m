%%========================================================================
% THIS FUNCTION WILL PRODUCE A A LOG-POLAR PLOT WITHIN GNU OCTAVE V.5.2.0
% Author: Ph.D. Miguel LLORENTE ISIDRO
% Contact: m.llorente@igme.es
% Author affiliation: Spanish Geological Survey
% TOS: use at your own risk.
% Date: 26/05/2020
% Version: 1.0

%%========================================================================
% REQUIREMENTS: GNU OCTAVE v. 5.2.0 
% Two vectors equal size:
% ori: vector data of orientation from North (up) clock-wise (eastwards +)
%   or from North (up) counter-clock-wise (westwards -).
% longi: vector data of any sort, usually frequency.

function logpolarplot(ori, longi);
  
pkg load geometry % this is required to get circles working.

%%========================================================================
% GENERAL PLOT PROPERTIES
fn = 1;             % Figure number
x = 200; y = 100;   % Screen location left-bottom corner of figure (pixels)
w = 800; h = 716;   % width and height (I had to test for sqareness of the view)
figure(fn, 'Position', [x y w h]);
hold on;
clear x y w h;

%%========================================================================
% CIRCLE PROPERTIES
a=0; b=0; % Coordinates of the center
rmax= round(log10(max(longi))); % exponent of the largest circle to plot
rmin= 1; %exponent of the smallest circle to plot
cmay=[10;10;10]/255; %color for guiding circles
cmen=[200;200;200]/255; %color for meshing circles

%%========================================================================
% Meshing circles and axis labels
for r=rmin:rmax;
  for i=2:9;
    drawCircle (a, b, r+log10(i),'-','color',cmen);
    text (0.1, r+.1, strcat('1E', num2str(r))); % Label log Y Axis
    text (r+.1, 0.1, strcat('1E', num2str(r))); % Label log X Axis
  endfor
endfor

% Guiding circles
for r=rmin:rmax+1;
  drawCircle (a, b, r,'-','color',cmay);
endfor

% Guiding mesh spaced 30º for orientations
for i=linspace(0,360,13);
      x=[0,(rmax+1)*cos(deg2rad(i))];
      y=[0,(rmax+1)*sin(deg2rad(i))];    
      plot(x, y,'-','color',cmen);
endfor

% Fitting axis
axis=([rmin,rmax]); % size range
set(gca, 'xaxislocation', 'origin', 'yaxislocation',...
 'origin','xcolor',cmay, 'ycolor', cmay); % move and color axis
xticklabels ([]); yticklabels ([]);  % remove original labels

% Labelling angular guides
clear x y i;
for i=linspace(0,330,12);
  x=(rmax+1)*sin(deg2rad(i));
  y=(rmax+1)*cos(deg2rad(i));
  if x>=0 && y>=0;
    ox=0.1; oy=0.1;
  elseif x<0 && y<0;
    ox=-0.4; oy=-0.1;
  elseif x<0 && y>=0;
    ox=-0.4; oy=0.1;
  elseif x>=0 && y<0
    ox=0.1; oy=-0.1;
  endif
  text (x+ox, y+oy, num2str(i));
endfor

%--------------------
% Angle correction, just in case, for negative or more than one turn
for i=1:length(ori);
  if ori(i)/360>=1; % Positive angles more than one turn
    ori(i)=ori(i)-360*round(ori(i)/360);
  endif
  
  if ori(i)<0; % Negative angles
    if abs(ori(i))/360 >=1; %...more than one turn
      ori(i)=360*(1-round(ori(i)/360))+ori(i);
    else
      ori(i)=ori(i)+360;
    endif
  endif

  % THE PLOT

  plot([0,log10(longi(i))*sin(deg2rad(ori(i)))],[0,log10(longi(i))*cos(deg2rad(ori(i)))],'-r');

endfor
hold off;
endfunction
