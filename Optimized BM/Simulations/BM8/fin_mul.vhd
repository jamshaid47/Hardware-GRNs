LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity fin_mul is 
port
  (
    clk 		: in std_logic;
    sin 		: in std_logic_vector(15 downto 0); 
    cos  	: in std_logic_vector(15 downto 0); 
    ln_sq : in std_logic_vector(15 downto 0); 
    outp1	: out std_logic_vector(15 downto 0); 
    outp2	: out std_logic_vector(15 downto 0)
	 );
end fin_mul; 

architecture Behavioral of fin_mul is 
signal    ssin   : signed(17 downto 0); 
signal    scos   : signed(17 downto 0); 
signal    sln_sq : signed(17 downto 0); 
signal    prod1  : signed(35 downto 0); 
signal    prod2  : signed(35 downto 0); 

begin 

process (clk) 
variable    vprod1  : signed(35 downto 0); 
variable    vprod2  : signed(35 downto 0); 
  begin
	if clk'event and clk = '1' then 
		--cycle 0
		ssin <= signed(sin(15)& sin(15) & sin);
		scos <= signed(cos(15)& cos(15)& cos);
		sln_sq <= signed("00" & ln_sq);

		--Cycle 1

		prod1 <= sln_sq * ssin;
		prod2 <= sln_sq * scos;
		
		vprod1 := prod1;
		vprod2 := prod2;
    

		
		--Cycle 3
    outp1 <= std_logic_vector(vprod1(31 downto 16));		
    outp2 <= std_logic_vector(vprod2(31 downto 16));		

  end if;
end process;
end Behavioral; 