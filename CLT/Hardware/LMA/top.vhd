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



component adder_block is 
port
  (
    clk : in std_logic;
    in0 : in std_logic_vector(15 downto 0); 
    in1 : in std_logic_vector(15 downto 0); 
    in2 : in std_logic_vector(15 downto 0); 
    in3 : in std_logic_vector(15 downto 0); 
    in4 : in std_logic_vector(15 downto 0); 
    in5 : in std_logic_vector(15 downto 0); 
    in6 : in std_logic_vector(15 downto 0); 
    in7 : in std_logic_vector(15 downto 0); 
    outp: out std_logic_vector(15 downto 0)
    ); 
end component;    



component my_lfsr is 
 
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0);
    out_164  : out std_logic_vector(15 downto 0);
    out_165  : out std_logic_vector(15 downto 0);
    out_166  : out std_logic_vector(15 downto 0);
    out_167  : out std_logic_vector(15 downto 0);
    out_168  : out std_logic_vector(15 downto 0)
    ); 
 end component; 

 
component corr_block is
	port 
		(
		clk	:	in 	std_logic;
		reset	:	in 	std_logic;
		inp			:	in 	std_logic_vector(15 downto 0);  
		outp	 :	out 	std_logic_vector (15 downto 0)
		);
 end component; 		
		
 

		
signal sout1: std_logic_vector(15 downto 0):= x"0000";
signal sout2: std_logic_vector(15 downto 0):= x"0000";

signal    tb_out_16_0     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_2     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_3     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_4     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_5     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_6     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_7     :  std_logic_vector(15 downto 0):= x"0000";


begin  

--Instantiate the Components  
    
 C1: my_lfsr port map(greset, gclk,  tb_out_16_0, tb_out_16_1, tb_out_16_2, tb_out_16_3, tb_out_16_4, tb_out_16_5, tb_out_16_6, tb_out_16_7);
 C2: adder_block port map(gclk, tb_out_16_0, tb_out_16_1, tb_out_16_2, tb_out_16_3, tb_out_16_4, tb_out_16_5, tb_out_16_6, tb_out_16_7, sout1);
 C3: corr_block port map(gclk, greset, sout1, sout2);
 

 goutf1 <= sout1; 
 goutf2 <= sout2; 

   
end architecture arch_top; 







