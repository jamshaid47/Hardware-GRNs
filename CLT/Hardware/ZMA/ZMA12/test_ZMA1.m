clear all;
close all;


load final_out.txt
x = -8:1/4:8;


a1 = final_out(:,1);
a2 = final_out(:,2);

a2 = a2(10:end);
a1 = a1(10:end);


a1 = (a1/4096);
a2 = (a2/4096);
plot(a1(1:10000),a1(2:10001),'.');
mean(a2)


pdf12 = hist(a1,x);
pdf12 = pdf12/max(pdf12);

pdf12_corr = hist(a2,x);
pdf12_corr = pdf12_corr/max(pdf12_corr);

ref = pdf('Normal',x,0,1);
ref = ref/max(ref);

figure;
semilogy(x,ref);hold;
semilogy(x,pdf12,'r.');
semilogy(x,pdf12_corr,'m.');


