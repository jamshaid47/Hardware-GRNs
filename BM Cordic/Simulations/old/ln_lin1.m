clear all;
close all;

%Generate referencepoints
M = 32;
N = 64
for i = 1:M
    

    j = i*N;
    for k = 1:N
        x(j-k+1) = 1 -2^(i-M-1) - 2^(i-M-1)/N*(-k+N);
        y(j-k+1) = 2^(-i-1) + 2^(-i-1)/N * (k-1);
    end

end
x = x(1:end-(N-1));
x = [x y];
theta = x;
% theta = theta(1985:end);
r = sqrt(-2 * log(theta));
plot(x,r);


%Generate data points for linear interpolation
x = 0;
y = 0;
M = 32;
N = 4;


for i = 1:M
        x(i) = 1 - 2^(i-M-1);
        y(i) = 2^(-i);
end

y = y(2:end);
x = [x y];

x = lin_int(x, N);


y = sqrt(-2 * log(x));
hold;plot(x,y,'r.');


msize = size(y);
msize = msize(1);


%Generate M and C vectors
for i = 2:msize
    M(i) = (y(i) - y(i-1))/(x(i) - x(i-1));
    C(i) = (y(i) - y(i-1))/(x(i) - x(i-1)) * -x(i-1) + y(i-1);
end
M = M(2:end);
C = C(2:end);

msize = size(M);
msize = msize(2)/2;

for i = 1:msize+1
    C_tr(i) = C(i) + M(i);
    w(i) = floor((msize-i)/4);
end

for i = msize+1: msize*2
    C_tr(i) = C(i);
    w(i) = floor((i-msize)/4);
end
w = [w(1:msize) w(msize: end-1)];
C_tr = C_tr';
w = w';

for i = 1:msize+1
    M_tr(i) = M(i) * 2^-w(i);
    x_tr(i) = (1- x(i)) * 2^w(i);
end

for i = msize+1: msize*2
    M_tr(i) = M(i) * 2^-w(i);
    x_tr(i) =  x(i) * 2^w(i);

end
M_tr = M_tr';
x_tr = x_tr';


msize1 = size(theta);
msize1 = msize1(2);

for j = 1:msize1
    xin = theta(j);
    for i = 1:(msize*2-1)
        if xin <= x(i) && xin >= x(i+1)
            Cin = C(i);Cin_tr = C_tr(i);
            Min = M(i);Min_tr = M_tr(i);
            if(xin > 0.5)
                xin_tr = (1- xin) * -2^w(i);
            else
                xin_tr = xin * 2^w(i);
            end
        end
     
    end
    yout(j) = Min * xin + Cin;
    yout_tr(j) = Min_tr * xin_tr + Cin_tr;
    newx(j) = xin_tr;
end

plot(theta,yout_tr,'g');
figure;
hold;semilogx(theta,yout-r,'r');

err = abs(yout-r);
err = err(1:end-20)
theta = theta(1:end-20)
hold;semilogx(theta,err,'r');
max(err)
mean(err)
std(err)
%figure;plot(x);




