LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity cordic is
  port (
        clk        : in  std_logic;
        ang        : in  std_logic_vector (15 downto 0); --9.8 format
        out_sin    : out std_logic_vector (15 downto 0); --4.12 format
        out_cos    : out std_logic_vector (15 downto 0) --4.12 format
        );
end cordic;

architecture structural of cordic is

TYPE 		data_array16 IS ARRAY (integer range <>) OF signed(15 downto 0);
                                           
                                            


signal x01, x02, x03, x04, x05, x06, x07, x08, x09, x10, x11: signed(15 downto 0);  
signal y01, y02, y03, y04, y05, y06, y07, y08, y09, y10, y11 : signed(15 downto 0);
signal z01, z02, z03, z04, z05, z06, z07, z08, z09, z10, z11: signed(15 downto 0);



signal beta : signed(15 downto 0);

signal v_ang: signed(15 downto 0);
signal v_ang1: signed(15 downto 0);

begin


p_cordic : process (clk)
variable  x_sh01, x_sh02, x_sh03, x_sh04, x_sh05, x_sh06, x_sh07, x_sh08, x_sh09, x_sh10, x_sh11, x_sh12, x_sh13, x_sh14, x_sh15 : signed(15 downto 0);
variable  y_sh01, y_sh02, y_sh03, y_sh04, y_sh05, y_sh06, y_sh07, y_sh08, y_sh09, y_sh10, y_sh11, y_sh12, y_sh13, y_sh14, y_sh15 : signed(15 downto 0);
variable  z_n01, z_n02, z_n03, z_n04, z_n05, z_n06, z_n07, z_n08, z_n09, z_n10, z_n11, z_n12, z_n13, z_n14, z_n15 : signed(15 downto 0);

  begin  
    if clk'event and clk = '1' then  -- rising clock edge

    v_ang <= signed(ang(15 downto 0));  
      --cycle -2
      if(v_ang > 16384) then --angle > 90 deg
          beta <= x"f649";
          v_ang1 <= v_ang - 32768;
      elsif(v_ang < -16384) then --angle < -90
          beta <= x"f649";
          v_ang1 <= v_ang - 32768;
      else
          beta <= x"09b7";
          v_ang1 <= v_ang;
      end if;

      --cycle 1
      if(v_ang1(15) = '1')then
        x01 <= beta;
        y01 <= -beta;
        z01 <= v_ang1 + x"2000";
      else 
        x01 <= beta;
        y01 <= beta;
        z01 <= v_ang1 + x"e000";
      end if;

      --cycle 2

 
      if(z01(15) = '1')then
        x_sh01 := -(x01(15) & x01(15 downto 1));
        y_sh01 := (y01(15) & y01(15 downto 1));
        z_n01  := x"12e4";
      else 
        x_sh01 := (x01(15) & x01(15 downto 1));
        y_sh01 := -(y01(15) & y01(15 downto 1));
        z_n01  := x"ed1c";
      end if;


      x02 <= x01 + y_sh01;
      y02 <= y01 + x_sh01;
      z02 <= z01 + z_n01;

      --cycle 3
     if(z02(15) = '1')then
        x_sh02 := -(x02(15) & x02(15) & x02(15 downto 2));
        y_sh02 := (y02(15) & y02(15) & y02(15 downto 2));
        z_n02  := x"09fb";
      else 
        x_sh02 := (x02(15) & x02(15) & x02(15 downto 2));
        y_sh02 := -(y02(15) & y02(15) & y02(15 downto 2));
        z_n02  := x"f605";
      end if;


      x03 <= x02 + y_sh02;
      y03 <= y02 + x_sh02;
      z03 <= z02 + z_n02;

      --cycle 4
       if(z03(15) = '1')then
         x_sh03 := -(x03(15) & x03(15) & x03(15) & x03(15 downto 3));
         y_sh03 := (y03(15) & y03(15) & y03(15) & y03(15 downto 3));
         z_n03  := x"0511";
      else 
         x_sh03 := (x03(15) & x03(15) & x03(15) & x03(15 downto 3));
         y_sh03 := -(y03(15) & y03(15) & y03(15) & y03(15 downto 3));
         z_n03  := x"faef";
      end if;


      x04 <= x03 + y_sh03;
      y04 <= y03 + x_sh03;
      z04 <= z03 + z_n03;

      --cycle 5
      if(z04(15) = '1')then
        x_sh04 := -(x04(15) & x04(15) & x04(15) & x04(15) & x04(15 downto 4));
        y_sh04 := (y04(15) & y04(15) & y04(15) & y04(15) & y04(15 downto 4));
        z_n04  := x"028b";
      else 
        x_sh04 := (x04(15) & x04(15) & x04(15) & x04(15) & x04(15 downto 4));
        y_sh04 := -(y04(15) & y04(15) & y04(15) & y04(15) & y04(15 downto 4));
        z_n04  := x"fd75";
      end if;

      
      x05 <= x04 + y_sh04;
      y05 <= y04 + x_sh04;
      z05 <= z04 + z_n04;

      --cycle 6
     if(z05(15) = '1')then
        x_sh05 := -(x05(15) & x05(15) & x05(15) & x05(15) & x05(15) & x05(15 downto 5));
        y_sh05 := (y05(15) & y05(15) & y05(15) & y05(15) & y05(15) & y05(15 downto 5));
        z_n05  := x"0146";
      else 
        x_sh05 := (x05(15) & x05(15) & x05(15) & x05(15) & x05(15) & x05(15 downto 5));
        y_sh05 := -(y05(15) & y05(15) & y05(15) & y05(15) & y05(15) & y05(15 downto 5));
        z_n05  := x"feba";
      end if;

      
      x06 <= x05 + y_sh05;
      y06 <= y05 + x_sh05;
      z06 <= z05 + z_n05;

      --cycle 7
       if(z06(15) = '1')then
        x_sh06 := -(x06(15) & x06(15) & x06(15) & x06(15) & x06(15) & x06(15) & x06(15 downto 6));
        y_sh06 := (y06(15) & y06(15) & y06(15) & y06(15) & y06(15) & y06(15) & y06(15 downto 6));
        z_n06  := x"00a3";
      else 
        x_sh06 := (x06(15) & x06(15) & x06(15) & x06(15) & x06(15) & x06(15) & x06(15 downto 6));
        y_sh06 := -(y06(15) & y06(15) & y06(15) & y06(15) & y06(15) & y06(15) & y06(15 downto 6));
        z_n06  := x"ff5d";
      end if;


      x07 <= x06 + y_sh06;
      y07 <= y06 + x_sh06;
      z07 <= z06 + z_n06;

      --cycle 8
      if(z07(15) = '1')then
        x_sh07 := -(x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15 downto 7));
        y_sh07 := (y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15 downto 7));
        z_n07  := x"0051";
      else 
        x_sh07 := (x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15) & x07(15 downto 7));
        y_sh07 := -(y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15) & y07(15 downto 7));
        z_n07  := x"ffaf";
      end if;

      x08 <= x07 + y_sh07;
      y08 <= y07 + x_sh07;
      z08 <= z07 + z_n07;

      --cycle 9
      if(z08(15) = '1')then
        x_sh08 := -(x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15 downto 8));
        y_sh08 := (y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15 downto 8));
        z_n08  := x"0029";
      else 
        x_sh08 := (x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15) & x08(15 downto 8));
        y_sh08 := -(y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15) & y08(15 downto 8));
        z_n08  := x"ffd7";
      end if;

      x09 <= x08 + y_sh08;
      y09 <= y08 + x_sh08;
      z09 <= z08 + z_n08;
      
      --cycle 10
     if(z09(15) = '1')then
        x_sh09 := -(x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15 downto 9));
        y_sh09 := (y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15 downto 9));
        z_n09  := x"0014";
     else 
        x_sh09 := (x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15) & x09(15 downto 9));
        y_sh09 := -(y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15) & y09(15 downto 9));
        z_n09  := x"ffec";
      end if;

      x10 <= x09 + y_sh09;
      y10 <= y09 + x_sh09;
      z10 <= z09 + z_n09;
      
      --cycle 11
      if(z10(15) = '1')then
        x_sh10 := -(x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15 downto 10));
        y_sh10 := (y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15 downto 10));
        z_n10  := x"000a";
     else 
        x_sh10 := (x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15) & x10(15 downto 10));
        y_sh10 := -(y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15) & y10(15 downto 10));
        z_n10  := x"fff6";
      end if;

      
      x11 <= x10 + y_sh10;
      y11 <= y10 + x_sh10;
      z11 <= z10 + z_n10;

      --cycle 12
     if(z11(15) = '1')then
        x_sh11 := -(x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15 downto 11));
        y_sh11 := (y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15 downto 11));
      else 
        x_sh11 := (x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15) & x11(15 downto 11));
        y_sh11 := -(y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15) & y11(15 downto 11));
      end if;


        out_sin <= std_logic_vector(x11 + y_sh11);
        out_cos <= std_logic_vector(y11 + x_sh11);
  end if;
    
 end process p_cordic;



end architecture;






