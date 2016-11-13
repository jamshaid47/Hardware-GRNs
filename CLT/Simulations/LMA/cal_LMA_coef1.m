clear all;
close all;

var8 = 8/3;
sq_var8 = sqrt(var8);

t = -1:1/2^12:1;
t8_hr = -8:1/2^12:8;

updf = pdf('uniform',t,-1,1);

%Compute the PDF for n = 8 in high resolution
%High resolution PDF ensures more accuracy at the edges after convolution
pdf2 = conv(updf,updf);
pdf4 = conv(pdf2,pdf2);
pdf8_hr = conv(pdf4,pdf4);
pdf8_hr = pdf8_hr/max(pdf8_hr );
pdf8_hr = [pdf8_hr(1:end/2) pdf8_hr(end/2+1:end)];
t8_hr =t8_hr(1:end-1) ;



%Compute the Error in PDF_n3 by inverse gaussian equation (High Rate)
pdf8_hr_old = pdf8_hr; %Save t8_hr for future
t8_hr_old = t8_hr; %Save t8_hr for future
t8_hr = t8_hr(end/2+1:end); %Take only positive side
pdf8_hr = pdf8_hr(end/2+1:end)* 1/sqrt(2*pi * var8);%Take only positive side

xg8_hr = sqrt(-2 * var8 * log(sqrt(2*pi * var8) * pdf8_hr));
ref8_hr =  exp(-xg8_hr.^2/(2*var8))* (1/(sqrt(2* pi * var8)));
err_n8_hr = (t8_hr-xg8_hr);


figure;
plot(t8_hr, err_n8_hr);


x_nl = [0, 1, 2, 3, 4, 5.118, 5.96, 6.566, 6.938, 7.252, 7.476, 7.634, 7.743, 7.812, 7.848, 7.872, 7.888, 7.904, 7.916, 7.924, 7.932];
y_nl = [0, 0.03518, 0.05775, 0.05269, -0.001297, -0.1653, -0.4272, -0.7791, -1.134, -1.593, -2.089, -2.606, -3.121, -3.578, -3.881, -4.13, -4.321, -4.525, -4.717, -4.855, -5.004];			


x_nl = fi(x_nl,1,16,12); hex(x_nl')
x_nl= double(x_nl);
hold;
plot(x_nl, y_nl,'r');


for i = 2:21
    p = polyfit(x_nl(i-1:i), y_nl(i-1:i), 1);
    M(i-1) = p(1);
    C(i-1) = p(2);
end


M = ((1-M)/ sq_var8) *1.018;
C = (-C/ sq_var8)*1.018;

M(7) = M(7) *1.006;
C(7) = C(7) *1.006;
M(8) = M(8) *1.009;
C(8) = C(8) *1.009;
M(9) = M(9) *1.014;
C(9) = C(9) *1.014;
M(10) = M(10) *1.015;
C(10) = C(10) *1.015;
M(11) = M(11) *1.016;
C(11) = C(11) *1.016;
M(12) = M(12) *1.020;
C(12) = C(12) *1.020;
M(13) = M(13) *1.022;
C(13) = C(13) *1.022;
M(14) = M(14) *1.024;
C(14) = C(14) *1.024;
M(15:end) = M(15:end) *1.026;
C(15:end) = C(15:end) *1.026;

M= fi(M,1,18,13); bin(M')
C= fi(C,1,18,10); bin(C')
M= double(M);
C= double(C);
figure;plot(M);
figure;plot(C);
x_nl = x_nl(2:end);
y_nl = y_nl(2:end);
t8_corr = zeros(1,32768);
for i = 1:32768
    if (t8_hr(i) < x_nl(1))
        t8_corr(i) = M(1) * t8_hr(i) + C(1); 
    elseif(t8_hr(i) < x_nl(2)) 
        t8_corr(i) = M(2) * t8_hr(i) + C(2);
    elseif(t8_hr(i) < x_nl(3))
        t8_corr(i) = M(3) * t8_hr(i) + C(3); 
    elseif(t8_hr(i) < x_nl(4))
        t8_corr(i) = M(4) * t8_hr(i) + C(4); 
    elseif(t8_hr(i) < x_nl(5))
        t8_corr(i) = M(5) * t8_hr(i) + C(5); 
    elseif(t8_hr(i) < x_nl(6))
        t8_corr(i) = M(6) * t8_hr(i) + C(6);
    elseif(t8_hr(i) < x_nl(7))
        t8_corr(i) = M(7) * t8_hr(i) + C(7);
    elseif(t8_hr(i) < x_nl(8))
        t8_corr(i) = M(8) * t8_hr(i) + C(8);
    elseif(t8_hr(i) < x_nl(9))
        t8_corr(i) = M(9) * t8_hr(i) + C(9);
    elseif(t8_hr(i) < x_nl(10))
        t8_corr(i) = M(10) * t8_hr(i) + C(10);
    elseif(t8_hr(i) < x_nl(11))
        t8_corr(i) = M(11) * t8_hr(i) + C(11);
    elseif(t8_hr(i) < x_nl(12))
        t8_corr(i) = M(12) * t8_hr(i) + C(12);
    elseif(t8_hr(i) < x_nl(13))
        t8_corr(i) = M(13) * t8_hr(i) + C(13);
    elseif(t8_hr(i) < x_nl(14))
        t8_corr(i) = M(14) * t8_hr(i) + C(14);
    elseif(t8_hr(i) < x_nl(15))
        t8_corr(i) = M(15) * t8_hr(i) + C(15);
    elseif(t8_hr(i) < x_nl(16))
        t8_corr(i) = M(16) * t8_hr(i) + C(16);
    elseif(t8_hr(i) < x_nl(17))
        t8_corr(i) = M(17) * t8_hr(i) + C(17);
    elseif(t8_hr(i) < x_nl(18))
        t8_corr(i) = M(18) * t8_hr(i) + C(18);
    elseif(t8_hr(i) < x_nl(19))
        t8_corr(i) = M(19) * t8_hr(i) + C(19);
    else
        t8_corr(i) = M(20) * t8_hr(i) + C(20);
    end
end




%Compute Gaussian PDF
bins = 0:1/2^5:12;
ref = pdf('Normal',bins,0,1);
pdf8_hr = pdf8_hr/max(pdf8_hr)*max(ref);

figure;
semilogy(bins, ref);hold
semilogy(t8_corr, pdf8_hr,'r.');
semilogy((t8_hr- err_n8_hr)/ sq_var8, pdf8_hr,'g.');

save('M.mat', 'M');
save('C.mat', 'C');
save('t8_corr.mat', 't8_corr');
save('pdf8_hr.mat', 'pdf8_hr');

Match_ref