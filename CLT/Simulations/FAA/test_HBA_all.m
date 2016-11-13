clear all;
close all;

var4 = 4/3;
sq_var4 = sqrt(var4);

ms = 1e6;

load coeff_1st
ai = coeff_1st(:,1);
bi = coeff_1st(:,2);

fac = 1/sq_var4/1.00923125;
ai = (1-ai)*fac;
bi = -bi*fac;

tt = 1: 1.1e-004:1.1126;

ai = ai.*tt';
bi = bi.*tt';

ai(end-5:end) =ai(end-5:end)*1.02; 
bi(end-5:end) =bi(end-5:end)*1.02; 
ai = fi(ai,1,18,8);
bi = fi(bi,1,18,6);
ai = double(ai);
bi = double(bi);

M = ai;
C = bi;

 
x = -4:1/8:4;



sum41=zeros(1,ms);
sum42=zeros(1,ms);
sum43=zeros(1,ms);
sum44=zeros(1,ms);
sum81=zeros(1,ms);
sum82=zeros(1,ms);
sum16=zeros(1,ms);

add1=zeros(1,ms);
add2=zeros(1,ms);
add3=zeros(1,ms);
add4=zeros(1,ms);
err1=zeros(1,ms);
err2=zeros(1,ms);
err3=zeros(1,ms);
err4=zeros(1,ms);
x1 = -16+1/2^4:1/2^3:16;

% pdf_sum41=zeros(1,length(x1));
pdf_sum41_corr=zeros(1,length(x1));
pdf_sum42_corr=zeros(1,length(x1));
pdf_sum43_corr=zeros(1,length(x1));
pdf_sum44_corr=zeros(1,length(x1));
pdf_sum81_corr=zeros(1,length(x1));
pdf_sum82_corr=zeros(1,length(x1));
pdf_sum16_corr=zeros(1,length(x1));


for k = 1:2
    sum41=zeros(1,ms);
    sum42=zeros(1,ms);
    sum43=zeros(1,ms);
    sum44=zeros(1,ms);

    for i = 1:4
        dum = (rand(1,ms)-0.5)*2;
        sum41 = sum41 + dum;
        dum = (rand(1,ms)-0.5)*2;
        sum42 = sum42 + dum;
        dum = (rand(1,ms)-0.5)*2;
        sum43 = sum43 + dum;
        dum = (rand(1,ms)-0.5)*2;
        sum44 = sum44 + dum;
    end
    
    for i = 1:ms
     add1(i) = floor((sum41(i)+4) * 256)+1;
     if(sum41(i) >= 0)
         add1(i) = add1(i) - 1024;
         err1(i) = M(add1(i))*sum41(i) + C(add1(i));
     else
         add1(i) = 1025 - add1(i) ;
         err1(i) = M(add1(i))*sum41(i) - C(add1(i));
     end
     
     add2(i) = floor((sum42(i)+4) * 256)+1;
     if(sum42(i) >= 0)
         add2(i) = add2(i) - 1024;
         err2(i) = M(add2(i))*sum42(i) + C(add2(i));
     else
         add2(i) = 1025 - add2(i) ;
         err2(i) = M(add2(i))*sum42(i) - C(add2(i));
     end
     
     add3(i) = floor((sum43(i)+4) * 256)+1;
     if(sum43(i) >= 0)
         add3(i) = add3(i) - 1024;
         err3(i) = M(add3(i))*sum43(i) + C(add3(i));
     else
         add3(i) = 1025 - add3(i) ;
         err3(i) = M(add3(i))*sum43(i) - C(add3(i));
     end

     add4(i) = floor((sum44(i)+4) * 256)+1;
     if(sum44(i) >= 0)
         add4(i) = add4(i) - 1024;
         err4(i) = M(add4(i))*sum44(i) + C(add4(i));
     else
         add4(i) = 1025 - add4(i) ;
         err4(i) = M(add4(i))*sum44(i) - C(add4(i));
     end
     
    end
    
    sum81 = err1 + err2;
    sum82 = err3 + err4;
    
    sum16 = (sum81 + sum82)/2;
    var(err4)
    var(sum81/sqrt(2))
    var(sum16)
    
%     pdf_sum41 = pdf_sum41+hist(sum41,x1);
%     pdf_sum42 = pdf_sum42+hist(sum42,x1);
%     pdf_sum43 = pdf_sum43+hist(sum43,x1);
%     pdf_sum44 = pdf_sum44+hist(sum44,x1);


    pdf_sum41_corr = pdf_sum41_corr+hist(err1,x1);
    pdf_sum42_corr = pdf_sum42_corr+hist(err2,x1);
    pdf_sum43_corr = pdf_sum43_corr+hist(err3,x1);
    pdf_sum44_corr = pdf_sum44_corr+hist(err4,x1);
    
    pdf_sum81_corr = pdf_sum81_corr+hist(sum81,x1);
    pdf_sum82_corr = pdf_sum82_corr+hist(sum82,x1);

    pdf_sum16_corr = pdf_sum16_corr+hist(sum16,x1);
    k

end


ref = pdf('Normal',x1,0,1);


pdf_sum41_corr = pdf_sum41_corr/max(pdf_sum41_corr)*max(ref);
pdf_sum42_corr = pdf_sum42_corr/max(pdf_sum42_corr)*max(ref);
pdf_sum43_corr = pdf_sum43_corr/max(pdf_sum43_corr)*max(ref);
pdf_sum44_corr = pdf_sum44_corr/max(pdf_sum44_corr)*max(ref);

pdf_sum81_corr = pdf_sum81_corr/max(pdf_sum81_corr)*max(ref);
pdf_sum82_corr = pdf_sum82_corr/max(pdf_sum82_corr)*max(ref);

pdf_sum16_corr = pdf_sum16_corr/max(pdf_sum16_corr)*max(ref);

% figure;
% semilogy(x1,ref);hold
% semilogy(x1/sqrt(2),pdf_sum81_corr,'m.');
% semilogy(x1/sqrt(2),pdf_sum82_corr,'g.');
% 
% figure;
% semilogy(x1,ref);hold
% semilogy(x1,pdf_sum43_corr,'c.');
% semilogy(x1,pdf_sum44_corr,'r.');
% 
% figure;
% semilogy(x1,ref);hold
% semilogy(x1,pdf_sum16_corr,'r.');

plot(err1(1:end-1),err1(2:end),'.', 'MarkerSize',2);
figure;
plot(sum81,sum82,'.', 'MarkerSize',2);

% figure;
% x1= sum8(1:100000-1);
% y1= sum8(2:100000);
% plot(x1,y1,'.');
% 
% figure;
% x1= sum3_corr(1:100000-1);
% y1= sum3_corr(2:100000);
% plot(x1,y1,'.');



