function [my_out] = lin_int(my_in, int_size)
my_in = [my_in 0];
isize = length(my_in);
output1 = zeros((isize *int_size),1);

for i = int_size:int_size:(isize*int_size-int_size)
    output1(i) = my_in(i/int_size);

    for j = 1: int_size-1
        output1(j+i)= my_in(i/int_size);
    end
end
output1 = output1(int_size:end);
output1 = output1(1:end-1);
my_out=output1;
