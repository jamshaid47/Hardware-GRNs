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
    in4 : in std_logic_vector(15 downto 0); 
    in5 : in std_logic_vector(15 downto 0); 
    in6 : in std_logic_vector(15 downto 0); 
    in7 : in std_logic_vector(15 downto 0); 
    in8 : in std_logic_vector(15 downto 0); 
    in9 : in std_logic_vector(15 downto 0); 
    in10 : in std_logic_vector(15 downto 0); 
    in11 : in std_logic_vector(15 downto 0); 
    outp: out std_logic_vector(15 downto 0)); 
end adder_block; 

architecture Behavioral of adder_block is 
signal    s10, s11, s12 : unsigned(16 downto 0); 

begin 

process (clk) 
variable s20   : unsigned(17 downto 0); 
variable    s00, s01, s02, s03, s04, s05   : unsigned(16 downto 0); 
  begin
	if clk'event and clk = '1' then 
		--cycle 0
		s00 := unsigned('0'&in0) + unsigned('0'&in1);
		s01 := unsigned('0'&in2) + unsigned('0'&in3);
		s02 := unsigned('0'&in4) + unsigned('0'&in5);
		s03 := unsigned('0'&in6) + unsigned('0'&in7);
		s04 := unsigned('0'&in8) + unsigned('0'&in9);
		s05 := unsigned('0'&in10) + unsigned('0'&in11);

		s10 <= ('0'&s00(16 downto 1)) + ('0'&s01(16 downto 1));
		s11 <= ('0'&s02(16 downto 1)) + ('0'&s03(16 downto 1));
		s12 <= ('0'&s04(16 downto 1)) + ('0'&s05(16 downto 1));
		
		--cycle 1
		s20 := ("00"&s10(16 downto 1)) + ("00"&s11(16 downto 1)) + ("00"&s12(16 downto 1));


		--cycle 3
		outp <= std_logic_vector(s20(17 downto 2));		
  end if;
end process;
end Behavioral; 