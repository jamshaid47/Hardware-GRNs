clear all;
close all;

t = -1:1/2^11:1;
t12_hr = -12:1/2^11:12;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 12 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf3 = conv(updf,pdf2);
pdf6 = conv(pdf3,pdf3);
pdf12_hr = conv(pdf6,pdf6);
pdf12_hr = pdf12_hr/max(pdf12_hr );


%Shrink the sample sile of PDF_n12 (by a factor of 32) 
ls = length(pdf12_hr);
j = 1;
for i = 17:32:ls
        t12(j) = t12_hr(i);
        pdf12(j) = pdf12_hr(i);
        j= j+1;
end


%Compute the Error in PDF_n12 by inverse gaussian equation
var12 = 12/3;
sq_var12 = sqrt(var12);
t12 = t12(end/2+1:end); %Take only positive side
pdf12 = pdf12(end/2+1:end)* 1/sqrt(2*pi * var12);%Take only positive side

xg12 = sqrt(-2 * var12 * log(sqrt(2*pi * var12) * pdf12));
ref12 =  exp(-xg12.^2/(2*var12))* (1/(sqrt(2* pi * var12)));

t12 = t12/sq_var12;
xg12= xg12/sq_var12;


err_n12 = (t12-xg12); %Error in PDF_n12


dum = zeros(1,256);
err_n12 = [err_n12 dum];
ZMA_coef12 = err_n12;


%Compute area under the curve for residual PDF
%Compute Gaussian PDF
x = 1/2^8:1/2^7:8-1/2^8;
ref = pdf('Normal',x,0,1);

ref1 = ref.*ZMA_coef12;
Area = sum(ref1*1/2^7)*2


%Compute Normalization factor after correction
NF = ((1+Area) * x)-x;

%Compute final coefficients after compensating for normalization
ZMA_coef12 = -ZMA_coef12+NF;

%Cater for the numerical inaccuracy caused on edges during convolution
ZMA_coef12(end*.46:end)= ZMA_coef12(end*.46:end)*1.059;




%Compute the change in x-axis after error compensation
pdf12 =  pdf12_hr(end/2+1:end-1);
t12 =  t12_hr(end/2+1:end-1)/2;

sz_pdf=length(pdf12);

add=zeros(1,sz_pdf);
err=zeros(1,sz_pdf);

 for i = 1:sz_pdf
    add(i) = floor(t12(i) * 128)+1;
    err(i) = ZMA_coef12(add(i));
 end

t12_corr = t12+err;



%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance

bins = 0:1/2^3:16;
sz_bin=length(bins);
pdf_corr= zeros(1,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t12_corr(j)>bins(i) && t12_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf12(j);
        end
    end
end

bins = bins + 1/2^4;

bins = (bins(1:end/2))';
pdf_corr = (pdf_corr(1:end/2))';

%compute the residual error
ref = pdf('Normal',bins,0,1);

pdf_corr = pdf_corr/max(pdf_corr)*max(ref);
pdf12 = pdf12/max(pdf12)*max(ref);


%plots
figure;
semilogy(bins,ref);hold;
semilogy(bins, pdf_corr,'r.')

bins1 = bins(1:36);
ref1 = round(ref(1:36)*3e5);
pdf_corr1 = round(pdf_corr(1:36)*3e5);
mychi1 = (ref1-pdf_corr1).^2./ref1;
chi_value1 =sum(mychi1)

bins2 = bins(37:48);
ref2 = round(ref(37:48)*1e9);
pdf_corr2 = round(pdf_corr(37:48)*1e9);
pdf_corr2 = round(pdf_corr2 / max(pdf_corr2) * max(ref2));
mychi2 = (ref2-pdf_corr2).^2./ref2;
chi_value2 =sum(mychi2)

bins3 = bins(49:56);
ref3 = round(ref(49:56)*5.0e11);
pdf_corr3 = round(pdf_corr(49:56)*5.0e11);
pdf_corr3 = round(pdf_corr3 / max(pdf_corr3) * max(ref3));
mychi3 = (ref3-pdf_corr3).^2./ref3;
chi_value3 =sum(mychi3)

bins4 = bins(57:64);
ref4 = round(ref(57:64)*1e15);
pdf_corr4 = round(pdf_corr(57:64)*1e15);
pdf_corr4 = round(pdf_corr4 / max(pdf_corr4) * max(ref4));
mychi4 = (ref4-pdf_corr4).^2./ref4;
chi_value4 = sum(mychi4)

