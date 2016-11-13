library ieee; 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


entity corr_block is
	port 
		(
		clk			:	in 	std_logic;
		reset	      :	in 	std_logic;
		inp			:	in 	std_logic_vector(15 downto 0);  
		outp	 	   :	out 	std_logic_vector (15 downto 0)
		);


	end corr_block ;

architecture behave of corr_block is

type 		data_array16 is array (integer range <>) of std_logic_vector(15 downto 0);

signal  	coef 	: 	data_array16(0 to 1023);
signal	  sin0, sin1 : std_logic_vector(15 downto 0); 
signal	  sign : std_logic; 
signal   err : signed(15 downto 0); 
signal   addr : unsigned(10 downto 0);  

begin 

--main process that that starts with start of internal clock,
process (reset, clk)
begin
	if (clk'event and clk = '1') then
		if(reset = '1')then
			coef <=
			(

      x"0000", x"ffff", x"ffff", x"ffff", x"fffe", x"fffe", x"fffe", x"fffd", x"fffd", x"fffc", x"fffc", x"fffc", x"fffb", x"fffb", x"fffb", x"fffa",
      x"fffa", x"fffa", x"fff9", x"fff9", x"fff8", x"fff8", x"fff8", x"fff7", x"fff7", x"fff7", x"fff6", x"fff6", x"fff6", x"fff5", x"fff5", x"fff5",
      x"fff4", x"fff4", x"fff4", x"fff3", x"fff3", x"fff3", x"fff2", x"fff2", x"fff2", x"fff1", x"fff1", x"fff1", x"fff0", x"fff0", x"fff0", x"ffef",
      x"ffef", x"ffef", x"ffee", x"ffee", x"ffee", x"ffed", x"ffed", x"ffed", x"ffec", x"ffec", x"ffec", x"ffec", x"ffeb", x"ffeb", x"ffeb", x"ffea",
      x"ffea", x"ffea", x"ffea", x"ffe9", x"ffe9", x"ffe9", x"ffe9", x"ffe8", x"ffe8", x"ffe8", x"ffe8", x"ffe7", x"ffe7", x"ffe7", x"ffe7", x"ffe6",
      x"ffe6", x"ffe6", x"ffe6", x"ffe5", x"ffe5", x"ffe5", x"ffe5", x"ffe5", x"ffe4", x"ffe4", x"ffe4", x"ffe4", x"ffe4", x"ffe4", x"ffe3", x"ffe3",
      x"ffe3", x"ffe3", x"ffe3", x"ffe3", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe1", x"ffe1", x"ffe1", x"ffe1",
      x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe0", x"ffe0", x"ffe0", x"ffe0", x"ffe0",
      x"ffe0", x"ffe0", x"ffe0", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1", x"ffe1",
      x"ffe1", x"ffe1", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe2", x"ffe3", x"ffe3", x"ffe3", x"ffe3", x"ffe3", x"ffe4", x"ffe4",
      x"ffe4", x"ffe4", x"ffe5", x"ffe5", x"ffe5", x"ffe5", x"ffe6", x"ffe6", x"ffe6", x"ffe6", x"ffe7", x"ffe7", x"ffe7", x"ffe8", x"ffe8", x"ffe8",
      x"ffe9", x"ffe9", x"ffe9", x"ffea", x"ffea", x"ffeb", x"ffeb", x"ffeb", x"ffec", x"ffec", x"ffed", x"ffed", x"ffee", x"ffee", x"ffef", x"ffef",
      x"fff0", x"fff0", x"fff1", x"fff1", x"fff2", x"fff2", x"fff3", x"fff3", x"fff4", x"fff4", x"fff5", x"fff6", x"fff6", x"fff7", x"fff8", x"fff8",
      x"fff9", x"fffa", x"fffa", x"fffb", x"fffc", x"fffc", x"fffd", x"fffe", x"ffff", x"ffff", x"0000", x"0001", x"0002", x"0002", x"0003", x"0004",
      x"0005", x"0006", x"0007", x"0008", x"0008", x"0009", x"000a", x"000b", x"000c", x"000d", x"000e", x"000f", x"0010", x"0011", x"0012", x"0013",
      x"0014", x"0015", x"0016", x"0017", x"0018", x"0019", x"001a", x"001c", x"001d", x"001e", x"001f", x"0020", x"0021", x"0023", x"0024", x"0025",
      x"0026", x"0028", x"0029", x"002a", x"002c", x"002d", x"002e", x"0030", x"0031", x"0032", x"0034", x"0035", x"0036", x"0038", x"0039", x"003b",
      x"003c", x"003e", x"003f", x"0041", x"0042", x"0044", x"0046", x"0047", x"0049", x"004a", x"004c", x"004e", x"004f", x"0051", x"0053", x"0055",
      x"0056", x"0058", x"005a", x"005c", x"005d", x"005f", x"0061", x"0063", x"0065", x"0067", x"0069", x"006b", x"006d", x"006f", x"0071", x"0073",
      x"0075", x"0077", x"0079", x"007b", x"007d", x"007f", x"0081", x"0083", x"0085", x"0088", x"008a", x"008c", x"008e", x"0091", x"0093", x"0095",
      x"0098", x"009a", x"009c", x"009f", x"00a1", x"00a4", x"00a6", x"00a8", x"00ab", x"00ae", x"00b0", x"00b3", x"00b5", x"00b8", x"00ba", x"00bd",
      x"00c0", x"00c2", x"00c5", x"00c8", x"00cb", x"00cd", x"00d0", x"00d3", x"00d6", x"00d9", x"00dc", x"00df", x"00e2", x"00e5", x"00e8", x"00eb",
      x"00ee", x"00f1", x"00f4", x"00f7", x"00fa", x"00fd", x"0100", x"0104", x"0107", x"010a", x"010d", x"0111", x"0114", x"0117", x"011b", x"011e",
      x"0122", x"0125", x"0129", x"012c", x"0130", x"0133", x"0137", x"013b", x"013e", x"0142", x"0146", x"0149", x"014d", x"0151", x"0155", x"0159",
      x"015d", x"0161", x"0164", x"0168", x"016c", x"0171", x"0175", x"0179", x"017d", x"0181", x"0185", x"0189", x"018e", x"0192", x"0196", x"019b",
      x"019f", x"01a3", x"01a8", x"01ac", x"01b1", x"01b5", x"01ba", x"01bf", x"01c3", x"01c8", x"01cd", x"01d1", x"01d6", x"01db", x"01e0", x"01e5",
      x"01ea", x"01ef", x"01f4", x"01f9", x"01fe", x"0203", x"0208", x"020d", x"0212", x"0218", x"021d", x"0222", x"0228", x"022d", x"0232", x"0238",
      x"023d", x"0243", x"0249", x"024e", x"0254", x"025a", x"025f", x"0265", x"026b", x"0271", x"0277", x"027d", x"0283", x"0289", x"028f", x"0295",
      x"029b", x"02a1", x"02a8", x"02ae", x"02b4", x"02bb", x"02c1", x"02c8", x"02ce", x"02d5", x"02dc", x"02e2", x"02e9", x"02f0", x"02f7", x"02fd",
      x"0304", x"030b", x"0312", x"0319", x"0321", x"0328", x"035f", x"0367", x"036e", x"0376", x"037e", x"0386", x"038e", x"0396", x"039e", x"03a6",
      x"03af", x"03b7", x"03bf", x"03c8", x"03d0", x"03d9", x"03e1", x"03ea", x"03f2", x"03fb", x"0404", x"040d", x"0416", x"041f", x"0428", x"0431",
      x"043a", x"0444", x"044d", x"0456", x"0460", x"0469", x"0473", x"047d", x"0486", x"0490", x"049a", x"04a4", x"04ae", x"04b8", x"04c2", x"04cd",
      x"04d7", x"04e1", x"04ec", x"04f7", x"0501", x"050c", x"0517", x"0522", x"052d", x"0538", x"0543", x"054e", x"0559", x"0565", x"0570", x"057c",
      x"0587", x"0593", x"059f", x"05ab", x"05b7", x"05c3", x"05cf", x"05db", x"05e8", x"05f4", x"0601", x"060d", x"061a", x"0627", x"0634", x"0641",
      x"064e", x"065b", x"0669", x"0676", x"0684", x"0691", x"069f", x"06ad", x"06bb", x"06c9", x"06d7", x"06e6", x"06f4", x"0703", x"0711", x"0720",
      x"072f", x"073e", x"074d", x"075d", x"076c", x"077c", x"078b", x"079b", x"07ab", x"07bb", x"07cb", x"07dc", x"07ec", x"07fd", x"080d", x"081e",
      x"082f", x"0841", x"0852", x"0863", x"0875", x"0887", x"0899", x"08ab", x"08bd", x"08cf", x"08e2", x"08f5", x"0908", x"091b", x"092e", x"0941",
      x"0955", x"0968", x"097c", x"0990", x"09a5", x"09b9", x"09ce", x"09e3", x"09f8", x"0a0d", x"0a22", x"0a38", x"0a4e", x"0a64", x"0a7a", x"0a91",
      x"0aa7", x"0abe", x"0ad5", x"0aec", x"0b04", x"0b1c", x"0b34", x"0b4c", x"0b64", x"0b7d", x"0b96", x"0baf", x"0bc9", x"0be2", x"0bfc", x"0c16",
      x"0c31", x"0c4c", x"0c67", x"0c82", x"0c9e", x"0cb9", x"0cd5", x"0cf2", x"0d0f", x"0d2c", x"0d49", x"0d67", x"0d85", x"0da3", x"0dc1", x"0de0",
      x"0e00", x"0e1f", x"0e3f", x"0e5f", x"0e80", x"0ea1", x"0ec2", x"0ee4", x"0f06", x"0f29", x"0f4c", x"0f6f", x"0f93", x"0fb7", x"0fdb", x"1000",
      x"1026", x"104c", x"1072", x"1099", x"10c0", x"10e8", x"1110", x"1139", x"1162", x"118b", x"11b6", x"11e0", x"120c", x"1238", x"1264", x"1291",
      x"12bf", x"12ed", x"131b", x"134b", x"137b", x"13ac", x"13dd", x"140f", x"1442", x"1475", x"14a9", x"14de", x"1514", x"154a", x"1581", x"15ba",
      x"15f2", x"162c", x"1667", x"16a2", x"16df", x"171c", x"175a", x"1799", x"17da", x"181b", x"185d", x"18a1", x"18e6", x"192b", x"1972", x"19bb",
      x"1a04", x"1a4f", x"1a9b", x"1ae9", x"1b38", x"1b88", x"1bda", x"1c2e", x"1c83", x"1cda", x"1d32", x"1d8d", x"1de9", x"1e47", x"1ea8", x"1f0a",
      x"1f6e", x"1fd5", x"203e", x"20aa", x"2118", x"2189", x"21fd", x"2273", x"22ed", x"236a", x"23ea", x"246e", x"24f5", x"2581", x"2610", x"26a4",
      x"273d", x"27da", x"287d", x"2925", x"29d4", x"2a88", x"2b44", x"2c06", x"2cd1", x"2da4", x"2e81", x"2f68", x"305a", x"3158", x"3263", x"337d",
      x"34a8", x"35e6", x"3739", x"38a5", x"3a2d", x"3bd5", x"3da5", x"3fa4", x"41de", x"4461", x"4746", x"4aae", x"4ed8", x"543a", x"5bed", x"6a2c",
      x"0162", x"0163", x"0163", x"0164", x"0164", x"0165", x"0165", x"0166", x"0166", x"0166", x"0167", x"0167", x"0168", x"0168", x"0169", x"0169",
      x"016a", x"016a", x"016b", x"016b", x"016c", x"016c", x"016c", x"016d", x"016d", x"016e", x"016e", x"016f", x"016f", x"0170", x"0170", x"0171",
      x"0171", x"0171", x"0172", x"0172", x"0173", x"0173", x"0174", x"0174", x"0175", x"0175", x"0176", x"0176", x"0177", x"0177", x"0177", x"0178",
      x"0178", x"0179", x"0179", x"017a", x"017a", x"017b", x"017b", x"017c", x"017c", x"017d", x"017d", x"017d", x"017e", x"017e", x"017f", x"017f",
      x"0180", x"0180", x"0181", x"0181", x"0182", x"0182", x"0183", x"0183", x"0183", x"0184", x"0184", x"0185", x"0185", x"0186", x"0186", x"0187",
      x"0187", x"0188", x"0188", x"0189", x"0189", x"0189", x"018a", x"018a", x"018b", x"018b", x"018c", x"018c", x"018d", x"018d", x"018e", x"018e",
      x"018f", x"018f", x"018f", x"0190", x"0190", x"0191", x"0191", x"0192", x"0192", x"0193", x"0193", x"0194", x"0194", x"0195", x"0195", x"0195",
      x"0196", x"0196", x"0197", x"0197", x"0198", x"0198", x"0199", x"0199", x"019a", x"019a", x"019b", x"019b", x"019b", x"019c", x"019c", x"019d",
      x"019d", x"019e", x"019e", x"019f", x"019f", x"01a0", x"01a0", x"01a1", x"01a1", x"01a1", x"01a2", x"01a2", x"01a3", x"01a3", x"01a4", x"01a4",
      x"01a5", x"01a5", x"01a6", x"01a6", x"01a7", x"01a7", x"01a7", x"01a8", x"01a8", x"01a9", x"01a9", x"01aa", x"01aa", x"01ab", x"01ab", x"01ac",
      x"01ac", x"01ad", x"01ad", x"01ad", x"01ae", x"01ae", x"01af", x"01af", x"01b0", x"01b0", x"01b1", x"01b1", x"01b2", x"01b2", x"01b3", x"01b3",
      x"01b3", x"01b4", x"01b4", x"01b5", x"01b5", x"01b6", x"01b6", x"01b7", x"01b7", x"01b8", x"01b8", x"01b8", x"01b9", x"01b9", x"01ba", x"01ba",
      x"01bb", x"01bb", x"01bc", x"01bc", x"01bd", x"01bd", x"01be", x"01be", x"01be", x"01bf", x"01bf", x"01c0", x"01c0", x"01c1", x"01c1", x"01c2",
      x"01c2", x"01c3", x"01c3", x"01c4", x"01c4", x"01c4", x"01c5", x"01c5", x"01c6", x"01c6", x"01c7", x"01c7", x"01c8", x"01c8", x"01c9", x"01c9",
      x"01ca", x"01ca", x"01ca", x"01cb", x"01cb", x"01cc", x"01cc", x"01cd", x"01cd", x"01ce", x"01ce", x"01cf", x"01cf", x"01d0", x"01d0", x"01d0",
      x"01d1", x"01d1", x"01d2", x"01d2", x"01d3", x"01d3", x"01d4", x"01d4", x"01d5", x"01d5", x"01d6", x"01d6", x"01d6", x"01d7", x"01d7", x"01be"
				);

			else
			--Cycle 0
			if(inp(15) = '0')then
				addr <= unsigned(inp(15 downto 5));
				sign <= '0';
				err <= signed(coef(to_integer(addr)));
  			else
				addr <= unsigned(not(inp(15 downto 5)));
				sign <= '1';
				err <= -signed(coef(to_integer(addr)));
			end if;
			sin0 <= inp;
			
			--Cycle 1
			if(sign = '0')then
				err <= signed(coef(to_integer(addr)));
  			else
				err <= -signed(coef(to_integer(addr)));
			end if;
			sin1 <= sin0;
			
		end if;
	end if;
end process ;
			outp <= std_logic_vector(err + signed(sin1));
end behave;













		
