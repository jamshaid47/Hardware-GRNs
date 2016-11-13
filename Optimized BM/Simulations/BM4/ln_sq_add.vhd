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

signal sinp, sinp1, sinp2, sinp3  : std_logic_vector(31 downto 0);

signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add1_11, add1_12, add1_13, add1_14, add1_15: signed(1 downto 0);
signal add1_16, add1_17, add1_18, add1_19, add1_20: signed(1 downto 0);
signal add5_01: signed(5 downto 0);
signal op16_1 : unsigned(15 downto 0);
signal op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(6 downto 0);
signal sadd, sadd1 :  unsigned(5 downto 0);
signal sadd_lsb :  unsigned(1 downto 0);
signal sign, sign1 : std_logic;
signal sadd3 :  unsigned(7 downto 0);


begin

process (clk, reset) 
  
variable op32 : unsigned(31 downto 0);
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

variable add3_01, add3_02, add3_03, add3_04: signed(4 downto 0);
variable add4_01, add4_02: signed(5 downto 0);


variable dum_m, dum_c :std_logic_vector(127 downto 0);
variable m_add, m_add_b   :  unsigned(6 downto 0);

variable prod1: signed(1 downto 0);
begin  -- process lfsr1 
	if clk'event and clk = '1' then  -- rising clock edge 
		if reset  ='1' then
			M_tr 	<=
			( 
      x"a7d1", x"de7b", x"ede5", x"f449", 
      x"ee11", x"f0d1", x"f32f", x"f535", 
      x"edc5", x"f090", x"f2f8", x"f506", 
      x"ed75", x"f04c", x"f2bd", x"f4d5", 
      x"ed21", x"f004", x"f280", x"f4a0", 
      x"ecc8", x"efb8", x"f23f", x"f469", 
      x"ec6a", x"ef67", x"f1fa", x"f42f", 
      x"ec06", x"ef12", x"f1b1", x"f3f1", 
      x"eb9c", x"eeb7", x"f164", x"f3af", 
      x"eb2b", x"ee56", x"f111", x"f368", 
      x"eab2", x"edef", x"f0b9", x"f31d", 
      x"ea31", x"ed80", x"f05a", x"f2cc", 
      x"e9a7", x"ed09", x"eff4", x"f274", 
      x"e911", x"ec88", x"ef86", x"f216", 
      x"e86f", x"ebfd", x"ef0e", x"f1af", 
      x"e7bf", x"eb65", x"ee8c", x"f140", 
      x"e6fe", x"eabf", x"edfd", x"f0c5", 
      x"e62b", x"ea08", x"ed5f", x"f03d", 
      x"e540", x"e93d", x"ecb0", x"efa6", 
      x"e43b", x"e85b", x"ebec", x"eefd", 
      x"e316", x"e75c", x"eb0f", x"ee3d", 
      x"e1c9", x"e63a", x"ea13", x"ed62", 
      x"e04b", x"e4ec", x"e8ef", x"ec64", 
      x"de8e", x"e365", x"e799", x"eb38", 
      x"dc7f", x"e194", x"e5ff", x"e9cf", 
      x"da00", x"df5e", x"e408", x"e811", 
      x"d6e5", x"dc96", x"e18b", x"e5d5", 
      x"d2e0", x"d8f2", x"de3e", x"e2d5", 
      x"cd62", x"d3e4", x"d992", x"de7d", 
      x"c53c", x"cc2d", x"d231", x"d75b", 
      x"b737", x"be24", x"c3cd", x"c816", 
      x"3575", x"34d3", x"3588", x"3726", 
      x"1cc4", x"1e4f", x"2022", x"2235", 
      x"124e", x"13ad", x"1531", x"16d7", 
      x"0c58", x"0d61", x"0e81", x"0fb8", 
      x"0889", x"0949", x"0a19", x"0af8", 
      x"05f8", x"0681", x"0716", x"07b5", 
      x"0432", x"0494", x"04fe", x"056e", 
      x"02f6", x"033b", x"0386", x"03d6", 
      x"0217", x"0248", x"027d", x"02b6", 
      x"017a", x"019d", x"01c2", x"01ea", 
      x"010b", x"0124", x"013e", x"015b", 
      x"00bd", x"00ce", x"00e1", x"00f5", 
      x"0086", x"0092", x"009f", x"00ad", 
      x"005e", x"0067", x"0071", x"007b", 
      x"0043", x"0049", x"0050", x"0057", 
      x"002f", x"0034", x"0038", x"0075", 
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000"
			);
      
	
			C_tr <=
			( 
      x"e20a", x"dcea", x"d9c8", x"d79c", 
      x"d63c", x"d56c", x"d497", x"d3bd", 
      x"d2e6", x"d212", x"d13a", x"d05d", 
      x"cf82", x"ceab", x"cdcf", x"ccee",
      x"cc10", x"cb35", x"ca55", x"c970", 
      x"c88f", x"c7af", x"c6cc", x"c5e3", 
      x"c4fd", x"c41a", x"c332", x"c245", 
      x"c15b", x"c074", x"bf87", x"be96",
      x"bda7", x"bcbb", x"bbca", x"bad4", 
      x"b9e1", x"b8f0", x"b7fa", x"b6fe", 
      x"b606", x"b510", x"b415", x"b314", 
      x"b216", x"b11b", x"b01a", x"af13",
      x"ae0f", x"ad0e", x"ac08", x"aafb", 
      x"a9f1", x"a8e9", x"a7dc", x"a6c9", 
      x"a5b8", x"a4aa", x"a396", x"a27b", 
      x"a163", x"a04e", x"9f32", x"9e0f",
      x"9cf0", x"9bd2", x"9aaf", x"9984", 
      x"985b", x"9736", x"9609", x"94d5", 
      x"93a3", x"9274", x"913e", x"9000", 
      x"8ec4", x"8d8a", x"8c49", x"8b00",
      x"89b9", x"8874", x"8727", x"85d1", 
      x"847d", x"832c", x"81d2", x"806e", 
      x"7f0c", x"7dac", x"7c43", x"7ad0", 
      x"795e", x"77ee", x"7674", x"74ef",
      x"736b", x"71e9", x"705b", x"6ec2", 
      x"6d29", x"6b91", x"69ed", x"683c", 
      x"668b", x"64da", x"631c", x"614f", 
      x"5f82", x"5db4", x"5bd7", x"59ea",
      x"57fc", x"560d", x"540e", x"51fe", 
      x"4fed", x"4dde", x"4bc0", x"4995", 
      x"4775", x"4566", x"4369", x"419c", 
      x"0af3", x"0b37", x"0af7", x"0a80",
      x"09e8", x"0942", x"089e", x"0800", 
      x"0766", x"06d3", x"064a", x"05cd", 
      x"0557", x"04e7", x"0482", x"0426", 
      x"03d0", x"037f", x"0336", x"02f3",
      x"02b6", x"027c", x"0248", x"0218", 
      x"01ec", x"01c3", x"019e", x"017d", 
      x"015e", x"0140", x"0126", x"010e", 
      x"00f8", x"00e4", x"00d1", x"00c0",
      x"00b1", x"00a2", x"0095", x"0089", 
      x"007e", x"0074", x"006a", x"0062", 
      x"005a", x"0053", x"004c", x"0046", 
      x"0041", x"003c", x"0037", x"0033",
      x"002f", x"002b", x"0028", x"0025", 
      x"0022", x"0020", x"001d", x"001b", 
      x"0019", x"0017", x"0016", x"0004",     
 			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000",
			x"0000", x"0000", x"0000", x"0000"
			);		
		else
			--Cycle 0
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


			--Cycle 1 
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



	
			add3_02 := ('0' & add2_03) + ('0' & add2_04);
			add3_03 := ('0' & add2_05) + ('0' & add2_06);
			add3_04 := ('0' & add2_07) + ("0000" & sinp1(31));

			--Cycle 2
			sinp2 <= sinp1;
			add5_01 <= ('0' & add3_02)+('0' & add3_03) + ('0' & add3_04);
			m_add := unsigned('0' & add5_01);
    
			--Cycle 3
			if sinp2(31) ='1' then
				sw <= m_add-31;	  
				sinp3 <= std_logic_vector(-signed(sinp2));
				sign <= '1';
			else
				sw <= 30-m_add;
				sinp3 <= sinp2;
				sign <= '0';
			end if; 

			sadd <= m_add(5 downto 0);
			op32 := SHIFT_LEFT(unsigned(sinp3), to_integer(sw));	
			op16 := op32(31 downto 16);

			--Cycle 4

  			 if op16(14 downto 7) < 152 then
		  		  sadd_lsb <= "00";
    			elsif op16(14 downto 7) < 180 then
				  sadd_lsb <= "01";
			 elsif op16(14 downto 7) < 216 then
				  sadd_lsb <= "10";
			 else 
				  sadd_lsb <= "11";
			 end if;
      
 			
			sadd1 <= sadd;
			op16_1 <= op16;
			sign1 <= sign;  

			--Cycle 5
		
			if(sign1 = '0') then
				sadd3(1 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15));
		    sadd3(7 downto 2) <=  sadd1;
        op16_2 <= op16_1;
    	else
				sadd3(1 downto 0) <= 3- sadd_lsb and not(op16_1(15)& op16_1(15));
        sadd3(7 downto 2) <=  sadd1;
        op16_2 <= op16_1;
  			end if;
   
      
			--Cycle 6
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 
		end if;
	end if;  
end process; 
 
 
end beh; 

