library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_top is 
end tb_top;

architecture arch_tb_top of tb_top is

component my_lfsr4 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0)
    ); 
 end component; 



signal    tb_clk   : std_logic := '0'; 
signal    tb_reset : std_logic := '0'; 
signal    tb_goutf1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_goutf2     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_goutf3     :  std_logic_vector(15 downto 0):= x"0000";



begin  

--Instantiate the Components  
    
Cn: my_lfsr4 port map(tb_reset, tb_clk, tb_goutf1, tb_goutf2, tb_goutf3);
   
   
tb_clk        <=  not(tb_clk) after 20 ns;
tb_reset      <=  '1' after 100 ns,
                  '0' after 200 ns;
    
                 
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
    dum_1     :=  conv_integer(unsigned(tb_goutf1));
    dum_2     :=  conv_integer(unsigned(tb_goutf2));
    dum_3     :=  conv_integer(unsigned(tb_goutf3));

      if(tb_clk'event and tb_clk ='1') then
       write(my_output_line, dum_1);    
       write(my_output_line, string'("   "));
       write(my_output_line, dum_2);   
       write(my_output_line, string'("   "));
       write(my_output_line, dum_3);   

       writeline(my_output, my_output_line);
      end if;
    end process write_file;end architecture arch_tb_top; -- of file_io







