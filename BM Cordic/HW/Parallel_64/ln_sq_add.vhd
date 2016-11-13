-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity ln_sq_add is 
   
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(63 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)
    ); 
 end ln_sq_add; 
 
architecture beh of ln_sq_add is 
 
TYPE 		data_array16 IS ARRAY (integer range <>) OF std_logic_vector(15 downto 0);
                                                                                                                                                                                                                                      
signal  	M_tr 	: 	data_array16(0 to 315);
      
signal  	C_tr 	: 	data_array16(0 to 315);		

signal sinp0, sinp, sinp1, sinp2, sinp3, sinp4  : std_logic_vector(63 downto 0);

signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add1_11, add1_12, add1_13, add1_14, add1_15: signed(1 downto 0);
signal add1_16, add1_17, add1_18, add1_19, add1_20: signed(1 downto 0);
signal add1_21, add1_22, add1_23, add1_24, add1_25: signed(1 downto 0);
signal add1_26, add1_27, add1_28, add1_29, add1_30, add1_31: signed(1 downto 0);


signal add5_01, add5_02, add5_dum: signed(5 downto 0);
signal op16_1 : unsigned(15 downto 0);
signal op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(6 downto 0);
signal sadd, sadd1, sadd2 :  unsigned(6 downto 0);
signal sadd_lsb :  unsigned(1 downto 0);
signal sign, sign1, sign2 : std_logic;
signal sadd3 :  unsigned(8 downto 0);

signal op64 : unsigned(63 downto 0);
signal add3_01, add3_02, add3_03, add3_04, add3_05, add3_06, add3_07: signed(4 downto 0);
signal or30: std_logic; 
begin

process (clk, reset) 
  
variable op16 : unsigned(15 downto 0);
    
variable dumm   : integer range 0 to 1000;
--variable sadd3 :  unsigned(7 downto 0);



variable and62, and61, and60, and59, and58, and57, and56, and55: std_logic; 
variable and54, and53, and52, and51, and50, and49, and48, and47: std_logic; 

variable or62, or61, or60, or59, or58, or57: std_logic; 
variable or56, or55, or54, or53, or52, or51, or50, or49: std_logic; 
variable or48, or47, or46, or45, or44, or43, or42, or41: std_logic; 
variable or40, or39, or38, or37, or36, or35, or34, or33: std_logic; 

variable or32, or31, or29, or28, or27, or26, or25: std_logic; 
variable or24, or23, or22, or21, or20, or19, or18, or17: std_logic; 
variable or16, or15, or14, or13, or12, or11, or10, or09: std_logic; 
variable or08, or07, or06, or05, or04, or03, or02, or01: std_logic; 

variable add2_01, add2_02, add2_03, add2_04, add2_05, add2_06, add2_07: signed(3 downto 0);
variable add2_08, add2_09, add2_10: signed(3 downto 0);



variable dum_m, dum_c :std_logic_vector(127 downto 0);
variable m_add, m_add_b   :  unsigned(6 downto 0);

variable prod1: signed(1 downto 0);
begin  -- process lfsr1 
	if clk'event and clk = '1' then  -- rising clock edge 
		if reset  ='1' then
	
	
	
			M_tr 	<=
			(
			x"f8c2", x"f8c2", x"fc1d", x"fd80", x"fc2f", x"fcc7", x"fd49", x"fdb8",
			x"fc27", x"fcc0", x"fd43", x"fdb3", x"fc1f", x"fcb9", x"fd3d", x"fdae",
			x"fc17", x"fcb2", x"fd37", x"fda9", x"fc0f", x"fcab", x"fd31", x"fda4",
			x"fc06", x"fca4", x"fd2b", x"fd9f", x"fbfd", x"fc9c", x"fd25", x"fd99",
			x"fbf4", x"fc94", x"fd1e", x"fd94", x"fbeb", x"fc8c", x"fd17", x"fd8e",
			x"fbe1", x"fc84", x"fd10", x"fd88", x"fbd7", x"fc7c", x"fd09", x"fd82",
			x"fbcd", x"fc73", x"fd02", x"fd7c", x"fbc2", x"fc6a", x"fcfa", x"fd76",
			x"fbb7", x"fc61", x"fcf3", x"fd6f", x"fbac", x"fc57", x"fceb", x"fd68",
			x"fba1", x"fc4e", x"fce2", x"fd61", x"fb95", x"fc44", x"fcda", x"fd5a",
			x"fb89", x"fc39", x"fcd1", x"fd53", x"fb7c", x"fc2e", x"fcc8", x"fd4b",
			x"fb6f", x"fc23", x"fcbe", x"fd43", x"fb61", x"fc18", x"fcb5", x"fd3b",
			x"fb53", x"fc0c", x"fcaa", x"fd32", x"fb45", x"fbff", x"fca0", x"fd29",
			x"fb36", x"fbf3", x"fc95", x"fd20", x"fb26", x"fbe5", x"fc8a", x"fd16",
			x"fb16", x"fbd7", x"fc7e", x"fd0c", x"fb05", x"fbc9", x"fc72", x"fd02",
			x"faf3", x"fbba", x"fc65", x"fcf7", x"fae1", x"fbaa", x"fc58", x"fcec",
			x"facd", x"fb9a", x"fc4a", x"fce0", x"fab9", x"fb89", x"fc3b", x"fcd4",
			x"faa4", x"fb77", x"fc2c", x"fcc7", x"fa8e", x"fb64", x"fc1c", x"fcb9",
			x"fa77", x"fb50", x"fc0b", x"fcab", x"fa5f", x"fb3b", x"fbf9", x"fc9c",
			x"fa45", x"fb25", x"fbe7", x"fc8c", x"fa2a", x"fb0e", x"fbd3", x"fc7b",
			x"fa0d", x"faf6", x"fbbe", x"fc69", x"f9ef", x"fadc", x"fba8", x"fc57",
			x"f9cf", x"fac0", x"fb90", x"fc43", x"f9ad", x"faa3", x"fb77", x"fc2d",
			x"f988", x"fa84", x"fb5c", x"fc16", x"f961", x"fa62", x"fb40", x"fbfe",
			x"f937", x"fa3e", x"fb21", x"fbe3", x"f909", x"fa17", x"faff", x"fbc6",
			x"f8d8", x"f9ed", x"fadb", x"fba7", x"f8a3", x"f9be", x"fab3", x"fb85",
			x"f868", x"f98c", x"fa88", x"fb60", x"f828", x"f954", x"fa58", x"fb37",
			x"f7e1", x"f917", x"fa23", x"fb09", x"f792", x"f8d2", x"f9e7", x"fad6",
			x"f739", x"f885", x"f9a4", x"fa9c", x"f6d4", x"f82d", x"f958", x"fa59",
			x"f660", x"f7c7", x"f8ff", x"fa0c", x"f5d8", x"f751", x"f897", x"f9b1",
			x"f538", x"f6c3", x"f81b", x"f943", x"f476", x"f617", x"f782", x"f8bc",
			x"f385", x"f53f", x"f6c1", x"f80e", x"f24c", x"f424", x"f5c0", x"f725",
			x"f0a2", x"f29c", x"f455", x"f5d3", x"ee28", x"f044", x"f217", x"f3a9",
			x"e9e6", x"ec01", x"edb9", x"ef06", x"103b", x"100a", x"1041", x"10be",
			x"08bc", x"0934", x"09c2", x"0a63", x"058f", x"05f9", x"066f", x"06ef",
			x"03bf", x"0410", x"0467", x"04c6", x"0297", x"02d2", x"0311", x"0355",
			x"01d0", x"01fa", x"0227", x"0257", x"0146", x"0164", x"0184", x"01a6",
			x"00e6", x"00fb", x"0112", x"012a", x"00a2", x"00b1", x"00c1", x"00d3",
			x"0073", x"007d", x"0089", x"0095", x"0051", x"0059", x"0061", x"0069",
			x"0039", x"003f", x"0044", x"004a", x"0029", x"002c", x"0030", x"0035",
			x"001d", x"001f", x"0022", x"0025", x"0014", x"0016", x"0018", x"001a",
			x"000e", x"0010", x"0011", x"0024"
			);
      
	
			C_tr <=		
			( 
			x"8947", x"ba68", x"b90b", x"b81a", x"b782", x"b728", x"b6cd", x"b66f",
			x"b613", x"b5b9", x"b55d", x"b4ff", x"b4a2", x"b447", x"b3ea", x"b38b",
			x"b32e", x"b2d2", x"b274", x"b214", x"b1b6", x"b159", x"b0fb", x"b09b",
			x"b03c", x"afde", x"af7f", x"af1e", x"aebe", x"ae5f", x"adff", x"ad9d",
			x"ad3d", x"acde", x"ac7d", x"ac1a", x"abb8", x"ab58", x"aaf7", x"aa93",
			x"aa31", x"a9d0", x"a96d", x"a908", x"a8a5", x"a843", x"a7e0", x"a77a",
			x"a716", x"a6b3", x"a64f", x"a5e8", x"a583", x"a520", x"a4ba", x"a453",
			x"a3ed", x"a388", x"a321", x"a2b9", x"a252", x"a1ec", x"a185", x"a11b",
			x"a0b3", x"a04c", x"9fe4", x"9f79", x"9f10", x"9ea8", x"9e3f", x"9dd3",
			x"9d69", x"9d00", x"9c95", x"9c28", x"9bbd", x"9b53", x"9ae7", x"9a79",
			x"9a0c", x"99a1", x"9934", x"98c5", x"9857", x"97eb", x"977d", x"970c",
			x"969d", x"962f", x"95c0", x"954e", x"94de", x"946f", x"93fe", x"938b",
			x"9319", x"92a9", x"9237", x"91c2", x"914f", x"90dd", x"906a", x"8ff4",
			x"8f7f", x"8f0c", x"8e97", x"8e1f", x"8da9", x"8d35", x"8cbe", x"8c45",
			x"8bcd", x"8b57", x"8adf", x"8a64", x"89eb", x"8973", x"88f9", x"887d",
			x"8802", x"8789", x"870d", x"868f", x"8612", x"8597", x"8519", x"8499",
			x"841b", x"839e", x"831f", x"829c", x"821c", x"819d", x"811c", x"8098",
			x"8015", x"7f94", x"7f11", x"7e8b", x"7e06", x"7d83", x"7cfe", x"7c75",
			x"7bee", x"7b69", x"7ae1", x"7a57", x"79ce", x"7946", x"78bc", x"782e",
			x"77a3", x"7719", x"768c", x"75fc", x"756e", x"74e1", x"7452", x"73bf",
			x"732e", x"729f", x"720d", x"7177", x"70e3", x"7051", x"6fbc", x"6f23",
			x"6e8c", x"6df7", x"6d5f", x"6cc3", x"6c28", x"6b90", x"6af4", x"6a54",
			x"69b6", x"691a", x"687b", x"67d8", x"6736", x"6696", x"65f3", x"654b",
			x"64a6", x"6402", x"635a", x"62ae", x"6204", x"615c", x"60b0", x"5fff",
			x"5f50", x"5ea3", x"5df2", x"5d3d", x"5c89", x"5bd6", x"5b20", x"5a64",
			x"59ab", x"58f3", x"5836", x"5775", x"56b5", x"55f7", x"5534", x"546c",
			x"53a5", x"52e0", x"5216", x"5146", x"5078", x"4fab", x"4ed9", x"4e01",
			x"4d2a", x"4c54", x"4b79", x"4a98", x"49b7", x"48d8", x"47f2", x"4706",
			x"461a", x"4530", x"443e", x"4345", x"424d", x"4156", x"4057", x"3f4f",
			x"3e49", x"3d42", x"3c33", x"3b1b", x"3a03", x"38ea", x"37c9", x"369d",
			x"3571", x"3445", x"330f", x"31ce", x"308d", x"2f4c", x"2e04", x"2cb3",
			x"2b68", x"2a28", x"28f3", x"27db", x"06a6", x"06cf", x"06a9", x"065e",
			x"0602", x"059d", x"0539", x"04d9", x"047c", x"0422", x"03d0", x"0384",
			x"033c", x"02f8", x"02bb", x"0283", x"024e", x"021d", x"01f1", x"01c9",
			x"01a3", x"0180", x"0160", x"0144", x"0129", x"0110", x"00f9", x"00e5",
			x"00d2", x"00c0", x"00b0", x"00a2", x"0095", x"0088", x"007d", x"0073",
			x"0069", x"0060", x"0058", x"0051", x"004a", x"0044", x"003e", x"0039",
			x"0035", x"0030", x"002c", x"0029", x"0025", x"0022", x"001f", x"001d",
			x"001a", x"0018", x"0016", x"0014", x"0013", x"0011", x"0010", x"000e",
			x"000d", x"000c", x"000b", x"0000"
			);		
		else
			--Cycle 1
			sinp <= inp;

			--Cycle 2
			and62 := sinp(62) and sinp(63);
			and61 := sinp(61) and and62;
			and60 := sinp(60) and and61;
			and59 := sinp(59) and and60;
			and58 := sinp(58) and and59;
			and57 := sinp(57) and and58;
			and56 := sinp(56) and and57;
			and55 := sinp(55) and and56;
	
			and54 := sinp(54) and and55;
			and53 := sinp(53) and and54;
			and52 := sinp(52) and and53;
			and51 := sinp(51) and and52;
			and50 := sinp(50) and and51;
			and49 := sinp(49) and and50;
			and48 := sinp(48) and and49;

			or62 := sinp(62) or sinp(63);
			or61 := sinp(61) or or62;
			or60 := sinp(60) or or61;
			or59 := sinp(59) or or60;
			or58 := sinp(58) or or59;
			or57 := sinp(57) or or58;
			or56 := sinp(56) or or57;
			or55 := sinp(55) or or56;
	
			or54 := sinp(54) or or55;
			or53 := sinp(53) or or54;
			or52 := sinp(52) or or53;
			or51 := sinp(51) or or52;
			or50 := sinp(50) or or51;
			or49 := sinp(49) or or50;
			or48 := sinp(48) or or49;
			or47 := sinp(47) or or48;

			or46 := sinp(46) or or47;
			or45 := sinp(45) or or46;
			or44 := sinp(44) or or45;
			or43 := sinp(43) or or44;
			or42 := sinp(42) or or43;
			or41 := sinp(41) or or42;
			or40 := sinp(40) or or41;
			or39 := sinp(39) or or40;

			or38 := sinp(38) or or39;
			or37 := sinp(37) or or38;
			or36 := sinp(36) or or37;
			or35 := sinp(35) or or36;
			or34 := sinp(34) or or35;
			or33 := sinp(33) or or34;
			or32 := sinp(32) or or33;
			or31 := sinp(31) or or32;
			sinp0 <= sinp;

			--Cycle 3 
			add1_06 <= ('0' & and48) + ('0' & and49) + ('0' & and50); 
			add1_07 <= ('0' & and51) + ('0' & and52) + ('0' & and53); 
			add1_08 <= ('0' & and54) + ('0' & and55) + ('0' & and56); 
			add1_09 <= ('0' & and57) + ('0' & and58) + ('0' & and59); 
			add1_10 <= ('0' & and60) + ('0' & and61) + ('0' & and62);
			
 			add1_21 <= ('0' & or31) + ('0' & or32) + ('0' & or33);    
			add1_22 <= ('0' & or34) + ('0' & or35) + ('0' & or36); 
			add1_23 <= ('0' & or37) + ('0' & or38) + ('0' & or39); 
			add1_24 <= ('0' & or40) + ('0' & or41) + ('0' & or42); 
			add1_25 <= ('0' & or43) + ('0' & or44) + ('0' & or45); 
			add1_26 <= ('0' & or46) + ('0' & or47) + ('0' & or48); 
			add1_27 <= ('0' & or49) + ('0' & or50) + ('0' & or51); 
			add1_28 <= ('0' & or52) + ('0' & or53) + ('0' & or54); 
			add1_29 <= ('0' & or55) + ('0' & or56) + ('0' & or57); 
			add1_30 <= ('0' & or58) + ('0' & or59) + ('0' & or60); 
			add1_31 <= ('0' & or61) + ('0' & or62);       

			add2_01 := ("00" & add1_06) + ("00" & add1_07) + ("00" & add1_08);
			add2_02 := ("00" & add1_09) + ("00" & add1_10); 
			add2_03 := ("00" & add1_21) + ("00" & add1_22) + ("00" & add1_23);
			add2_04 := ("00" & add1_24) + ("00" & add1_25) + ("00" & add1_26); 
			add2_05 := ("00" & add1_27) + ("00" & add1_28) + ("00" & add1_29); 
			add2_06 := ("00" & add1_30) + ("00" & add1_31) ; --5
			
			or30 <= sinp(30) or or31;
			or29 := sinp0(29) or or30;
			or28 := sinp0(28) or or29;
			or27 := sinp0(27) or or28;
			or26 := sinp0(26) or or27;
			or25 := sinp0(25) or or26;
			or24 := sinp0(24) or or25;
			or23 := sinp0(23) or or24;

			or22 := sinp0(22) or or23;
			or21 := sinp0(21) or or22;
			or20 := sinp0(20) or or21;
			or19 := sinp0(19) or or20;
			or18 := sinp0(18) or or19;
			or17 := sinp0(17) or or18;
			or16 := sinp0(16) or or17;
			or15 := sinp0(15) or or16;

			or14 := sinp0(14) or or15;
			or13 := sinp0(13) or or14;
			or12 := sinp0(12) or or13;
			or11 := sinp0(11) or or12;
			or10 := sinp0(10) or or11;
			or09 := sinp0(09) or or10;
			or08 := sinp0(08) or or09;
			or07 := sinp0(07) or or08;

			or06 := sinp0(06) or or07;
			or05 := sinp0(05) or or06;
			or04 := sinp0(04) or or05;
			or03 := sinp0(03) or or04;
			or02 := sinp0(02) or or03;
			or01 := sinp0(01) or or02;

			sinp1 <= sinp0;
			--Cycle 4 

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

      

			add2_07 := ("00" & add1_11); 
			add2_08 := ("00" & add1_12) + ("00" & add1_13) + ("00" & add1_14);
			add2_09 := ("00" & add1_15) + ("00" & add1_16) + ("00" & add1_17);
			add2_10 := ("00" & add1_18) + ("00" & add1_19) + ("00" & add1_20); 

			add3_01 <= ('0' & add2_01) + ('0' & add2_02); 
			add3_02 <= ('0' & add2_03) + ('0' & add2_04); 
			add3_03 <= ('0' & add2_05) + ('0' & add2_06); 

			sinp2 <= sinp1;

			--Cycle 5

			add3_04 <= ('0' & add2_07); 
			add3_05 <= ('0' & add2_08) + ('0' & add2_09); 
			add3_06 <= ('0' & add2_10)+ ("0000" & sinp2(63)); 

			add5_01 <= ('0' & add3_01)+('0' & add3_02) + ('0' & add3_03);

			sinp3 <= sinp2;

			--Cycle 6
			add5_02 <= ('0' & add3_04)+('0' & add3_05) + ('0' & add3_06); 
			add5_dum <= add5_01;
			
			m_add := unsigned(('0' & add5_dum) + ('0' & add5_02));
    
			if m_add >= 63 then
				sw <= m_add-63;	  
				sinp4 <= std_logic_vector(-signed(sinp3));
				sign <= '1';
			else
				sw <= 62-m_add;
				sinp4 <= sinp3;
				sign <= '0';
			end if; 

			sadd <= m_add;

			--Cycle 7
			op64 <= SHIFT_LEFT(unsigned(sinp4), to_integer(sw));	
			op16 := op64(63 downto 48);
			sadd1 <= sadd;
			sign1 <= sign;  

			--Cycle 8
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

			--Cycle 9
		
			if(sign2 = '0') then
				sadd3(1 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15));
    	 else
				sadd3(1 downto 0) <= 3- sadd_lsb and not(op16_1(15)& op16_1(15));
  			end if;
      sadd3(8 downto 2) <=  sadd2;
      op16_2 <= op16_1;
   
      
			--Cycle 10
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 
		end if;
	end if;  
end process; 
 
 
end beh; 

