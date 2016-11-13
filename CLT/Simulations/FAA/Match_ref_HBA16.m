clear all;
close all;


var4 = 2;
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
semilogy(bins+0.000976,pdf16,'r');


figure;
plot(bins-1/2^12,ref,'b');hold;
plot(bins,pdf16,'r');



