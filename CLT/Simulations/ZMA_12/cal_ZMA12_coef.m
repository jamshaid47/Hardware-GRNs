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

Area = 1 + Area;

%Compute Normalization factor after correction
NF = x*(Area -1);

%Compute final coefficients after compensating for normalization
ZMA_coef12 = -(ZMA_coef12*Area) +NF;
%ZMA_coef12 = -ZMA_coef12;

%Cater for the numerical inaccuracy caused on edges during convolution
ZMA_coef12(end*.35:end)= ZMA_coef12(end*.35:end)*1.0455;




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


%compute the residual error
ref = pdf('Normal',bins,0,1);

pdf_corr = pdf_corr/max(pdf_corr)*max(ref);
pdf12 = pdf12/max(pdf12)*max(ref);
sum(ref*1/2^2)
sum(pdf_corr*1/2^2)
sum(pdf12*1/2^2)

%plots
figure;
semilogy(bins,ref);hold;
semilogy(bins, pdf_corr,'r.')
semilogy(t12, pdf12,'g')

pdf12_corr_sav = [bins' pdf_corr' ref'];
pdf12_sav = [t12' pdf12'];


%Compute the Residual Error in PDF after compensation
ref = pdf('Normal',bins,0,1);

xg12 = sqrt(-2  * log(sqrt(2*pi ) * pdf_corr));
err_n12 = (bins-xg12)*100/8; %Error in PDF_n12


figure;
plot(bins(1:end-64),err_n12(1:end-64),'r');
mean(abs(err_n12(1:end-64)))