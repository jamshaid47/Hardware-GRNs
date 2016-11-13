clear all;
close all;

var8 = 8/3;
sq_var8 = sqrt(var8);

t = -1:1/2^12:1;
t8_hr = -8:1/2^12:8;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 8 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf4 = conv(pdf2,pdf2);
pdf8_hr = conv(pdf4,pdf4);
pdf8_hr = pdf8_hr/max(pdf8_hr );
pdf8_hr = [pdf8_hr(1:end/2) pdf8_hr(end/2+1:end)];
t8_hr =t8_hr(1:end-1) ;



%Compute the Error in PDF_n3 by inverse gaussian equation (High Rate)
pdf8_hr_old = pdf8_hr; %Save t8_hr for future
t8_hr_old = t8_hr; %Save t8_hr for future
t8_hr = t8_hr(end/2+1:end); %Take only positive side
pdf8_hr = pdf8_hr(end/2+1:end)* 1/sqrt(2*pi * var8);%Take only positive side

xg8_hr = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf8_hr));
ref8_hr =  exp(-xg8_hr.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err_n8_hr = (t8_hr-xg8_hr);


figure;
plot(t8_hr, err_n8_hr/8);


dt = t8_hr(2)-t8_hr(1)
velx = diff(t8_hr)/dt;
vely = diff(err_n8_hr)/dt;

acclx = diff(velx)/dt;
accly = diff(vely)/dt;

accl = acclx.^2 + accly.^2;
accl = sqrt(accl);

hold;
plot(t8_hr(3:end-200),-accl(1:end-200)/20/4,'g');
grid on

t = (t8_hr(16834+3:end-200))';
var = [t (accl(16834+1:end-200)/400)'+0.003];

ADC_tb_sd;
sim('ADC_tb_sd');
simout(14)=0;
plot(tout,-(simout(1:end)),'m');
legend('error function','curvature', 'segments');
title('Modeling error function');
xlabel('Standard Deviation (sigma)');
grid on;

