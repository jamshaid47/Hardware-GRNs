library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_cordic is 
end tb_cordic;

architecture arch_tb_cordic of tb_cordic is
component cordic  
  port (
        clk        : in  std_logic;
        strb       : in  std_logic;
        mag        : in  std_logic_vector (15 downto 0); --9.8 format
        ang        : in  std_logic_vector (15 downto 0); --9.8 format
        out_sin    : out std_logic_vector (15 downto 0); --4.12 format
        out_cos    : out std_logic_vector (15 downto 0) --4.12 format
        );
end component;    



signal 		 tb_clk			     :		std_logic := '0';
signal 		 tb_strb			     :		std_logic := '0';
signal  		tb_mag 		     :		std_logic_vector(15 downto 0) := x"09b7";
signal  		tb_ang 		     :		std_logic_vector(15 downto 0) := x"0000";
signal  		tb_out_sin 		 :		std_logic_vector(15 downto 0) := x"0000";
signal  		tb_out_cos 		 :		std_logic_vector(15 downto 0) := x"0000";


begin  
  --Instantiate the Component  
  C1:cordic port map(tb_clk, tb_strb,	tb_mag, tb_ang,	tb_out_sin, tb_out_cos);


  tb_clk        <=  not(tb_clk) after 20 ns;
  tb_mag        <=  x"09b7";
  tb_ang        <=  x"d710";
  tb_strb       <=  '1' after 150 ns,
                    '0' after 250 ns;
  --tb_ang        <=  x"009b" after 550 ns;
                    --x"009b" after 650 ns,
                    --x"009c" after 750 ns,
                    --x"009d" after 850 ns;
  

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
--
--  write_file:
--    process (tb_clk) is    -- write file_io.out (when done goes to '1')
--      file my_output : TEXT open WRITE_MODE is "fo_cordic.txt";
--      -- above declaration should be in architecture declarations for multiple
--      variable my_line : LINE;
--      variable my_output_line : LINE;
--      variable	dum1 	 :		integer range -100000 to 100000;
--      variable	dum2 	 :		integer range -100000 to 100000;
--    begin
--    dum1 :=  conv_integer(signed(tb_out_sin));
--    dum2 :=  conv_integer(signed(tb_out_cos));
--      if(tb_clk'event and tb_clk ='1') then
--       write(my_output_line, dum1);    
--       write(my_output_line, string'("   "));
--       write(my_output_line, dum2);    
--        writeline(my_output, my_output_line);
--      end if;
--    end process write_file;
                    

 
  
end architecture arch_tb_cordic; -- of file_io




