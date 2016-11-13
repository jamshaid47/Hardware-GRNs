library ieee; 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


entity corr_block is
	port 
		(
		clk			:	in 	std_logic;
		reset	:	in 	std_logic;
		inp1			:	in 	std_logic_vector(16 downto 0);  
		inp2			:	in 	std_logic_vector(16 downto 0);  
		outp1	 :	out std_logic_vector(15 downto 0);
		outp2	 :	out std_logic_vector(15 downto 0)
		);


	end corr_block ;

architecture behave of corr_block is

type 		data_array16 is array (integer range <>) of std_logic_vector(15 downto 0);

signal  	coef 	: 	data_array16(0 to 1023);
signal	  sin1 : signed(15 downto 0);
signal	  sign1 : std_logic; 
signal   addr1 : unsigned(9 downto 0);  

signal	  sin2 : signed(15 downto 0);
signal	  sign2 : std_logic; 
signal   addr2 : unsigned(9 downto 0);  

begin 

--main process that that starts with start of internal clock,
process (reset, clk)
begin
	if (clk'event and clk = '1') then
		if(reset = '1')then
			coef <=
			(
			x"0002", x"0007", x"000c", x"0011", x"0016", x"001b", x"0020", x"0025", x"002a", x"002f", x"0035", x"003a", x"003f", x"0044", x"0049", x"004e",
			x"0053", x"0058", x"005d", x"0062", x"0067", x"006c", x"0071", x"0076", x"007b", x"0080", x"0085", x"008a", x"008f", x"0094", x"0099", x"009e",
			x"00a3", x"00a8", x"00ad", x"00b2", x"00b7", x"00bc", x"00c1", x"00c6", x"00cb", x"00d0", x"00d5", x"00da", x"00df", x"00e4", x"00e9", x"00ee",
			x"00f3", x"00f8", x"00fd", x"0102", x"0107", x"010c", x"0111", x"0116", x"011b", x"0120", x"0125", x"012a", x"012f", x"0134", x"013a", x"013f",
			x"0144", x"0149", x"014e", x"0153", x"0158", x"015d", x"0162", x"0167", x"016c", x"0171", x"0176", x"017b", x"0180", x"0185", x"018a", x"018f",
			x"0194", x"0199", x"019e", x"01a3", x"01a8", x"01ad", x"01b2", x"01b7", x"01bc", x"01c1", x"01c6", x"01cc", x"01d1", x"01d6", x"01db", x"01e0",
			x"01e5", x"01ea", x"01ef", x"01f4", x"01f9", x"01fe", x"0203", x"0208", x"020d", x"0212", x"0217", x"021c", x"0221", x"0226", x"022c", x"0231",
			x"0236", x"023b", x"0240", x"0245", x"024a", x"024f", x"0254", x"0259", x"025e", x"0263", x"0268", x"026d", x"0272", x"0278", x"027d", x"0282",
			x"0287", x"028c", x"0291", x"0296", x"029b", x"02a0", x"02a5", x"02aa", x"02af", x"02b4", x"02ba", x"02bf", x"02c4", x"02c9", x"02ce", x"02d3",
			x"02d8", x"02dd", x"02e2", x"02e7", x"02ec", x"02f2", x"02f7", x"02fc", x"0301", x"0306", x"030b", x"0310", x"0315", x"031a", x"031f", x"0325",
			x"032a", x"032f", x"0334", x"0339", x"033e", x"0343", x"0348", x"034e", x"0353", x"0358", x"035d", x"0362", x"0367", x"036c", x"0371", x"0377",
			x"037c", x"0381", x"0386", x"038b", x"0390", x"0395", x"039b", x"03a0", x"03a5", x"03aa", x"03af", x"03b4", x"03b9", x"03bf", x"03c4", x"03c9",
			x"03ce", x"03d3", x"03d8", x"03de", x"03e3", x"03e8", x"03ed", x"03f2", x"03f7", x"03fc", x"0402", x"0407", x"040c", x"0411", x"0416", x"041c",
			x"0421", x"0426", x"042b", x"0430", x"0435", x"043b", x"0440", x"0445", x"044a", x"044f", x"0455", x"045a", x"045f", x"0464", x"0469", x"046f",
			x"0474", x"0479", x"047e", x"0484", x"0489", x"048e", x"0493", x"0498", x"049e", x"04a3", x"04a8", x"04ad", x"04b3", x"04b8", x"04bd", x"04c2",
			x"04c8", x"04cd", x"04d2", x"04d7", x"04dc", x"04e2", x"04e7", x"04ec", x"04f2", x"04f7", x"04fc", x"0501", x"0507", x"050c", x"0511", x"0516",
			x"051c", x"0521", x"0526", x"052b", x"0531", x"0536", x"053b", x"0541", x"0546", x"054b", x"0550", x"0556", x"055b", x"0560", x"0566", x"056b",
			x"0570", x"0576", x"057b", x"0580", x"0586", x"058b", x"0590", x"0596", x"059b", x"05a0", x"05a6", x"05ab", x"05b0", x"05b6", x"05bb", x"05c0",
			x"05c6", x"05cb", x"05d0", x"05d6", x"05db", x"05e0", x"05e6", x"05eb", x"05f1", x"05f6", x"05fb", x"0601", x"0606", x"060b", x"0611", x"0616",
			x"061c", x"0621", x"0626", x"062c", x"0631", x"0637", x"063c", x"0641", x"0647", x"064c", x"0652", x"0657", x"065c", x"0662", x"0667", x"066d",
			x"0672", x"0678", x"067d", x"0682", x"0688", x"068d", x"0693", x"0698", x"069e", x"06a3", x"06a9", x"06ae", x"06b4", x"06b9", x"06bf", x"06c4",
			x"06ca", x"06cf", x"06d5", x"06da", x"06e0", x"06e5", x"06eb", x"06f0", x"06f6", x"06fb", x"0701", x"0706", x"070c", x"0711", x"0717", x"071c",
			x"0722", x"0727", x"072d", x"0732", x"0738", x"073d", x"0743", x"0749", x"074e", x"0754", x"0759", x"075f", x"0764", x"076a", x"0770", x"0775",
			x"077b", x"0780", x"0786", x"078c", x"0791", x"0797", x"079c", x"07a2", x"07a8", x"07ad", x"07b3", x"07b8", x"07be", x"07c4", x"07c9", x"07cf",
			x"07d5", x"07da", x"07e0", x"07e6", x"07eb", x"07f1", x"07f7", x"07fc", x"0802", x"0808", x"080d", x"0813", x"0819", x"081e", x"0824", x"082a",
			x"0830", x"0835", x"083b", x"0841", x"0846", x"084c", x"0852", x"0858", x"085d", x"0863", x"0869", x"086f", x"0874", x"087a", x"0880", x"0886",
			x"088c", x"0891", x"0897", x"089d", x"08a3", x"08a9", x"08ae", x"08b4", x"08ba", x"08c0", x"08c6", x"08cb", x"08d1", x"08d7", x"08dd", x"08e3",
			x"08e9", x"08ef", x"08f4", x"08fa", x"0900", x"0906", x"090c", x"0912", x"0918", x"091e", x"0923", x"0929", x"092f", x"0935", x"093b", x"0941",
			x"0947", x"094d", x"0953", x"0959", x"095f", x"0965", x"096b", x"0971", x"0977", x"097d", x"0982", x"0988", x"098e", x"0994", x"099a", x"09a0",
			x"09a6", x"09ac", x"09b3", x"09b9", x"09bf", x"09c5", x"09cb", x"09d1", x"09d7", x"09dd", x"09e3", x"09e9", x"09ef", x"09f5", x"09fb", x"0a01",
			x"0a07", x"0a0d", x"0a14", x"0a1a", x"0a20", x"0a26", x"0a2c", x"0a32", x"0a38", x"0a3f", x"0a45", x"0a4b", x"0a51", x"0a57", x"0a5d", x"0a64",
			x"0a6a", x"0a70", x"0a76", x"0a7c", x"0a83", x"0a89", x"0a8f", x"0a95", x"0a9c", x"0aa2", x"0aa8", x"0aae", x"0ab5", x"0abb", x"0ac1", x"0ac7",
			x"0ace", x"0ad4", x"0ada", x"0ae1", x"0ae7", x"0aed", x"0af4", x"0afa", x"0b00", x"0b07", x"0b0d", x"0b13", x"0b1a", x"0b20", x"0b27", x"0b2d",
			x"0b33", x"0b3a", x"0b40", x"0b47", x"0b4d", x"0b53", x"0b5a", x"0b60", x"0b67", x"0b6d", x"0b74", x"0b7a", x"0b81", x"0b87", x"0b8e", x"0b94",
			x"0b9b", x"0ba1", x"0ba8", x"0bae", x"0bb5", x"0bbb", x"0bc2", x"0bc9", x"0bcf", x"0bd6", x"0bdc", x"0be3", x"0bea", x"0bf0", x"0bf7", x"0bfd",
			x"0c04", x"0c0b", x"0c11", x"0c18", x"0c1f", x"0c25", x"0c2c", x"0c33", x"0c39", x"0c40", x"0c47", x"0c4e", x"0c54", x"0c5b", x"0c62", x"0c69",
			x"0c6f", x"0c76", x"0c7d", x"0c84", x"0c8b", x"0c91", x"0c98", x"0c9f", x"0ca6", x"0cad", x"0cb4", x"0cbb", x"0cc1", x"0cc8", x"0ccf", x"0cd6",
			x"0cdd", x"0ce4", x"0ceb", x"0cf2", x"0cf9", x"0d00", x"0d07", x"0d0e", x"0d15", x"0d1c", x"0d23", x"0d2a", x"0d31", x"0d38", x"0d3f", x"0d46",
			x"0d4d", x"0d54", x"0d5b", x"0d62", x"0d6a", x"0d71", x"0d78", x"0d7f", x"0d86", x"0d8d", x"0d94", x"0d9c", x"0da3", x"0daa", x"0db1", x"0db9",
			x"0dc0", x"0dc7", x"0dce", x"0dd6", x"0ddd", x"0de4", x"0deb", x"0df3", x"0dfa", x"0e01", x"0e09", x"0e10", x"0e18", x"0e1f", x"0e26", x"0e2e",
			x"0e35", x"0e3d", x"0e44", x"0e4c", x"0e53", x"0e5b", x"0e62", x"0e6a", x"0e71", x"0e79", x"0e80", x"0e88", x"0e8f", x"0e97", x"0e9f", x"0ea6",
			x"0eae", x"0eb5", x"0ebd", x"0ec5", x"0ecc", x"0ed4", x"0edc", x"0ee4", x"0eeb", x"0ef3", x"0efb", x"0f03", x"0f0a", x"0f12", x"0f1a", x"0f22",
			x"0f2a", x"0f32", x"0f39", x"0f41", x"0f49", x"0f51", x"0f59", x"0f61", x"0f69", x"0f71", x"0f79", x"0f81", x"0f89", x"0f91", x"0f99", x"0fa1",
			x"0fa9", x"0fb1", x"0fba", x"0fc2", x"0fca", x"0fd2", x"0fda", x"0fe2", x"0feb", x"0ff3", x"0ffb", x"1003", x"100c", x"1014", x"101c", x"1024",
			x"102d", x"1035", x"103e", x"1046", x"104e", x"1057", x"105f", x"1068", x"1070", x"1079", x"1081", x"108a", x"1092", x"109b", x"10a4", x"10ac",
			x"10b5", x"10be", x"10c6", x"10cf", x"10d8", x"10e0", x"10e9", x"10f2", x"10fb", x"1103", x"110c", x"1115", x"111e", x"1127", x"1130", x"1139",
			x"1142", x"114b", x"1154", x"115d", x"1166", x"116f", x"1178", x"1181", x"118a", x"1193", x"119d", x"11a6", x"11af", x"11b8", x"11c1", x"11cb",
			x"11d4", x"11dd", x"11e7", x"11f0", x"11fa", x"1203", x"120c", x"1216", x"121f", x"1229", x"1233", x"123c", x"1246", x"124f", x"1259", x"1263",
			x"126c", x"1276", x"1280", x"128a", x"1294", x"129d", x"12a7", x"12b1", x"12bb", x"12c5", x"12cf", x"12d9", x"12e3", x"12ed", x"12f7", x"1301",
			x"130c", x"1316", x"1320", x"132a", x"1335", x"133f", x"1349", x"1354", x"135e", x"1368", x"1373", x"137d", x"1388", x"1393", x"139d", x"13a8",
			x"13b3", x"13bd", x"13c8", x"13d3", x"13de", x"13e8", x"13f3", x"13fe", x"1409", x"1414", x"141f", x"142a", x"1435", x"1441", x"144c", x"1457",
			x"1462", x"146e", x"1479", x"1484", x"1490", x"149b", x"14a7", x"14b2", x"14be", x"14ca", x"14d5", x"14e1", x"14ed", x"14f9", x"1504", x"1510",
			x"151c", x"1528", x"1534", x"1540", x"154c", x"1559", x"1565", x"1571", x"157e", x"158a", x"1596", x"15a3", x"15af", x"15bc", x"15c9", x"15d5",
			x"15e2", x"15ef", x"15fc", x"1609", x"1616", x"1623", x"1630", x"163d", x"164a", x"1657", x"1665", x"1672", x"167f", x"168d", x"169a", x"16a8",
			x"16b6", x"16c4", x"16d1", x"16df", x"16ed", x"16fb", x"1709", x"1717", x"1726", x"1734", x"1742", x"1751", x"175f", x"176e", x"177d", x"178b",
			x"179a", x"17a9", x"17b8", x"17c7", x"17d7", x"17e6", x"17f5", x"1805", x"1814", x"1824", x"1833", x"1843", x"1853", x"1863", x"1873", x"1883",
			x"1893", x"18a4", x"18b4", x"18c5", x"18d5", x"18e6", x"18f7", x"1908", x"1919", x"192a", x"193c", x"194d", x"195f", x"1970", x"1982", x"1994",
			x"19a6", x"19b8", x"19cb", x"19dd", x"19f0", x"1a02", x"1a15", x"1a28", x"1a3c", x"1a4f", x"1a62", x"1a76", x"1a8a", x"1a9e", x"1ab2", x"1ac6",
			x"1ada", x"1aef", x"1b04", x"1b19", x"1b2e", x"1b43", x"1b58", x"1b6e", x"1b84", x"1b9a", x"1bb0", x"1bc7", x"1bde", x"1bf5", x"1c0c", x"1c23",
			x"1c3b", x"1c53", x"1c6b", x"1c83", x"1c9c", x"1cb5", x"1cce", x"1ce8", x"1d01", x"1d1c", x"1d36", x"1d51", x"1d6c", x"1d87", x"1da3", x"1dbf",
			x"1ddb", x"1df8", x"1e15", x"1e33", x"1e51", x"1e6f", x"1e8e", x"1ead", x"1ecd", x"1eed", x"1f0e", x"1f2f", x"1f51", x"1f73", x"1f96", x"1fb9",
			x"1fde", x"2002", x"2028", x"204e", x"2075", x"209c", x"20c5", x"20ee", x"2118", x"2143", x"216f", x"219c", x"21ca", x"21f9", x"222a", x"225b",
			x"228e", x"22c3", x"22f9", x"2330", x"2369", x"23a4", x"23e1", x"2420", x"2461", x"24a5", x"24ec", x"2535", x"2581", x"25d1", x"2625", x"267e",
			x"26db", x"273d", x"27a6", x"2815", x"288d", x"290f", x"299c", x"2a37", x"2ae3", x"2ba5", x"2c83", x"2d8a", x"2ecb", x"306e", x"32cf", x"3789"
			);

			else
			--Cycle 0
			addr1 <= unsigned(inp1(15 downto 6));
			if(inp1(16) = '0')then
				sin1 <= signed(coef(to_integer(addr1)));
  			else
				sin1 <= -signed(coef(to_integer(addr1)));
			end if;
			
			addr2 <= unsigned(inp2(15 downto 6));
			if(inp2(16) = '0')then
				sin2 <= signed(coef(to_integer(addr2)));
  			else
				sin2 <= -signed(coef(to_integer(addr2)));
			end if;
			
		end if;
	end if;
end process ;
			outp1 <= std_logic_vector(sin1);
			outp2 <= std_logic_vector(sin2);
end behave;













		
