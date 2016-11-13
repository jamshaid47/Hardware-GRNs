function [z0,z1]=equation(u1,u2,n)
% this function evaluates two equations: 
% z0=sqrt(-2*ln(u1)) * cos(2*pi*u2) ,
% z1=sqrt(-2*ln(u1)) * sin(2*pi*u2)
% first we find natural logarithm of u1 using the CORDIC method
%    Input n is the number of steps/iterations to compute ln(x).
%    input u1 is the input angle
%    Local, real A(1:25) = exp ( (1/2)^(1:25) );
a_length = 25;

  a = [ ...
    1.648721270700128, ...
    1.284025416687742, ...
    1.133148453066826, ...
    1.064494458917859, ...
    1.031743407499103, ...
    1.015747708586686, ...
    1.007843097206488, ...
    1.003913889338348, ...
    1.001955033591003, ...
    1.000977039492417, ...
    1.000488400478694, ...
    1.000244170429748, ...
    1.000122077763384, ...
    1.000061037018933, ...
    1.000030518043791, ...
    1.0000152589054785, ...
    1.0000076294236351, ...
    1.0000038147045416, ...
    1.0000019073504518, ...
    1.0000009536747712, ...
    1.0000004768372719, ...
    1.0000002384186075, ...
    1.0000001192092967, ...
    1.0000000596046466, ...
    1.0000000298023228 ];
% exp(1)=2.718281828459045; 
  e = 2.718281828459045;  

  if ( u1 <= 0.0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'LN_CORDIC - Fatal error!\n' );
    fprintf ( 1, '  Input argument u1 <= 0.0\n' );
    error ( 'LN_CORDIC - Fatal error!' );
  end

  k = 0;

  while ( e <= u1 )
    k = k + 1;
    u1 = u1 / e;
  end

  while ( u1 < 1.0 )
    k = k - 1;
    u1 = u1 * e;
  end
%
%  Determine the weights.
%
  for i = 1 : n

    w(i) = 0.0;

    if ( i <= a_length )
      ai = a(i);
    else
      ai = 1.0 + ( ai - 1.0 ) / 2.0;
    end

    if ( ai < u1 )
      w(i) = 1.0;
      u1 = u1 / ai;
    end

  end

  u1 = u1 - 1.0;
  u1 = u1 ...
    * ( 1.0 - ( u1 / 2.0 ) ...
    * ( 1.0 + ( u1 / 3.0 ) ...
    * ( 1.0 -   u1 / 4.0 )));
%
%  Assemble.
%
  poweroftwo = 0.5;
  for i = 1 : n
    u1 = u1 + w(i) * poweroftwo;
    poweroftwo = poweroftwo / 2.0;
  end

  ln_u1 = k + u1;
  
root_var=-2*ln_u1;  

% square root computation
if ( root_var < 0.0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'SQRT_CORDIC - Fatal error!\n' );
    fprintf ( 1, '  root_var < 0.\n' );
    error ( 'SQRT_CORDIC - Fatal error!' )
  end

  if ( root_var == 0.0 )
    root_result = 0.0;
    return
  end

  if ( root_var == 1.0 )
    root_result = 1.0;
    return
  end

  poweroftwo = 1.0;

  if ( root_var < 1.0 )

    while ( root_var <= poweroftwo * poweroftwo )
      poweroftwo = poweroftwo / 2.0;
    end

    root_result = poweroftwo;

  elseif ( 1.0 < root_var )

    while ( poweroftwo * poweroftwo <= root_var )
      poweroftwo = 2.0 * poweroftwo;
    end

    root_result = poweroftwo / 2.0;

  end

  for i = 1 : n
    poweroftwo = poweroftwo / 2.0;
    if ( ( root_result + poweroftwo ) * ( root_result + poweroftwo ) <= root_var )
      root_result = root_result + poweroftwo;
    end
  end
   
  %cos and sin computation
  cos_sin_var=2*pi*u2;
  

%Change angle and sign to cover entire 360 degree range

if cos_sin_var <=270 && cos_sin_var > 90
    cos_sin_var = cos_sin_var - 180;
    sign = -1;
elseif cos_sin_var <= 360 && cos_sin_var > 270
    cos_sin_var = cos_sin_var - 360;
    sign = 1;
else
    sign = 1;
end

% Initialization of tables of constants used by CORDIC
% need a table of arctangents of negative powers of two, in degree:
% angles = atan(2.^-(0:27));
angles =  [ ...
    45.0000000000001    26.5650511770782    14.0362434679262    7.12501634890172     ...
    3.57633437499750    1.78991060824617    0.895173710211256   0.447614170860489    ...
    0.223810500368712   0.111905677066275   0.0559528918938427  0.0279764526167230   ...
    0.0139882271423016  0.00699411367514263 0.00349705685046287 0.00174852842723679  ...
    0.00087426421361833 0.00043713210680919 0.00021856605369107 0.000109283026559060 ...
    ];

% K factor
Kn =0.607252;

% Initialize loop variables:
x = Kn;
y = 0;

%To save the old values
x_old = Kn;
y_old = 0;

poweroftwo = 1;

% Iterations
for j = 0:n-1;
    angle = angles(j+1);
    if cos_sin_var < 0
        % update the remaining angle
        cos_sin_var = cos_sin_var + angle; 
        
        %Compute x and y for current iteration
        x = x + y_old*poweroftwo;
        y = y - x_old*poweroftwo;
    else
        % update the remaining angle
        cos_sin_var = cos_sin_var - angle; 
        
        %Compute x and y for current iteration
        x = x - y_old*poweroftwo;
        y = y + x_old*poweroftwo;
    end
   
    poweroftwo = poweroftwo *0.5;
    % Save the old variables
    x_old = x;
    y_old = y;


end

% Adjust length of output vector to be [cos(beta), sin(beta)]:
sin_out = y * sign;
cos_out = x * sign;

z0=root_result*cos_out;  % z0=sqrt(-2*ln(u1)) * cos(2*pi*u2)

z1=root_result*sin_out;  % z1=sqrt(-2*ln(u1)) * sin(2*pi*u2)


end
