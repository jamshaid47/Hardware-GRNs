clear all;
close all;

var16 = 16/3;
sq_var16 = sqrt(var16);

load coeff_2nd.mat;
load pdf16_hr_old

a2i = coeff_2nd(:,1);
b2i = coeff_2nd(:,2);
c2i = coeff_2nd(:,3);

%fac = 1/sq_var16/0.9909519640007090;
fac = 1/sq_var16/0.992693;

gg = 256 ;
tt = 1.0325;
a2i(gg:end)= a2i(gg:end)*tt;
b2i(gg:end)= b2i(gg:end)*tt;
c2i(gg:end)= c2i(gg:end)*tt;




a_tr = a2i*fac;
b_tr = (1- b2i)*fac ;
c_tr = c2i*fac;


x = -16:1/32:16;


ms = 1e7;

sum16_corr=zeros(1,ms);
add=zeros(1,ms);
err=zeros(1,ms);
sum16=zeros(1,ms);

x1 = -16^4:1/2^3:16;

pdf_sum16=zeros(1,length(x1));
pdf_sum16_corr=zeros(1,length(x1));


for k = 1:2000
    sum16=zeros(1,ms);
    for i = 1:16
        dum = (rand(1,ms)-0.5)*2;
        sum16 = sum16 + dum;
    end
    
    
    
    for i = 1:ms
        
     add(i) = floor((sum16(i)+16) * 64)+1;
     if(sum16(i) >= 0)
         add(i) = add(i) - 1024;
         sum16_corr(i)= -a_tr(add(i))*sum16(i)^2 + b_tr(add(i))*sum16(i) - c_tr(add(i));
      else
         add(i) = 1025 - add(i) ;
         sum16_corr(i)= a_tr(add(i))*sum16(i)^2 + b_tr(add(i))*sum16(i) + c_tr(add(i));
      end        
        
    end
    
    
    pdf_sum16 = pdf_sum16+hist(sum16,x1);
    pdf_sum16_corr = pdf_sum16_corr+hist(sum16_corr,x1);
    
    k
end


%Compute Gaussian PDF
ref = pdf('Normal',x,0,1);


pdf_sum16_corr = pdf_sum16_corr/max(pdf_sum16_corr)*max(ref);
pdf_sum16 = pdf_sum16/max(pdf_sum16)*max(ref);

figure;
semilogy(x,ref);hold;
% semilogy(bins_corr, pdf_corr,'r')
semilogy(x1/sq_var16,pdf_sum16,'k.');
semilogy(x1,pdf_sum16_corr,'m.');
% semilogy(x8,y8,'c');


% figure;
% x1= sum8(1:100000-1);
% y1= sum8(2:100000);
% plot(x1,y1,'.');
% 
% figure;
% x1= sum3_corr(1:100000-1);
% y1= sum3_corr(2:100000);
% plot(x1,y1,'.');



