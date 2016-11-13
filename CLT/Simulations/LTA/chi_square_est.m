clear all;
close all;

var16 = 16/3;
sq_var16 = sqrt(var16);

load coeff_2nd.mat;
load pdf16_hr_old

a2i = coeff_2nd(:,1);
b2i = coeff_2nd(:,2);
c2i = coeff_2nd(:,3);

%fac = 1/sq_var16/0.9909519640007090;
fac = 1/sq_var16/0.992693;

gg = 256 ;
tt = 1.0325;
a2i(gg:end)= a2i(gg:end)*tt;
b2i(gg:end)= b2i(gg:end)*tt;
c2i(gg:end)= c2i(gg:end)*tt;






a_tr = a2i*fac;
b_tr = (1- b2i)*fac ;
c_tr = c2i*fac;


t16_hr = -16:2^-11:16-2^-12;


sz_pdf=length(t16_hr);
add=zeros(1,sz_pdf);
t16_corr=zeros(1,sz_pdf);
t16_corr1=zeros(1,sz_pdf);
err16=zeros(1,sz_pdf);

%Compute the change in x-axis after error compensation
for i = 1:sz_pdf
     add(i) = floor((t16_hr(i)+16) * 64)+1;
     if(t16_hr(i) >= 0)
         add(i) = add(i) - 1024;
         t16_corr(i)= -a_tr(add(i))*t16_hr(i)^2 + b_tr(add(i))*t16_hr(i) - c_tr(add(i));
      else
         add(i) = 1025 - add(i) ;
         t16_corr(i)= a_tr(add(i))*t16_hr(i)^2 + b_tr(add(i))*t16_hr(i) + c_tr(add(i));
      end
end


t16_corr= fi(t16_corr, 1, 16,11);
t16_corr= double(t16_corr);


%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance
nn = 2^3;
nn2 = nn*2;
nn4 = nn2*2;
bins = -16:1/nn:16;
sz_bin=length(bins);
pdf_corr= zeros(-2,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t16_corr(j)>bins(i) && t16_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf16_hr_old(j);
        end
    end
end

bins = bins + 1/(nn2);

%Reduce bins and pdf_corr to +- 8 sigma


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
pdf_corr = pdf_corr/max(pdf_corr)*max(ref);

bins = bins(end/2:end);
ref = (ref(end/2:end))';
pdf_corr = (pdf_corr(end/2:end))';


bins1 = bins(1:36);
ref1 = round(ref(1:36)*3e5);
pdf_corr1 = round(pdf_corr(1:36)*3e5);
mychi1 = (ref1-pdf_corr1).^2./ref1;
chi_value1 =sum(mychi1)

bins2 = bins(37:53);
ref2 = round(ref(37:53)*2e10);
pdf_corr2 = round(pdf_corr(37:53)*2e10);
pdf_corr2 = round(pdf_corr2 / max(pdf_corr2) * max(ref2));
mychi2 = (ref2-pdf_corr2).^2./ref2;
chi_value2 =sum(mychi2)

bins3 = bins(54:65);
ref3 = round(ref(54:65)*1.5e15);
pdf_corr3 = round(pdf_corr(54:65)*1.5e15);
pdf_corr3 = round(pdf_corr3 / max(pdf_corr3) * max(ref3));
mychi3 = (ref3-pdf_corr3).^2./ref3;
chi_value3 =sum(mychi3)

bins4 = bins(66:75);
ref4 = round(ref(66:75)*1e20);
pdf_corr4 = round(pdf_corr(66:75)*1e20);
pdf_corr4 = round(pdf_corr4 / max(pdf_corr4) * max(ref4));
mychi4 = (ref4-pdf_corr4).^2./ref4;
chi_value4 = sum(mychi4)

bins5 = bins(76:85);
ref5 = round(ref(76:85)*3e25);
pdf_corr5 = round(pdf_corr(76:85)*3e25);
pdf_corr5 = round(pdf_corr5 / max(pdf_corr5) * max(ref5));
mychi5 = (ref5-pdf_corr5).^2./ref5;
chi_value5 = sum(mychi5)

bins6 = bins(86:94);
ref6 = round(ref(86:94)*5.3e30);
pdf_corr6 = round(pdf_corr(86:94)*5.3e30);
pdf_corr6 = round(pdf_corr6 / max(pdf_corr6) * max(ref6));
mychi6 = (ref6-pdf_corr6).^2./ref6;
chi_value6 = sum(mychi6)

bins7 = bins(95:102);
ref7 = round(ref(95:102)*5e35);
pdf_corr7 = round(pdf_corr(95:102)*5e35);
pdf_corr7 = round(pdf_corr7 / max(pdf_corr7) * max(ref7));
mychi7 = (ref7-pdf_corr7).^2./ref7;
chi_value7 = sum(mychi7)

bins8 = bins(103:110);
ref8 = round(ref(103:110)*3e41);
pdf_corr8 = round(pdf_corr(103:110)*3e41);
pdf_corr8 = round(pdf_corr8 / max(pdf_corr8) * max(ref8));
mychi8 = (ref8-pdf_corr8).^2./ref8;
chi_value8 = sum(mychi8)

bins9 = bins(111:117);
ref9 = round(ref(111:117)*5e47);
pdf_corr9 = round(pdf_corr(111:117)*5e47);
pdf_corr9 = round(pdf_corr9 / max(pdf_corr9) * max(ref9));
mychi9 = (ref9-pdf_corr9).^2./ref9;
chi_value9 = sum(mychi9)

bins10 = bins(118:123);
ref10 = round(ref(118:123)*5e51);
pdf_corr10 = round(pdf_corr(118:123)*5e51);
pdf_corr10 = round(pdf_corr10 / max(pdf_corr10) * max(ref10));
mychi10 = (ref10-pdf_corr10).^2./ref10;
chi_value10 = sum(mychi10)

bins11 = bins(124:129);
ref11 = round(ref(124:129)*5e56);
pdf_corr11 = round(pdf_corr(124:129)*5e56);
pdf_corr11 = round(pdf_corr11 / max(pdf_corr11) * max(ref11));
mychi11 = (ref11-pdf_corr11).^2./ref11;
chi_value11 = sum(mychi11)


figure;
semilogy(bins1, pdf_corr1,'.');hold
semilogy(bins1, ref1,'r.');
figure;
semilogy(bins2, pdf_corr2,'.');hold
semilogy(bins2, ref2,'r.');
figure;
semilogy(bins3, pdf_corr3,'.');hold
semilogy(bins3, ref3,'r.');
figure;
semilogy(bins4, pdf_corr4,'.');hold
semilogy(bins4, ref4,'r.');
figure;
semilogy(bins5, pdf_corr5,'.');hold
semilogy(bins5, ref5,'r.');
figure;
semilogy(bins6, pdf_corr6,'.');hold
semilogy(bins6, ref6,'r.');
figure;
semilogy(bins7, pdf_corr7,'.');hold
semilogy(bins7, ref7,'r.');
figure;
semilogy(bins8, pdf_corr8,'.');hold
semilogy(bins8, ref8,'r.');
figure;
semilogy(bins9, pdf_corr9,'.');hold
semilogy(bins9, ref9,'r.');
figure;
semilogy(bins10, pdf_corr10,'.');hold
semilogy(bins10, ref10,'r.');
figure;
semilogy(bins11, pdf_corr11,'.');hold
semilogy(bins11, ref11,'r.');
