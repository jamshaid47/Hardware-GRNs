clear all;
close all;
clc
load sin_cos_out.txt;
load sin_cos_in.txt;
theta = sin_cos_in/ 2^16 *360;

sin_in = sind(theta);
cos_in = cosd(theta);
cos_out= sin_cos_out(:,2)./ 2^15;
sin_out= sin_cos_out(:,1)./ 2^15;
sin_out = sin_out(5:end);
sin_out = sin_out(1:length(sin_in));
cos_out = cos_out(11:end);
cos_out = cos_out(1:length(sin_in));


plot(sin_out,'g');hold;
plot(sin_in,'r');

err_sin = sin_in-sin_out;
figure;plot(abs(err_sin),'r');

% err_cos = cos_in-cos_out;
% figure;plot(abs(err_cos));
