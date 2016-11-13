LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity cordic_lin is
  port (
        clk  : in  std_logic;
        M_in    : in  std_logic_vector (15 downto 0); --9.8 format
        C_in    : in  std_logic_vector (15 downto 0); --9.8 format
        x_in    : in  std_logic_vector (15 downto 0); --9.8 format
		  
        y_out    : out std_logic_vector (15 downto 0) --4.12 format
        );
end cordic_lin;

architecture structural of cordic_lin is

TYPE 		data_array16 IS ARRAY (integer range <>) OF signed(15 downto 0);
                                           
                                            


signal x02, x03, x04, x05, x06, x07, x08, x09, x10, x11, x12, x13, x14, x15 : signed(15 downto 0);  
signal y02, y03, y04, y05, y06, y07, y08, y09, y10, y11, y12, y13, y14, y15: signed(15 downto 0);
signal z02, z03, z04, z05, z06, z07, z08, z09, z10, z11, z12, z13, z14, z15: signed(15 downto 0);

signal    sMin     : std_logic_vector (15 downto 0);
signal    sCin     : std_logic_vector (15 downto 0); 
signal    sin   : std_logic_vector (15 downto 0); 


begin


p_cordic_lin : process (clk)
variable x01, y01, z01: signed(15 downto 0);



  begin  
    if clk'event and clk = '1' then  -- rising clock edge
		sMin <= M_in;
		sCin <= C_in;
		sin <= x_in;
      --cycle 1
        x01 := signed(("00" & sin (15 downto 2))); --0.3.13
        y01 := signed(sCin); --0.3.13
        z01 := signed(sMin); --1.3.12

      --cycle 2
      if(z01(15) = '1')then
        y02 <= y01 - x01; -- 0.0.16 => 1.3.12 * 4 (15 significant bits)
        z02 <= z01 + x"4000";
      else 
        y02 <= y01 + x01; -- 0.0.16 => 1.3.12 * 4 (15 significant bits)
        z02 <= z01 + x"c000";
      end if;
      x02 <= '0' & x01(15 downto 1);

      --cycle 3
     if(z02(15) = '1')then
        y03 <= y02 - x02; --(13 significant bits)
        z03 <= z02 + x"2000";
      else 
        y03 <= y02 + x02; --(13 significant bits)
        z03 <= z02 + x"e000";
      end if;
      x03 <= '0' & x02(15 downto 1);

      --cycle 4
       if(z03(15) = '1')then
         y04 <= y03 - x03; --(12 significant bits)
         z04 <= z03 + x"1000";
      else 
         y04 <= y03 + x03; --(12 significant bits)
         z04 <= z03 + x"f000";
      end if;
      x04 <= '0' & x03(15 downto 1);

      --cycle 5
      if(z04(15) = '1')then
        y05 <= y04 - x04; --(11 significant bits)
        z05 <= z04 + x"0800";
      else 
        y05 <= y04 + x04; --(11 significant bits)
        z05 <= z04 + x"f800";
      end if;
      x05 <= '0' & x04(15 downto 1);

      --cycle 6
     if(z05(15) = '1')then
        y06 <= y05 - x05; --(10 significant bits)
        z06 <= z05 + x"0400";
      else 
        y06 <= y05 + x05; --(10 significant bits)
        z06 <= z05 + x"fc00";
      end if;
      x06 <= '0' & x05(15 downto 1);

      --cycle 7
       if(z06(15) = '1')then
        y07 <= y06 - x06; --(9 significant bits)
        z07 <= z06 + x"0200";
      else 
        y07 <= y06 + x06;--(9 significant bits)
        z07 <= z06 + x"fe00";
      end if;
      x07 <= '0' & x06(15 downto 1);

      --cycle 8
      if(z07(15) = '1')then
        y08 <= y07 - x07; --(8 significant bits)
        z08 <= z07 + x"0100";
      else 
        y08 <= y07 + x07; --(8 significant bits)
        z08 <= z07 + x"ff00";
      end if;
      x08 <= '0' & x07(15 downto 1);

      --cycle 9
      if(z08(15) = '1')then
        y09 <= y08 - x08; --(7 significant bits)
        z09 <= z08 + x"0080";
      else 
        y09 <= y08 + x08; --(7 significant bits)
        z09 <= z08 + x"ff80";
      end if;
      x09 <= '0' & x08(15 downto 1);
      
      --cycle 10
     if(z09(15) = '1')then
        y10 <= y09 - x09; --(6 significant bits)
        z10 <= z09 + x"0040";
     else 
        y10 <= y09 + x09; --(6 significant bits)
        z10 <= z09 + x"ffc0";
      end if;
      x10 <= '0' & x09(15 downto 1);
      
      --cycle 11
      if(z10(15) = '1')then
        y11 <= y10 - x10; --(5 significant bits)
        z11 <= z10 + x"0020";
     else 
        y11 <= y10 + x10; --(5 significant bits)
        z11 <= z10 + x"ffe0";
      end if;
      x11 <= '0' & x10(15 downto 1);

      --cycle 12
     if(z11(15) = '1')then
        y12 <= y11 - x11; --(4 significant bits)
        z12 <= z11 + x"0010";
      else 
        y12 <= y11 + x11; --(4 significant bits)
        z12 <= z11 + x"fff0";
      end if;
      x12 <= '0' & x11(15 downto 1);

      --cycle 13
     if(z12(15) = '1')then
        y13 <= y12 - x12; --(3 significant bits)
        z13 <= z12 + x"0008";
      else 
        y13 <= y12 + x12; --(3 significant bits)
        z13 <= z12 + x"fff8";
      end if;
      x13 <= '0' & x12(15 downto 1);

      --cycle 14
     if(z13(15) = '1')then
       y_out <= std_logic_vector(Y13 - x13);
     else 
       y_out <= std_logic_vector(Y13 + x13);
     end if;


        
  end if;
    
 end process p_cordic_lin;



end architecture;






