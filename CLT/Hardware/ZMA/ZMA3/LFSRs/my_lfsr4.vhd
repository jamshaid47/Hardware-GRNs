library ieee; 

USE ieee.std_logic_arith.ALL;
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all; 


 
entity my_lfsr4 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_161  : out std_logic_vector(15 downto 0);
    out_162  : out std_logic_vector(15 downto 0);
    out_163  : out std_logic_vector(15 downto 0)

    ); 
 end my_lfsr4; 
 
architecture beh2 of my_lfsr4 is 
 
signal reg2 : std_logic_vector(63 downto 1); 
   
begin  -- beh 

	lfsr : process (clk, reset) 
	begin  -- process lfsr1 
		if reset = '1' then                 -- asynchronous reset (active low) 
			reg2 <= '1' & '0' & '1' & x"1dabd55a468daf5"; 
	elsif clk'event and clk = '1' then  -- rising clock edge 
	
	   reg2(1) <= reg2(23) xor reg2(24);
	   reg2(2) <= reg2(24) xor reg2(25);
	   reg2(3) <= reg2(25) xor reg2(26);
	   reg2(4) <= reg2(26) xor reg2(27);
	   reg2(5) <= reg2(27) xor reg2(28);
	   reg2(6) <= reg2(28) xor reg2(29);
	   reg2(7) <= reg2(29) xor reg2(30);
	   reg2(8) <= reg2(30) xor reg2(31);
	   reg2(9) <= reg2(31) xor reg2(32);
	   reg2(10) <= reg2(32) xor reg2(33);
	   reg2(11) <= reg2(33) xor reg2(34);
	   reg2(12) <= reg2(34) xor reg2(35);
	   reg2(13) <= reg2(35) xor reg2(36);
	   reg2(14) <= reg2(36) xor reg2(37);
	   reg2(15) <= reg2(37) xor reg2(38);
	   reg2(16) <= reg2(38) xor reg2(39);
	   reg2(17) <= reg2(39) xor reg2(40);
	   reg2(18) <= reg2(40) xor reg2(41);
	   reg2(19) <= reg2(41) xor reg2(42);
	   reg2(20) <= reg2(42) xor reg2(43);
	   reg2(21) <= reg2(43) xor reg2(44);
	   reg2(22) <= reg2(44) xor reg2(45);
	   reg2(23) <= reg2(45) xor reg2(46);
	   reg2(24) <= reg2(46) xor reg2(47);
	   reg2(25) <= reg2(47) xor reg2(48);
	   reg2(26) <= reg2(48) xor reg2(49);
	   reg2(27) <= reg2(49) xor reg2(50);
	   reg2(28) <= reg2(50) xor reg2(51);
	   reg2(29) <= reg2(51) xor reg2(52);
	   reg2(30) <= reg2(52) xor reg2(53);
	   reg2(31) <= reg2(53) xor reg2(54);
	   reg2(32) <= reg2(54) xor reg2(55);
	   reg2(33) <= reg2(55) xor reg2(56);
	   reg2(34) <= reg2(56) xor reg2(57);
	   reg2(35) <= reg2(57) xor reg2(58);
	   reg2(36) <= reg2(58) xor reg2(59);
	   reg2(37) <= reg2(59) xor reg2(60);
	   reg2(38) <= reg2(60) xor reg2(61);
	   reg2(39) <= reg2(61) xor reg2(62);
	   reg2(40) <= reg2(62) xor reg2(63);
	   reg2(41) <= reg2(1);
	   reg2(42) <= reg2(2);
	   reg2(43) <= reg2(3);
	   reg2(44) <= reg2(4);
	   reg2(45) <= reg2(5);
	   reg2(46) <= reg2(6);
	   reg2(47) <= reg2(7);
	   reg2(48) <= reg2(8);
	   reg2(49) <= reg2(9);
	   reg2(50) <= reg2(10);
	   reg2(51) <= reg2(11);
	   reg2(52) <= reg2(12);
	   reg2(53) <= reg2(13);
	   reg2(54) <= reg2(14);
	   reg2(55) <= reg2(15);
	   reg2(56) <= reg2(16);
	   reg2(57) <= reg2(17);
	   reg2(58) <= reg2(18);
	   reg2(59) <= reg2(19);
	   reg2(60) <= reg2(20);
	   reg2(61) <= reg2(21);
	   reg2(62) <= reg2(22);
	   reg2(63) <= reg2(23);

	end if; 
	end process lfsr; 

	     out_161 <= reg2(14 downto 1) & reg2(48) & reg2(45); 
	     out_162 <= reg2(27 downto 15) & reg2(47) & reg2(44) & reg2(42); 
	     out_163 <= reg2(40 downto 28)& reg2(46) & reg2(41) & reg2(43);  



end beh2; 

