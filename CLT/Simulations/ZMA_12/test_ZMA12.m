clear all;
close all;

ms = 1e7;

load ZMA_coef12
load pdf12_sav
load pdf12_corr_sav

ZMA_coef12i = fi(ZMA_coef12,1,16,12);
plot(ZMA_coef12);hold
plot(ZMA_coef12i,'r.');

hex(ZMA_coef12i')

x12 = pdf12_sav(:,1); 
y12 = pdf12_sav(:,2);

bins_corr = pdf12_corr_sav(:,1);
pdf_corr = pdf12_corr_sav(:,2);
ref = pdf12_corr_sav(:,3);









x = -8:1/8:8;



sum12=zeros(1,ms);
add=zeros(1,ms);
err=zeros(1,ms);
x1 = -1/2^4:1/2^3:6;

pdf_sum12=zeros(1,length(x1));
pdf_sum12_corr=zeros(1,length(x1));


for k = 1:1000
    sum12=zeros(1,ms);
    for i = 1:12
        dum = rand(1,ms)-0.5;
        sum12 = sum12 + dum;
    end
    
    for i = 1:ms
        if(sum12(i)>0)
            add(i) = floor(sum12(i) * 128)+1;
            err(i) = ZMA_coef12(add(i));
        else
            add(i) = floor(-sum12(i) * 128)+1;
            err(i) = -ZMA_coef12(add(i));
        end
    end
    
    pdf_sum12 = pdf_sum12+hist(sum12,x1);

    sum12_corr = sum12+ err;
    pdf_sum12_corr = pdf_sum12_corr+hist(sum12_corr,x1);
    
    k
end





x1= x1(2:end);
pdf_sum12= pdf_sum12(2:end);
pdf_sum12_corr= pdf_sum12_corr(2:end);

pdf_sum12_corr = pdf_sum12_corr/max(pdf_sum12_corr)*max(ref);
pdf_sum12 = pdf_sum12/max(pdf_sum12)*max(ref);

figure;
semilogy(bins_corr,ref);hold;
%semilogy(bins_corr, pdf_corr,'r.')
semilogy(x1,pdf_sum12,'k.');
semilogy(x1,pdf_sum12_corr,'m.');
semilogy(x12,y12,'c');


figure;
x1= sum12(1:100000-1);
y1= sum12(2:100000);
plot(x1,y1,'.');

figure;
x1= sum12_corr(1:100000-1);
y1= sum12_corr(2:100000);
plot(x1,y1,'.');



