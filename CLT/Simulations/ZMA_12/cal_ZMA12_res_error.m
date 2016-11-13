clear all;
close all;



%Load coefficients for error function
load pdf12_sav

x12 = pdf12_sav(:,1);
y12 = pdf12_sav(:,2);

ref = pdf('Normal',x12,0,1);
y12 = y12/max(y12)*max(ref);


%Compute the Error in PDF_n12 by inverse gaussian equation

xg12 = sqrt(-2  * log(sqrt(2*pi ) * y12));
ref12 =  exp(-xg12.^2/2)* (1/(sqrt(2* pi )));

err_n12 = (x12-xg12); %Error in PDF_n12


figure;
plot(x12,err_n12);