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
      goutf1	: out  std_logic_vector(15 downto 0);
      goutf2	: out  std_logic_vector(15 downto 0)
   );
end top;


architecture arch_top of top is

signal sout1, sout2: std_logic_vector(15 downto 0);

component adder_block is 
port
  (
    clk : in std_logic;
    in0 : in std_logic_vector(15 downto 0); 
    in1 : in std_logic_vector(15 downto 0); 
    in2 : in std_logic_vector(15 downto 0); 
    outp: out std_logic_vector(15 downto 0)); 
end component;    

component my_lfsr1 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_160  : out std_logic_vector(15 downto 0);
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0)
    ); 
 end component; 

component corr_block is 
port
  (
		clk			:	in 	std_logic;
		reset	:	in 	std_logic;
		inp			:	in 	std_logic_vector(15 downto 0);  
		outp	 :	out 	std_logic_vector (15 downto 0)
  ); 
end component; 


signal    tb_out_16_0     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_2     :  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  
    
 C1: my_lfsr1 port map(greset, gclk,  tb_out_16_0, tb_out_16_1, tb_out_16_2);
 C5: adder_block port map(gclk, tb_out_16_0, tb_out_16_1, tb_out_16_2, sout1);
 C6: corr_block port map(gclk, greset, sout1, sout2);
  
 goutf1 <= sout1; 
 goutf2 <= sout2; 

   
end architecture arch_top; 







