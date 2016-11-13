LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity cordic is
  port (
        clk        : in  std_logic;
        mag        : in  std_logic_vector (15 downto 0); --9.8 format
        ang        : in  std_logic_vector (15 downto 0); --9.8 format
        out_sin    : out std_logic_vector (15 downto 0); --4.12 format
        out_cos    : out std_logic_vector (15 downto 0) --4.12 format
        );
end cordic;

architecture structural of cordic is

TYPE 		data_array16 IS ARRAY (integer range <>) OF signed(15 downto 0);
                                           
signal  	angles 	: 	data_array16(0 to 15) :=
			(
			x"2000", x"12e4", x"09fb", x"0511",
			x"028b", x"0146", x"00a3", x"0051",
			x"0029", x"0014", x"000a", x"0005",
			x"0003", x"0002", x"0001", x"0000"
			);

signal  strb_s       : std_logic := '1';
signal x,  y : signed(15 downto 0);

signal v_ang, v_ang_old: signed(15 downto 0) := x"0000";
signal counter :		 integer range 0 to 15;

begin


p_cordic : process (clk, strb_s)
variable x_old, y_old: signed(15 downto 0) := x"0000" ;

  begin  
    if clk'event and clk = '1' then  -- rising clock edge

      if strb_s = '1' then
          if(signed(ang) > 16384 or signed(ang) < -16384) then --angle > 90 deg
            x     <= -signed(mag(15 downto 0));
            v_ang <= signed(ang(15 downto 0)) - 32768;
          else
            x <= signed(mag(15 downto 0));
            v_ang <= signed(ang(15 downto 0));
          end if;
         
         y <= x"0000";
         counter <= 0;
         strb_s <= '0';
         
      else
        x_old := shift_right(x, counter) ;
        y_old := shift_right(y, counter) ;
        
        if(v_ang(15) = '1') then
          x <= x + y_old;
          y <= y - x_old;
          v_ang <= v_ang + signed(angles(counter));
        else
          x <= x - y_old;
          y <= y + x_old;
          v_ang <= v_ang - signed(angles(counter));
        end if;

        counter <= counter +1;

        if (counter = 13) then
           strb_s <= '1';
           out_sin <= std_logic_vector(x);  
           out_cos <= std_logic_vector(y);
        end if;
      end if;
    end if;
    
 end process p_cordic;



end architecture;






