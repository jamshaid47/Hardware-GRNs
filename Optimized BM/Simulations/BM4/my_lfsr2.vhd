library ieee; 

USE ieee.std_logic_arith.ALL;
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all; 


 
entity my_lfsr2 is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    out_32  : out std_logic_vector(31 downto 0)
    ); 
 end my_lfsr2; 
 
architecture beh2 of my_lfsr2 is 
 
signal reg1 : std_logic_vector(128 downto 1); 

   
begin  -- beh 

	process (clk, reset) 
	begin  -- process lfsr1 

		if clk'event and clk = '1' then  -- rising clock edge 
    		if reset = '1' then   -- asynchronous reset (active low) 
			  reg1 <= x"CDFADCFDCCADFCDADCFDCFACDDCAAFDC"; 
      else
        reg1(128) <= reg1(45) xor reg1(43) xor reg1(18) xor reg1(16); 
        reg1(127) <= reg1(44) xor reg1(42) xor reg1(17) xor reg1(15);
		    reg1(126) <= reg1(43) xor reg1(41) xor reg1(16) xor reg1(14); 
		    reg1(125) <= reg1(42) xor reg1(40) xor reg1(15) xor reg1(13);

        reg1(124) <= reg1(41) xor reg1(39) xor reg1(14) xor reg1(12); 
        reg1(123) <= reg1(40) xor reg1(38) xor reg1(13) xor reg1(11);
		    reg1(122) <= reg1(39) xor reg1(37) xor reg1(12) xor reg1(10); 
		    reg1(121) <= reg1(38) xor reg1(36) xor reg1(11) xor reg1(9);
		  
		    reg1(120) <= reg1(37) xor reg1(35) xor reg1(10) xor reg1(8); 
		    reg1(119) <=  reg1(36) xor reg1(34) xor reg1(9) xor reg1(7);
		    reg1(118) <= reg1(35) xor reg1(33) xor reg1(8) xor reg1(6); 
		    reg1(117) <= reg1(34) xor reg1(32) xor reg1(7) xor reg1(5);
		  
		    reg1(116) <= reg1(33) xor reg1(31) xor reg1(6) xor reg1(4); 
		    reg1(115) <= reg1(32) xor reg1(30) xor reg1(5) xor reg1(3);
		    reg1(114) <= reg1(31) xor reg1(29) xor reg1(4) xor reg1(2); 
		    reg1(113) <= reg1(30) xor reg1(28) xor reg1(3) xor reg1(1);
		 
		 

		 
        reg1(112) <= reg1(128); reg1(111) <= reg1(127);
        reg1(110) <= reg1(126); reg1(109) <= reg1(125);
		    reg1(108) <= reg1(124); reg1(107) <= reg1(123);
		    reg1(106) <= reg1(122); reg1(105) <= reg1(121);
		 
		    reg1(104) <= reg1(120);  reg1(103) <= reg1(119);
        reg1(102) <= reg1(118); reg1(101) <= reg1(117);
		    reg1(100) <= reg1(116); reg1(99) <= reg1(115);
		    reg1(98) <= reg1(114);  reg1(97) <= reg1(113);
		  
		    reg1(96) <= reg1(112); reg1(95) <= reg1(111);
        reg1(94) <= reg1(110); reg1(93) <= reg1(109);
		    reg1(92) <= reg1(108); reg1(91) <= reg1(107);
		    reg1(90) <= reg1(106); reg1(89) <= reg1(105);
		  
		    reg1(88) <= reg1(104); reg1(87) <= reg1(103);
        reg1(86) <= reg1(102); reg1(85) <= reg1(101);
		    reg1(84) <= reg1(100); reg1(83) <= reg1(99);
		    reg1(82) <= reg1(98);  reg1(81) <= reg1(97);
		 
		    reg1(80) <= reg1(96); reg1(79) <= reg1(95);
        reg1(78) <= reg1(94); reg1(77) <= reg1(93);
		    reg1(76) <= reg1(92); reg1(75) <= reg1(91);
		    reg1(74) <= reg1(90); reg1(73) <= reg1(89);
		  
		    reg1(72) <= reg1(88);  reg1(71) <= reg1(87);
        reg1(70) <= reg1(86); reg1(69) <= reg1(85);
		    reg1(68) <= reg1(84); reg1(67) <= reg1(83);
		    reg1(66) <= reg1(82); reg1(65) <= reg1(81);
		 
		    reg1(64) <= reg1(80); reg1(63) <= reg1(79);
        reg1(62) <= reg1(78); reg1(61) <= reg1(77);
		    reg1(60) <= reg1(76); reg1(59) <= reg1(75);
		    reg1(58) <= reg1(74); reg1(57) <= reg1(73);
		 
		    reg1(56) <= reg1(72); reg1(55) <= reg1(71);
   		   reg1(54) <= reg1(70); reg1(53) <= reg1(69);
		    reg1(52) <= reg1(68); reg1(51) <= reg1(67);
		    reg1(50) <= reg1(66); reg1(49) <= reg1(65);
		 
		    reg1(48) <= reg1(64); reg1(47) <= reg1(63);
        reg1(46) <= reg1(62); reg1(45) <=reg1(61);
		    reg1(44) <= reg1(60); reg1(43) <= reg1(59);
		    reg1(42) <= reg1(58); reg1(41) <= reg1(57);
		  
		    reg1(40) <= reg1(56); reg1(39) <= reg1(55);
		    reg1(38) <= reg1(54); reg1(37) <= reg1(53);
		    reg1(36) <= reg1(52); reg1(35) <= reg1(51);
		    reg1(34) <= reg1(50); reg1(33) <= reg1(49);

  		    reg1(32) <= reg1(48); reg1(31) <= reg1(47);
		    reg1(30) <= reg1(46); reg1(29) <= reg1(45);
		    reg1(28) <= reg1(44); reg1(27) <= reg1(43);
		    reg1(26) <= reg1(42); reg1(25) <= reg1(41);
		 
		    reg1(24) <= reg1(40); reg1(23) <= reg1(39);
		    reg1(22) <= reg1(38); reg1(21) <= reg1(37);
		    reg1(20) <= reg1(36); reg1(19) <= reg1(35);
		    reg1(18) <= reg1(34); reg1(17) <= reg1(33);
		 
		    reg1(16) <= reg1(32); reg1(15) <= reg1(31);
		    reg1(14) <= reg1(30); reg1(13) <= reg1(29);
		    reg1(12) <= reg1(28); reg1(11) <= reg1(27);
		    reg1(10) <= reg1(26); reg1(9) <= reg1(25);
		 
		    reg1(8) <= reg1(24);  reg1(7) <= reg1(23);
		    reg1(6) <= reg1(22);  reg1(5) <= reg1(21);
		    reg1(4) <= reg1(20);  reg1(3) <= reg1(19);
	      reg1(2) <= reg1(18);  reg1(1) <= reg1(17);		  
		  
        out_32<= reg1(62 downto 31); 
    		end if; 
		end if; 
	end process ; 
 
 
end beh2; 
