clear all;
close all;

t = -1:1/2^13:1;
t3_hr = -3:1/2^13:3;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 3 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf3_hr = conv(updf,pdf2);
pdf3_hr = pdf3_hr/max(pdf3_hr );


%Shrink the sample sile of PDF_n3 (by a factor of 32) 
ls = length(pdf3_hr);
j = 1;
for i = 17:32:ls
        t3(j) = t3_hr(i);
        pdf3(j) = pdf3_hr(i);
        j= j+1;
end


%Compute the Error in PDF_n3 by inverse gaussian equation
var3 = 4/3;
sq_var3 = sqrt(var3);
t3 = t3(end/2+1:end); %Take only positive side
pdf3 = pdf3(end/2+1:end)* 1/sqrt(2*pi * var3);%Take only positive side

xg3 = sqrt(-2 * var3 * log(sqrt(2*pi * var3) * pdf3));
ref3 =  exp(-xg3.^2/(2*var3))* (1/(sqrt(2* pi * var3)));

t3 = t3/sq_var3;
xg3= xg3/sq_var3;


err_n3 = (t3-xg3); %Error in PDF_n3
bar(err_n3)

dum = zeros(1,256);
err_n3 = [err_n3 dum];
ZMA_coef3 = err_n3;


%Compute area under the curve for residual PDF
%Compute Gaussian PDF
x = 1/2^9:1/2^8:4-1/2^9;
ref = pdf('Normal',x,0,1);

ref1 = ref.*ZMA_coef3;






Area = sum(ref1*1/2^7)*2


%Compute Normalization factor after correction
NF = ((1+Area) * x)-x;

%Compute final coefficients after compensating for normalization
ZMA_coef3 = -ZMA_coef3+NF;



%Cater for the numerical inaccuracy caused on edges during convolution
ZMA_coef3(end*.46:end)= ZMA_coef3(end*.46:end)*1.35;


ZMA_coef3 = ZMA_coef3;

%Compute the change in x-axis after error compensation
pdf3 =  pdf3_hr(end/2+1:end-1);
t3 =  t3_hr(end/2+1:end-1);

sz_pdf=length(pdf3);

add=zeros(1,sz_pdf);
err=zeros(1,sz_pdf);

 for i = 1:sz_pdf
    add(i) = floor(t3(i) * 128*2)+1;
    err(i) = ZMA_coef3(add(i));
 end

t3_corr = t3+err;



%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance

bins = 0:1/2^3:8;
sz_bin=length(bins);
pdf_corr= zeros(1,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t3_corr(j)>bins(i) && t3_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf3(j);
        end
    end
end

bins = bins + 1/2^4;


%compute the residual error
ref = pdf('Normal',bins,0,1);

pdf_corr = pdf_corr/max(pdf_corr)*max(ref);
pdf3 = pdf3/max(pdf3)*max(ref);
sum(ref*1/2^2)
sum(pdf_corr*1/2^2)
sum(pdf3*1/2^2)

%plots
figure;
semilogy(bins,ref);hold;
semilogy(bins, pdf_corr,'r.');
semilogy(t3, pdf3,'g');

pdf3_corr_sav = [bins' pdf_corr' ref'];
pdf3_sav = [t3' pdf3'];


%Compute the Residual Error in PDF after compensation
ref = pdf('Normal',bins,0,1);

xg3 = sqrt(-2  * log(sqrt(2*pi ) * pdf_corr));
err_n3 = (bins-xg3)*100/5; %Error in PDF_n3

err_n3(end-25:end) =  0.0;
figure;
plot(bins,err_n3);
mean(abs(err_n3))
