clear all;
close all;
clc

WL = 64;% Number of bits
L = 4; % Number of (non-)uniform sub-segments

% Generate 62 logrithmic segments
for i = 1:WL
   x_0_p5(WL+1-i) = 2^-i;
end
for i = WL*3/4:WL
   x_p5_1(WL+1-i) = 1 -2^(i-WL-1);
end
fac = [0.1875  0.40625 0.6797];
fac1 =[0.3203  0.59375 0.8125];


x_0_p5(1) = 0;

dum1 = x_0_p5;
dum2 = x_p5_1;

dum1 = intp_4(dum1, fac);
dum2 = intp_4(dum2, fac1);
dum2 = dum2(2:end);

x_p5_1 = x_p5_1(2:end);
x = [x_0_p5 x_p5_1];
x(end) = 1;


dumx = [dum1' dum2'];
dumx(end) = 1;
% Generate 62xL (non-)uniform sub-segments


x = intp_4(x, fac);

x = dumx';


%x = lin_int(x, L);

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
M=M';
C= C';
%plot(M);


%Calculate 16-bit transformed M and C vectors
for i = 1:length(C);
    if x(i) < 0.5
        w(i) = floor((63*L-i)/L);
        C_tr(i) = C(i);
        M_tr(i) = 2^-w(i) *M(i);
    else
        w(i) = floor((i-63*L-1)/L);
        C_tr(i) = C(i)+M(i);
        M_tr(i) = -2^-w(i) *M(i);
    end 
        
end
M_tr(1) = M_tr(2);
%xin = 1.220705125000000e-004;% 0.53125;
xin = [1.12777343019843e-10;];
xin = fi(xin,0,64,64);hex(xin)
%xin = 1.220703125000000e-004;
xin =double(xin);
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





a = fi(x_tr,0,16,16);hex(a)
b = fi(a2 *0.60725,1,16,12);hex(b)
c = fi(a1 *0.60725,0,16,13);hex(c)

y = b*a+c;
b = fi(y,1,16,12);hex(b)
