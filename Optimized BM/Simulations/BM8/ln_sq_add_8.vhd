
-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 




 
entity ln_sq_add_8 is 
   
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(31 downto 0);
	 M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)
    ); 
 end ln_sq_add_8; 
 
architecture beh of ln_sq_add_8 is 
 
TYPE 		data_array16 IS ARRAY (integer range <>) OF std_logic_vector(15 downto 0);
                                                                                                                                                                                                                                      
signal  	C_tr 	: 	data_array16(0 to 495);
      
signal  	M_tr 	: 	data_array16(0 to 495);		

signal sinp, sinp1, sinp2, sinp3   : std_logic_vector(31 downto 0);
-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 




 
entity ln_sq_add_8 is 
   
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(31 downto 0);
	 M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)
    ); 
 end ln_sq_add_8; 
 
architecture beh of ln_sq_add_8 is 
 
TYPE 		data_array16 IS ARRAY (integer range <>) OF std_logic_vector(15 downto 0);
                                                                                                                                                                                                                                      
signal  	C_tr 	: 	data_array16(0 to 495);
      
signal  	M_tr 	: 	data_array16(0 to 495);		

signal sinp, sinp1, sinp2, sinp3   : std_logic_vector(31 downto 0);

signal add1_01, add1_02, add1_03, add1_04, add1_05: signed(1 downto 0);
signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add1_11, add1_12, add1_13, add1_14, add1_15: signed(1 downto 0);
signal add1_16, add1_17, add1_18, add1_19, add1_20: signed(1 downto 0);
signal add5_01: signed(5 downto 0);
signal op16_1,op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(6 downto 0);
signal sadd, sadd1 :  unsigned(5 downto 0) := "000000";
signal sadd_lsb :  unsigned(2 downto 0) := "000";
signal sign,sign1 : std_logic;
signal sadd3 :  unsigned(8 downto 0) := "000000000";
signal test1 :  unsigned(8 downto 3) ;
signal test2 :  unsigned(2 downto 0) ;


begin

process (clk) 
  
variable op32 : unsigned(31 downto 0);
variable op16 : unsigned(15 downto 0);
    
variable dumm   : integer range 0 to 1000;

variable and08, and07, and06, and05, and04, and03, and02, and01: std_logic; 
variable and16, and15, and14, and13, and12, and11, and10, and09: std_logic; 
variable and24, and23, and22, and21, and20, and19, and18, and17: std_logic; 
variable and30, and29, and28, and27, and26, and25: std_logic; 

variable or08, or07, or06, or05, or04, or03, or02, or01: std_logic; 
variable or16, or15, or14, or13, or12, or11, or10, or09: std_logic; 
variable or24, or23, or22, or21, or20, or19, or18, or17: std_logic; 
variable or30, or29, or28, or27, or26, or25: std_logic; 
variable vadd_lsb :  unsigned(2 downto 0);



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
      x"8000", x"efbd", x"f142", x"f283", x"f392", x"f478", x"f53f", x"f5ed", 
      x"ed94", x"ef7a", x"f104", x"f24b", x"f35e", x"f448", x"f512", x"f5c3",
      x"ed45", x"ef34", x"f0c4", x"f210", x"f327", x"f415", x"f4e3", x"f596", 
      x"ecf3", x"eee9", x"f081", x"f1d2", x"f2ed", x"f3df", x"f4b0", x"f567",
      x"ec9d", x"ee9b", x"f039", x"f190", x"f2b1", x"f3a7", x"f47c", x"f535", 
      x"ec41", x"ee49", x"efee", x"f14b", x"f271", x"f36b", x"f444", x"f500",
      x"ebe1", x"edf2", x"ef9f", x"f102", x"f22d", x"f32c", x"f409", x"f4c9", 
      x"eb7a", x"ed95", x"ef4a", x"f0b4", x"f1e5", x"f2e9", x"f3ca", x"f48e",
      x"eb0e", x"ed33", x"eef1", x"f062", x"f199", x"f2a2", x"f387", x"f44f", 
      x"ea9a", x"ecca", x"ee91", x"f00a", x"f147", x"f256", x"f340", x"f40c",
      x"ea1e", x"ec5b", x"ee2b", x"efac", x"f0f0", x"f204", x"f2f3", x"f3c4", 
      x"e99a", x"ebe3", x"edbe", x"ef47", x"f092", x"f1ad", x"f2a1", x"f377",
      x"e90c", x"eb62", x"ed48", x"eeda", x"f02d", x"f14f", x"f249", x"f324", 
      x"e872", x"ead7", x"ecc9", x"ee65", x"efc1", x"f0e9", x"f1ea", x"f2ca",
      x"e7cc", x"ea41", x"ec3f", x"ede6", x"ef4a", x"f07b", x"f182", x"f268", 
      x"e718", x"e99d", x"eba9", x"ed5c", x"eeca", x"f002", x"f111", x"f1fd",
      x"e653", x"e8ea", x"eb05", x"ecc4", x"ee3c", x"ef7e", x"f095", x"f188", 
      x"e57a", x"e825", x"ea50", x"ec1d", x"eda1", x"eeed", x"f00b", x"f106",
      x"e48a", x"e74b", x"e988", x"eb63", x"ecf4", x"ee4a", x"ef73", x"f076", 
      x"e37f", x"e657", x"e8a8", x"ea94", x"ec32", x"ed95", x"eec8", x"efd4",
      x"e253", x"e546", x"e7ac", x"e9aa", x"eb58", x"ecc8", x"ee06", x"ef1d", 
      x"e0fe", x"e40f", x"e68d", x"e89f", x"ea5f", x"ebdd", x"ed29", x"ee4b",
      x"df78", x"e2a9", x"e542", x"e76b", x"e93e", x"eace", x"ec28", x"ed57", 
      x"ddb1", x"e108", x"e3c0", x"e603", x"e7eb", x"e98e", x"eaf9", x"ec36",
      x"db97", x"df18", x"e1f3", x"e454", x"e656", x"e80e", x"e98c", x"eadb", 
      x"d90b", x"dcbe", x"dfc2", x"e244", x"e464", x"e636", x"e7ca", x"e92c",
      x"d5e1", x"d9cd", x"dd00", x"dfab", x"e1ec", x"e3dc", x"e58a", x"e704", 
      x"d1cb", x"d5f9", x"d964", x"dc3d", x"dea6", x"e0b9", x"e285", x"e419",
      x"cc3a", x"d0b4", x"d45e", x"d76b", x"da02", x"dc3a", x"de27", x"dfd7", 
      x"c3ff", x"c8c7", x"ccae", x"cfec", x"d2a8", x"d4fe", x"d702", x"d8c3",
      x"b5f5", x"bacc", x"bea5", x"c1bc", x"c43c", x"c640", x"c7dc", x"c91f", 
      x"35ef", x"3545", x"34e2", x"34c6", x"34f1", x"356b", x"363e", x"3779",
      x"1c5a", x"1cdd", x"1d76", x"1e2b", x"1eff", x"1ffb", x"2127", x"2293", 
      x"11eb", x"1267", x"12f2", x"138f", x"1443", x"1512", x"1603", x"1720",
      x"0c0c", x"0c6b", x"0cd5", x"0d4b", x"0dd1", x"0e6b", x"0f1c", x"0fed", 
      x"0852", x"0897", x"08e3", x"0939", x"099a", x"0a08", x"0a88", x"0b1f",
      x"05d0", x"0602", x"0639", x"0676", x"06bb", x"070a", x"0765", x"07d0", 
      x"0416", x"043a", x"0461", x"048c", x"04bd", x"04f5", x"0536", x"0582",
      x"02e2", x"02fb", x"0316", x"0335", x"0358", x"0380", x"03ae", x"03e3", 
      x"0209", x"021b", x"022e", x"0244", x"025d", x"0279", x"0299", x"02bf",
      x"0170", x"017d", x"018a", x"019a", x"01ab", x"01bf", x"01d6", x"01f1", 
      x"0104", x"010d", x"0117", x"0122", x"012e", x"013c", x"014c", x"015f",      
      x"00b8", x"00be", x"00c5", x"00cd", x"00d6", x"00e0", x"00eb", x"00f8", 
      x"0082", x"0086", x"008b", x"0091", x"0097", x"009e", x"00a6", x"00b0",
      x"005c", x"005f", x"0063", x"0066", x"006b", x"0070", x"0076", x"007c", 
      x"0041", x"0043", x"0046", x"0048", x"004c", x"004f", x"0053", x"0058",
      x"002e", x"0030", x"0031", x"0033", x"0035", x"0038", x"003b", x"003e", 
      x"0021", x"0022", x"0023", x"0024", x"0026", x"0028", x"002a", x"002c",
      x"0017", x"0018", x"0019", x"001a", x"001b", x"001c", x"001d", x"001f", 
      x"0010", x"0011", x"0011", x"0012", x"0013", x"0014", x"0015", x"0016",
      x"000b", x"000c", x"000c", x"000d", x"000d", x"000e", x"000f", x"0010", 
      x"0008", x"0008", x"0009", x"0009", x"0009", x"000a", x"000a", x"000b",
      x"0006", x"0006", x"0006", x"0006", x"0007", x"0007", x"0007", x"0008", 
      x"0004", x"0004", x"0004", x"0005", x"0005", x"0005", x"0005", x"0005",
      x"0003", x"0003", x"0003", x"0003", x"0003", x"0003", x"0004", x"0004", 
      x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0003", x"0003",
      x"0001", x"0001", x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000"
			);
      
	
			C_tr <=
			( 
      x"ffff", x"d924", x"d8ab", x"d83c", x"d7d7", x"d779", x"d722", x"d6d0", 
      x"d662", x"d5d9", x"d55e", x"d4ee", x"d487", x"d428", x"d3cf", x"d37c",
      x"d30c", x"d281", x"d204", x"d192", x"d12a", x"d0c9", x"d06f", x"d01b", 
      x"cfa9", x"cf1c", x"ce9c", x"ce29", x"cdbe", x"cd5c", x"cd00", x"ccab",
      x"cc37", x"cba8", x"cb26", x"cab0", x"ca44", x"c9e0", x"c983", x"c92c", 
      x"c8b6", x"c824", x"c7a1", x"c729", x"c6ba", x"c655", x"c5f6", x"c59e",
      x"c526", x"c491", x"c40b", x"c391", x"c321", x"c2b9", x"c258", x"c1fe", 
      x"c184", x"c0ed", x"c064", x"bfe8", x"bf75", x"bf0c", x"bea9", x"be4d",
      x"bdd1", x"bd36", x"bcab", x"bc2c", x"bbb8", x"bb4c", x"bae8", x"ba8a", 
      x"ba0b", x"b96d", x"b8df", x"b85e", x"b7e7", x"b779", x"b712", x"b6b3",
      x"b631", x"b590", x"b4ff", x"b47b", x"b401", x"b391", x"b328", x"b2c7", 
      x"b242", x"b19e", x"b109", x"b082", x"b006", x"af93", x"af28", x"aec4",
      x"ae3c", x"ad94", x"acfc", x"ac72", x"abf3", x"ab7d", x"ab10", x"aaa9", 
      x"aa1e", x"a972", x"a8d7", x"a849", x"a7c7", x"a74e", x"a6de", x"a675",
      x"a5e7", x"a536", x"a496", x"a405", x"a37f", x"a304", x"a291", x"a225", 
      x"a193", x"a0dd", x"a03a", x"9fa4", x"9f1b", x"9e9c", x"9e26", x"9db7",
      x"9d21", x"9c66", x"9bbe", x"9b24", x"9a97", x"9a14", x"999a", x"9928", 
      x"988e", x"97ce", x"9720", x"9682", x"95f0", x"956a", x"94ec", x"9477",
      x"93d7", x"9311", x"925e", x"91ba", x"9124", x"9099", x"9017", x"8f9e", 
      x"8ef9", x"8e2c", x"8d73", x"8cca", x"8c2e", x"8b9e", x"8b18", x"8a9a",
      x"89f0", x"891b", x"885b", x"87ac", x"870b", x"8675", x"85ea", x"8568", 
      x"84b6", x"83da", x"8312", x"825c", x"81b4", x"8119", x"8088", x"8000",
      x"7f47", x"7e61", x"7d92", x"7cd3", x"7c24", x"7b82", x"7aeb", x"7a5d", 
      x"799c", x"78ab", x"77d2", x"770b", x"7654", x"75a9", x"750b", x"7476",
      x"73ab", x"72af", x"71cb", x"70f9", x"7039", x"6f86", x"6ede", x"6e42", 
      x"6d6c", x"6c62", x"6b71", x"6a94", x"69c8", x"690b", x"685a", x"67b4",
      x"66d2", x"65b8", x"64b8", x"63cd", x"62f4", x"622b", x"616f", x"60be", 
      x"5fcd", x"5ea0", x"5d8f", x"5c94", x"5bac", x"5ad5", x"5a0c", x"594e",
      x"584c", x"570a", x"55e5", x"54d8", x"53e0", x"52f9", x"5221", x"5157", 
      x"5042", x"4eea", x"4db2", x"4c95", x"4b8e", x"4a9b", x"49ba", x"48e7",
      x"47cb", x"466f", x"453b", x"442b", x"433b", x"426a", x"41b5", x"411e", 
      x"0ab6", x"0b05", x"0b31", x"0b3c", x"0b2c", x"0b02", x"0ac0", x"0a68",
      x"0a19", x"09db", x"0998", x"094f", x"08ff", x"08a9", x"084b", x"07e5", 
      x"0794", x"075a", x"071d", x"06dd", x"069a", x"0653", x"0607", x"05b7",
      x"0579", x"054d", x"051e", x"04ee", x"04bc", x"0487", x"0450", x"0415", 
      x"03e7", x"03c7", x"03a6", x"0383", x"035e", x"0338", x"0310", x"02e6",
      x"02c6", x"02ae", x"0297", x"027e", x"0264", x"0249", x"022c", x"020e", 
      x"01f7", x"01e6", x"01d5", x"01c4", x"01b1", x"019e", x"018a", x"0174",
      x"0164", x"0158", x"014c", x"0140", x"0132", x"0125", x"0117", x"0107", 
      x"00fc", x"00f3", x"00eb", x"00e2", x"00d9", x"00cf", x"00c5", x"00ba",
      x"00b2", x"00ac", x"00a6", x"00a0", x"0099", x"0092", x"008b", x"0084", 
      x"007e", x"007a", x"0076", x"0071", x"006c", x"0068", x"0063", x"005d",
      x"0059", x"0056", x"0053", x"0050", x"004d", x"0049", x"0046", x"0042", 
      x"003f", x"003d", x"003b", x"0039", x"0036", x"0034", x"0031", x"002f",
      x"002d", x"002b", x"002a", x"0028", x"0026", x"0025", x"0023", x"0021", 
      x"001f", x"001e", x"001d", x"001c", x"001b", x"001a", x"0019", x"0017",
      x"0016", x"0016", x"0015", x"0014", x"0013", x"0012", x"0011", x"0010", 
      x"0010", x"000f", x"000f", x"000e", x"000e", x"000d", x"000c", x"000c",
      x"000b", x"000b", x"000a", x"000a", x"000a", x"0009", x"0009", x"0008", 
      x"0008", x"0008", x"0007", x"0007", x"0007", x"0006", x"0006", x"0006",
      x"0006", x"0005", x"0005", x"0005", x"0005", x"0005", x"0004", x"0004", 
      x"0004", x"0004", x"0004", x"0004", x"0003", x"0003", x"0003", x"0003",
      x"0003", x"0003", x"0003", x"0002", x"0002", x"0002", x"0002", x"0002", 
      x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000"
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
      and15 := sinp(15) and and16;

      and14 := sinp(14) and and15;
      and13 := sinp(13) and and14;
      and12 := sinp(12) and and13;
      and11 := sinp(11) and and12;
      and10 := sinp(10) and and11;
      and09 := sinp(09) and and10;
      and08 := sinp(08) and and09;
      and07 := sinp(07) and and08;

      and06 := sinp(06) and and07;
      and05 := sinp(05) and and06;
      and04 := sinp(04) and and05;
      and03 := sinp(03) and and04;
      and02 := sinp(02) and and03;
      and01 := sinp(01) and and02;

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
      add1_01 <= ('0' & and01) + ('0' & and02) +('0' & and03);    
      add1_02 <= ('0' & and04) + ('0' & and05) +('0' & and06); 
      add1_03 <= ('0' & and07) + ('0' & and08) +('0' & and09); 
      add1_04 <= ('0' & and10) + ('0' & and11) +('0' & and12); 
      add1_05 <= ('0' & and13) + ('0' & and14) +('0' & and15); 
      add1_06 <= ('0' & and16) + ('0' & and17) +('0' & and18); 
      add1_07 <= ('0' & and19) + ('0' & and20) +('0' & and21); 
      add1_08 <= ('0' & and22) + ('0' & and23) +('0' & and24); 
      add1_09 <= ('0' & and25) + ('0' & and26) +('0' & and27); 
      add1_10 <= ('0' & and28) + ('0' & and29) +('0' & and30);
       

      add1_11 <= ('0' & or01) + ('0' & or02) +('0' & or03);    
      add1_12 <= ('0' & or04) + ('0' & or05) +('0' & or06); 
      add1_13 <= ('0' & or07) + ('0' & or08) +('0' & or09); 
      add1_14 <= ('0' & or10) + ('0' & or11) +('0' & or12); 
      add1_15 <= ('0' & or13) + ('0' & or14) +('0' & or15); 
      add1_16 <= ('0' & or16) + ('0' & or17) +('0' & or18); 
      add1_17 <= ('0' & or19) + ('0' & or20) +('0' & or21); 
      add1_18 <= ('0' & or22) + ('0' & or23) +('0' & or24); 
      add1_19 <= ('0' & or25) + ('0' & or26) +('0' & or27); 
      add1_20 <= ('0' & or28) + ('0' & or29) +('0' & or30); 
      


		
		add2_01 := ("00" & add1_01) + ("00" & add1_02) + ("00" & add1_03);
		add2_02 := ("00" & add1_04) + ("00" & add1_05) + ("00" & add1_06);
		add2_03 := ("00" & add1_07) + ("00" & add1_08) + ("00" & add1_09);
		add2_04 := ("00" & add1_10) + ("00" & add1_11) + ("00" & add1_12);
		add2_05 := ("00" & add1_13) + ("00" & add1_14) + ("00" & add1_15);
		add2_06 := ("00" & add1_16) + ("00" & add1_17) + ("00" & add1_18);
		add2_07 := ("00" & add1_19) + ("00" & add1_20) ;



		add3_01 := ('0' & add2_01) + ('0' & add2_02);
		add3_02 := ('0' & add2_03) + ('0' & add2_04);
		add3_03 := ('0' & add2_05) + ('0' & add2_06);
		add3_04 := ('0' & add2_07) + ("0000" & sinp1(31)); 

		add4_01 := ('0' & add3_01) + ('0' & add3_02); 
		add4_02 := ('0' & add3_03) + ('0' & add3_04);

		--Cycle 2 
		sinp2 <= sinp1;
	  add5_01 <= add4_01 + add4_02 ;
    m_add := unsigned('0' & add5_01);
    

		--Cycle 3
		if m_add >= 31 then
			sw <= m_add-31;	  
		  sinp3 <= std_logic_vector(signed(not(sinp2))+1);
		  sign <= '1';
		else
			sw <= 30-m_add;
		  sinp3 <= sinp2;
		  sign <= '0';
		end if; 

		sadd <= m_add(5 downto 0);
		op32 := SHIFT_LEFT(unsigned(sinp3), to_integer(sw));	
		op16 := op32(31 downto 16);
		vadd_lsb := (not(op16_1(15)& op16_1(15)& op16_1(15)));
		
		
		--Cycle 4
    sadd_lsb <= op16(13 downto 11);
		sadd1 <= sadd;
		op16_1 <= op16;
		sign1 <= sign;  

			--Cycle 5
		
			if(sign1 = '0') then
				sadd3(2 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15)& op16_1(15));
		    sadd3(8 downto 3) <=  sadd1;
        op16_2 <= op16_1;
    	else
				sadd3(2 downto 0) <= 7- sadd_lsb and not(op16_1(15)& op16_1(15)& op16_1(15));
        sadd3(8 downto 3) <=  sadd1;
        op16_2 <= op16_1;
  			end if;
   
      
			--Cycle 6
			test1 <= sadd3(8 downto 3);
			test2 <= sadd3(2 downto 0);
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 









		
		
--		--Cycle 4
--		if sign = '1' then
--			sadd_lsb <= 7 - (unsigned(op16(13 downto 11)) and vadd_lsb);--and not(op16_1(15)& op16_1(15)& op16_1(15));
--		else
--			sadd_lsb <= op16(13 downto 11) and vadd_lsb;--and not(op16_1(15)& op16_1(15)& op16_1(15);
--		end if;
--
--		sadd1 <= sadd;
--		op16_1 <= op16;
--    
--		sadd3(8 downto 3) := sadd1;
--		sadd3(2 downto 0) := sadd_lsb;
--   
--   
--		--Cycle 5
--		outp <= std_logic_vector(op16_1); 
--		M <= M_tr(to_integer(sadd3));
--		C <= C_tr(to_integer(sadd3));
		end if;  
	end if;  

end process; 
 
 
end beh; 



signal add1_01, add1_02, add1_03, add1_04, add1_05: signed(1 downto 0);
signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add1_11, add1_12, add1_13, add1_14, add1_15: signed(1 downto 0);
signal add1_16, add1_17, add1_18, add1_19, add1_20: signed(1 downto 0);
signal add5_01: signed(5 downto 0);
signal op16_1,op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(6 downto 0);
signal sadd, sadd1 :  unsigned(5 downto 0) := "000000";
signal sadd_lsb :  unsigned(2 downto 0) := "000";
signal sign,sign1 : std_logic;
signal sadd3 :  unsigned(8 downto 0) := "000000000";
signal test1 :  unsigned(8 downto 3) ;
signal test2 :  unsigned(2 downto 0) ;


begin

process (clk) 
  
variable op32 : unsigned(31 downto 0);
variable op16 : unsigned(15 downto 0);
    
variable dumm   : integer range 0 to 1000;

variable and08, and07, and06, and05, and04, and03, and02, and01: std_logic; 
variable and16, and15, and14, and13, and12, and11, and10, and09: std_logic; 
variable and24, and23, and22, and21, and20, and19, and18, and17: std_logic; 
variable and30, and29, and28, and27, and26, and25: std_logic; 

variable or08, or07, or06, or05, or04, or03, or02, or01: std_logic; 
variable or16, or15, or14, or13, or12, or11, or10, or09: std_logic; 
variable or24, or23, or22, or21, or20, or19, or18, or17: std_logic; 
variable or30, or29, or28, or27, or26, or25: std_logic; 
variable vadd_lsb :  unsigned(2 downto 0);



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
      x"8000", x"efbd", x"f142", x"f283", x"f392", x"f478", x"f53f", x"f5ed", 
      x"ed94", x"ef7a", x"f104", x"f24b", x"f35e", x"f448", x"f512", x"f5c3",
      x"ed45", x"ef34", x"f0c4", x"f210", x"f327", x"f415", x"f4e3", x"f596", 
      x"ecf3", x"eee9", x"f081", x"f1d2", x"f2ed", x"f3df", x"f4b0", x"f567",
      x"ec9d", x"ee9b", x"f039", x"f190", x"f2b1", x"f3a7", x"f47c", x"f535", 
      x"ec41", x"ee49", x"efee", x"f14b", x"f271", x"f36b", x"f444", x"f500",
      x"ebe1", x"edf2", x"ef9f", x"f102", x"f22d", x"f32c", x"f409", x"f4c9", 
      x"eb7a", x"ed95", x"ef4a", x"f0b4", x"f1e5", x"f2e9", x"f3ca", x"f48e",
      x"eb0e", x"ed33", x"eef1", x"f062", x"f199", x"f2a2", x"f387", x"f44f", 
      x"ea9a", x"ecca", x"ee91", x"f00a", x"f147", x"f256", x"f340", x"f40c",
      x"ea1e", x"ec5b", x"ee2b", x"efac", x"f0f0", x"f204", x"f2f3", x"f3c4", 
      x"e99a", x"ebe3", x"edbe", x"ef47", x"f092", x"f1ad", x"f2a1", x"f377",
      x"e90c", x"eb62", x"ed48", x"eeda", x"f02d", x"f14f", x"f249", x"f324", 
      x"e872", x"ead7", x"ecc9", x"ee65", x"efc1", x"f0e9", x"f1ea", x"f2ca",
      x"e7cc", x"ea41", x"ec3f", x"ede6", x"ef4a", x"f07b", x"f182", x"f268", 
      x"e718", x"e99d", x"eba9", x"ed5c", x"eeca", x"f002", x"f111", x"f1fd",
      x"e653", x"e8ea", x"eb05", x"ecc4", x"ee3c", x"ef7e", x"f095", x"f188", 
      x"e57a", x"e825", x"ea50", x"ec1d", x"eda1", x"eeed", x"f00b", x"f106",
      x"e48a", x"e74b", x"e988", x"eb63", x"ecf4", x"ee4a", x"ef73", x"f076", 
      x"e37f", x"e657", x"e8a8", x"ea94", x"ec32", x"ed95", x"eec8", x"efd4",
      x"e253", x"e546", x"e7ac", x"e9aa", x"eb58", x"ecc8", x"ee06", x"ef1d", 
      x"e0fe", x"e40f", x"e68d", x"e89f", x"ea5f", x"ebdd", x"ed29", x"ee4b",
      x"df78", x"e2a9", x"e542", x"e76b", x"e93e", x"eace", x"ec28", x"ed57", 
      x"ddb1", x"e108", x"e3c0", x"e603", x"e7eb", x"e98e", x"eaf9", x"ec36",
      x"db97", x"df18", x"e1f3", x"e454", x"e656", x"e80e", x"e98c", x"eadb", 
      x"d90b", x"dcbe", x"dfc2", x"e244", x"e464", x"e636", x"e7ca", x"e92c",
      x"d5e1", x"d9cd", x"dd00", x"dfab", x"e1ec", x"e3dc", x"e58a", x"e704", 
      x"d1cb", x"d5f9", x"d964", x"dc3d", x"dea6", x"e0b9", x"e285", x"e419",
      x"cc3a", x"d0b4", x"d45e", x"d76b", x"da02", x"dc3a", x"de27", x"dfd7", 
      x"c3ff", x"c8c7", x"ccae", x"cfec", x"d2a8", x"d4fe", x"d702", x"d8c3",
      x"b5f5", x"bacc", x"bea5", x"c1bc", x"c43c", x"c640", x"c7dc", x"c91f", 
      x"35ef", x"3545", x"34e2", x"34c6", x"34f1", x"356b", x"363e", x"3779",
      x"1c5a", x"1cdd", x"1d76", x"1e2b", x"1eff", x"1ffb", x"2127", x"2293", 
      x"11eb", x"1267", x"12f2", x"138f", x"1443", x"1512", x"1603", x"1720",
      x"0c0c", x"0c6b", x"0cd5", x"0d4b", x"0dd1", x"0e6b", x"0f1c", x"0fed", 
      x"0852", x"0897", x"08e3", x"0939", x"099a", x"0a08", x"0a88", x"0b1f",
      x"05d0", x"0602", x"0639", x"0676", x"06bb", x"070a", x"0765", x"07d0", 
      x"0416", x"043a", x"0461", x"048c", x"04bd", x"04f5", x"0536", x"0582",
      x"02e2", x"02fb", x"0316", x"0335", x"0358", x"0380", x"03ae", x"03e3", 
      x"0209", x"021b", x"022e", x"0244", x"025d", x"0279", x"0299", x"02bf",
      x"0170", x"017d", x"018a", x"019a", x"01ab", x"01bf", x"01d6", x"01f1", 
      x"0104", x"010d", x"0117", x"0122", x"012e", x"013c", x"014c", x"015f",      
      x"00b8", x"00be", x"00c5", x"00cd", x"00d6", x"00e0", x"00eb", x"00f8", 
      x"0082", x"0086", x"008b", x"0091", x"0097", x"009e", x"00a6", x"00b0",
      x"005c", x"005f", x"0063", x"0066", x"006b", x"0070", x"0076", x"007c", 
      x"0041", x"0043", x"0046", x"0048", x"004c", x"004f", x"0053", x"0058",
      x"002e", x"0030", x"0031", x"0033", x"0035", x"0038", x"003b", x"003e", 
      x"0021", x"0022", x"0023", x"0024", x"0026", x"0028", x"002a", x"002c",
      x"0017", x"0018", x"0019", x"001a", x"001b", x"001c", x"001d", x"001f", 
      x"0010", x"0011", x"0011", x"0012", x"0013", x"0014", x"0015", x"0016",
      x"000b", x"000c", x"000c", x"000d", x"000d", x"000e", x"000f", x"0010", 
      x"0008", x"0008", x"0009", x"0009", x"0009", x"000a", x"000a", x"000b",
      x"0006", x"0006", x"0006", x"0006", x"0007", x"0007", x"0007", x"0008", 
      x"0004", x"0004", x"0004", x"0005", x"0005", x"0005", x"0005", x"0005",
      x"0003", x"0003", x"0003", x"0003", x"0003", x"0003", x"0004", x"0004", 
      x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0003", x"0003",
      x"0001", x"0001", x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000"
			);
      
	
			C_tr <=
			( 
      x"ffff", x"d924", x"d8ab", x"d83c", x"d7d7", x"d779", x"d722", x"d6d0", 
      x"d662", x"d5d9", x"d55e", x"d4ee", x"d487", x"d428", x"d3cf", x"d37c",
      x"d30c", x"d281", x"d204", x"d192", x"d12a", x"d0c9", x"d06f", x"d01b", 
      x"cfa9", x"cf1c", x"ce9c", x"ce29", x"cdbe", x"cd5c", x"cd00", x"ccab",
      x"cc37", x"cba8", x"cb26", x"cab0", x"ca44", x"c9e0", x"c983", x"c92c", 
      x"c8b6", x"c824", x"c7a1", x"c729", x"c6ba", x"c655", x"c5f6", x"c59e",
      x"c526", x"c491", x"c40b", x"c391", x"c321", x"c2b9", x"c258", x"c1fe", 
      x"c184", x"c0ed", x"c064", x"bfe8", x"bf75", x"bf0c", x"bea9", x"be4d",
      x"bdd1", x"bd36", x"bcab", x"bc2c", x"bbb8", x"bb4c", x"bae8", x"ba8a", 
      x"ba0b", x"b96d", x"b8df", x"b85e", x"b7e7", x"b779", x"b712", x"b6b3",
      x"b631", x"b590", x"b4ff", x"b47b", x"b401", x"b391", x"b328", x"b2c7", 
      x"b242", x"b19e", x"b109", x"b082", x"b006", x"af93", x"af28", x"aec4",
      x"ae3c", x"ad94", x"acfc", x"ac72", x"abf3", x"ab7d", x"ab10", x"aaa9", 
      x"aa1e", x"a972", x"a8d7", x"a849", x"a7c7", x"a74e", x"a6de", x"a675",
      x"a5e7", x"a536", x"a496", x"a405", x"a37f", x"a304", x"a291", x"a225", 
      x"a193", x"a0dd", x"a03a", x"9fa4", x"9f1b", x"9e9c", x"9e26", x"9db7",
      x"9d21", x"9c66", x"9bbe", x"9b24", x"9a97", x"9a14", x"999a", x"9928", 
      x"988e", x"97ce", x"9720", x"9682", x"95f0", x"956a", x"94ec", x"9477",
      x"93d7", x"9311", x"925e", x"91ba", x"9124", x"9099", x"9017", x"8f9e", 
      x"8ef9", x"8e2c", x"8d73", x"8cca", x"8c2e", x"8b9e", x"8b18", x"8a9a",
      x"89f0", x"891b", x"885b", x"87ac", x"870b", x"8675", x"85ea", x"8568", 
      x"84b6", x"83da", x"8312", x"825c", x"81b4", x"8119", x"8088", x"8000",
      x"7f47", x"7e61", x"7d92", x"7cd3", x"7c24", x"7b82", x"7aeb", x"7a5d", 
      x"799c", x"78ab", x"77d2", x"770b", x"7654", x"75a9", x"750b", x"7476",
      x"73ab", x"72af", x"71cb", x"70f9", x"7039", x"6f86", x"6ede", x"6e42", 
      x"6d6c", x"6c62", x"6b71", x"6a94", x"69c8", x"690b", x"685a", x"67b4",
      x"66d2", x"65b8", x"64b8", x"63cd", x"62f4", x"622b", x"616f", x"60be", 
      x"5fcd", x"5ea0", x"5d8f", x"5c94", x"5bac", x"5ad5", x"5a0c", x"594e",
      x"584c", x"570a", x"55e5", x"54d8", x"53e0", x"52f9", x"5221", x"5157", 
      x"5042", x"4eea", x"4db2", x"4c95", x"4b8e", x"4a9b", x"49ba", x"48e7",
      x"47cb", x"466f", x"453b", x"442b", x"433b", x"426a", x"41b5", x"411e", 
      x"0ab6", x"0b05", x"0b31", x"0b3c", x"0b2c", x"0b02", x"0ac0", x"0a68",
      x"0a19", x"09db", x"0998", x"094f", x"08ff", x"08a9", x"084b", x"07e5", 
      x"0794", x"075a", x"071d", x"06dd", x"069a", x"0653", x"0607", x"05b7",
      x"0579", x"054d", x"051e", x"04ee", x"04bc", x"0487", x"0450", x"0415", 
      x"03e7", x"03c7", x"03a6", x"0383", x"035e", x"0338", x"0310", x"02e6",
      x"02c6", x"02ae", x"0297", x"027e", x"0264", x"0249", x"022c", x"020e", 
      x"01f7", x"01e6", x"01d5", x"01c4", x"01b1", x"019e", x"018a", x"0174",
      x"0164", x"0158", x"014c", x"0140", x"0132", x"0125", x"0117", x"0107", 
      x"00fc", x"00f3", x"00eb", x"00e2", x"00d9", x"00cf", x"00c5", x"00ba",
      x"00b2", x"00ac", x"00a6", x"00a0", x"0099", x"0092", x"008b", x"0084", 
      x"007e", x"007a", x"0076", x"0071", x"006c", x"0068", x"0063", x"005d",
      x"0059", x"0056", x"0053", x"0050", x"004d", x"0049", x"0046", x"0042", 
      x"003f", x"003d", x"003b", x"0039", x"0036", x"0034", x"0031", x"002f",
      x"002d", x"002b", x"002a", x"0028", x"0026", x"0025", x"0023", x"0021", 
      x"001f", x"001e", x"001d", x"001c", x"001b", x"001a", x"0019", x"0017",
      x"0016", x"0016", x"0015", x"0014", x"0013", x"0012", x"0011", x"0010", 
      x"0010", x"000f", x"000f", x"000e", x"000e", x"000d", x"000c", x"000c",
      x"000b", x"000b", x"000a", x"000a", x"000a", x"0009", x"0009", x"0008", 
      x"0008", x"0008", x"0007", x"0007", x"0007", x"0006", x"0006", x"0006",
      x"0006", x"0005", x"0005", x"0005", x"0005", x"0005", x"0004", x"0004", 
      x"0004", x"0004", x"0004", x"0004", x"0003", x"0003", x"0003", x"0003",
      x"0003", x"0003", x"0003", x"0002", x"0002", x"0002", x"0002", x"0002", 
      x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0002", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001",
      x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", x"0001", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000",
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
      x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000"
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
      and15 := sinp(15) and and16;

      and14 := sinp(14) and and15;
      and13 := sinp(13) and and14;
      and12 := sinp(12) and and13;
      and11 := sinp(11) and and12;
      and10 := sinp(10) and and11;
      and09 := sinp(09) and and10;
      and08 := sinp(08) and and09;
      and07 := sinp(07) and and08;

      and06 := sinp(06) and and07;
      and05 := sinp(05) and and06;
      and04 := sinp(04) and and05;
      and03 := sinp(03) and and04;
      and02 := sinp(02) and and03;
      and01 := sinp(01) and and02;

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
      add1_01 <= ('0' & and01) + ('0' & and02) +('0' & and03);    
      add1_02 <= ('0' & and04) + ('0' & and05) +('0' & and06); 
      add1_03 <= ('0' & and07) + ('0' & and08) +('0' & and09); 
      add1_04 <= ('0' & and10) + ('0' & and11) +('0' & and12); 
      add1_05 <= ('0' & and13) + ('0' & and14) +('0' & and15); 
      add1_06 <= ('0' & and16) + ('0' & and17) +('0' & and18); 
      add1_07 <= ('0' & and19) + ('0' & and20) +('0' & and21); 
      add1_08 <= ('0' & and22) + ('0' & and23) +('0' & and24); 
      add1_09 <= ('0' & and25) + ('0' & and26) +('0' & and27); 
      add1_10 <= ('0' & and28) + ('0' & and29) +('0' & and30);
       

      add1_11 <= ('0' & or01) + ('0' & or02) +('0' & or03);    
      add1_12 <= ('0' & or04) + ('0' & or05) +('0' & or06); 
      add1_13 <= ('0' & or07) + ('0' & or08) +('0' & or09); 
      add1_14 <= ('0' & or10) + ('0' & or11) +('0' & or12); 
      add1_15 <= ('0' & or13) + ('0' & or14) +('0' & or15); 
      add1_16 <= ('0' & or16) + ('0' & or17) +('0' & or18); 
      add1_17 <= ('0' & or19) + ('0' & or20) +('0' & or21); 
      add1_18 <= ('0' & or22) + ('0' & or23) +('0' & or24); 
      add1_19 <= ('0' & or25) + ('0' & or26) +('0' & or27); 
      add1_20 <= ('0' & or28) + ('0' & or29) +('0' & or30); 
      


		
		add2_01 := ("00" & add1_01) + ("00" & add1_02) + ("00" & add1_03);
		add2_02 := ("00" & add1_04) + ("00" & add1_05) + ("00" & add1_06);
		add2_03 := ("00" & add1_07) + ("00" & add1_08) + ("00" & add1_09);
		add2_04 := ("00" & add1_10) + ("00" & add1_11) + ("00" & add1_12);
		add2_05 := ("00" & add1_13) + ("00" & add1_14) + ("00" & add1_15);
		add2_06 := ("00" & add1_16) + ("00" & add1_17) + ("00" & add1_18);
		add2_07 := ("00" & add1_19) + ("00" & add1_20) ;



		add3_01 := ('0' & add2_01) + ('0' & add2_02);
		add3_02 := ('0' & add2_03) + ('0' & add2_04);
		add3_03 := ('0' & add2_05) + ('0' & add2_06);
		add3_04 := ('0' & add2_07) + ("0000" & sinp1(31)); 

		add4_01 := ('0' & add3_01) + ('0' & add3_02); 
		add4_02 := ('0' & add3_03) + ('0' & add3_04);

		--Cycle 2 
		sinp2 <= sinp1;
	  add5_01 <= add4_01 + add4_02 ;
    m_add := unsigned('0' & add5_01);
    

		--Cycle 3
		if m_add >= 31 then
			sw <= m_add-31;	  
		  sinp3 <= std_logic_vector(signed(not(sinp2))+1);
		  sign <= '1';
		else
			sw <= 30-m_add;
		  sinp3 <= sinp2;
		  sign <= '0';
		end if; 

		sadd <= m_add(5 downto 0);
		op32 := SHIFT_LEFT(unsigned(sinp3), to_integer(sw));	
		op16 := op32(31 downto 16);
		vadd_lsb := (not(op16_1(15)& op16_1(15)& op16_1(15)));
		
		
		--Cycle 4
    sadd_lsb <= op16(13 downto 11);
		sadd1 <= sadd;
		op16_1 <= op16;
		sign1 <= sign;  

			--Cycle 5
		
			if(sign1 = '0') then
				sadd3(2 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15)& op16_1(15));
		    sadd3(8 downto 3) <=  sadd1;
        op16_2 <= op16_1;
    	else
				sadd3(2 downto 0) <= 7- sadd_lsb and not(op16_1(15)& op16_1(15)& op16_1(15));
        sadd3(8 downto 3) <=  sadd1;
        op16_2 <= op16_1;
  			end if;
   
      
			--Cycle 6
			test1 <= sadd3(8 downto 3);
			test2 <= sadd3(2 downto 0);
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 









		
		
--		--Cycle 4
--		if sign = '1' then
--			sadd_lsb <= 7 - (unsigned(op16(13 downto 11)) and vadd_lsb);--and not(op16_1(15)& op16_1(15)& op16_1(15));
--		else
--			sadd_lsb <= op16(13 downto 11) and vadd_lsb;--and not(op16_1(15)& op16_1(15)& op16_1(15);
--		end if;
--
--		sadd1 <= sadd;
--		op16_1 <= op16;
--    
--		sadd3(8 downto 3) := sadd1;
--		sadd3(2 downto 0) := sadd_lsb;
--   
--   
--		--Cycle 5
--		outp <= std_logic_vector(op16_1); 
--		M <= M_tr(to_integer(sadd3));
--		C <= C_tr(to_integer(sadd3));
		end if;  
	end if;  

end process; 
 
 
end beh; 

