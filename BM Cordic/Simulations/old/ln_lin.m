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
N = 8


for i = 1:M
    

    j = i*N;
    for k = 1:N
        x(j-k+1) = 1 -2^(i-M-1) - 2^(i-M-1)/N*(-k+N);
        y(j-k+1) = 2^(-i-1) + 2^(-i-1)/N * (k-1);
    end

end
x = x(1:end-(N-1));
x = [x y];

y = sqrt(-2 * log(x));
hold;plot(x,y,'r');


msize = size(y);
msize = msize(2);


%Generate M and C vectors
for i = 2:msize
    M(i) = (y(i) - y(i-1))/(x(i) - x(i-1));
    C(i) = (y(i) - y(i-1))/(x(i) - x(i-1)) * -x(i-1) + y(i-1);
end
M = M(2:end);
C = C(2:end);

msize1 = size(theta);
msize1 = msize1(2);

for j = 1:msize1
    xin = theta(j);

    for i = 1:(msize-1)
        if xin <= x(i) && xin >= x(i+1)
            Cin = C(i);
            Min = M(i);
        end
     
    end
    yout(j) = Min * xin + Cin;
end

plot(theta,yout,'g');
figure;
% hold;semilogx(theta,yout-r,'r');

err = abs(yout-r);
err = err(1:end-20)
theta = theta(1:end-20)
hold;semilogx(theta,err,'r');
max(err)
mean(err)
std(err)
%figure;plot(x);




