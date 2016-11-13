ang = -57.57;
n = 12;

Matlabsin = sind(ang)    
Matlabcos = cosd(ang)

%Change angle and sign to cover entire 360 degree range

if ang > 90
    ang = ang - 180;
    sign = -1;
elseif ang <= -90
    ang = ang + 180;
    sign = -1;
else
    sign = 1;
end
ang = ang * 182.044444444;
ang = round(ang)

% Initialization of tables of constants used by CORDIC
% need a table of arctangents of negative powers of two, in degree:
% angles = atan(2.^-(0:27));
angles =  round([ ...
    45.0000000000001    26.5650511770782    14.0362434679262    7.12501634890172     ...
    3.57633437499750    1.78991060824617    0.895173710211256   0.447614170860489    ...
    0.223810500368712   0.111905677066275   0.0559528918938427  0.0279764526167230   ...
    ]* 182.044444444);

% K factor

Kn=0.607252*sign; 
Kn_fi = fi(Kn,1,16,12);hex(Kn_fi)
% Initialize loop variables:
x = Kn;
y = 0;

%To save the old values
x_old = Kn;
y_old = 0;

poweroftwo = 1; 
 
%Iterations
for j = 0:n-1;
    angle = angles(j+1);

    if ang < 0
        x = x + y_old;
        y = y - x_old;
        ang = ang + angle; 
    else
        x = x - y_old;
        y = y + x_old;
        ang = ang - angle; 
    end
    
    poweroftwo = poweroftwo / 2;

    %Save the old variables
    x_old = x*poweroftwo;
    y_old = y*poweroftwo;

    a1 = fi(x,1,16,12);
    a2 = fi(y,1,16,12);
    a3 = fi(ang,1,16,0); 

    a4 = fi(x_old,1,16,12);
    a5 = fi(y_old,1,16,12);
    clc
    j
    hex([a1 a2]) 
    hex([a4 a5]) 
    hex(a3)
end

%Adjust length of output vector to be [cos(ang), sin(ang)]:
sintheta = [y Matlabsin]
costheta = [x Matlabcos]
