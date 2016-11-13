clear all;
close all;
load file_out.txt
load wlo.txt;
load whi.txt;

whi = whi * 2^16;
whi = (whi + wlo)/2^32;
tt= fi(whi,0,32,32);hex(tt(302))

yac = sqrt(-2 * log(whi));
yac = yac(4:end);
%plot(file_out1/8192)
file_out = file_out(15:end);
a = file_out(1:length(yac));
whi = whi(1:end-3);
figure;
plot(yac*8192,'g');hold;
plot(a);

figure;
% plot(a,'g')
plot(whi,(a/8192-yac),'r');

figure;
% plot(a,'g')
plot((a/8192-yac));