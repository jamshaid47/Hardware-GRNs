clear all;
close all;

var8 = 8/3;
sq_var8 = sqrt(var8);

load M;
load C;



fac = 1/sq_var8;




x = -8:1/32:8;
ms = 1e7;

sum8_corr=zeros(1,ms);
add=zeros(1,ms);
err=zeros(1,ms);
sum8=zeros(1,ms);

x1 = -8:1/2^3:8;

pdf_sum8=zeros(1,length(x1));
pdf_sum8_corr=zeros(1,length(x1));

x_nl = [1.003, 2.001, 2.999, 4, 5.118, 5.96, 6.566, 6.938, 7.252, 7.476, 7.634, 7.743, 7.812, 7.848, 7.872, 7.888, 7.904, 7.916, 7.924, 7.932];
y_nl = [0.03518, 0.05775, 0.05269, -0.001297, -0.1653, -0.4272, -0.7791, -1.134, -1.593, -2.089, -2.606, -3.121, -3.578, -3.881, -4.13, -4.321, -4.525, -4.717, -4.855, -5.004];			



for k = 1:2000
    sum8=zeros(1,ms);
    for i = 1:8
        dum = (rand(1,ms)-0.5)*2;
        sum8 = sum8 + dum;
    end
    
    
    
    for i = 1:ms
     if(sum8(i) >= 0)
        if (sum8(i) < x_nl(1))
            sum8_corr(i) = M(1) * sum8(i) + C(1); 
        elseif(sum8(i) < x_nl(2)) 
            sum8_corr(i) = M(2) * sum8(i) + C(2);
        elseif(sum8(i) < x_nl(3))
            sum8_corr(i) = M(3) * sum8(i) + C(3); 
        elseif(sum8(i) < x_nl(4))
            sum8_corr(i) = M(4) * sum8(i) + C(4); 
        elseif(sum8(i) < x_nl(5))
            sum8_corr(i) = M(5) * sum8(i) + C(5); 
        elseif(sum8(i) < x_nl(6))
            sum8_corr(i) = M(6) * sum8(i) + C(6);
        elseif(sum8(i) < x_nl(7))
            sum8_corr(i) = M(7) * sum8(i) + C(7);
        elseif(sum8(i) < x_nl(8))
            sum8_corr(i) = M(8) * sum8(i) + C(8);
        elseif(sum8(i) < x_nl(9))
            sum8_corr(i) = M(9) * sum8(i) + C(9);
        elseif(sum8(i) < x_nl(10))
            sum8_corr(i) = M(10) * sum8(i) + C(10);
        elseif(sum8(i) < x_nl(11))
            sum8_corr(i) = M(11) * sum8(i) + C(11);
        elseif(sum8(i) < x_nl(12))
            sum8_corr(i) = M(12) * sum8(i) + C(12);
        elseif(sum8(i) < x_nl(13))
            sum8_corr(i) = M(13) * sum8(i) + C(13);
        elseif(sum8(i) < x_nl(14))
            sum8_corr(i) = M(14) * sum8(i) + C(14);
        elseif(sum8(i) < x_nl(15))
            sum8_corr(i) = M(15) * sum8(i) + C(15);
        elseif(sum8(i) < x_nl(16))
            sum8_corr(i) = M(16) * sum8(i) + C(16);
        elseif(sum8(i) < x_nl(17))
            sum8_corr(i) = M(17) * sum8(i) + C(17);
        elseif(sum8(i) < x_nl(18))
            sum8_corr(i) = M(18) * sum8(i) + C(18);
        elseif(sum8(i) < x_nl(19))
            sum8_corr(i) = M(19) * sum8(i) + C(19);
        else
            sum8_corr(i) = M(20) * sum8(i) + C(20);
        end
     else
        sum8(i) = -sum8(i);
        
        if (sum8(i) < x_nl(1))
            sum8_corr(i) = M(1) * sum8(i) + C(1); 
        elseif(sum8(i) < x_nl(2)) 
            sum8_corr(i) = M(2) * sum8(i) + C(2);
        elseif(sum8(i) < x_nl(3))
            sum8_corr(i) = M(3) * sum8(i) + C(3); 
        elseif(sum8(i) < x_nl(4))
            sum8_corr(i) = M(4) * sum8(i) + C(4); 
        elseif(sum8(i) < x_nl(5))
            sum8_corr(i) = M(5) * sum8(i) + C(5); 
        elseif(sum8(i) < x_nl(6))
            sum8_corr(i) = M(6) * sum8(i) + C(6);
        elseif(sum8(i) < x_nl(7))
            sum8_corr(i) = M(7) * sum8(i) + C(7);
        elseif(sum8(i) < x_nl(8))
            sum8_corr(i) = M(8) * sum8(i) + C(8);
        elseif(sum8(i) < x_nl(9))
            sum8_corr(i) = M(9) * sum8(i) + C(9);
        elseif(sum8(i) < x_nl(10))
            sum8_corr(i) = M(10) * sum8(i) + C(10);
        elseif(sum8(i) < x_nl(11))
            sum8_corr(i) = M(11) * sum8(i) + C(11);
        elseif(sum8(i) < x_nl(12))
            sum8_corr(i) = M(12) * sum8(i) + C(12);
        elseif(sum8(i) < x_nl(13))
            sum8_corr(i) = M(13) * sum8(i) + C(13);
        elseif(sum8(i) < x_nl(14))
            sum8_corr(i) = M(14) * sum8(i) + C(14);
        elseif(sum8(i) < x_nl(15))
            sum8_corr(i) = M(15) * sum8(i) + C(15);
        elseif(sum8(i) < x_nl(16))
            sum8_corr(i) = M(16) * sum8(i) + C(16);
        elseif(sum8(i) < x_nl(17))
            sum8_corr(i) = M(17) * sum8(i) + C(17);
        elseif(sum8(i) < x_nl(18))
            sum8_corr(i) = M(18) * sum8(i) + C(18);
        elseif(sum8(i) < x_nl(19))
            sum8_corr(i) = M(19) * sum8(i) + C(19);
        else
            sum8_corr(i) = M(20) * sum8(i) + C(20);
        end
        
        sum8(i) = -sum8(i);
        sum8_corr(i) = -sum8_corr(i);
      end        
    end
    
    
    pdf_sum8 = pdf_sum8+hist(sum8,x1);
    pdf_sum8_corr = pdf_sum8_corr+hist(sum8_corr,x1);
    
    k
end


%Compute Gaussian PDF
ref = pdf('Normal',x,0,1);


pdf_sum8_corr = pdf_sum8_corr/max(pdf_sum8_corr)*max(ref);
pdf_sum8 = pdf_sum8/max(pdf_sum8)*max(ref);

figure;
semilogy(x,ref);hold;
% semilogy(bins_corr, pdf_corr,'r')
semilogy(x1/sq_var8,pdf_sum8,'k.');
semilogy(x1,pdf_sum8_corr,'m.');
% semilogy(x8,y8,'c');
std(sum8_corr)

% figure;
% x1= sum8(1:100000-1);
% y1= sum8(2:100000);
% plot(x1,y1,'.');
% 
% figure;
% x1= sum3_corr(1:100000-1);
% y1= sum3_corr(2:100000);
% plot(x1,y1,'.');



