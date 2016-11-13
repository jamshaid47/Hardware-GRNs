library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_top is 
end tb_top;

architecture arch_tb_top of tb_top is
component ln_sq_add  
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(63 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)

    ); 
end component;    

component cordic_lin is
  port (
        clk  : in  std_logic;
        M_in    : in  std_logic_vector (15 downto 0); --9.8 format
        C_in    : in  std_logic_vector (15 downto 0); --9.8 format
        x_in    : in  std_logic_vector (15 downto 0); --9.8 format
        y_out    : out std_logic_vector (15 downto 0) --4.12 format
        );
end component;   

component ln_sq_mac is 
port
  (
    clk : in std_logic;

    aM  : in std_logic_vector(15 downto 0);--1.3.12 (signed)  
    aC  : in std_logic_vector(15 downto 0);--0.3.13 (unsigned) 
    inp : in std_logic_vector(15 downto 0);--0.16 (unsigned)     
	 outp: out std_logic_vector(15 downto 0)
	 ); 
end component; 

component cordic is
  port (
        clk        : in  std_logic;
        mag        : in  std_logic_vector (15 downto 0); --9.8 format
        ang        : in  std_logic_vector (15 downto 0); --9.8 format
        out_sin    : out std_logic_vector (15 downto 0); --4.12 format
        out_cos    : out std_logic_vector (15 downto 0) --4.12 format
        );
end  component; 



component my_lfsr is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_16  : out std_logic_vector(15 downto 0);
    out_64  : out std_logic_vector(63 downto 0)
    );
end component; 




    

constant  period1    : time      := 20 ns; 
constant  period2    : time      := 1251 nS; 




signal    tb_clk   : std_logic := '0'; 
signal    tb_reset : std_logic := '0'; 
signal    tb_U1    :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_U2    :  std_logic_vector(63 downto 0):= x"0000000000000000";
signal    tb_M     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_C     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_U2_tr	:  std_logic_vector(15 downto 0):= x"0000";
signal    tb_ln_sq	:  std_logic_vector(15 downto 0):= x"0000";
signal    tb_sin	  :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_cos	  :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_outf1	:  std_logic_vector(15 downto 0):= x"0000";
signal    tb_outf2	:  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  

 C1: my_lfsr port map(tb_reset, tb_clk,  tb_U1, tb_U2);
 C3: ln_sq_add port map(tb_clk, tb_reset, tb_U2,	tb_M,	tb_C,	tb_U2_tr);
 C2: ln_sq_mac port map(tb_clk, tb_M,	tb_C,	tb_U2_tr, tb_ln_sq);
-- C4: cordic_lin port map(tb_clk, tb_M,	tb_C,	tb_U2_tr, tb_ln_sq);
 C5: cordic   port map(tb_clk, tb_ln_sq, tb_U1,	tb_outf1,	tb_outf2);

   
   
tb_clk        <=  not(tb_clk) after period1;
tb_reset      <=  '1' after 100 ns,
                    '0' after 200 ns;
--                    
--  tb_U2         <=    x"00000002" after 2 ns;
--                    x"0015097d" after 255 ns,
--                    x"bed67770" after 295 ns,
--                    x"f209aaa4" after 335 ns,
--                    x"ffecfe9b" after 375 ns,
--                    x"ffffef39" after 415 ns,
--                    x"00000001" after 710 ns,
--                    x"00000008" after 810 ns;
--                    
--  tb_U1         <=  x"3872" after 215 ns;
--                    x"14d" after 455 ns,
--                    x"630" after 495 ns,
--                    x"a6a" after 535 ns,
--                    x"e2c" after 575 ns,
--                    x"fff" after 615 ns,
--                    x"000" after 710 ns,
--                    x"000" after 810 ns;   


--  read_file:  process (tb_clk)
--  
--    file my_input       :   text open read_mode is "fwlo.txt";
--    variable line_in    :   line;
--    variable input_tmp  :   integer;
--
--    begin 
--        if(tb_clk'event and tb_clk ='0') then
--          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
--          if not(endfile(my_input)) then
--            readline(my_input, line_in);
--            read(line_in, input_tmp);
--            tb_U2(15 downto 0) <= conv_std_logic_vector(input_tmp, 16);
--          end if;
--      end if;
--    end process read_file;
--    
--  read_file1:  process (tb_clk)
--  
--    file my_input       :   text open read_mode is "fwhi.txt";
--    variable line_in    :   line;
--    variable input_tmp  :   integer;
--
--    begin 
--        if(tb_clk'event and tb_clk ='0') then
--          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
--          if not(endfile(my_input)) then
--            readline(my_input, line_in);
--            read(line_in, input_tmp);
--            tb_U2(31 downto 16) <= conv_std_logic_vector(input_tmp, 16);
--          end if;
--      end if;
--    end process read_file1;
--    
--read_file2:  process (tb_clk)
--  
--    file my_input       :   text open read_mode is "file_in.txt";
--    variable line_in    :   line;
--    variable input_tmp  :   integer;
--    variable dum   :  std_logic_vector(15 downto 0); 
--
--    begin 
--        if(tb_clk'event and tb_clk ='0') then
--          -- Read one line from the input file to the variable "line_in" and read the value in the line "line_in" to the variable "input_mp"
--          if not(endfile(my_input)) then
--            readline(my_input, line_in);
--            read(line_in, input_tmp);
--            dum := conv_std_logic_vector(input_tmp, 16);
--            tb_U1 <= dum;
--          end if;
--      end if;
--    end process read_file2;    
--    
                 
  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "final_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum_sin   	 :		 integer range -65535 to 65535;
      variable	dum_cos   	 :		 integer range -65535 to 65535;
    begin
    dum_sin     :=  conv_integer(signed(tb_outf1));
    dum_cos     :=  conv_integer(signed(tb_outf2));
      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum_sin);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum_cos);   

       writeline(my_output, my_output_line);
      end if;
    end process write_file;end architecture arch_tb_top; -- of file_io







