LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity adder_8_16 is 
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
end adder_8_16; 

architecture Behavioral of adder_8_16 is 
signal    s10 : signed(16 downto 0); 
signal    prod1, prod2 : signed(27 downto 0); 
constant  sqrt_2: signed(11 downto 0) := x"5a8"; 
begin 

process (clk) 
variable s00, s01   : signed(16 downto 0); 

  begin
	if clk'event and clk = '1' then 
		--cycle 0
		s00 := signed(in0(15)&in0) + signed(in1(15)&in1);--5.12
		s01 := signed(in2(15)&in2) + signed(in3(15)&in3);--5.12

		s10 <= (s00(16)&s00(16 downto 1)) + (s01(16)&s01(16 downto 1));--5.12

		--cycle 1
		outp16 <= std_logic_vector(s10(16 downto 1));		 --5.11
    prod1 <= s00(15 downto 0) * sqrt_2; --4.12 *1.11 = 5.23
    prod2 <= s01(15 downto 0) * sqrt_2; --4.12 *1.11 = 5.23

		--cycle 2
		outp81 <= std_logic_vector(prod1(26 downto 11));		 --4.12
		outp82 <= std_logic_vector(prod2(26 downto 11));		 --4.12
  end if;
end process;
end Behavioral; 