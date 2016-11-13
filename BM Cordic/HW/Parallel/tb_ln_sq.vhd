library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;




entity tb_ln_sq is 
end tb_ln_sq;

architecture arch_tb_ln_sq of tb_ln_sq is
component ln_sq_add  
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(31 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)

    ); 
end component;    

component cordic_lin is
  port (
        clk  : in  std_logic;
        x_in    : in  std_logic_vector (15 downto 0); --9.8 format
        M_in    : in  std_logic_vector (15 downto 0); --9.8 format
        C_in    : in  std_logic_vector (15 downto 0); --9.8 format
        y_out    : out std_logic_vector (15 downto 0) --4.12 format
        );
end  component; 

component ln_sq_mac is 
port
  (
    clk : in std_logic;

    aM  : in std_logic_vector(15 downto 0);--4.12 (signed)  
    aC  : in std_logic_vector(15 downto 0);--3.13 (unsigned) 
    inp : in std_logic_vector(15 downto 0);--0.16 (unsigned)     
	 outp: out std_logic_vector(15 downto 0)
	 ); 
end component; 

constant  period1    : time      := 20 ns; 
constant  period2    : time      := 1251 nS; 




signal    tb_clk   : std_logic := '0'; 
signal    tb_reset   : std_logic := '0'; 
signal    tb_inp   :  std_logic_vector(31 downto 0):= x"00000000";
signal    tb_M   :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_C   :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_outp	  :  std_logic_vector(15 downto 0);
signal    tb_outf	  :  std_logic_vector(15 downto 0);
signal    tb_outf1	  :  std_logic_vector(15 downto 0);

begin  
  --Instantiate the Component  
 C1:ln_sq_add port map(tb_clk, tb_reset, tb_inp,	tb_M,	tb_C,	tb_outp);
 C2:ln_sq_mac port map(tb_clk, tb_M,	tb_C, tb_outp, tb_outf);
 C3:cordic_lin port map(tb_clk, tb_outp, tb_M,	tb_C, tb_outf1);
 
--  tb_reset      <=  '0' after 50ns;
  tb_clk        <=  not(tb_clk) after period1;
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
  
    file my_input       :   text open read_mode is "wlo.txt";
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
    
  read_file1:  process (tb_clk)
  
    file my_input       :   text open read_mode is "whi.txt";
    variable line_in    :   line;
    variable input_tmp  :   integer;

    begin 
        if(tb_clk'event and tb_clk ='0') then
          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
          if not(endfile(my_input)) then
            readline(my_input, line_in);
            read(line_in, input_tmp);
            tb_inp(31 downto 16) <= conv_std_logic_vector(input_tmp, 16);
          end if;
      end if;
    end process read_file1; 



  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "file_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum1, dum2   	 :		 integer range -66000 to 66000;
    begin
    dum1     :=  conv_integer(tb_outf);
    dum2     :=  conv_integer(tb_outf1);
      if(tb_clk'event and tb_clk ='1') then
      
       write(my_output_line, dum1);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum2);    
       writeline(my_output, my_output_line);
      end if;
    end process write_file;
                    


  
end architecture arch_tb_ln_sq; -- of file_io








