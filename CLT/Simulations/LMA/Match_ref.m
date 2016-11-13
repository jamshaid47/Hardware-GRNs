clear all;
close all;

var8 = 8/3;
sq_var8 = sqrt(var8);

load t8_hr;
load pdf8_hr;

%Compute the change in x-axis after error compensation
load t8_corr;




%Compute Gaussian PDF
bins = 0:1/2^5:12;
ref = pdf('Normal',bins,0,1);
pdf8_hr = pdf8_hr/max(pdf8_hr)*max(ref);

%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance

sz_pdf=length(t8_hr);
bins = 0:1/2^3:16;
sz_bin=length(bins);
pdf_corr= zeros(1,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t8_corr(j)>bins(i) && t8_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf8_hr(j);
        end
    end
end

bins = bins + 1/2^4;


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
sum(ref *1/2^2)
pdf_corr = pdf_corr/max(pdf_corr)*max(ref);
sum(pdf_corr *1/2^2)

figure;
semilogy(bins, pdf_corr,'.');hold
semilogy(bins, ref,'r');
legend('Reference PDF', 'Corrected PDF');
xlabel('Standard deviation');
ylabel('Probability');


%Compute the Error in PDF_corr by inverse gaussian equation 
var8 = 1;
sq_var8 = sqrt(var8);

xg8 = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf_corr));
ref =  exp(-xg8.^2/(2*var8))* (1/(sqrt(2* pi * var8)));

var8 = 8/3;
sq_var8 = sqrt(var8);
err_n8 = (bins-xg8);




figure;
plot(bins(1:65), err_n8(1:65)*100/8);
title('Error after correction');
xlabel('Standard deviation');
ylabel('% error in standard deviation');


% mean(abs(err_n8))
mean(abs(err_n8(1:65)))


% %plots
% figure;
% semilogy(xg8,ref,'b');hold;
% semilogy(bins, pdf_corr,'r.');
% legend('Reference PDF', 'Corrected PDF');
% xlabel('Standard deviation');
% ylabel('Probability');
% % semilogy(t8_hr/sq_var8, pdf8_hr_old,'g');
