clear all;
close all;

%Targeting for a 16-bit URNG we define the accettable error to be less than
%one-bit
single_bit_error = 2^-16;

%Range of the (+-) CDF y-component to be stored in the LUT
%We need to store only half of them (1K) sine the function is symmetric around center
y_target_cdf_value = 2^-12:2^-11:1;
x_computed_cdf_value =zeros(1,length(y_target_cdf_value));
y_computed_cdf_value =zeros(1,length(y_target_cdf_value));

%Main algorithm to compute the the coefficients for the LUT
% 1. We sweep the x component at a vey fine resolution
% 2. For every value of x, we compute the CDF (y-component).
% 3. Computed CDF is then compared to the corresponding y_target_cdf_value (computed above) 
% 4. If the difference is less than single_bit_error we store both x and y components

x_cdf_sweep = -4.5:1e-5:4.5;
j=1;
for i = 2:length(x_cdf_sweep)
    if(j<2049)
        y_cdf_sweep = normcdf(x_cdf_sweep(i), 0, 1);
        err=abs(y_cdf_sweep - y_target_cdf_value(j));
        if (err < single_bit_error)
            y_computed_cdf_value(j)= y_cdf_sweep;
            x_computed_cdf_value(j)= x_cdf_sweep(i);
            j=j+1;
        end
    end
end


% x_computed_cdf_value should be stored in the LUTs as coefficients

%Plotting and comparing with theoretical PDF
plot(y_computed_cdf_value, x_computed_cdf_value,'.');
x_cdf_matlab = -3.5:1e-4:3.5;
y_cdf_matlab = normcdf(x_cdf_matlab, 0, 1);
hold;
plot(y_cdf_matlab, x_cdf_matlab,'r');



