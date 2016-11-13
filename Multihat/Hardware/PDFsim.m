
%Convolution of uniform densities 

close all;
clear all;
load final_out.txt;
out2 = final_out/2^12;

plot(out2);

x = -8:0.15:8;
mpdf = hist(out2,x);
mpdf = mpdf/max(mpdf);
bar(x, mpdf);

%Getting the correct number of bins (x-component of the computed PDF)
bins =  -8:0.1:8;

%Plotting against the reference PDF
matlab_pdf = pdf('Normal',bins, 0, 1);
semilogy(bins,matlab_pdf);
my_pdf= hist(out2 , bins );
my_pdf = my_pdf/max(my_pdf)*max(matlab_pdf);
hold;
semilogy(bins,my_pdf,'r.');


figure;
plot(out2(1:end-1), out2(2:end),'.','MarkerSize',2);
xlabel('x_{i}');
ylabel('x_{i-1}');

figure;
plot(abs(fft(out2(1:10000))));
xlabel('Frequency');


[c1,lags] = xcorr(out2(1:10000),out2(1:10000), 500);
figure;
plot(lags, c1);
xlabel('Lags');
ylabel('Autocorrelation');