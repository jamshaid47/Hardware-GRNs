clear all;
close all;
clc

WL = 64;% Number of bits
L = 8; % Number of (non-)uniform sub-segments

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
% C_tr(1:124) = C_tr(1:124)- 0.001508658625404/2;
% C_tr(128:end) = C_tr(128:end)+ 0.00088/2;
%C_tr(130:end) = C_tr(130:end)+ 0.00088/2;




%Generate reference points
Ni = 64
for i = 1:WL
    

    j = i*Ni;
    for k = 1:Ni
        xi(j-k+1) = 1 -2^(i-WL-1) - 2^(i-WL-1)/Ni*(-k+Ni);
        yi(j-k+1) = 2^(-i-1) + 2^(-i-1)/Ni * (k-1);
    end

end
xi = xi(1:end-(Ni-1));
xin = [xi yi(1:end-128)];
Xin = fi(xin,0,32,32);hex(Xin')

%Generate approx. F(u1) function using transformed M and C
for j = 1:length(xin)
    if xin(j) < 0.5 
        for i = 1:(msize-1)
            if xin(j) >= x(i) && xin(j) <= x(i+1)
                x_tr(j) =  2^w(i) * xin(j);
                yout(j) = M_tr(i)  * x_tr(j) + C_tr(i);
            end
        end
    else
        for i = 1:(msize-1)
            if xin(j) >= x(i) && xin(j) <= x(i+1)
                x_tr(j) =  2^w(i) * (1-xin(j));
                yout(j) = M_tr(i)  *  x_tr(j) + C_tr(i);
            end
        end
    end
end
yac = sqrt(-2* log(xin)); 
% plot(xin,yout,'g');hold;
% 
% plot(xin,yac);
%  
% figure;
plot( abs(yout-yac),'b');hold
plot(xin/1000,'r');
% plot(xin, x_tr,'r');
figure;
plot(xin, abs(yout-yac),'b');hold
max(abs(yout-yac))
mean((yout-yac))

x_tr = x_tr';
M_tr=M_tr';
C_tr= C_tr';
w = w';
