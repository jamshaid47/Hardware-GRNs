function ln_out=ln_alpha(alpha, n)
% cordic algorithm: vectoring mode
% n = 20;
%Kn =1.25;  % An=0.80
% Initialization of variables
if(alpha<0)
alpha1=alpha*-1;
else
alpha1=alpha;
end


x0=alpha1+1;
y0=alpha1-1;

% x =Kn*x0;
% y =Kn*y0;
x =x0;
y =y0;
% Initialization of tables of constants used by CORDIC
% need a table of hyperbolic arctangents of negative powers of two, in degree:
% angles = atanh(2.^-(0:14));
angles =  [ ...
                       31.47292373094224   14.63407615446474   7.19962803559361    3.58565992092839     ...
    1.79107629434275    0.89531942091983    0.44763238469835    0.22381277709844    ...
    0.11190596165728    0.0559529274677     0.02797645706374    0.01398822769813    ...
    0.00699411374481    0 
    ];

angles =fi(angles,1,32,16);
%To save the old values
x_old = x0;
y_old = y0;
phase_out=0;
poweroftwo = 1;
% Iterations
for j = 0:n-1;
    angle = angles(j+1);

    if (y < 0)
        % update the remaining angle
        phase_out = phase_out - angle; 
        
        %Compute x and y for current iteration

        x = x + y_old*poweroftwo;
        y = y + x_old*poweroftwo;
        
    else
        % update the remaining angle
        phase_out = phase_out + angle; 
        
        %Compute x and y for current iteration      
        x = x - y_old*poweroftwo;
        y = y - x_old*poweroftwo;
       
    end
    poweroftwo = poweroftwo *0.5;
    % Save the old variables
    x_old = x;
    y_old = y;

end

 r = x ;
% if ((x_in <0 && y_in<0) || (x_in >0 && y_in>0))
if (alpha<0)
% if (x < 0 )
    phase = phase_out*-1;
    
else
    phase=phase_out;
end

ln_out=2*phase;
end