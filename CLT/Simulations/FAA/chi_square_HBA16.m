clear all;
close all;


var4 = 1;
sq_var4 = sqrt(var4);

bins = -16 :1/2^11:16;

load pdf4_16p

x = pdf4_16p(:,1);
pdf4 = pdf4_16p(:,2);

pdf4(end) = 0;
pdf8 = conv(pdf4,pdf4);
pdf16 = conv(pdf8,pdf8);


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
pdf16 = pdf16/max(pdf16)*max(ref);

semilogy(bins,ref,'b');hold;
semilogy(bins,pdf16,'g.');


pdf16 = pdf16(end/2+1:end);
bins = bins(end/2+1:end);
ref = ref(end/2+1:end);



fac = 2^7;
k = 1;
for i = 1:fac:32768
    dum(k) = 0;
    for j = 1:fac
        dum(k) = dum(k) + pdf16(i-1+j);
    end
k = k+1;
end
dum = dum/max(dum)*ref(64);
bins1 = 0+8/fac :8/fac:16;
bins1 = bins1/sq_var4-2^-5;
figure;
semilogy(bins1, dum,'r.');hold;
semilogy(bins,ref,'b');
semilogy(bins,pdf16,'g');



%Compute the Error in PDF_n4 by inverse gaussian equation (High Rate)
xg4_hr = sqrt(-2 * var4 * log(sqrt(2*pi * var4) * dum));
ref4_hr =  exp(-xg4_hr.^2/(2*var4))* (1/(sqrt(2* pi * var4)));
err_n4_hr = (bins1-xg4_hr);

figure;
plot(bins1, abs(err_n4_hr*40/16),'b');









%Compute Gaussian PDF
ref = pdf('Normal',bins1,0,1);

 
bins2 = bins1(1:48);
ref1 = round(ref(1:48)*1e3);
pdf_corr1 = round(dum(1:48)*1e3);
mychi1 = (ref1-pdf_corr1).^2./ref1;
chi_value1 =sum(mychi1)
 
bins3 = bins1(49:72);
ref2 = round(ref(49:72)*5e5);
pdf_corr2 = round(dum(49:72)*5e5);
pdf_corr2 = round(pdf_corr2 / max(pdf_corr2) * max(ref2));
mychi2 = (ref2-pdf_corr2).^2./ref2;
chi_value2 =sum(mychi2)
%  
bins4 = bins1(73:96);
ref3 = round(ref(73:96)*4e8);
pdf_corr3 = round(dum(73:96)*4e8);
pdf_corr3 = round(pdf_corr3 / max(pdf_corr3) * max(ref3));
mychi3 = (ref3-pdf_corr3).^2./ref3;
chi_value3 =sum(mychi3)% chi_value3 =sum(mychi3)
 
bins5 = bins1(97:120);
ref4 = round(ref(97:120)*1e13);
pdf_corr4 = round(dum(97:120)*1e13);
pdf_corr4 = round(pdf_corr4 / max(pdf_corr4) * max(ref4));
mychi4 = (ref4-pdf_corr4).^2./ref4;
chi_value4 =sum(mychi4)% chi_value3 =sum(mychi3)
% 
bins6 = bins1(121:144);
ref5 = round(ref(121:144)*2e18);
pdf_corr5 = round(dum(121:144)*2e18);
pdf_corr5 = round(pdf_corr5 / max(pdf_corr5) * max(ref5));
mychi5 = (ref5-pdf_corr5).^2./ref5;
chi_value5 =sum(mychi5)% chi_value3 =sum(mychi3)

bins7 = bins1(145:168);
ref6 = round(ref(145:168)*1.4e25);
pdf_corr6 = round(dum(145:168)*1.4e25);
pdf_corr6 = round(pdf_corr6 / max(pdf_corr6) * max(ref6));
mychi6 = (ref6-pdf_corr6).^2./ref6;
chi_value6 =sum(mychi6)% chi_value3 =sum(mychi3)
% 
% bins8 = bins1(102:113);
% ref7 = round(ref(102:113)*1.4e22);
% pdf_corr7 = round(dum(102:113)*1.4e22);
% pdf_corr7 = round(pdf_corr7 / max(pdf_corr7) * max(ref7));
% mychi7 = (ref7-pdf_corr7).^2./ref7;
% chi_value7 =sum(mychi7)% chi_value3 =sum(mychi3)


