-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity cal_bins is 
   
 port 
    ( 
    clk    : in  std_logic; 
    reset  : in  std_logic; 
    inp    : in  std_logic_vector(16 downto 0);
    strobe : out  std_logic; 
    outp   : out std_logic_vector(31 downto 0)
    ); 
 end cal_bins; 
 
architecture beh of cal_bins is 
 
TYPE 		data_array32 IS ARRAY (integer range <>) OF unsigned(31 downto 0);
signal  	bins 	: 	data_array32(0 to 63);

signal counter : unsigned(31 downto 0);
signal adr, adr1 : unsigned(5 downto 0);
signal sstrb : std_logic; 


begin

process (clk, reset) 
  
variable op32 : unsigned(31 downto 0);
variable op16 : unsigned(15 downto 0);

begin  -- process lfsr1 
	if clk'event and clk = '1' then  -- rising clock edge 
		if reset  ='1' then
			bins 	<=
			( 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", 
      x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000" 
			);
      counter <= x"00000000";
			sstrb <= '0';
      adr <= "000000";
 		else
		  adr <= unsigned(inp(15 downto 10));
		  counter <= counter + 1;
			bins(to_integer(adr)) <= bins(to_integer(adr)) + 1;
			
			if(counter >= 10000065) then
			  sstrb <= '0';
			elsif(counter >= 10000000) then
			  sstrb <= '1';
			 end if;
		end if;
	end if;  
end process;

 
process (sstrb, clk) 
  

begin  -- process lfsr1 
	if clk'event and clk = '1' then 
		if sstrb  ='1' then
		  adr1 <= adr1 + 1;
			outp <= std_logic_vector(bins(to_integer(adr1)));
			strobe <= '1';
		else
		  adr1 <= "000000";
			strobe <= '0';
			outp <= x"00000000";
		 end if;
	end if;
end process; 
 

 
end beh; 

