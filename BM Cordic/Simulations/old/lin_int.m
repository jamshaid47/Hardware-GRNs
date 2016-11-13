function [my_out] = lin_int(my_in, int_size)
isize = size(my_in);isize = isize(2)-1;
output1 = zeros((isize *int_size),1);

for i = int_size:int_size:(isize*int_size)
    output1(i-int_size+1) = my_in(i/int_size);

    for j = 1: int_size-1
        output1(j+i -int_size +1)= (j/int_size) * (my_in((i+int_size)/int_size)- my_in(i/int_size)) + my_in(i/int_size);
    end
end

my_out=[output1' my_in(end)]';
