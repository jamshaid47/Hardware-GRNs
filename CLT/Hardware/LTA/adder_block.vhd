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
    in12 : in std_logic_vector(15 downto 0); 
    in13 : in std_logic_vector(15 downto 0); 
    in14 : in std_logic_vector(15 downto 0); 
    in15 : in std_logic_vector(15 downto 0); 
    outp: out std_logic_vector(15 downto 0)
    ); 
end adder_block; 

architecture Behavioral of adder_block is 
signal    s10, s11, s12, s13 : signed(16 downto 0); 
signal    s30 : signed(16 downto 0); 

begin 

process (clk) 
variable s20, s21   : signed(16 downto 0); 
variable    s00, s01, s02, s03, s04, s05, s06, s07   : signed(16 downto 0); 
  begin
	if clk'event and clk = '1' then 
		--cycle 0
		s00 := signed(in0(15)&in0) + signed(in1(15)&in1);
		s01 := signed(in2(15)&in2) + signed(in3(15)&in3);
		s02 := signed(in4(15)&in4) + signed(in5(15)&in5);
		s03 := signed(in6(15)&in6) + signed(in7(15)&in7);
		s04 := signed(in8(15)&in8) + signed(in9(15)&in9);
		s05 := signed(in10(15)&in10) + signed(in11(15)&in11);
		s06 := signed(in12(15)&in12) + signed(in13(15)&in13);
		s07 := signed(in14(15)&in14) + signed(in15(15)&in15); --2.15

		s10 <= (s00(16)&s00(16 downto 1)) + (s01(16)&s01(16 downto 1));
		s11 <= (s02(16)&s02(16 downto 1)) + (s03(16)&s03(16 downto 1));
		s12 <= (s04(16)&s04(16 downto 1)) + (s05(16)&s05(16 downto 1));
		s13 <= (s06(16)&s06(16 downto 1)) + (s07(16)&s07(16 downto 1)); --3.14
		
		--cycle 1
		s20 := (s10(16)&s10(16 downto 1)) + (s11(16)&s11(16 downto 1)) ;
		s21 := (s12(16)&s12(16 downto 1)) + (s13(16)&s13(16 downto 1)) ; --4.13


		s30 <= (s20(16)&s20(16 downto 1)) + (s21(16)&s21(16 downto 1));  --5.12

		--cycle 3
		outp <= std_logic_vector(s30(16 downto 1));		 --5.11
  end if;
end process;
end Behavioral; 