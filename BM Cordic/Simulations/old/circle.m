clear all;
close all;
% theta = 0:1:90
% 
% R =     [0.3];% 0.4 0.5 0.6 0.7 0.8 0.9]; 
% theta = [0.7];% 0.6 0.5 0.4 0.3 0.2 0.1];
% 
% y_cart = R .* cosd(theta*360);
% x_cart = R .* sind(theta*360); 
% plot(y_cart,x_cart,'.');
% 
% msize = size(R);
% msize = msize(2);
% x_bm = zeros (1,msize);
% y_bm = zeros (1,msize);
% for i = 1:msize
%     x_bm(i) = sqrt(-2 * log(R(i)))* cosd(theta(i)*360);
%     y_bm(i) = sqrt(-2 * log(R(i)))* sind(theta(i)*360);
% end
% hold;
% plot(x_bm,y_bm,'.r');
% 
theta = 0.0005:0.00005:0.999;

r = sqrt(-2 * log(theta));
plot(theta,r);
M = 16;
N = 4
for i = 1:M
    

    j = i*N;
    for k = 1:N
        x(j-k+1) = 1 -2^(i-M-1) - 2^(i-M-1)/N*(-k+N);
        y(j-k+1) = 2^(-i-1) + 2^(-i-1)/N * (k-1);
    end

end
x = x(1:end-(N-1));
x = [x y]

% 
% x = [1,0.999,0.995, 0.99,0.97, 0.95, 0.9, 0.8,0.7, 0.5];%, 0.3, 0.2, 0.1, 0.05, 1e-2, 1e-3, 1e-4];
% x = [1-2^-9, 1-2^-8, 1-2^-7, 1-2^-6, 1-2^-5, 1-2^-4, 1-2^-3, 1-2^-2, 2^-1];
%  x = [1-2^-11, 1-2^-10, 1-2^-7, 1-2^-6, 1-2^-5, 1-2^-4, 1-2^-3, 1-2^-2, 2^-1, 2^-2, 2^-3, 2^-4, 2^-5, 2^-6, 2^-7, 2^-8, 2^-9, 2^-10, 2^-11];
y = sqrt(-2 * log(x));
hold;plot(x,y,'r');


msize = size(y);
msize = msize(2);


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

figure;semilogx(theta,yout-r,'g');
figure;plot(x);


% 
% 
% clear all;
% close all;
% theta = 80:1:90
% 
% % y = sqrt((0.5)^2 - x.^2);
% % x = [x x];
% % y = [y -y];
% 
% 
% y_cart = 1 * cosd(theta);
% x_cart = 1 * sind(theta); 
% 
% % x = rand(1,1e6);
% % y = rand(1,1e6);
% plot(y_cart,x_cart,'.');
% 
% msize = size(y_cart);
% msize = msize(2);
% x_bm = zeros (1,msize);
% y_bm = zeros (1,msize);
% for i = 1:msize
%     R = sqrt(-2 * log((1)))
%     x_bm(i) = sqrt(-2 * log(0.25))* cosd(theta(i));
%     y_bm(i) = sqrt(-2 * log(0.25))* sind(theta(i));
% end
% hold;
% plot(x_bm,y_bm,'.r');
% 
% % t1= [z0(2) z1(2) R theta(2)]
% % t2= [z0(3) z1(3) R]
% 
% 
% 
% 
% 
