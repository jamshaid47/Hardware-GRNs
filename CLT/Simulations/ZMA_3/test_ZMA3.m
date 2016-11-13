clear all;
close all;

load pdf3_sav %PDF of CLT for N = 3
load pdf3_corr_sav %Gaussian and corrected PDFs

x3 = pdf3_sav(:,1);
y3 = pdf3_sav(:,2);

bins_corr = pdf3_corr_sav(:,1);
pdf_corr = pdf3_corr_sav(:,2);
ref = pdf3_corr_sav(:,3);


figure;
semilogy(bins_corr,ref);hold;
semilogy(bins_corr, pdf_corr,'r.')
semilogy(x3,y3,'c');
legend('Reference', 'Corrected PDF', 'CLT3 PDF');

%Load the PDF file from your test setup here