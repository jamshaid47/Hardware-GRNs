close all;
clear all;
load final_out.txt;
load fwlo.txt;
load fwhi.txt;
load fsin_cos_in.txt;


sout = final_out(:,1);
cout = final_out(:,2);

cout = cout(25:985817);
sout = sout(25:985817);
fwlo = fwlo(11:end);
fwhi = fwhi(11:end);
fsin_cos_in = fsin_cos_in(18:end);

% plot(cout);


ind = 1;
for i = 1:1009
    for j = 1:977
        zouts(i,j) = sout(ind);
        zoutc(i,j) = cout(ind);
        ind = ind+1;
    end
end
zouts = zouts/2^15*8;
zoutc = zoutc/2^15*8;

for i = 1:977
    xlo(i) = fwlo(i);
    xhi(i) = fwhi(i);
end
xin = (xhi* 2^16 + xlo)/2^32;

for i = 977:977:985793
    yin(i/977) = fsin_cos_in(i);
end
yin = yin/2^16*360;

[xin,yin] = meshgrid(xin, yin);

zins = sqrt(-2 * log(xin)).*sind(yin);
zinc = sqrt(-2 * log(xin)).*cosd(yin);


mesh(xin,yin,abs(zinc-zoutc))
figure;
mesh(xin,yin,(zoutc))
figure;
mesh(xin,yin,abs(zins-zouts))
figure;
mesh(xin,yin,(zouts))
