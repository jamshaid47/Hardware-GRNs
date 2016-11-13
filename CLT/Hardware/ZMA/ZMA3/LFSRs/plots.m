close all;
clear all;
load final_out.txt
a1 = final_out(:,1);
a2 = final_out(:,2);
a3 = final_out(:,3);





% figure;
% a1= a1-mean(a1);
% sig_freq = fft(a1);
% mean(a1)
% sig_freq = fftshift(sig_freq);
% sig_freq = sig_freq./max(abs(sig_freq));
% plot(20*log10(abs(sig_freq)));
% 
% 
figure;
plot(a1, a2,'.','MarkerSize',2);
hold;
plot(a1, a3,'g.','MarkerSize',2);
plot(a2, a3,'k.','MarkerSize',2);

plot(a1(1:end-1), a1(2:end),'r.','MarkerSize',2);






% figure;
% a1= a1-mean(a1);
% a2= a2-mean(a2);
% plot(abs(fft(a1)));
% 
% 
[c1,lags] = xcorr(a1,a1, 50);

figure;
plot(lags, c1);hold
% [c2,lags1] = xcorr(a1,a2, 500);
% semilogx(lags1, c2,'r');
% figure;
% plot(a1(1:end-1), a1(2:end),'.','MarkerSize',2);
% hold;
% plot(a2(1:end-1), a2(2:end),'r.','MarkerSize',2);
% 
% 
% figure;
% plot(a1(1:end-1), a2(2:end),'r.','MarkerSize',2);
