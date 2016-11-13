library ieee; 

USE ieee.std_logic_arith.ALL;
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all; 


 
entity my_lfsr is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_32_1  : out std_logic_vector(31 downto 0);
    out_32_2  : out std_logic_vector(31 downto 0);
    out_32_3  : out std_logic_vector(31 downto 0);
    out_32_4  : out std_logic_vector(31 downto 0)
     ); 
 end my_lfsr; 
 
architecture beh2 of my_lfsr is 
 
signal reg1 : std_logic_vector(130 downto 1); 
signal reg2 : std_logic_vector(130 downto 1); 
   
begin  -- beh 

	lfsr : process (clk, reset) 
	begin  -- process lfsr1 
		if reset = '1' then                 -- asynchronous reset (active low) 
			reg2 <= '0' & '0' & x"123456789bdefa2154acbd55a468daf5"; 
	elsif clk'event and clk = '1' then  -- rising clock edge 
	
	

	   reg2(1) <= reg2(8) xor reg2(11);
	   reg2(2) <= reg2(9) xor reg2(12);
	   reg2(3) <= reg2(10) xor reg2(13);
	   reg2(4) <= reg2(11) xor reg2(14);
	   reg2(5) <= reg2(12) xor reg2(15);
	   reg2(6) <= reg2(13) xor reg2(16);
	   reg2(7) <= reg2(14) xor reg2(17);
	   reg2(8) <= reg2(15) xor reg2(18);
	   reg2(9) <= reg2(16) xor reg2(19);
	   reg2(10) <= reg2(17) xor reg2(20);
	   reg2(11) <= reg2(18) xor reg2(21);
	   reg2(12) <= reg2(19) xor reg2(22);
	   reg2(13) <= reg2(20) xor reg2(23);
	   reg2(14) <= reg2(21) xor reg2(24);
	   reg2(15) <= reg2(22) xor reg2(25);
	   reg2(16) <= reg2(23) xor reg2(26);
	   reg2(17) <= reg2(24) xor reg2(27);
	   reg2(18) <= reg2(25) xor reg2(28);
	   reg2(19) <= reg2(26) xor reg2(29);
	   reg2(20) <= reg2(27) xor reg2(30);
	   reg2(21) <= reg2(28) xor reg2(31);
	   reg2(22) <= reg2(29) xor reg2(32);
	   reg2(23) <= reg2(30) xor reg2(33);
	   reg2(24) <= reg2(31) xor reg2(34);
	   reg2(25) <= reg2(32) xor reg2(35);
	   reg2(26) <= reg2(33) xor reg2(36);
	   reg2(27) <= reg2(34) xor reg2(37);
	   reg2(28) <= reg2(35) xor reg2(38);
	   reg2(29) <= reg2(36) xor reg2(39);
	   reg2(30) <= reg2(37) xor reg2(40);
	   reg2(31) <= reg2(38) xor reg2(41);
	   reg2(32) <= reg2(39) xor reg2(42);
	   reg2(33) <= reg2(40) xor reg2(43);
	   reg2(34) <= reg2(41) xor reg2(44);
	   reg2(35) <= reg2(42) xor reg2(45);
	   reg2(36) <= reg2(43) xor reg2(46);
	   reg2(37) <= reg2(44) xor reg2(47);
	   reg2(38) <= reg2(45) xor reg2(48);
	   reg2(39) <= reg2(46) xor reg2(49);
	   reg2(40) <= reg2(47) xor reg2(50);
	   reg2(41) <= reg2(48) xor reg2(51);
	   reg2(42) <= reg2(49) xor reg2(52);
	   reg2(43) <= reg2(50) xor reg2(53);
	   reg2(44) <= reg2(51) xor reg2(54);
	   reg2(45) <= reg2(52) xor reg2(55);
	   reg2(46) <= reg2(53) xor reg2(56);
	   reg2(47) <= reg2(54) xor reg2(57);
	   reg2(48) <= reg2(55) xor reg2(58);
	   reg2(49) <= reg2(56) xor reg2(59);
	   reg2(50) <= reg2(57) xor reg2(60);
	   reg2(51) <= reg2(58) xor reg2(61);
	   reg2(52) <= reg2(59) xor reg2(62);
	   reg2(53) <= reg2(60) xor reg2(63);
	   reg2(54) <= reg2(61) xor reg2(64);
	   reg2(55) <= reg2(62) xor reg2(65);
	   reg2(56) <= reg2(63) xor reg2(66);
	   reg2(57) <= reg2(64) xor reg2(67);
	   reg2(58) <= reg2(65) xor reg2(68);
	   reg2(59) <= reg2(66) xor reg2(69);
	   reg2(60) <= reg2(67) xor reg2(70);
	   reg2(61) <= reg2(68) xor reg2(71);
	   reg2(62) <= reg2(69) xor reg2(72);
	   reg2(63) <= reg2(70) xor reg2(73);
	   reg2(64) <= reg2(71) xor reg2(74);
	   reg2(65) <= reg2(72) xor reg2(75);
	   reg2(66) <= reg2(73) xor reg2(76);
	   reg2(67) <= reg2(74) xor reg2(77);
	   reg2(68) <= reg2(75) xor reg2(78);
	   reg2(69) <= reg2(76) xor reg2(79);
	   reg2(70) <= reg2(77) xor reg2(80);
	   reg2(71) <= reg2(78) xor reg2(81);
	   reg2(72) <= reg2(79) xor reg2(82);
	   reg2(73) <= reg2(80) xor reg2(83);
	   reg2(74) <= reg2(81) xor reg2(84);
	   reg2(75) <= reg2(82) xor reg2(85);
	   reg2(76) <= reg2(83) xor reg2(86);
	   reg2(77) <= reg2(84) xor reg2(87);
	   reg2(78) <= reg2(85) xor reg2(88);
	   reg2(79) <= reg2(86) xor reg2(89);
	   reg2(80) <= reg2(87) xor reg2(90);
	   reg2(81) <= reg2(88) xor reg2(91);
	   reg2(82) <= reg2(89) xor reg2(92);
	   reg2(83) <= reg2(90) xor reg2(93);
	   reg2(84) <= reg2(91) xor reg2(94);
	   reg2(85) <= reg2(92) xor reg2(95);
	   reg2(86) <= reg2(93) xor reg2(96);
	   reg2(87) <= reg2(94) xor reg2(97);
	   reg2(88) <= reg2(95) xor reg2(98);
	   reg2(89) <= reg2(96) xor reg2(99);
	   reg2(90) <= reg2(97) xor reg2(100);
	   reg2(91) <= reg2(98) xor reg2(101);
	   reg2(92) <= reg2(99) xor reg2(102);
	   reg2(93) <= reg2(100) xor reg2(103);
	   reg2(94) <= reg2(101) xor reg2(104);
	   reg2(95) <= reg2(102) xor reg2(105);
	   reg2(96) <= reg2(103) xor reg2(106);
	   reg2(97) <= reg2(104) xor reg2(107);
	   reg2(98) <= reg2(105) xor reg2(108);
	   reg2(99) <= reg2(106) xor reg2(109);
	   reg2(100) <= reg2(107) xor reg2(110);
	   reg2(101) <= reg2(108) xor reg2(111);
	   reg2(102) <= reg2(109) xor reg2(112);
	   reg2(103) <= reg2(110) xor reg2(113);
	   reg2(104) <= reg2(111) xor reg2(114);
	   reg2(105) <= reg2(112) xor reg2(115);
	   reg2(106) <= reg2(113) xor reg2(116);
	   reg2(107) <= reg2(114) xor reg2(117);
	   reg2(108) <= reg2(115) xor reg2(118);
	   reg2(109) <= reg2(116) xor reg2(119);
	   reg2(110) <= reg2(117) xor reg2(120);
	   reg2(111) <= reg2(118) xor reg2(121);
	   reg2(112) <= reg2(119) xor reg2(122);
	   reg2(113) <= reg2(120) xor reg2(123);
	   reg2(114) <= reg2(121) xor reg2(124);
	   reg2(115) <= reg2(122) xor reg2(125);
	   reg2(116) <= reg2(123) xor reg2(126);
	   reg2(117) <= reg2(124) xor reg2(127);
	   reg2(118) <= reg2(125) xor reg2(128);
	   reg2(119) <= reg2(126) xor reg2(129);
	   reg2(120) <= reg2(127) xor reg2(130);
	   reg2(121) <= reg2(1);
	   reg2(122) <= reg2(2);
	   reg2(123) <= reg2(3);
	   reg2(124) <= reg2(4);
	   reg2(125) <= reg2(5);
	   reg2(126) <= reg2(6);
	   reg2(127) <= reg2(7);
	   reg2(128) <= reg2(8);
	   reg2(129) <= reg2(9);
	   reg2(130) <= reg2(10);

		end if; 
	end process lfsr; 

	     out_32_1 <= reg2(32 downto 1); 
	     out_32_2 <= reg2(64 downto 33); 
	     out_32_3 <= reg2(96 downto 65); 
	     out_32_4 <= reg2(128 downto 97); 


end beh2; 

