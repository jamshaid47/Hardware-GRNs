clear all;
close all;


WL = 16;% Number of bits
L = 4; % Number of (non-)uniform sub-segments

% Generate 62 logrithmic segments
for i = 1:WL
   x_0_p5(WL+1-i) = 2^-i;
end
for i = 1:WL
   x_p5_1(WL+1-i) = 1 -2^(i-1-WL);
end


x = [x_0_p5 x_p5_1(2:end)];


% Generate 30xL (non-)uniform sub-segments
x = lin_int(x, L);


%Generate ideal F(u1) function
y = sqrt(-2 * log(x));
y(1) = sqrt(-2 * log(2^-36));
msize = length(y);


%Calculate M and C vectors using ideal F(u1) function
for i = 2:length(y);
    M(i) = (y(i) - y(i-1))/(x(i) - x(i-1));
    C(i) = (y(i) - y(i-1))/(x(i) - x(i-1)) * -x(i-1) + y(i-1);
end
M = M(2:end);
C = C(2:end);


%Calculate 16-bit transformed M and C vectors
for i = 1:length(C);
    if x(i) < 0.5
        w(i) = floor((15*L-i)/L);
        C_tr(i) = C(i);
        M_tr(i) = 2^-w(i) *M(i);
    else
        w(i) = floor((i-15*L-1)/L);
        C_tr(i) = C(i)+M(i);
        M_tr(i) = -2^-w(i) *M(i);
    end 
end
M_tr(1) = M_tr(2)/1.06;
C_tr(1) = C_tr(2);



xin = 0.029113769531250;
%xin = 1.220703125000000e-004;

    if xin < 0.5 
        for i = 1:(msize-1)
            if xin >= x(i) && xin <= x(i+1)
                x_tr =  2^w(i) * xin;
                yout = M_tr(i)  *  x_tr + C_tr(i);
                a1 = C_tr(i);
                a2 = M_tr(i);
                i
            end
        end
    else
        for i = 1:(msize-1)
            if xin >= x(i) && xin <= x(i+1)
                x_tr =  2^w(i) * (1-xin);
                yout = M_tr(i)  *  x_tr + C_tr(i);
                a1 = C_tr(i);
                a2 = M_tr(i);
                i
            end
        end
    end



yac = sqrt(-2* log(xin)) 


a = fi(x_tr,0,16,16);hex(a)
b = fi(a2,1,16,12);hex(b)
c = fi(a1,0,16,13);hex(c)

y = b*a+c;
b = fi(y,0,16,12);hex(b)
