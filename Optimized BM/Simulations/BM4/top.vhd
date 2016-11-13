library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity tb_top is

   port 
    ( 
      gclk   : in std_logic ; 
      greset : in std_logic ; 
      goutf1	: out  std_logic_vector(15 downto 0);
      goutf2	: out  std_logic_vector(15 downto 0)
   );

   


end tb_top;

architecture arch_tb_top of tb_top is
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

component ln_sq_mac is 
port
  (
    clk : in std_logic;
    aM  : in std_logic_vector(15 downto 0); 
    aC  : in std_logic_vector(15 downto 0); 
    inp : in std_logic_vector(15 downto 0);     
	  outp: out std_logic_vector(15 downto 0)
	  ); 
end  component; 

component sin_cos is
	port 
		(
		clk			:	in 	std_logic;
		reset	      :	in 	std_logic;
		in_ang 		:	in 	std_logic_vector(15 downto 4);  
		out_sin 	   :	out 	std_logic_vector (15 downto 0);
  		out_cos 	   :	out 	std_logic_vector (15 downto 0)
		);
end  component; 

component fin_mul is 
port
  (
    clk 		: in std_logic;
    sin 		: in std_logic_vector(15 downto 0); 
    cos  	: in std_logic_vector(15 downto 0); 
    ln_sq  	: in std_logic_vector(15 downto 0); 
    outp1	: out std_logic_vector(15 downto 0); 
    outp2	: out std_logic_vector(15 downto 0)
	 );
end component; 

component my_lfsr1 is 
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_16  : out std_logic_vector(15 downto 4)
    ); 
    
end component; 

component my_lfsr2 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_32  : out std_logic_vector(31 downto 0)
    );
end component; 

signal    tb_U1    :  std_logic_vector(15 downto 4):= x"000";
signal    tb_U2    :  std_logic_vector(31 downto 0):= x"00000000";
signal    tb_M     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_C     :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_U2_tr	:  std_logic_vector(15 downto 0):= x"0000";
signal    tb_ln_sq	:  std_logic_vector(15 downto 0):= x"0000";
signal    tb_sin	  :  std_logic_vector(15 downto 0):= x"0000";
signal    tb_cos	  :  std_logic_vector(15 downto 0):= x"0000";

begin  

--Instantiate the Components  
    
 C1: my_lfsr1 port map(greset, gclk,  tb_U1);
 C2: my_lfsr2 port map(greset, gclk,  tb_U2);
 C3: ln_sq_add port map(gclk, greset, tb_U2,	tb_M,	tb_C,	tb_U2_tr);
 C4: sin_cos   port map(gclk, greset, tb_U1,	tb_sin,	tb_cos);
 C5: ln_sq_mac port map(gclk, tb_M,	tb_C,	tb_U2_tr, tb_ln_sq);
 C6: fin_mul port map(gclk, tb_sin,	tb_cos,	tb_ln_sq, goutf1, goutf2);
   
   
end architecture arch_tb_top; -- of file_io







