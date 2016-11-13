clear all;
close all;

sq_var4 = sqrt(4/3);
var4 = sq_var4^2;

load coeff_1st
load pdf4_hr_old

ai = coeff_1st(:,1);
bi = coeff_1st(:,2);

fac = 1/sq_var4/1.00923125;
ai = (1-ai)*fac;
bi = -bi*fac;

tt = 1: 1.1e-004:1.1126;

ai = ai.*tt';
bi = bi.*tt';

% ai(end-5:end) =ai(end-5:end)*1.02; 
% bi(end-5:end) =bi(end-5:end)*1.02; 
% ai = fi(ai,1,18,8);
% bi = fi(bi,1,18,6);
% bin(bi)
% ai = double(ai);
% bi = double(bi);

t4_hr = -4:2^-13:4-2^-14;


sz_pdf=length(t4_hr);
add=zeros(1,sz_pdf);
err=zeros(1,sz_pdf);


%Compute the change in x-axis after error compensation
for i = 1:sz_pdf
     add(i) = floor((t4_hr(i)+4) * 256)+1;
      if(t4_hr(i) >= 0)
          add(i) = add(i) - 1024;
          err(i) = ai(add(i))*t4_hr(i) + bi(add(i));
      else
          add(i) = 1025 - add(i) ;
          err(i) = ai(add(i))*t4_hr(i) - bi(add(i));
     end
end
t4_corr = err';

t4_corr = fi(t4_corr,1,16,12);
t4_corr = double(t4_corr);

pdf4_hr_old = [pdf4_hr_old(1:end/2) pdf4_hr_old(end/2+1:end) ];
%Compute Gaussian PDF
bins = -16 :1/2^11:16;
ref = pdf('Normal',bins,0,1);
pdf4_hr_old = pdf4_hr_old/max(pdf4_hr_old)*max(ref);
semilogy(t4_corr*0.92,pdf4_hr_old,'m.');


%Compute the change in y-axis (probabilities) after error compensation
%within bins of fixed distance
bins = -12:1/2^4:12;
sz_bin=length(bins);
pdf_corr= zeros(1,sz_bin);

for i = 1:sz_bin
    pdf_corr(i) = 0;
    for j = 1:(sz_pdf-1)
        if(t4_corr(j)>bins(i) && t4_corr(j)<bins(i+1))
            pdf_corr(i) = pdf_corr(i)+ pdf4_hr_old(j);
        end
    end
end
bins = bins + 1/2^5

 


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
pdf_corr = pdf_corr/max(pdf_corr)*max(ref);

bins = bins(end/2+1:end);
ref = ref(end/2+1:end);
pdf_corr = pdf_corr(end/2+1:end);

var4 = 1;
%Compute the Error in PDF_n4 by inverse gaussian equation (High Rate)
xg4_hr = sqrt(-2 * var4 * log(sqrt(2*pi * var4) * pdf_corr));
ref4_hr =  exp(-xg4_hr.^2/(2*var4))* (1/(sqrt(2* pi * var4)));
err_n4_hr = abs(bins-xg4_hr);

figure;
plot(bins, err_n4_hr*100/8,'r');


figure;
semilogy(bins,ref,'b.');hold;
semilogy(bins, pdf_corr,'r.');
legend('Reference PDF', 'Corrected PDF');
xlabel('Standard deviation');
ylabel('Probability');
