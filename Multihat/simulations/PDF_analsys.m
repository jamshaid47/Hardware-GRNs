
%Convolution of uniform densities 

close all;
clear all;


bins = 32;
range = 2^4 ;
step = (range *2)/bins;

ifac = 2^4 ;
xn = -range+step/2:step:range-step/2;

npdf = pdf('normal',xn,0,1);
xn = xn(13:20);
npdf = npdf(13:20);
bar(xn,npdf);

npdf_test = [0.0009 0.0118 0.135 0.3521 0.3521 0.135 0.0118 0.0009];
hold;
bar(xn,npdf_test,'r');


figure;
npdf_test1=lin_int(npdf_test,ifac/4);
npdf_test2 = [0; conv(npdf_test1,npdf_test1); 0];
npdf_test4 = conv(npdf_test2,npdf_test2);


npdf1=lin_int(npdf,ifac);
npdf2 = [0; conv(npdf1,npdf1); 0];
npdf4 = conv(npdf2,npdf2);


% npdf8 = conv(npdf4,npdf4);
% 
npdf_test4 = npdf_test4'/max(npdf_test4);
npdf4 = npdf4'/max(npdf4);
% npdf8 = npdf8'/max(npdf8);
% 
xn = -8:0.03125*4:8;

xn1 = -8:0.025*4:8;
npdf = pdf('normal',xn1,0,1);
npdf = npdf/max(npdf);
semilogy(xn, npdf_test4,'m.');hold;
semilogy(xn1, npdf);


% semilogy(xn, npdf4);


%Compute the Error in PDF_corr by inverse gaussian equation 
var8 = 1;
sq_var8 = sqrt(var8);
bins = xn(end/2+1:end); %Take only positive side
pdf4 = npdf_test4(end/2+1:end);%Take only positive side

xg8 = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf4));
ref =  exp(-xg8.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err = (bins-xg8);
figure;
plot(bins,err*8/100);
xlabel('\sigma');
ylabel('% error in \sigma');