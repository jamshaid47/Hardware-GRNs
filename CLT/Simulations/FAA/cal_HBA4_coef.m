clear all;
close all;


sq_var4 = sqrt(4/3);
var4 = sq_var4^2;


t = -1:1/2^13:1;
t4_hr = -4:1/2^13:4;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 4 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf4_hr = conv(pdf2,pdf2);

% pdf4_hr = [pdf4_hr(1:end/2) pdf4_hr(end/2+1:end)];
% t4_hr = [t4_hr(1:end/2) t4_hr(end/2+1:end)] ;% / 1.036503531843320;


fac = t4_hr(2) - t4_hr(1)
%Compute Gaussian PDF
bins = -8:1/2^12:8;
% bins = [bins(1:end/2) bins(end/2+1:end)];

ref = pdf('Normal',bins,0,1);

pdf4_hr = pdf4_hr/max(pdf4_hr);


semilogy(t4_hr/sq_var4,pdf4_hr*max(ref),'.');hold;
semilogy(bins,ref,'r');


 
%Compute the Error in PDF_n4 by inverse gaussian equation (High Rate)
pdf4_hr_old = pdf4_hr; %Save t4_hr for future
t4_hr_old = t4_hr; %Save t4_hr for future
t4_hr = t4_hr(end/2+1:end); %Take only positive side
pdf4_hr = pdf4_hr(end/2+1:end)* max(ref)/sq_var4;%Take only positive side
 
xg4_hr = sqrt(-2 * var4 * log(sqrt(2*pi * var4) * pdf4_hr));
ref4_hr =  exp(-xg4_hr.^2/(2*var4))* (1/(sqrt(2* pi * var4)));
err_n4_hr = (t4_hr-xg4_hr);

figure;
semilogy(xg4_hr, ref4_hr,'.');hold;
semilogy(t4_hr, pdf4_hr,'r.');
%Shrink the sample sile of PDF_n4 (by a factor of 32) 
ls = length(pdf4_hr);
j = 1;
for i = 1:32:ls
        t4_lr(j) = t4_hr(i);
        err_n4_lr(j) = err_n4_hr(i);
        j= j+1;
end
t4_lr(j) = t4_hr(end);
err_n4_lr(j) = err_n4_hr(end);

for i = 1:32:ls
    j= i+31;
    p1 = polyfit(t4_hr(i:i+31), err_n4_hr(i:i+31), 1);
    err_n4_fit1(i:i+31) = polyval(p1, t4_hr(i:i+31));

    coeff_1st1(j/32) = p1(1);
	coeff_1st2(j/32) = p1(2);
 
end
 
figure; 
plot(t4_hr, err_n4_hr,'.');hold;
plot(t4_lr, err_n4_lr,'r.');
plot(t4_hr, err_n4_fit1,'g');

figure;
plot(t4_hr, (err_n4_fit1 - err_n4_hr));hold

coeff_1st = [coeff_1st1' coeff_1st2'];
save('coeff_1st.mat', 'coeff_1st');
save('pdf4_hr_old.mat', 'pdf4_hr_old');
% 
% 
% % Match_ref
