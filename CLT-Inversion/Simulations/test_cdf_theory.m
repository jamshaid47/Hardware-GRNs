close all;
clear all;

%Load the saved LUT coefficients for the PDF
load cdf_coef.txt;
x_in = cdf_coef;


x_in_LUT = fi(x_in,1,16,12);
plot(x_in);hold
plot(x_in_LUT,'r.');

hex(x_in_LUT')




%Sweep the input (URNG) at a very fine increment
x_test = 0:0.00001:1-0.00001;

%Compute the output against swept values
%Note that we are only generating the positive values
%In real hardware we will simply shift the sign randomly to generate complete positive ans negative values
out_sample = zeros(1,length(x_test));
for i = 1:length(x_test)
    index = floor(x_test(i)*1024);
    out_sample(i) = x_in(index+1);
end

%Computing and plotting theoretical and our PDFs
bins =  0.05:0.1:5;
matlab_pdf = pdf('Normal',bins, 0, 1);
my_pdf= hist( out_sample , bins );
my_pdf = my_pdf/max(my_pdf)*max(matlab_pdf);
bar(bins,my_pdf,'r');
hold;
bar(bins,matlab_pdf)


%Mirroring the PDFs towards negative sides
%We need it because we require complete PDF compute the the resultant PDF
%from 04 additions (Done by convolving)
j=length(my_pdf)
for i = 1:length(my_pdf)
     my_pdf_n(j) = my_pdf(i);
     matlab_pdf_n(j) = matlab_pdf(i);
     bins_n(j) = -bins(i);
     j=j-1;
end
my_pdf = [my_pdf_n my_pdf];
matlab_pdf = [matlab_pdf_n matlab_pdf];
bins = [bins_n bins];

figure;
bar(bins,my_pdf,'r');
hold;
bar(bins,matlab_pdf);


%We now convolve the computed PDF to find the theoretical value of final PDF that results from addition of 04 numbers
pdf2=conv(my_pdf,my_pdf);
pdf4=conv(pdf2,pdf2);

%Getting the correct number of bins (x-component of the computed PDF)
bins4 =  -5:0.1/4:5;
bins4 = 2*bins4(3:end-2);

%Plotting against the reference PDF
matlab_pdf = pdf('Normal',bins4, 0, 1);
pdf4 = pdf4/max(pdf4)*max(matlab_pdf);
figure;
semilogy(bins4, matlab_pdf,'.');
hold;
semilogy(bins4, pdf4,'g.');


%Compute the Error in PDF_corr by inverse gaussian equation 
var8 = 1;
sq_var8 = sqrt(var8);
bins = bins(end/2+1:end); %Take only positive side
pdf4 = pdf4(end/2+1:end);%Take only positive side

xg8 = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf4));
ref =  exp(-xg8.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err = (bins-xg8);
figure;
plot(bins,err*8/100);


