close all;
clear all;
clc
%Define length of the LFSR
Size = 63;

%Define Polynomial
Pol = zeros(1,Size);
Pol(63) =1;
Pol(62) =1;

%No. of steps to skip
Skip = 40;

A = eye(Size);
A(1,1) = 0;
A = circshift(A,[0 -1]);
A(1, 1:end) = Pol;
A = mod(A^1,2);


%Generate VHDL code snippet for a Skip-adead LFSR 
for i = 1:Size
    str = sprintf('\t   reg1(%d) <=',i);
    disp(str);

    for j = 1:Size
        if A(i,j) == 1;
            str = sprintf('\b \b reg1(%d) xor',j);
            disp(str);
        end
    end
    str = sprintf('\b\b\b\b\b;');
    disp(str);
end

    str = sprintf('\n\n\n\n\n');
    disp(str);

A = eye(Size);
A(1,1) = 0;
A = circshift(A,[0 -1]);
A(1, 1:end) = Pol;
A = mod(A^Skip,2);


%Generate VHDL code snippet for a normal LFSR 
for i = 1:Size
    str = sprintf('\t   reg2(%d) <=',i);
    disp(str);

    for j = 1:Size
        if A(i,j) == 1;
            str = sprintf('\b \b reg2(%d) xor',j);
            disp(str);
        end
    end
    str = sprintf('\b\b\b\b\b;');
    disp(str);
end