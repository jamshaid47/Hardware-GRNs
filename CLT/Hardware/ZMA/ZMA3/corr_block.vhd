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

      x"ffff", x"fffd", x"fffb", x"fffa", x"fff8", x"fff6", x"fff4", x"fff2", x"fff0", x"ffee", x"ffed", x"ffeb", x"ffe9", x"ffe7", x"ffe5", x"ffe3",
      x"ffe2", x"ffe0", x"ffde", x"ffdc", x"ffda", x"ffd8", x"ffd7", x"ffd5", x"ffd3", x"ffd1", x"ffcf", x"ffcd", x"ffcc", x"ffca", x"ffc8", x"ffc6",
      x"ffc4", x"ffc3", x"ffc1", x"ffbf", x"ffbd", x"ffbc", x"ffba", x"ffb8", x"ffb6", x"ffb4", x"ffb3", x"ffb1", x"ffaf", x"ffad", x"ffac", x"ffaa",
      x"ffa8", x"ffa6", x"ffa5", x"ffa3", x"ffa1", x"ffa0", x"ff9e", x"ff9c", x"ff9b", x"ff99", x"ff97", x"ff95", x"ff94", x"ff92", x"ff90", x"ff8f",
      x"ff8d", x"ff8c", x"ff8a", x"ff88", x"ff87", x"ff85", x"ff83", x"ff82", x"ff80", x"ff7f", x"ff7d", x"ff7c", x"ff7a", x"ff79", x"ff77", x"ff75",
      x"ff74", x"ff72", x"ff71", x"ff6f", x"ff6e", x"ff6c", x"ff6b", x"ff6a", x"ff68", x"ff67", x"ff65", x"ff64", x"ff62", x"ff61", x"ff60", x"ff5e",
      x"ff5d", x"ff5b", x"ff5a", x"ff59", x"ff57", x"ff56", x"ff55", x"ff54", x"ff52", x"ff51", x"ff50", x"ff4e", x"ff4d", x"ff4c", x"ff4b", x"ff4a",
      x"ff48", x"ff47", x"ff46", x"ff45", x"ff44", x"ff43", x"ff42", x"ff40", x"ff3f", x"ff3e", x"ff3d", x"ff3c", x"ff3b", x"ff3a", x"ff39", x"ff38",
      x"ff37", x"ff36", x"ff35", x"ff34", x"ff34", x"ff33", x"ff32", x"ff31", x"ff30", x"ff2f", x"ff2e", x"ff2e", x"ff2d", x"ff2c", x"ff2b", x"ff2b",
      x"ff2a", x"ff29", x"ff29", x"ff28", x"ff27", x"ff27", x"ff26", x"ff25", x"ff25", x"ff24", x"ff24", x"ff23", x"ff23", x"ff22", x"ff22", x"ff22",
      x"ff21", x"ff21", x"ff20", x"ff20", x"ff20", x"ff1f", x"ff1f", x"ff1f", x"ff1f", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e",
      x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1e", x"ff1f", x"ff1f", x"ff1f", x"ff20", x"ff20",
      x"ff20", x"ff21", x"ff21", x"ff22", x"ff22", x"ff23", x"ff23", x"ff24", x"ff24", x"ff25", x"ff26", x"ff26", x"ff27", x"ff28", x"ff28", x"ff29",
      x"ff2a", x"ff2b", x"ff2c", x"ff2d", x"ff2e", x"ff2f", x"ff30", x"ff31", x"ff32", x"ff33", x"ff34", x"ff36", x"ff37", x"ff38", x"ff3a", x"ff3b",
      x"ff3c", x"ff3e", x"ff3f", x"ff41", x"ff42", x"ff44", x"ff46", x"ff47", x"ff49", x"ff4b", x"ff4d", x"ff4e", x"ff50", x"ff52", x"ff54", x"ff56",
      x"ff58", x"ff5a", x"ff5d", x"ff5f", x"ff61", x"ff63", x"ff66", x"ff68", x"ff6b", x"ff6d", x"ff70", x"ff72", x"ff75", x"ff78", x"ff7a", x"ff7d",
      x"ff80", x"ff83", x"ff86", x"ff88", x"ff8b", x"ff8d", x"ff90", x"ff93", x"ff95", x"ff97", x"ff9a", x"ff9c", x"ff9f", x"ffa1", x"ffa3", x"ffa5",
      x"ffa7", x"ffa9", x"ffab", x"ffad", x"ffaf", x"ffb1", x"ffb3", x"ffb5", x"ffb7", x"ffb9", x"ffbb", x"ffbc", x"ffbe", x"ffc0", x"ffc1", x"ffc3",
      x"ffc5", x"ffc6", x"ffc8", x"ffc9", x"ffcb", x"ffcc", x"ffce", x"ffcf", x"ffd0", x"ffd2", x"ffd3", x"ffd4", x"ffd6", x"ffd7", x"ffd8", x"ffd9",
      x"ffda", x"ffdc", x"ffdd", x"ffde", x"ffdf", x"ffe0", x"ffe1", x"ffe2", x"ffe3", x"ffe4", x"ffe5", x"ffe6", x"ffe7", x"ffe8", x"ffe9", x"ffea",
      x"ffea", x"ffeb", x"ffec", x"ffed", x"ffee", x"ffee", x"ffef", x"fff0", x"fff1", x"fff1", x"fff2", x"fff3", x"fff3", x"fff4", x"fff5", x"fff5",
      x"fff6", x"fff7", x"fff7", x"fff8", x"fff8", x"fff9", x"fff9", x"fffa", x"fffa", x"fffb", x"fffb", x"fffc", x"fffc", x"fffd", x"fffd", x"fffe",
      x"fffe", x"ffff", x"ffff", x"0000", x"0000", x"0001", x"0001", x"0001", x"0002", x"0002", x"0003", x"0003", x"0003", x"0004", x"0004", x"0004",
      x"0005", x"0005", x"0005", x"0006", x"0006", x"0006", x"0007", x"0007", x"0007", x"0008", x"0008", x"0008", x"0009", x"0009", x"0009", x"000a",
      x"000a", x"000a", x"000b", x"000b", x"000b", x"000c", x"000c", x"000c", x"000d", x"000d", x"000d", x"000e", x"000e", x"000e", x"000f", x"000f",
      x"000f", x"0010", x"0010", x"0010", x"0011", x"0011", x"0011", x"0012", x"0012", x"0012", x"0013", x"0013", x"0013", x"0014", x"0014", x"0015",
      x"0015", x"0015", x"0016", x"0016", x"0017", x"0017", x"0018", x"0018", x"0018", x"0019", x"0019", x"001a", x"001a", x"001b", x"001b", x"001c",
      x"001c", x"001d", x"001d", x"001e", x"001f", x"001f", x"0020", x"0020", x"0021", x"0021", x"0022", x"0023", x"0023", x"0024", x"0025", x"0025",
      x"0026", x"0027", x"0027", x"0028", x"0029", x"002a", x"002a", x"002b", x"002c", x"002d", x"002e", x"002f", x"002f", x"0030", x"0031", x"0032",
      x"0033", x"0034", x"0035", x"0036", x"0037", x"0038", x"004d", x"004e", x"0050", x"0051", x"0053", x"0054", x"0056", x"0057", x"0059", x"005a",
      x"005c", x"005e", x"005f", x"0061", x"0063", x"0064", x"0066", x"0068", x"006a", x"006c", x"006e", x"0070", x"0072", x"0074", x"0076", x"0078",
      x"007a", x"007c", x"007e", x"0080", x"0083", x"0085", x"0087", x"008a", x"008c", x"008e", x"0091", x"0093", x"0096", x"0099", x"009b", x"009e",
      x"00a0", x"00a3", x"00a6", x"00a9", x"00ac", x"00ae", x"00b1", x"00b4", x"00b7", x"00ba", x"00be", x"00c1", x"00c4", x"00c7", x"00ca", x"00ce",
      x"00d1", x"00d5", x"00d8", x"00dc", x"00df", x"00e3", x"00e6", x"00ea", x"00ee", x"00f2", x"00f6", x"00f9", x"00fd", x"0101", x"0106", x"010a",
      x"010e", x"0112", x"0116", x"011b", x"011f", x"0124", x"0128", x"012d", x"0132", x"0136", x"013b", x"0140", x"0145", x"014a", x"014f", x"0154",
      x"0159", x"015e", x"0164", x"0169", x"016e", x"0174", x"017a", x"017f", x"0185", x"018b", x"0191", x"0197", x"019d", x"01a3", x"01a9", x"01af",
      x"01b5", x"01bc", x"01c2", x"01c9", x"01d0", x"01d6", x"01dd", x"01e4", x"01eb", x"01f2", x"01f9", x"0201", x"0208", x"020f", x"0217", x"021f",
      x"0226", x"022e", x"0236", x"023e", x"0246", x"024f", x"0257", x"025f", x"0268", x"0270", x"0279", x"0282", x"028b", x"0294", x"029d", x"02a7",
      x"02b0", x"02ba", x"02c3", x"02cd", x"02d7", x"02e1", x"02eb", x"02f6", x"0300", x"030a", x"0315", x"0320", x"032b", x"0336", x"0341", x"034d",
      x"0358", x"0364", x"0370", x"037c", x"0388", x"0394", x"03a0", x"03ad", x"03ba", x"03c7", x"03d4", x"03e1", x"03ee", x"03fc", x"040a", x"0418",
      x"0426", x"0434", x"0443", x"0451", x"0460", x"046f", x"047f", x"048e", x"049e", x"04ae", x"04be", x"04ce", x"04df", x"04ef", x"0500", x"0512",
      x"0523", x"0535", x"0547", x"0559", x"056c", x"057e", x"0591", x"05a4", x"05b8", x"05cc", x"05e0", x"05f4", x"0609", x"061e", x"0633", x"0649",
      x"065f", x"0675", x"068b", x"06a2", x"06b9", x"06d1", x"06e9", x"0701", x"071a", x"0733", x"074d", x"0766", x"0781", x"079b", x"07b7", x"07d2",
      x"07ee", x"080b", x"0828", x"0845", x"0863", x"0881", x"08a0", x"08c0", x"08e0", x"0900", x"0922", x"0943", x"0966", x"0989", x"09ad", x"09d1",
      x"09f6", x"0a1c", x"0a42", x"0a69", x"0a91", x"0aba", x"0ae4", x"0b0e", x"0b3a", x"0b66", x"0b93", x"0bc1", x"0bf0", x"0c21", x"0c52", x"0c85",
      x"0cb8", x"0ced", x"0d23", x"0d5b", x"0d94", x"0dce", x"0e0a", x"0e47", x"0e87", x"0ec7", x"0f0a", x"0f4f", x"0f95", x"0fde", x"1029", x"1077",
      x"10c6", x"1119", x"116f", x"11c7", x"1223", x"1282", x"12e5", x"134c", x"13b7", x"1427", x"149c", x"1516", x"1597", x"161e", x"16ad", x"1743",
      x"17e3", x"188d", x"1943", x"1a07", x"1ada", x"1bbf", x"1cb9", x"1dce", x"1f04", x"2063", x"21f8", x"23d8", x"2627", x"292c", x"2d95", x"364e",
      x"fbb8", x"fbb6", x"fbb5", x"fbb4", x"fbb2", x"fbb1", x"fbaf", x"fbae", x"fbac", x"fbab", x"fbaa", x"fba8", x"fba7", x"fba5", x"fba4", x"fba2",
      x"fba1", x"fba0", x"fb9e", x"fb9d", x"fb9b", x"fb9a", x"fb99", x"fb97", x"fb96", x"fb94", x"fb93", x"fb91", x"fb90", x"fb8f", x"fb8d", x"fb8c",
      x"fb8a", x"fb89", x"fb87", x"fb86", x"fb85", x"fb83", x"fb82", x"fb80", x"fb7f", x"fb7d", x"fb7c", x"fb7b", x"fb79", x"fb78", x"fb76", x"fb75",
      x"fb73", x"fb72", x"fb71", x"fb6f", x"fb6e", x"fb6c", x"fb6b", x"fb69", x"fb68", x"fb67", x"fb65", x"fb64", x"fb62", x"fb61", x"fb5f", x"fb5e",
      x"fb5d", x"fb5b", x"fb5a", x"fb58", x"fb57", x"fb55", x"fb54", x"fb53", x"fb51", x"fb50", x"fb4e", x"fb4d", x"fb4b", x"fb4a", x"fb49", x"fb47",
      x"fb46", x"fb44", x"fb43", x"fb42", x"fb40", x"fb3f", x"fb3d", x"fb3c", x"fb3a", x"fb39", x"fb38", x"fb36", x"fb35", x"fb33", x"fb32", x"fb30",
      x"fb2f", x"fb2e", x"fb2c", x"fb2b", x"fb29", x"fb28", x"fb26", x"fb25", x"fb24", x"fb22", x"fb21", x"fb1f", x"fb1e", x"fb1c", x"fb1b", x"fb1a",
      x"fb18", x"fb17", x"fb15", x"fb14", x"fb12", x"fb11", x"fb10", x"fb0e", x"fb0d", x"fb0b", x"fb0a", x"fb08", x"fb07", x"fb06", x"fb04", x"fb03",
      x"fb01", x"fb00", x"fafe", x"fafd", x"fafc", x"fafa", x"faf9", x"faf7", x"faf6", x"faf4", x"faf3", x"faf2", x"faf0", x"faef", x"faed", x"faec",
      x"faeb", x"fae9", x"fae8", x"fae6", x"fae5", x"fae3", x"fae2", x"fae1", x"fadf", x"fade", x"fadc", x"fadb", x"fad9", x"fad8", x"fad7", x"fad5",
      x"fad4", x"fad2", x"fad1", x"facf", x"face", x"facd", x"facb", x"faca", x"fac8", x"fac7", x"fac5", x"fac4", x"fac3", x"fac1", x"fac0", x"fabe",
      x"fabd", x"fabb", x"faba", x"fab9", x"fab7", x"fab6", x"fab4", x"fab3", x"fab1", x"fab0", x"faaf", x"faad", x"faac", x"faaa", x"faa9", x"faa7",
      x"faa6", x"faa5", x"faa3", x"faa2", x"faa0", x"fa9f", x"fa9d", x"fa9c", x"fa9b", x"fa99", x"fa98", x"fa96", x"fa95", x"fa94", x"fa92", x"fa91",
      x"fa8f", x"fa8e", x"fa8c", x"fa8b", x"fa8a", x"fa88", x"fa87", x"fa85", x"fa84", x"fa82", x"fa81", x"fa80", x"fa7e", x"fa7d", x"fa7b", x"fa7a",
      x"fa78", x"fa77", x"fa76", x"fa74", x"fa73", x"fa71", x"fa70", x"fa6e", x"fa6d", x"fa6c", x"fa6a", x"fa69", x"fa67", x"fa66", x"fa64", x"fa63",
      x"fa62", x"fa60", x"fa5f", x"fa5d", x"fa5c", x"fa5a", x"fa59", x"fa58", x"fa56", x"fa55", x"fa53", x"fa52", x"fa50", x"fa4f", x"fa4e", x"fbc7"
					);

			else
			--Cycle 0
			if(inp(15) = '0')then
				addr <= unsigned(inp(14 downto 4));
				sign <= '0';
				err <= signed(coef(to_integer(addr)));
  			else
				addr <= unsigned(not(inp(14 downto 4)));
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













		
