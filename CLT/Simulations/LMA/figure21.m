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
bins = 0:1/2^11:16;
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

bins = bins + 1/2^12;


%Compute Gaussian PDF
ref = pdf('Normal',bins,0,1);
sum(ref *1/2^2)
pdf_corr = pdf_corr/max(pdf_corr)*max(ref);
sum(pdf_corr *1/2^2)

figure;
semilogy(bins, pdf_corr,'b.');hold
semilogy(bins, ref,'r');hold

legend('Corrected PDF', 'Reference PDF');
xlabel('Standard deviation');
ylabel('Probability');

