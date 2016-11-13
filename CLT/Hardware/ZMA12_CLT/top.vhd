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
    in3 : in std_logic_vector(15 downto 0); 
    in4 : in std_logic_vector(15 downto 0); 
    in5 : in std_logic_vector(15 downto 0); 
    in6 : in std_logic_vector(15 downto 0); 
    in7 : in std_logic_vector(15 downto 0); 
    in8 : in std_logic_vector(15 downto 0); 
    in9 : in std_logic_vector(15 downto 0); 
    in10 : in std_logic_vector(15 downto 0); 
    in11 : in std_logic_vector(15 downto 0); 
    outp: out std_logic_vector(15 downto 0)); 
end component;    

component my_lfsr1 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0)
    ); 
 end component; 

component my_lfsr2 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0)
    ); 
 end component; 

component my_lfsr3 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0)
    ); 
 end component; 

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

component corr_block is 
port
  (
		clk			:	in 	std_logic;
		reset	      :	in 	std_logic;
		inp			:	in 	std_logic_vector(15 downto 0);  
		outp	 	   :	out 	std_logic_vector (15 downto 0)
  ); 
end component; 


signal    tb_out_16_0     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_1     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_2     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_3     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_4     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_5     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_6     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_7     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_8     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_9     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_10     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_11     :  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  
    
 C1: my_lfsr1 port map(greset, gclk,  tb_out_16_0, tb_out_16_1, tb_out_16_2);
 C2: my_lfsr2 port map(greset, gclk,  tb_out_16_3, tb_out_16_4, tb_out_16_5);
 C3: my_lfsr3 port map(greset, gclk,  tb_out_16_6, tb_out_16_7, tb_out_16_8);
 C4: my_lfsr4 port map(greset, gclk,  tb_out_16_9, tb_out_16_10, tb_out_16_11);
 C5: adder_block port map(gclk, tb_out_16_0, tb_out_16_1, tb_out_16_2, tb_out_16_3, tb_out_16_4, tb_out_16_5, tb_out_16_6, tb_out_16_7,  tb_out_16_8, tb_out_16_9, tb_out_16_10, tb_out_16_11, sout1);
 C6: corr_block port map(gclk, greset, sout1, sout2);
  
 goutf1 <= sout1; 
 goutf2 <= sout2; 

   
end architecture arch_top; 







