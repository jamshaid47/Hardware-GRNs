clear all;
close all;


load ZMA_coef
ZMA_coef = ZMA_coef(end/2+1:end);
plot(ZMA_coef)
ZMA_coef= fi(ZMA_coef,1,16,12);
plot(ZMA_coef)
load pdf12_sav
load final_out.txt
load pdf12_sav
x = -8:1/4:8;


x_pdf12 = pdf12_sav(:,1);
y_pdf12 = pdf12_sav(:,2);

x_pdf12 = x_pdf12(350:end -350);
y_pdf12 = y_pdf12(350:end -350);

a1 = final_out(:,1);
a2 = final_out(:,2);

a2 = a2(10:end);
a1 = a1(8:end-2);


a1 = (a1/4096);
a2 = (a2/4096);



x_pdf12 = pdf12_sav(:,1);
y_pdf12 = pdf12_sav(:,2);

x_pdf12 = x_pdf12(350:end -350);
y_pdf12 = y_pdf12(350:end -350);

sum12=a1;
ms = length(sum12);
add = zeros(1,ms);
err = zeros(1,ms);

    for i = 1:ms
        
        if(sum12(i)>0)
            add(i) = floor(sum12(i) * 64)+1;
            err(i) = ZMA_coef(add(i));
        else
            add(i) = floor(-sum12(i) * 64)+1;
            err(i) = -ZMA_coef(add(i));
        end
        dum = [sum12(i)*4096 add(i)-1 floor(err(i)*4096)];
    end



pdf12 = hist(sum12,x);
pdf12_corrv = hist(a2,x);

sum12_corr = (sum12)+ err';
pdf12_corr = hist(sum12_corr,x);

test =[sum12*4096 floor(sum12_corr*4096) add'-1 floor(err'*4096)];

pdf12 = pdf12/max(pdf12);
pdf12_corr = pdf12_corr/max(pdf12_corr);
pdf12_corrv = pdf12_corrv/max(pdf12_corrv);

ref = pdf('Normal',x,0,1);
ref = ref/max(ref);
figure;
semilogy(x,ref);hold;
semilogy(x_pdf12,y_pdf12,'g');
semilogy(x,pdf12,'r.');
semilogy(x,pdf12_corr,'m.');
semilogy(x,pdf12_corrv,'c.');


figure;
plot(a2(1:end-1),a2(2:end),'r.','MarkerSize',2);
hold;
plot(a1(1:end-1),a1(2:end),'.','MarkerSize',2);
mean(a2)