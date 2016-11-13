LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity adder_block is 
port
  (
    clk : in std_logic;
    in0 : in std_logic_vector(15 downto 0); 
    in1 : in std_logic_vector(15 downto 0); 
    in2 : in std_logic_vector(15 downto 0); 
    in3 : in std_logic_vector(15 downto 0); 

    outp: out std_logic_vector(15 downto 0)); 
end adder_block; 

architecture Behavioral of adder_block is 
signal    s10 : signed(16 downto 0); 

begin 

process (clk) 
variable    s00, s01 : signed(16 downto 0); 
  begin
	if clk'event and clk = '1' then 
		--cycle 0
		s00 := signed(in0(15)&in0) + signed(in1(15)&in1);
		s01 := signed(in2(15)&in2) + signed(in3(15)&in3);


		s10 <= (s00(16)&s00(16 downto 1)) + (s01(16)&s01(16 downto 1));
		
		--cycle 1
		outp <= std_logic_vector(s10(16 downto 1));		
  end if;
end process;
end Behavioral; 