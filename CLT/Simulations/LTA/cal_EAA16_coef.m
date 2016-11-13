clear all;
close all;

var16 = 16/3;
sq_var16 = sqrt(var16);

t = -1:1/2^11:1;
t16_hr = -16:1/2^11:16;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 16 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf4 = conv(pdf2,pdf2);
pdf8 = conv(pdf4,pdf4);
pdf16_hr = conv(pdf8,pdf8);
pdf16_hr = pdf16_hr/max(pdf16_hr );
pdf16_hr = [pdf16_hr(1:end/2) pdf16_hr(end/2+1:end)];
t16_hr =t16_hr(1:end-1) ;




%Compute the Error in PDF_n3 by inverse gaussian equation (High Rate)
pdf16_hr_old = pdf16_hr; %Save t16_hr for future
t16_hr_old = t16_hr; %Save t16_hr for future
t16_hr = t16_hr(end/2+1:end); %Take only positive side
pdf16_hr = pdf16_hr(end/2+1:end)* 1/sqrt(2*pi * var16);%Take only positive side

xg16_hr = sqrt(-2 * var16 * log(sqrt(2*pi * var16) * pdf16_hr));
ref16_hr =  exp(-xg16_hr.^2/(2*var16))* (1/(sqrt(2* pi * var16)));
err_n16_hr = (t16_hr-xg16_hr);


%Shrink the sample sile of PDF_n16 (by a factor of 32) 
ls = length(pdf16_hr);
j = 1;
for i = 1:32:ls
        t16_lr(j) = t16_hr(i);
        err_n16_lr(j) = err_n16_hr(i);
        j= j+1;
end
t16_lr(j) = t16_hr(end);
err_n16_lr(j) = err_n16_hr(end);



for i = 1:32:ls
    j= i+31;
    p2 = polyfit(t16_hr(i:i+31), err_n16_hr(i:i+31), 2);
    err_n16_fit2(i:i+31) = polyval(p2, t16_hr(i:i+31));
    p1 = polyfit(t16_hr(i:i+31), err_n16_hr(i:i+31), 1);
    err_n16_fit1(i:i+31) = polyval(p1, t16_hr(i:i+31));

    coeff_1st1(j/32) = p1(1);
	coeff_1st2(j/32) = p1(2);

    coeff_2nd1(j/32) = p2(1);
	coeff_2nd2(j/32) = p2(2);
	coeff_2nd3(j/32) = p2(3);
end


plot(t16_hr, err_n16_hr,'.');hold;
plot(t16_lr, err_n16_lr,'r.');
plot(t16_hr, err_n16_fit1,'g');

figure;
semilogy(t16_hr, abs(err_n16_fit1 - err_n16_hr));hold
semilogy(t16_hr, abs(err_n16_fit2 - err_n16_hr),'r');

figure;
plot(t16_hr, (err_n16_fit1 - err_n16_hr));hold
plot(t16_hr, (err_n16_fit2 - err_n16_hr),'r');

coeff_1st = [coeff_1st1' coeff_1st2'];
coeff_2nd = [coeff_2nd1' coeff_2nd2' coeff_2nd3'];

 
save('coeff_1st.mat', 'coeff_1st');
save('coeff_2nd.mat', 'coeff_2nd');
save('pdf16_hr_old.mat', 'pdf16_hr_old');


% Match_2nd_ref
