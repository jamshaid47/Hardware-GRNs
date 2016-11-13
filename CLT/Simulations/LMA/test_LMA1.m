clear all;
close all;


load M;
load C;

x_nl = [1.003, 2.001, 2.999, 4, 5.118, 5.96, 6.566, 6.938, 7.252, 7.476, 7.634, 7.743, 7.812, 7.848, 7.872, 7.888, 7.904, 7.916, 7.924, 7.932];
y_nl = [0.03518, 0.05775, 0.05269, -0.001297, -0.1653, -0.4272, -0.7791, -1.134, -1.593, -2.089, -2.606, -3.121, -3.578, -3.881, -4.13, -4.321, -4.525, -4.717, -4.855, -5.004];			


sum8 = 24750;
sum8 = sum8/2^12;


    

     if(sum8 >= 0)
        if (sum8 < x_nl(1))
            sum8_corr = M(1) * sum8 + C(1); 
        elseif(sum8 < x_nl(2)) 
            sum8_corr = M(2) * sum8 + C(2);
        elseif(sum8 < x_nl(3))
            sum8_corr = M(3) * sum8 + C(3); 
        elseif(sum8 < x_nl(4))
            sum8_corr = M(4) * sum8 + C(4); 
        elseif(sum8 < x_nl(5))
            sum8_corr = M(5) * sum8 + C(5); 
        elseif(sum8 < x_nl(6))
            sum8_corr = M(6) * sum8 + C(6);
        elseif(sum8 < x_nl(7))
            sum8_corr = M(7) * sum8 + C(7);
        elseif(sum8 < x_nl(8))
            sum8_corr = M(8) * sum8 + C(8);
        elseif(sum8 < x_nl(9))
            sum8_corr = M(9) * sum8 + C(9);
        elseif(sum8 < x_nl(10))
            sum8_corr = M(10) * sum8 + C(10);
        elseif(sum8 < x_nl(11))
            sum8_corr = M(11) * sum8 + C(11);
        elseif(sum8 < x_nl(12))
            sum8_corr = M(12) * sum8 + C(12);
        elseif(sum8 < x_nl(13))
            sum8_corr = M(13) * sum8 + C(13);
        elseif(sum8 < x_nl(14))
            sum8_corr = M(14) * sum8 + C(14);
        elseif(sum8 < x_nl(15))
            sum8_corr = M(15) * sum8 + C(15);
        elseif(sum8 < x_nl(16))
            sum8_corr = M(16) * sum8 + C(16);
        elseif(sum8 < x_nl(17))
            sum8_corr = M(17) * sum8 + C(17);
        elseif(sum8 < x_nl(18))
            sum8_corr = M(18) * sum8 + C(18);
        elseif(sum8 < x_nl(19))
            sum8_corr = M(19) * sum8 + C(19);
        else
            sum8_corr = M(20) * sum8 + C(20);
        end
     else
        sum8 = -sum8;
        
        if (sum8 < x_nl(1))
            sum8_corr = M(1) * sum8 + C(1); 
        elseif(sum8 < x_nl(2)) 
            sum8_corr = M(2) * sum8 + C(2);
        elseif(sum8 < x_nl(3))
            sum8_corr = M(3) * sum8 + C(3); 
        elseif(sum8 < x_nl(4))
            sum8_corr = M(4) * sum8 + C(4); 
        elseif(sum8 < x_nl(5))
            sum8_corr = M(5) * sum8 + C(5); 
        elseif(sum8 < x_nl(6))
            sum8_corr = M(6) * sum8 + C(6);
        elseif(sum8 < x_nl(7))
            sum8_corr = M(7) * sum8 + C(7);
        elseif(sum8 < x_nl(8))
            sum8_corr = M(8) * sum8 + C(8);
        elseif(sum8 < x_nl(9))
            sum8_corr = M(9) * sum8 + C(9);
        elseif(sum8 < x_nl(10))
            sum8_corr = M(10) * sum8 + C(10);
        elseif(sum8 < x_nl(11))
            sum8_corr = M(11) * sum8 + C(11);
        elseif(sum8 < x_nl(12))
            sum8_corr = M(12) * sum8 + C(12);
        elseif(sum8 < x_nl(13))
            sum8_corr = M(13) * sum8 + C(13);
        elseif(sum8 < x_nl(14))
            sum8_corr = M(14) * sum8 + C(14);
        elseif(sum8 < x_nl(15))
            sum8_corr = M(15) * sum8 + C(15);
        elseif(sum8 < x_nl(16))
            sum8_corr = M(16) * sum8 + C(16);
        elseif(sum8 < x_nl(17))
            sum8_corr = M(17) * sum8 + C(17);
        elseif(sum8 < x_nl(18))
            sum8_corr = M(18) * sum8 + C(18);
        elseif(sum8 < x_nl(19))
            sum8_corr = M(19) * sum8 + C(19);
        else
            sum8_corr = M(20) * sum8 + C(20);
        end
        
        sum8 = -sum8;
        sum8_corr = -sum8_corr;
      end        

 sum8_corr   
 a=fi(sum8_corr,1,16,12);dec(a)