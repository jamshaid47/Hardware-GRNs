library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity top is
   port 
    ( 
      gclk   : in std_logic ; 
      greset : in std_logic ; 
      goutf	: out  std_logic_vector(15 downto 0)
   );
end top;


architecture arch_top of top is

component hat_mul is 
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    in_32  : in std_logic_vector(31 downto 0);
    out_16  : out std_logic_vector(15 downto 0)
    ); 
end component; 

component my_lfsr is 
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_32_1  : out std_logic_vector(31 downto 0);
    out_32_2  : out std_logic_vector(31 downto 0);
    out_32_3  : out std_logic_vector(31 downto 0);
    out_32_4  : out std_logic_vector(31 downto 0)
    ); 
 end component;  

component adder_block is 
port
  (
    clk : in std_logic;
    in0 : in std_logic_vector(15 downto 0); 
    in1 : in std_logic_vector(15 downto 0); 
    in2 : in std_logic_vector(15 downto 0); 
    in3 : in std_logic_vector(15 downto 0); 

    outp: out std_logic_vector(15 downto 0)); 
end component;

signal    tb_in32_1	  :  std_logic_vector(31 downto 0):= x"00000000";
signal    tb_in32_2	  :  std_logic_vector(31 downto 0):= x"00000000";
signal    tb_in32_3	  :  std_logic_vector(31 downto 0):= x"00000000";
signal    tb_in32_4	  :  std_logic_vector(31 downto 0):= x"00000000";

signal    tb_out1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out2     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out3     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out4     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_outf     :  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  
    
C1: my_lfsr port map(greset, gclk,  tb_in32_1,  tb_in32_2,  tb_in32_3,  tb_in32_4);
C2: hat_mul port map(greset, gclk, tb_in32_1, tb_out1);
C3: hat_mul port map(greset, gclk, tb_in32_2, tb_out2);
C4: hat_mul port map(greset, gclk, tb_in32_3, tb_out3);
C5: hat_mul port map(greset, gclk, tb_in32_4, tb_out4);
C6: adder_block port map(gclk, tb_out1, tb_out2, tb_out3, tb_out4, tb_outf);
  
goutf <= tb_outf; 
 
   
end architecture arch_top; 







