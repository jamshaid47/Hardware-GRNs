load final_out.txt;

U1 = final_out(:,1);
U2 = final_out(:,2);
U1 = U1(20:end);
U2 = U2(20:end);
plot(U2)

