library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity lshift is
port (
		clk: in  std_logic; 
		inp 	 : in std_logic_vector(15 downto 0);
		sshift : in std_logic_vector(3 downto 0);
		outp 	 : out std_logic_vector(15 downto 0));
end lshift;

architecture behavior of lshift is


begin
	process (clk) 
	variable	step   	 :		 integer range 0 to 65535;
	variable	voutp, vinp 	:  bit_vector(15 downto 0);
	begin  -- process lfsr1 
		if clk'event and clk = '1' then  -- rising clock edge 
			vinp := bit_vector(inp);
			step := conv_integer(sshift);
--			outp <= inp srl step;
			outp <= std_logic_vector(voutp);
		end if;
	end process; 		
end behavior;

