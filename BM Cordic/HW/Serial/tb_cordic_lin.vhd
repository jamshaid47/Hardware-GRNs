library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_cordic_lin is 
end tb_cordic_lin;

architecture arch_tb_cordic_lin of tb_cordic_lin is
component cordic_lin  
  port (
        clk  : in  std_logic;
        x_in    : in  std_logic_vector (15 downto 0); --9.8 format
        M_in    : in  std_logic_vector (15 downto 0); --9.8 format
        C_in    : in  std_logic_vector (15 downto 0); --9.8 format
        y_out    : out std_logic_vector (15 downto 0) --4.12 format
        );
end component;    


signal 		 tb_clk			     :		std_logic := '0';
signal  		tb_x_in 		     :		std_logic_vector(15 downto 0) := x"0000";
signal  		tb_M_in 		     :		std_logic_vector(15 downto 0) := x"0000";
signal  		tb_C_in 		     :		std_logic_vector(15 downto 0) := x"0000";
signal  		tb_y_out 		     :		std_logic_vector(15 downto 0) := x"0000";


begin  
  --Instantiate the Component  
  C1:cordic_lin port map(tb_clk,	tb_x_in,	tb_M_in, tb_C_in, tb_y_out);


  tb_clk        <=  not(tb_clk) after 20 ns;
  tb_x_in       <=  x"faa0" after 550 ns;
                   --x"009b" after 650 ns,
  
  tb_M_in       <=  x"868f" after 550 ns;
                   --x"009b" after 650 ns,
  
  tb_C_in       <=  x"6a77" after 550 ns;
                   --x"009b" after 650 ns,
  

--  read_file:  process (tb_clk)
--  
--    file my_input       :   text open read_mode is "file_in.txt";
--    variable line_in    :   line;
--    variable input_tmp  :   integer;
--
--    begin 
--        if(tb_clk'event and tb_clk ='0') then
--          -- Read one line from the input file to the variable ?line_in? and read the value in the line ?line_in? to the variable ?input_mp?
--          if not(endfile(my_input)) then
--            readline(my_input, line_in);
--            read(line_in, input_tmp);
--            tb_ang <= conv_std_logic_vector(input_tmp, 16);
--          end if;
--      end if;
--    end process read_file;

  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "file_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum1 	 :		integer range -100000 to 100000;
      variable	dum2 	 :		integer range -100000 to 100000;
    begin
    dum1 :=  conv_integer(signed(tb_y_out));
      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum1);    
        writeline(my_output, my_output_line);
      end if;
    end process write_file;
                    

 
  
end architecture arch_tb_cordic_lin; -- of file_io




