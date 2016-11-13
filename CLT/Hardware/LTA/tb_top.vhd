library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_top is 
end tb_top;

architecture arch_tb_top of tb_top is
component top is
   port 
    ( 
      gclk   : in std_logic ; 
      greset : in std_logic ; 
      goutf1	: out  std_logic_vector(15 downto 0);
      goutf2	: out  std_logic_vector(15 downto 0)

   );
end  component;    





signal    tb_clk   : std_logic := '0'; 
signal    tb_reset : std_logic := '0'; 
signal    tb_goutf1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_goutf2     :  std_logic_vector(15 downto 0):= x"0000";


begin  

--Instantiate the Components  
    
Cn: top port map(tb_clk,tb_reset, tb_goutf1, tb_goutf2);
   
   
tb_clk        <=  not(tb_clk) after 20 ns;
tb_reset      <=  '0' after 100 ns,
                    '1' after 200 ns;
    
                 
  write_file:
    process (tb_clk) is    -- write file_io.out (when done goes to '1')
      file my_output : TEXT open WRITE_MODE is "final_out.txt";
      -- above declaration should be in architecture declarations for multiple
      variable my_line : LINE;
      variable my_output_line : LINE;
      variable	dum_1   	 :		 integer range -65535 to 65535;
      variable	dum_2   	 :		 integer range -65535 to 65535;
      variable	dum_3   	 :		 integer range -65535 to 65535;
    begin
    dum_1     :=  conv_integer(signed(tb_goutf1));
    dum_2     :=  conv_integer(signed(tb_goutf2));

      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum_1);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum_2);   

       writeline(my_output, my_output_line);
      end if;
    end process write_file;end architecture arch_tb_top; -- of file_io







