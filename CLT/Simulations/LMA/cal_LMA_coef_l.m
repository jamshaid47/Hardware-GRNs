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
plot(t8_hr, err_n8_hr);

fac = 2^8;

for i = fac:fac:32768
    p = polyfit(t8_hr(i-fac+1:i), err_n8_hr(i-fac+1:i), 1);
    M(i/fac) = p(1);
    C(i/fac) = p(2);
end



err_n8_corr = zeros(1,32768);
add = zeros(1,32768);
for i = 1:32768
     add(i) = floor((t8_hr(i)) * 16)+1;
     err_n8_corr(i) = M(add(i))*t8_hr(i) + C(add(i));
end


hold;
plot(t8_hr, err_n8_corr ,'c');



figure;
plot(t8_hr, (err_n8_corr-err_n8_hr),'r');





%Compute Gaussian PDF
bins = 0:1/2^5:12;
ref = pdf('Normal',bins,0,1);
pdf8_hr = pdf8_hr/max(pdf8_hr)*max(ref);

figure;
semilogy(bins, ref);hold
semilogy((t8_hr- err_n8_corr)/sq_var8, pdf8_hr,'r.');
semilogy((t8_hr- err_n8_hr)/sq_var8, pdf8_hr,'g.');

save('t8_hr.mat', 't8_hr');
save('err_n8_corr.mat', 'err_n8_corr');
save('pdf8_hr.mat', 'pdf8_hr');

% Match_ref