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

semilogy(bins,ref,'b');hold;
semilogy(bins/sq_var4,pdf8,'r');



