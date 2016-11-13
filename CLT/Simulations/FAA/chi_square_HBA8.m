clear all;
close all;


var4 = 2;
sq_var4 = sqrt(var4);

bins = -16 :1/2^11:16;

load pdf4_8p

x = pdf4_8p(:,1);
pdf4 = pdf4_8p(:,2);


pdf8 = conv(pdf4,pdf4);


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
pdf8 = pdf8/max(pdf8)*max(ref);
semilogy(bins/sq_var4,pdf8,'g.');

pdf8 = pdf8(end/2+1:end);
bins = bins(end/2+1:end);
ref = ref(end/2+1:end);



fac = 2^8;
k = 1;
for i = 1:fac:32768
    dum(k) = 0;
    for j = 1:fac
        dum(k) = dum(k) + pdf8(i-1+j);
    end
k = k+1;
end
dum = dum/max(dum)*max(ref);
bins1 = 0+8/fac :32/fac:16;
bins1 = bins1/sq_var4;

semilogy(bins1, dum,'g.');hold;
semilogy(bins,ref,'b');
semilogy(bins/sq_var4,pdf8,'g.');

var4 = 1;
%Compute the Error in PDF_n4 by inverse gaussian equation (High Rate)
xg4_hr = sqrt(-2 * var4 * log(sqrt(2*pi * var4) * dum));
ref4_hr =  exp(-xg4_hr.^2/(2*var4))* (1/(sqrt(2* pi * var4)));
err_n4_hr = (bins1-xg4_hr);

figure;
plot(bins1, abs(err_n4_hr*100/16),'g');

%Compute Gaussian PDF
ref = pdf('Normal',bins1,0,1);

 
bins2 = bins1(1:36);
ref1 = round(ref(1:36)*3e3);
pdf_corr1 = round(dum(1:36)*3e3);
mychi1 = (ref1-pdf_corr1).^2./ref1;
chi_value1 =sum(mychi1)
 
bins3 = bins1(37:53);
ref2 = round(ref(37:53)*9e5);
pdf_corr2 = round(dum(37:53)*9e5);
mychi2 = (ref2-pdf_corr2).^2./ref2;
chi_value2 =sum(mychi2)
 
bins4 = bins1(54:65);
ref3 = round(ref(54:65)*8e7);
pdf_corr3 = round(dum(54:65)*8e7);
mychi3 = (ref3-pdf_corr3).^2./ref3;
chi_value3 =sum(mychi3)% chi_value3 =sum(mychi3)

bins5 = bins1(66:77);
ref4 = round(ref(66:77)*1e11);
pdf_corr4 = round(dum(66:77)*1e11);
mychi4 = (ref4-pdf_corr4).^2./ref4;
chi_value4 =sum(mychi4)% chi_value3 =sum(mychi3)

bins6 = bins1(78:89);
ref5 = round(ref(78:89)*2e14);
pdf_corr5 = round(dum(78:89)*2e14);
pdf_corr5 = round(pdf_corr5 / max(pdf_corr5) * max(ref5));
mychi5 = (ref5-pdf_corr5).^2./ref5;
chi_value5 =sum(mychi5)% chi_value3 =sum(mychi3)

bins7 = bins1(90:101);
ref6 = round(ref(90:101)*1.4e18);
pdf_corr6 = round(dum(90:101)*1.4e18);
pdf_corr6 = round(pdf_corr6 / max(pdf_corr6) * max(ref6));
mychi6 = (ref6-pdf_corr6).^2./ref6;
chi_value6 =sum(mychi6)% chi_value3 =sum(mychi3)

bins8 = bins1(102:113);
ref7 = round(ref(102:113)*1.4e22);
pdf_corr7 = round(dum(102:113)*1.4e22);
pdf_corr7 = round(pdf_corr7 / max(pdf_corr7) * max(ref7));
mychi7 = (ref7-pdf_corr7).^2./ref7;
chi_value7 =sum(mychi7)% chi_value3 =sum(mychi3)


% figure;
% semilogy(bins1, pdf_corr1,'.');hold
% semilogy(bins1, ref1,'r.');
% figure;
% semilogy(bins2, pdf_corr2,'.');hold
% semilogy(bins2, ref2,'r.');
% figure;
% semilogy(bins3, pdf_corr3,'.');hold
% semilogy(bins3, ref3,'r.');
% figure;
% semilogy(bins4, pdf_corr4,'.');hold
% semilogy(bins4, ref4,'r.');
% figure;
% semilogy(bins5, pdf_corr5,'.');hold
% semilogy(bins5, ref5,'r.');
% figure;
% semilogy(bins6, pdf_corr6,'.');hold
% semilogy(bins6, ref6,'r.');
% figure;
% semilogy(bins7, pdf_corr7,'.');hold
% semilogy(bins7, ref7,'r.');
% figure;
% semilogy(bins8, pdf_corr8,'.');hold
% semilogy(bins8, ref8,'r.');
% figure;
% semilogy(bins9, pdf_corr9,'.');hold
% semilogy(bins9, ref9,'r.');
% figure;
% semilogy(bins10, pdf_corr10,'.');hold
% semilogy(bins10, ref10,'r.');
% figure;
% semilogy(bins11, pdf_corr11,'.');hold
% semilogy(bins11, ref11,'r.');
