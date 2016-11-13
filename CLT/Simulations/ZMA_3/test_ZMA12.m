clear all;
close all;

load pdf12_sav %PDF of CLT for N = 3
load pdf12_corr_sav %Gaussian and corrected PDFs

x12 = pdf12_sav(:,1);
y12 = pdf12_sav(:,2);

bins_corr = pdf12_corr_sav(:,1);
pdf_corr = pdf12_corr_sav(:,2);
ref = pdf12_corr_sav(:,3);

figure;
semilogy(bins_corr,ref);hold;
semilogy(bins_corr, pdf_corr,'r.')
semilogy(x12,y12,'c');

legend('Reference', 'Corrected PDF', 'CLT12 PDF');

%Load the PDF file from your test setup here