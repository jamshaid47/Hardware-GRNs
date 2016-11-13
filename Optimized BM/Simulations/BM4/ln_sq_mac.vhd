LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity ln_sq_mac is 
port
  (
    clk : in std_logic;

    aM  : in std_logic_vector(15 downto 0);--4.12 (signed)  
    aC  : in std_logic_vector(15 downto 0);--3.13 (unsigned) 
    inp : in std_logic_vector(15 downto 0);--0.16 (unsigned)     
	 outp: out std_logic_vector(15 downto 0)
	 ); 
end ln_sq_mac; 

architecture Behavioral of ln_sq_mac is 
signal    Min     : signed(16 downto 0); 
signal    Cin     : signed(16 downto 0); 
signal    inpin   : signed(16 downto 0); 
signal    prod    : signed(16 downto 0); 
signal    Cin2    : signed(16 downto 0); 

begin 

process (clk) 
variable  vprod   : signed(33 downto 0); 
variable  voutp   : signed(16 downto 0); 
  begin
	if clk'event and clk = '1' then 
		--cycle 0
		Min <= signed(aM(15)& aM);
		Cin <= signed('0' & aC);
		inpin <= signed('0' & inp);

		--Cycle 1
		vprod := Min *inpin;
		Cin2 <= Cin;
		prod <= vprod(31)& vprod(31 downto 16);
		--Cycle 3
      voutp := prod + Cin2;
      outp <= std_logic_vector(voutp(15 downto 0));		
  end if;
end process;
end Behavioral; 