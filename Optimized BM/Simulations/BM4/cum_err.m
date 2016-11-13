load sin_cos_in.txt;

load wlo.txt;
load whi.txt;
s1 = length(sin_cos_in);
s2 = length(whi);
 
v1 = zeros(s1*s2,1);
v2 = zeros(s1*s2,1);
v3 = zeros(s1*s2,1);

for i = 0: s1-1
    for j = 1:s2
        v1(i*s2+j)=whi(j);
        v2(i*s2+j)=wlo(j);
        v3(i*s2+j)=sin_cos_in(i+1);
    end
end
dum_hi=[2993; 2993; 2993; 2993; 2993; 2993; 2993; 2993; 2993; 2993];
dum_lo=[1908; 1908; 1908; 1908; 1908; 1908; 1908; 1908; 1908; 1908];
dum_sc=[5342; 5342; 5342; 5342; 5342; 5342; 5342; 5342; 5342; 5342];


v1 = [dum_hi;v1];
v2 = [dum_lo;v2];
v3 = [0;0;0;0;0;0;0;dum_sc;v3];


% open the file with write permission
fid = fopen('fwhi.txt', 'w');
fprintf(fid, '%d \n', v1');
fclose(fid);
fid = fopen('fwlo.txt', 'w');
fprintf(fid, '%d \n', v2');
fclose(fid);
fid = fopen('fsin_cos_in.txt', 'w');
fprintf(fid, '%d \n', v3');
fclose(fid);


