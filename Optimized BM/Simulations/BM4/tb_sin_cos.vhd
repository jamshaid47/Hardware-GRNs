library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_sin_cos is 
end tb_sin_cos;

architecture arch_tb_sin_cos of tb_sin_cos is
component sin_cos IS
	PORT 
	(
	clk			      :	in 		std_logic;
	reset	      :	in 		std_logic;
	in_ang 		   :	in 		std_logic_vector(15 downto 4); 
	out_sin 	   :	out 	std_logic_vector (15 downto 0);
  out_cos 	   :	out 	std_logic_vector (15 downto 0)
  );


	end component;    


constant  period1    : time      := 20 ns; 
constant  period2    : time      := 1251 nS; 




signal    tb_clk      :  std_logic := '0'; 
signal    tb_reset    :  std_logic := '0'; 
signal    tb_in_ang   :  std_logic_vector(15 downto 4):= x"000"; 
signal    tb_out_sin  :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_cos  :  std_logic_vector(15 downto 0):= x"0000";

begin  
  --Instantiate the Component  
 C1:sin_cos port map(tb_clk, tb_reset,	tb_in_ang,	tb_out_sin,	tb_out_cos);
 
--  tb_reset      <=  '0' after 50ns;
  tb_clk        <=  not(tb_clk) after period1;
  tb_reset      <=  '1' after 100 ns,
                    '0' after 200 ns;
--  tb_in_ang     <=  x"000" after 215 ns,
--                    x"000" after 255 ns,
--                    x"14d" after 295 ns,
--                    x"630" after 335 ns,
--                    x"a6a" after 375 ns,
--                    x"e2c" after 415 ns,
--                    x"000" after 710 ns,
--                    x"000" after 810 ns;
  
  
read_file1:  process (tb_clk)
  
    file my_input       :   text open read_mode is "sin_cos_in.txt";
    variable line_in    :   line;
    variable input_tmp  :   integer;
    variable dum   :  std_logic_vector(15 downto 0); 

    begin 
        if(tb_clk'event and tb_clk ='0') then
          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
          if not(endfile(my_input)) then
            readline(my_input, line_in);
            read(line_in, input_tmp);
            dum := conv_std_logic_vector(input_tmp, 16);
            tb_in_ang <= dum(15 downto 4);
          end if;
      end if;
    end process read_file1;



  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "sin_cos_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum_sin   	 :		 integer range -65535 to 65535;
      variable	dum_cos   	 :		 integer range -65535 to 65535;
    begin
    dum_sin     :=  conv_integer(signed(tb_out_sin));
    dum_cos     :=  conv_integer(signed(tb_out_cos));
      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum_sin);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum_cos);   

       writeline(my_output, my_output_line);
      end if;
    end process write_file;
                    

  
end architecture arch_tb_sin_cos; -- of file_io







