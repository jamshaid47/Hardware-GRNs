library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_lfsr is 
end tb_lfsr;

architecture arch_tb_lfsr of tb_lfsr is
component my_lfsr is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_16  : out std_logic_vector(15 downto 4);
    out_32  : out std_logic_vector(31 downto 0)
    );

	end component;    


constant  period1    : time      := 20 ns; 
constant  period2    : time      := 1251 nS; 




signal    tb_clk      :  std_logic := '0'; 
signal    tb_reset    :  std_logic := '0'; 
signal    tb_out_16   :  std_logic_vector(15 downto 4):= x"000"; 
signal    tb_out_32  :  std_logic_vector(31 downto 0):= x"00000000";

begin  
  --Instantiate the Component  
 C1:my_lfsr port map(tb_reset,	tb_clk, tb_out_16,	tb_out_32);
 
 
  tb_clk        <=  not(tb_clk) after period1;
  tb_reset      <=  '1' after 100 ns,
                    '0' after 200 ns;
 
 
   write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "file_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum_up   	 :		 integer range 0 to 4096;
--      variable	dum_down 	 :		long range 0 to 4294967296;
    begin
    dum_up     :=  conv_integer(tb_out_16);
--    dum_down   :=  conv_integer(tb_out_32);
      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum_up);    
--       write(my_output_line, string'("   "));
--       write(my_output_line, dum_down);  
         
       writeline(my_output, my_output_line);
      end if;
    end process write_file;
  
end architecture arch_tb_lfsr; -- of file_io







