clear all;
close all;
load final_out.txt
load pdf12_sav
x = -8:1/4:8;


x_pdf12 = pdf12_sav(:,1);
y_pdf12 = pdf12_sav(:,2);

x_pdf12 = x_pdf12(350:end -350);
y_pdf12 = y_pdf12(350:end -350);

a1 = final_out(:,1);

a2 = final_out(:,2);
% a3 = final_out(:,3);
% 
% a1 = a1(100:end);
a2 = a2(100:end);
a1 = a1(98:end-2);

% a2 =a2- mean(a2);
% a3 =a3- mean(a3);
%a1 =a1- mean(a1);

a1 = (a1/4096);
a2 = (a2/4096);
plot(a1);
hold;
plot(a2,'r');
l = a1-a2;
figure;
plot(l)



figure;
plot(abs(fft(a1)));
figure;
plot(a1(1:end-1),a1(2:end),'.','MarkerSize',2);

figure;

pdf121 = hist(a1,x);
pdf122 = hist(a2,x);
ref = pdf('Normal',x,0,1);

ref = ref/max(ref);
pdf121 = pdf121/max(pdf121);
pdf122 = pdf122/max(pdf122);
semilogy(x,pdf121,'r.');hold;
semilogy(x,pdf122,'c.');
semilogy(x,ref);
semilogy(x_pdf12,y_pdf12,'g');
% c = a1 + a2 + a3;
% figure;
% plot(a2(1:end-1),a2(2:end),'.r','MarkerSize',2);hold
% plot(a3(1:end-1),a3(2:end),'.g','MarkerSize',2);
% plot(a1(1:end-1),a1(2:end),'.b','MarkerSize',2);
% 
% figure;
% plot(c(1:end-2),c(3:end),'.r','MarkerSize',2);hold
