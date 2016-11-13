-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity ln_sq_add is 
   
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(31 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)
    ); 
 end ln_sq_add; 
 
architecture beh of ln_sq_add is 
 
TYPE 		data_array16 IS ARRAY (integer range <>) OF std_logic_vector(15 downto 0);
                                                                                                                                                                                                                                      
signal  	M_tr 	: 	data_array16(0 to 255);
      
signal  	C_tr 	: 	data_array16(0 to 255);		

signal sinp, sinp1, sinp2, sinp3, sinp4  : std_logic_vector(31 downto 0);

signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add1_11, add1_12, add1_13, add1_14, add1_15: signed(1 downto 0);
signal add1_16, add1_17, add1_18, add1_19, add1_20: signed(1 downto 0);
signal add5_01: signed(5 downto 0);
signal op16_1 : unsigned(15 downto 0);
signal op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(6 downto 0);
signal sadd, sadd1, sadd2 :  unsigned(5 downto 0);
signal sadd_lsb :  unsigned(1 downto 0);
signal sign, sign1, sign2 : std_logic;
signal sadd3 :  unsigned(7 downto 0);
signal add3_01, add3_02, add3_03, add3_04: signed(4 downto 0);
signal op32 : unsigned(31 downto 0);

-- signal or14 : std_logic; 



begin

process (clk, reset) 
  
variable op16 : unsigned(15 downto 0);
    
variable dumm   : integer range 0 to 1000;
--variable sadd3 :  unsigned(7 downto 0);



variable and22, and21, and20, and19, and18, and17, and16, and15: std_logic; 
variable and30, and29, and28, and27, and26, and25, and24, and23: std_logic; 

variable or08, or07, or06, or05, or04, or03, or02, or01: std_logic; 
variable or16, or15, or14, or13, or12, or11, or10, or09: std_logic; 
variable or24, or23, or22, or21, or20, or19, or18, or17: std_logic; 
variable or30, or29, or28, or27, or26, or25: std_logic; 

variable add2_01, add2_02, add2_03, add2_04, add2_05, add2_06, add2_07: signed(3 downto 0);

variable add4_01, add4_02: signed(5 downto 0);


variable dum_m, dum_c :std_logic_vector(127 downto 0);
variable m_add, m_add_b   :  unsigned(6 downto 0);

variable prod1: signed(1 downto 0);
begin  -- process lfsr1 
	if clk'event and clk = '1' then  -- rising clock edge 
		if reset  ='1' then
			M_tr 	<=
			(
			x"ca73", x"eba5", x"f501", x"f8e3", x"f51c", x"f6c8", x"f838", x"f972",
			x"f4ee", x"f6a0", x"f816", x"f956", x"f4bd", x"f677", x"f7f3", x"f938",
			x"f48a", x"f64b", x"f7cd", x"f918", x"f454", x"f61d", x"f7a6", x"f8f6",
			x"f41b", x"f5ec", x"f77c", x"f8d3", x"f3de", x"f5b8", x"f750", x"f8ad",
			x"f39e", x"f581", x"f721", x"f885", x"f359", x"f546", x"f6ef", x"f85a",
			x"f310", x"f507", x"f6b9", x"f82c", x"f2c2", x"f4c4", x"f67f", x"f7fb",
			x"f26e", x"f47c", x"f641", x"f7c6", x"f213", x"f42e", x"f5fe", x"f78d",
			x"f1b0", x"f3d9", x"f5b6", x"f74f", x"f145", x"f37d", x"f567", x"f70b",
			x"f0d0", x"f318", x"f510", x"f6c0", x"f050", x"f2a9", x"f4b0", x"f66e",
			x"efc2", x"f22e", x"f446", x"f612", x"ef23", x"f1a4", x"f3cf", x"f5ab",
			x"ee71", x"f10a", x"f349", x"f537", x"eda7", x"f05a", x"f2af", x"f4b2",
			x"ecbf", x"ef8f", x"f1fe", x"f418", x"ebb1", x"eea1", x"f12e", x"f361",
			x"ea71", x"ed87", x"f035", x"f286", x"e8ed", x"ec2f", x"ef04", x"f177",
			x"e70a", x"ea7f", x"ed81", x"f01c", x"e499", x"e849", x"eb80", x"ee4a",
			x"e143", x"e537", x"e8aa", x"eba6", x"dc50", x"e087", x"e42f", x"e751",
			x"d3cd", x"d802", x"db71", x"de0c", x"2076", x"2014", x"2082", x"217d",
			x"1178", x"1267", x"1383", x"14c6", x"0b1d", x"0bf3", x"0cde", x"0dde",
			x"077f", x"0820", x"08cf", x"098b", x"052f", x"05a3", x"0622", x"06a9",
			x"03a0", x"03f3", x"044d", x"04ae", x"028c", x"02c8", x"0308", x"034c",
			x"01cc", x"01f6", x"0224", x"0254", x"0145", x"0163", x"0183", x"01a5",
			x"00e6", x"00fb", x"0111", x"012a", x"00a2", x"00b1", x"00c1", x"00d2",
			x"0073", x"007d", x"0089", x"0095", x"0051", x"0059", x"0061", x"0069",
			x"0039", x"003f", x"0044", x"004a", x"0029", x"002c", x"0030", x"0035",
			x"001d", x"001f", x"0022", x"0047",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000"
			);
      
	
			C_tr <=		
			( 
			x"8943", x"8626", x"8440", x"82ee", x"8218", x"819a", x"8118", x"8094",
			x"8012", x"7f91", x"7f0d", x"7e87", x"7e03", x"7d80", x"7cfa", x"7c72",
			x"7beb", x"7b66", x"7ade", x"7a53", x"79ca", x"7942", x"78b8", x"782b",
			x"779f", x"7715", x"7689", x"75f9", x"756a", x"74de", x"744e", x"73bc",
			x"732b", x"729b", x"7209", x"7174", x"70e0", x"704e", x"6fb8", x"6f20",
			x"6e89", x"6df3", x"6d5b", x"6cbf", x"6c25", x"6b8c", x"6af0", x"6a51",
			x"69b3", x"6917", x"6877", x"67d4", x"6732", x"6692", x"65ef", x"6548",
			x"64a2", x"63fe", x"6356", x"62ab", x"6201", x"6158", x"60ac", x"5ffb",
			x"5f4d", x"5ea0", x"5dee", x"5d39", x"5c85", x"5bd3", x"5b1c", x"5a61",
			x"59a7", x"58ef", x"5833", x"5771", x"56b2", x"55f3", x"5530", x"5468",
			x"53a2", x"52dc", x"5212", x"5143", x"5074", x"4fa7", x"4ed5", x"4dfd",
			x"4d26", x"4c51", x"4b76", x"4a94", x"49b4", x"48d4", x"47ef", x"4702",
			x"4617", x"452c", x"443b", x"4342", x"424a", x"4152", x"4053", x"3f4c",
			x"3e45", x"3d3e", x"3c2f", x"3b17", x"39ff", x"38e7", x"37c5", x"369a",
			x"356e", x"3441", x"330b", x"31ca", x"3089", x"2f49", x"2e00", x"2caf",
			x"2b64", x"2a25", x"28ef", x"27d8", x"06a6", x"06cf", x"06a9", x"0660",
			x"0604", x"059f", x"053b", x"04dc", x"047e", x"0425", x"03d2", x"0386",
			x"033e", x"02fa", x"02bd", x"0285", x"0250", x"021f", x"01f3", x"01cb",
			x"01a5", x"0182", x"0162", x"0146", x"012b", x"0112", x"00fc", x"00e7",
			x"00d4", x"00c3", x"00b3", x"00a4", x"0097", x"008a", x"007f", x"0075",
			x"006b", x"0062", x"005a", x"0053", x"004d", x"0046", x"0041", x"003c",
			x"0037", x"0032", x"002e", x"002b", x"0027", x"0024", x"0021", x"001f",
			x"001c", x"001a", x"0018", x"0016", x"0015", x"0013", x"0012", x"0011",
			x"000f", x"000e", x"000d", x"0002", x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",	x"0000", x"0000", x"0000", x"0000"
			);		
		else
			--Cycle 1
			sinp <= inp;

			and30 := sinp(30) and sinp(31);
			and29 := sinp(29) and and30;
			and28 := sinp(28) and and29;
			and27 := sinp(27) and and28;
			and26 := sinp(26) and and27;
			and25 := sinp(25) and and26;
			and24 := sinp(24) and and25;
			and23 := sinp(23) and and24;
	
			and22 := sinp(22) and and23;
			and21 := sinp(21) and and22;
			and20 := sinp(20) and and21;
			and19 := sinp(19) and and20;
			and18 := sinp(18) and and19;
			and17 := sinp(17) and and18;
			and16 := sinp(16) and and17;

			or30 := sinp(30) or sinp(31);
			or29 := sinp(29) or or30;
			or28 := sinp(28) or or29;
			or27 := sinp(27) or or28;
			or26 := sinp(26) or or27;
			or25 := sinp(25) or or26;
			or24 := sinp(24) or or25;
			or23 := sinp(23) or or24;

			or22 := sinp(22) or or23;
			or21 := sinp(21) or or22;
			or20 := sinp(20) or or21;
			or19 := sinp(19) or or20;
			or18 := sinp(18) or or19;
			or17 := sinp(17) or or18;
			or16 := sinp(16) or or17;
			or15 := sinp(15) or or16;

			or14 := sinp(14) or or15;
			or13 := sinp(13) or or14;
			or12 := sinp(12) or or13;
			or11 := sinp(11) or or12;
			or10 := sinp(10) or or11;
			or09 := sinp(09) or or10;
			or08 := sinp(08) or or09;
			or07 := sinp(07) or or08;

			or06 := sinp(06) or or07;
			or05 := sinp(05) or or06;
			or04 := sinp(04) or or05;
			or03 := sinp(03) or or04;
			or02 := sinp(02) or or03;
			or01 := sinp(01) or or02;

			--Cycle 2
			sinp1 <= sinp;

			add1_06 <= ('0' & and16) + ('0' & and17) + ('0' & and18); 
			add1_07 <= ('0' & and19) + ('0' & and20) + ('0' & and21); 
			add1_08 <= ('0' & and22) + ('0' & and23) + ('0' & and24); 
			add1_09 <= ('0' & and25) + ('0' & and26) + ('0' & and27); 
			add1_10 <= ('0' & and28) + ('0' & and29) + ('0' & and30);
       

			add1_11 <= ('0' & or01) + ('0' & or02) + ('0' & or03);    
			add1_12 <= ('0' & or04) + ('0' & or05) + ('0' & or06); 
			add1_13 <= ('0' & or07) + ('0' & or08) + ('0' & or09); 
			add1_14 <= ('0' & or10) + ('0' & or11) + ('0' & or12); 
			add1_15 <= ('0' & or13) + ('0' & or14) + ('0' & or15); 
			add1_16 <= ('0' & or16) + ('0' & or17) + ('0' & or18); 
			add1_17 <= ('0' & or19) + ('0' & or20) + ('0' & or21); 
			add1_18 <= ('0' & or22) + ('0' & or23) + ('0' & or24); 
			add1_19 <= ('0' & or25) + ('0' & or26) + ('0' & or27); 
			add1_20 <= ('0' & or28) + ('0' & or29) + ('0' & or30); 

			add2_03 := ("00" & add1_06) + ("00" & add1_07) + ("00" & add1_08);
			add2_04 := ("00" & add1_09) + ("00" & add1_10) + ("00" & add1_11);
			add2_05 := ("00" & add1_12) + ("00" & add1_13) + ("00" & add1_14);
			add2_06 := ("00" & add1_15) + ("00" & add1_16) + ("00" & add1_17);
			add2_07 := ("00" & add1_18) + ("00" & add1_19) + ("00" & add1_20);

			--Cycle 3
			sinp2 <= sinp1;
      
	
			add3_02 <= ('0' & add2_03) + ('0' & add2_04);
			add3_03 <= ('0' & add2_05) + ('0' & add2_06);
			add3_04 <= ('0' & add2_07) + ("0000" & sinp1(31));

			--Cycle 4
			sinp3 <= sinp2;
			add5_01 <= ('0' & add3_02)+('0' & add3_03) + ('0' & add3_04);
			m_add := unsigned('0' & add5_01);
    
			--Cycle 5
			if m_add >= 31 then
				sw <= m_add-31;	  
				sinp4 <= std_logic_vector(-signed(sinp3));
				sign <= '1';
			else
				sw <= 30-m_add;
				sinp4 <= sinp3;
				sign <= '0';
			end if; 
			sadd <= m_add(5 downto 0);

			--Cycle 6
			op32 <= SHIFT_LEFT(unsigned(sinp4), to_integer(sw));	
			op16 := op32(31 downto 16);
			sadd1 <= sadd;
			sign1 <= sign;  

			--Cycle 7

  			 if op16(14 downto 7) < 152 then
		  		  sadd_lsb <= "00";
    			elsif op16(14 downto 7) < 180 then
				  sadd_lsb <= "01";
			 elsif op16(14 downto 7) < 216 then
				  sadd_lsb <= "10";
			 else 
				  sadd_lsb <= "11";
			 end if;
      
 			
			sadd2 <= sadd1;
			op16_1 <= op16;
			sign2 <= sign1;  

			--Cycle 5
		
			if(sign2 = '0') then
				sadd3(1 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15));
    	else
				sadd3(1 downto 0) <= 3- sadd_lsb and not(op16_1(15)& op16_1(15));
  			end if;
        sadd3(7 downto 2) <=  sadd2;
        op16_2 <= op16_1;
   
      
			--Cycle 6
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 
		end if;
	end if;  
end process; 
 
 
end beh; 

