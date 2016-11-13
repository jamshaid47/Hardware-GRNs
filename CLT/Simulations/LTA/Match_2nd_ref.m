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


a_tr= fi(a_tr, 1, 32,16);
a_tr= double(a_tr);
b_tr= fi(b_tr, 1, 32,11);
b_tr= double(b_tr);
c_tr= fi(c_tr, 1, 32,10);
c_tr= double(c_tr);


t16_hr= fi(t16_hr, 1, 16,11);
t16_hr= double(t16_hr);


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

semilogy(t16_corr,pdf16_hr_old,'b.');



%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance
bins = -16:1/2^2:16;
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

bins = bins + 1/2^3;

%Reduce bins and pdf_corr to +- 8 sigma


bins1 = -16:1/2^2:16;
bins1 = bins1 + 1/2^3;

%Compute Gaussian PDF
ref1 = pdf('Normal',bins1,0,1);
pdf_corr = pdf_corr/max(pdf_corr)*max(ref1);

figure;
semilogy(bins, pdf_corr,'.r');hold
semilogy(bins1, ref1,'r');
legend('Reference PDF', 'Corrected PDF','FontSize',14);
xlabel('Standard deviation','FontSize',14,'FontName','Arial');
ylabel('Probability','FontSize',14,'FontName','Arial');


sum(ref1*(1/2^2))
sum(pdf_corr*(1/2^2))

%Compute the Error in PDF_corr by inverse gaussian equation 
var8 = 1;
sq_var8 = sqrt(var8);
pdf_corr_old = pdf_corr; %Save t8_hr for future
bins_old = bins; %Save t8_hr for future
bins = bins(end/2+1:end); %Take only positive side
pdf_corr = pdf_corr(end/2+1:end);%Take only positive side

xg8 = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf_corr));
ref =  exp(-xg8.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err_n8 = ((bins-xg8)/16*100);




figure;
plot(bins(1:end-3), err_n8(1:end-3));
title('Error after correction');
xlabel('Standard deviation','FontSize',18,'FontName','Arial');
ylabel('% error in standard deviation','FontSize',18,'FontName','Arial');
mean(abs(err_n8))
% 
% %plots
% figure;
% semilogy(xg8,ref,'b');hold;
% semilogy(bins, pdf_corr,'r.');
% legend('Reference PDF', 'Corrected PDF');
% xlabel('Standard deviation');
% ylabel('Probability');
% % semilogy(t8_hr/sq_var8, pdf8_hr_old,'g');



% pdf8_sav_8s = [(t8_hr/sq_var8)' pdf8_hr_old'];
% pdf8_corr_sav_8s = [bins' pdf_corr' ref'];





