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



signal x ,y, z : signed(15 downto 0);  
signal z_old, x_old1 : signed(15 downto 0);  
signal  strb_s       : std_logic := '1';

signal counter :		 integer range 0 to 16;



begin


p_cordic_lin : process (clk, strb_s)
variable x_old: signed(15 downto 0);
begin  
  if clk'event and clk = '1' then  -- rising clock edge
    if strb_s = '1' then
      x <= signed(("00" & x_in(15 downto 2))); --0.3.13
      y <= '0' & signed(C_in(15 downto 1)); --0.3.13
      z <= signed(M_in); --1.3.12
        
      counter <= 0;
      strb_s <= '0';
      z_old <= x"4000"; 
    else
      x_old := shift_right(x, counter);
      x_old1 <= x_old;
      
      if(z(15) = '1')then
        y <= y - x_old; 
        z <= z + z_old;
      else 
        y <= y + x_old; 
        z <= z - z_old;
      end if;
      z_old <= shift_right(z_old, 1);

      counter <= counter +1;

      if (counter = 14) then
        strb_s <= '1';
        y_out <= std_logic_vector(y);  
      end if;
    end if;
  end if;
    
 end process p_cordic_lin;



end architecture;






