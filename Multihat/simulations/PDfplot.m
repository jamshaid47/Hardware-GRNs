
%Convolution of uniform densities 

close all;
clear all;


bins = 32;
range = 2^4 ;
step = (range *2)/bins;

ifac = 2^4 ;
xn = -range+step/2:step:range-step/2;
xn2 = -range*2:step/ifac:range*2;
xn4 = -range*4:step/ifac:range*4;
xn8 = -range*8:step/ifac:range*8;

npdf = pdf('normal',xn,0,1);
xn = xn(13:20);
npdf = npdf(13:20);
bar(xn,npdf)
sum(npdf*step)
npdf1=lin_int(npdf,ifac);
npdf2 = [0; conv(npdf1,npdf1); 0];
npdf4 = conv(npdf2,npdf2);


% npdf8 = conv(npdf4,npdf4);
% 
npdf2 = npdf2'/max(npdf2);
npdf4 = npdf4'/max(npdf4);
% npdf8 = npdf8'/max(npdf8);
% 
xn = -8:0.03125:8;
semilogy(xn, npdf4);hold;

xn1 = -8:0.25:8;
npdf = pdf('normal',xn1,0,1);
npdf = npdf/max(npdf);
semilogy(xn1, npdf,'r.');
% hold;
% semilogy(xn2/ sqrt(2), npdf2,'r');
% semilogy(xn4/sqrt(4), npdf4,'g');
% % semilogy(xn8/sqrt(8), npdf8,'m');
% 
% % N = hist(out2,t);
% % % npdf =round(npdf*10000/40000*100000);
% % bar(t,npdf);
% % sum(npdf*.125)
% % load bins.txt;
% % npdf = bins;
% % plot(npdf)
% % npdf4 = conv(npdf,npdf);
% % figure;plot(npdf4)
% % npdf4 = conv(npdf4,npdf4);
% % figure;plot(npdf4)
% % npdf4 = npdf4/max(npdf4);
% % npdf4 = [0 0 npdf4 0 0];
% % t = -8 :1/8: 8;
% % updf = pdf('normal',t,0,1);
% % updf = updf/max(updf);
% % semilogy(t/1.632993162,npdf4);
% % hold;
% %  semilogy(t,updf,'r.');
% % 
