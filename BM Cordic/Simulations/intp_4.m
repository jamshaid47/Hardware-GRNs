function [my_out] = intp_4(my_in, fac)

isize = length(my_in)

output1 = zeros((isize *4),1);


for i = 4:4:(isize*4-4)
    output1(i) = my_in(i/4);
    if(output1(i) < 0.5)
        output1(i+1)= fac(1) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
        output1(i+2)= fac(2) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
        output1(i+3)= fac(3) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
    else
        output1(i+1)= fac(1) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
        output1(i+2)= fac(2) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
        output1(i+3)= fac(3) * (my_in((i+4)/4)- my_in(i/4)) + my_in(i/4);
    end
end
output1 = output1(4:end);
output1(end) = my_in(end);
my_out=output1;
