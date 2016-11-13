close all;
clear all;

%In this program we will test generate the actual GRNs using the stored
%LUTs for the CDF

load cdf_coef.txt;
y_in = cdf_coef(:,1);

%Morroring the coefficients towards negative side
%Only doing to make the software simple
%In hardware we do it by reversing the sign of the output randomly
j=length(y_in)
for i = 1:length(y_in)
     y_in_n(j) = y_in(i);
     j=j-1;
end
y_in = [-y_in_n y_in'];

%Generate 04 streams of URNGs between 0 and 1
x_test1 = rand(1e7,1);
x_test2 = rand(1e7,1);
x_test3 = rand(1e7,1);
x_test4 = rand(1e7,1);

out_sample = zeros(1,length(x_test1));

%Repeat the hgeneration of GRNs k times, saving the PDF everytime
bins =  -7:0.1:7;
my_pdf = hist( out_sample , bins )*0;
k =1;
for k = 1:10
    for i = 1:length(x_test1)
        index1 = floor(x_test1(i)*2048);
        index2 = floor(x_test2(i)*2048);
        index3 = floor(x_test3(i)*2048);
        index4 = floor(x_test4(i)*2048);
        samp1 = y_in(index1+1);
        samp2 = y_in(index2+1);
        samp3 = y_in(index3+1);
        samp4 = y_in(index4+1);
        out_sample(i) = (samp1+samp2+samp3+samp4)/2;
    end
    k
    my_pdf = my_pdf + hist( out_sample , bins );
    x_test1 = rand(1e7,1);
    x_test2 = rand(1e7,1);
    x_test3 = rand(1e7,1);
    x_test4 = rand(1e7,1);
end



matlab_pdf = pdf('Normal',bins, 0, 1);
my_pdf = my_pdf/max(my_pdf)*max(matlab_pdf);

semilogy(bins, matlab_pdf,'.' );
hold;
semilogy(bins/0.9995, my_pdf,'r.');
