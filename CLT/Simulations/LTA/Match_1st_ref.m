clear all;
close all;

var16 = 16/3;
sq_var16 = sqrt(var16);

load coeff_1st.mat;
load coeff_2nd.mat;
load pdf16_hr_old

a1i = coeff_1st(:,1);
b1i = coeff_1st(:,2);

a2i = coeff_2nd(:,1);
b2i = coeff_2nd(:,2);
c2i = coeff_2nd(:,3);

t16_hr = -16:2^-11:16-2^-12;


sz_pdf=length(t16_hr);
add=zeros(1,sz_pdf);
t16_corr=zeros(1,sz_pdf);
err16=zeros(1,sz_pdf);

%Compute the change in x-axis after error compensation
for i = 1:sz_pdf
     add(i) = floor((t16_hr(i)+16) * 64)+1;
     if(t16_hr(i) >= 0)
         add(i) = add(i) - 1024;
         err16(i) = a1i(add(i))*t16_hr(i) + b1i(add(i));
         t16_corr(i)= -err16(i) + t16_hr(i);
      else
         add(i) = 1025 - add(i) ;
         err16(i) = -a1i(add(i))*t16_hr(i) + b1i(add(i));
         t16_corr(i)= err16(i) + t16_hr(i);
      end
end

t16_corr = t16_corr/sq_var16/0.9905519640007090;

semilogy(t16_corr,pdf16_hr_old,'.');


%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance
bins = -16:1/2^3:16;
sz_bin=length(bins);
pdf_corr= zeros(1,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t16_corr(j)>bins(i) && t16_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf16_hr_old(j);
        end
    end
end

bins = bins + 1/2^4;

%Reduce bins and pdf_corr to +- 8 sigma


bins1 = -16:1/2^3:16;
bins1 = bins1 + 1/2^4;

%Compute Gaussian PDF
ref = pdf('Normal',bins1,0,1);
pdf_corr = pdf_corr/max(pdf_corr)*max(ref);

figure;
semilogy(bins, pdf_corr,'.');hold
semilogy(bins1, ref,'r');

%Compute the Error in PDF_corr by inverse gaussian equation 
var8 = 1;
sq_var8 = sqrt(var8);
pdf_corr_old = pdf_corr; %Save t8_hr for future
bins_old = bins; %Save t8_hr for future
bins = bins(end/2+1:end); %Take only positive side
pdf_corr = pdf_corr(end/2+1:end);%Take only positive side

xg8 = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf_corr));
ref =  exp(-xg8.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err_n8 = (bins-xg8);




figure;
plot(bins(1:end-3), err_n8(1:end-3));
title('Error after correction');
xlabel('Standard deviation');
ylabel('% error in standard deviation');
mean(abs(err_n8))

%plots
figure;
semilogy(xg8,ref,'b');hold;
semilogy(bins, pdf_corr,'r.');
legend('Reference PDF', 'Corrected PDF');
xlabel('Standard deviation');
ylabel('Probability');
% semilogy(t8_hr/sq_var8, pdf8_hr_old,'g');



% pdf8_sav_8s = [(t8_hr/sq_var8)' pdf8_hr_old'];
% pdf8_corr_sav_8s = [bins' pdf_corr' ref'];
% 

sum(pdf_corr*(1/2^2).*bins.^2)
sum(pdf_corr*(1/2^2))

