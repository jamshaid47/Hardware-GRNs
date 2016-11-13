library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;




entity tb_ln_sq_add is 
end tb_ln_sq_add;

architecture arch_tb_ln_sq of tb_ln_sq_add is
component ln_sq_add  
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(15 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)

    ); 
end component;    




signal    tb_clk   : std_logic := '0'; 
signal    tb_reset   : std_logic := '0'; 
signal    tb_inp   :  std_logic_vector(15 downto 0):= x"000f";
signal    tb_M   :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_C   :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_outp	  :  std_logic_vector(15 downto 0);


begin  
  --Instantiate the Component  
 C1:ln_sq_add port map(tb_clk, tb_reset, tb_inp,	tb_M,	tb_C,	tb_outp);
 
  tb_clk        <=  not(tb_clk) after 20 ns;
  tb_reset        <=  '1' after 100 ns,
                    '0' after 200 ns;

--  tb_inp        <=  x"0bb10774" after 215 ns,
--                    x"0015097d" after 255 ns,
--                    x"bed67770" after 295 ns,
--                    x"f209aaa4" after 335 ns,
--                    x"ffecfe9b" after 375 ns,
--                    x"00000001" after 415 ns,
--                    x"ffffef39" after 455 ns,
--                    x"00000008" after 810 ns;

  read_file:  process (tb_clk)
  
    file my_input       :   text open read_mode is "file_in.txt";
    variable line_in    :   line;
    variable input_tmp  :   integer;

    begin 
        if(tb_clk'event and tb_clk ='0') then
          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
          if not(endfile(my_input)) then
            readline(my_input, line_in);
            read(line_in, input_tmp);
            tb_inp(15 downto 0) <= conv_std_logic_vector(input_tmp, 16);
          end if;
      end if;
    end process read_file;
    




  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "file_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum1, dum2, dum3   	 :		 integer range -66000 to 66000;
    begin
    dum1     :=  conv_integer(tb_M);
    dum2     :=  conv_integer(tb_C);
    dum3     :=  conv_integer(tb_outp);
      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum1);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum2);        
       write(my_output_line, string'("   "));
       write(my_output_line, dum3);    
       writeline(my_output, my_output_line);
      end if;
    end process write_file;
                    


  
end architecture arch_tb_ln_sq; -- of file_io








