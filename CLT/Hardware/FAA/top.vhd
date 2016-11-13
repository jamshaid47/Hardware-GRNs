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
      goutf41	: out  std_logic_vector(15 downto 0);
      goutf42	: out  std_logic_vector(15 downto 0);
      goutf43	: out  std_logic_vector(15 downto 0);
      goutf44	: out  std_logic_vector(15 downto 0);
      goutf81	: out  std_logic_vector(15 downto 0);
      goutf82	: out  std_logic_vector(15 downto 0);
		goutf16	: out  std_logic_vector(15 downto 0)
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
    in8 : in std_logic_vector(15 downto 0); 
    in9 : in std_logic_vector(15 downto 0); 
    in10 : in std_logic_vector(15 downto 0); 
    in11 : in std_logic_vector(15 downto 0); 
    in12 : in std_logic_vector(15 downto 0); 
    in13 : in std_logic_vector(15 downto 0); 
    in14 : in std_logic_vector(15 downto 0); 
    in15 : in std_logic_vector(15 downto 0); 
    outp1: out std_logic_vector(15 downto 0);
    outp2: out std_logic_vector(15 downto 0);
    outp3: out std_logic_vector(15 downto 0);
    outp4: out std_logic_vector(15 downto 0)
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

 component my_lfsr2 is 
 
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
		inp1			:	in 	std_logic_vector(15 downto 0);  
		inp2			:	in 	std_logic_vector(15 downto 0);  
		outp1	 :	out 	std_logic_vector (15 downto 0);
		outp2	 :	out 	std_logic_vector (15 downto 0)
		);
 end component; 		
		
component adder_8_16 is 
port
  (
    clk : in std_logic;
    in0 : in std_logic_vector(15 downto 0); 
    in1 : in std_logic_vector(15 downto 0); 
    in2 : in std_logic_vector(15 downto 0); 
    in3 : in std_logic_vector(15 downto 0); 
    outp81: out std_logic_vector(15 downto 0);
    outp82: out std_logic_vector(15 downto 0);
    outp16: out std_logic_vector(15 downto 0)
    ); 
end component;  

		
signal sin41: std_logic_vector(15 downto 0):= x"0000";
signal sin42: std_logic_vector(15 downto 0):= x"0000";
signal sin43: std_logic_vector(15 downto 0):= x"0000";
signal sin44: std_logic_vector(15 downto 0):= x"0000";

signal sout41: std_logic_vector(15 downto 0):= x"0000";
signal sout42: std_logic_vector(15 downto 0):= x"0000";
signal sout43: std_logic_vector(15 downto 0):= x"0000";
signal sout44: std_logic_vector(15 downto 0):= x"0000";

signal sout81: std_logic_vector(15 downto 0):= x"0000";
signal sout82: std_logic_vector(15 downto 0):= x"0000";

signal sout16: std_logic_vector(15 downto 0):= x"0000";

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
signal    tb_out_16_12     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_13     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_14     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_out_16_15     :  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  
    
 C1: my_lfsr port map(greset, gclk,  tb_out_16_0, tb_out_16_1, tb_out_16_2, tb_out_16_3, tb_out_16_4, tb_out_16_5, tb_out_16_6, tb_out_16_7);
 C2: my_lfsr2 port map(greset, gclk,  tb_out_16_8, tb_out_16_9, tb_out_16_10, tb_out_16_11, tb_out_16_12, tb_out_16_13, tb_out_16_14, tb_out_16_15);
 C3: adder_block port map(gclk, tb_out_16_0, tb_out_16_1, tb_out_16_2, tb_out_16_3, tb_out_16_4, tb_out_16_5, tb_out_16_6, tb_out_16_7, tb_out_16_8, tb_out_16_9, tb_out_16_10, tb_out_16_11, tb_out_16_12, tb_out_16_13, tb_out_16_14, tb_out_16_15, sin41, sin42, sin43, sin44);
 C4: corr_block port map(gclk, greset, sin41, sin42, sout41, sout42);
 C5: corr_block port map(gclk, greset, sin43, sin44, sout43, sout44);
 C6: adder_8_16 port map(gclk, sout41, sout42, sout43, sout44, sout81, sout82, sout16);
 

 goutf41 <= sout41; 
 goutf42 <= sout42; 
 goutf43 <= sout43; 
 goutf44 <= sout44; 
 goutf81 <= sout81; 
 goutf82 <= sout82; 
 goutf16 <= sout16; 

   
end architecture arch_top; 







