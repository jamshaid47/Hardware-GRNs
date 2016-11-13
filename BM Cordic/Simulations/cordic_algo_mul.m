n = 16;




Xx = 0.491516113281250; 
Zm = -0.501464843750000; 
Yc = 4.495971679687500;
xhex = fi(Xx,0,16,16);hex(xhex)
Chex = fi(Yc,0,16,13);hex(Chex)
Mhex = fi(Zm,1,16,12);hex(Mhex)

test = Yc + Xx*Zm;
%To save the old values
Xx_old = Xx;
Yc_old = Yc;
Zm_old = Zm;

poweroftwo = 4; 
 
%Iterations
for j = 0:n-1;

    a1 = fi(Xx*poweroftwo,1,16,12)
    a2 = fi(Yc_old,1,16,12)
    a3 = fi(Zm_old,1,16,12)
    clc
    j
    hex(a1) 
    hex(a2) 
    hex(a3)     

    
    if Zm < 0
        Yc = Yc - Xx*poweroftwo;
        Zm = Zm + poweroftwo;
    else
        Yc = Yc + Xx*poweroftwo;
        Zm = Zm - poweroftwo;
    end
    


    %Save the old variables
    clc
    Yc_old = Yc;
    Zm_old = Zm;

    poweroftwo = poweroftwo / 2;   
end

[test Yc]