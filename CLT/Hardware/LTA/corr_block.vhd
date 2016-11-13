library ieee; 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


entity corr_block is
	port 
		(
		clk			:	in 	std_logic;
		reset	:	in 	std_logic;
		inp			:	in 	std_logic_vector(15 downto 0);  
		outp	 :	out 	std_logic_vector (15 downto 0)
		);


	end corr_block ;

architecture behave of corr_block is

type 		data_array32 is array (integer range <>) of std_logic_vector(31 downto 0);

signal   in_sq : signed(31 downto 0); 
signal  	a_tr 	: 	data_array32(0 to 1023);
signal  	b_tr	: 	data_array32(0 to 1023);
signal  	c_tr	: 	data_array32(0 to 1023);
signal	  sin0, sin1, sin2 : std_logic_vector(15 downto 0); 
signal	  sign : std_logic; 
signal   a_tr1, b_tr1, c_tr1 : signed(31 downto 0); 
signal   a_tr2 : signed(63 downto 0); 
signal   b_tr2 : signed(47 downto 0); 
signal   c_tr2 : signed(31 downto 0); 
signal   outps : signed(32 downto 0); 
signal   addr : unsigned(9 downto 0);  


begin 

--main process that that starts with start of internal clock,
process (reset, clk)
begin
	if (clk'event and clk = '1') then
		if(reset = '0')then
			a_tr <=
			(
			
			
			
			
			x"00000000", x"ffffffff", x"fffffffe", x"fffffffd", x"fffffffd", x"fffffffc", x"fffffffb", x"fffffffa", x"fffffffa", x"fffffff9", x"fffffff8", x"fffffff8", x"fffffff7", x"fffffff6", x"fffffff5", x"fffffff5",
			x"fffffff4", x"fffffff3", x"fffffff2", x"fffffff2", x"fffffff1", x"fffffff0", x"ffffffef", x"ffffffef", x"ffffffee", x"ffffffed", x"ffffffed", x"ffffffec", x"ffffffeb", x"ffffffea", x"ffffffea", x"ffffffe9",
			x"ffffffe8", x"ffffffe7", x"ffffffe7", x"ffffffe6", x"ffffffe5", x"ffffffe4", x"ffffffe4", x"ffffffe3", x"ffffffe2", x"ffffffe1", x"ffffffe1", x"ffffffe0", x"ffffffdf", x"ffffffdf", x"ffffffde", x"ffffffdd",
			x"ffffffdc", x"ffffffdc", x"ffffffdb", x"ffffffda", x"ffffffd9", x"ffffffd9", x"ffffffd8", x"ffffffd7", x"ffffffd6", x"ffffffd6", x"ffffffd5", x"ffffffd4", x"ffffffd3", x"ffffffd3", x"ffffffd2", x"ffffffd1",
			x"ffffffd0", x"ffffffd0", x"ffffffcf", x"ffffffce", x"ffffffcd", x"ffffffcd", x"ffffffcc", x"ffffffcb", x"ffffffca", x"ffffffca", x"ffffffc9", x"ffffffc8", x"ffffffc7", x"ffffffc7", x"ffffffc6", x"ffffffc5",
			x"ffffffc4", x"ffffffc4", x"ffffffc3", x"ffffffc2", x"ffffffc1", x"ffffffc1", x"ffffffc0", x"ffffffbf", x"ffffffbe", x"ffffffbe", x"ffffffbd", x"ffffffbc", x"ffffffbb", x"ffffffba", x"ffffffba", x"ffffffb9",
			x"ffffffb8", x"ffffffb7", x"ffffffb7", x"ffffffb6", x"ffffffb5", x"ffffffb4", x"ffffffb4", x"ffffffb3", x"ffffffb2", x"ffffffb1", x"ffffffb0", x"ffffffb0", x"ffffffaf", x"ffffffae", x"ffffffad", x"ffffffad",
			x"ffffffac", x"ffffffab", x"ffffffaa", x"ffffffa9", x"ffffffa9", x"ffffffa8", x"ffffffa7", x"ffffffa6", x"ffffffa5", x"ffffffa5", x"ffffffa4", x"ffffffa3", x"ffffffa2", x"ffffffa1", x"ffffffa1", x"ffffffa0",
			x"ffffff9f", x"ffffff9e", x"ffffff9e", x"ffffff9d", x"ffffff9c", x"ffffff9b", x"ffffff9a", x"ffffff99", x"ffffff99", x"ffffff98", x"ffffff97", x"ffffff96", x"ffffff95", x"ffffff95", x"ffffff94", x"ffffff93",
			x"ffffff92", x"ffffff91", x"ffffff91", x"ffffff90", x"ffffff8f", x"ffffff8e", x"ffffff8d", x"ffffff8c", x"ffffff8c", x"ffffff8b", x"ffffff8a", x"ffffff89", x"ffffff88", x"ffffff87", x"ffffff87", x"ffffff86",
			x"ffffff85", x"ffffff84", x"ffffff83", x"ffffff82", x"ffffff82", x"ffffff81", x"ffffff80", x"ffffff7f", x"ffffff7e", x"ffffff7d", x"ffffff7d", x"ffffff7c", x"ffffff7b", x"ffffff7a", x"ffffff79", x"ffffff78",
			x"ffffff77", x"ffffff77", x"ffffff76", x"ffffff75", x"ffffff74", x"ffffff73", x"ffffff72", x"ffffff71", x"ffffff70", x"ffffff70", x"ffffff6f", x"ffffff6e", x"ffffff6d", x"ffffff6c", x"ffffff6b", x"ffffff6a",
			x"ffffff69", x"ffffff69", x"ffffff68", x"ffffff67", x"ffffff66", x"ffffff65", x"ffffff64", x"ffffff63", x"ffffff62", x"ffffff61", x"ffffff61", x"ffffff60", x"ffffff5f", x"ffffff5e", x"ffffff5d", x"ffffff5c",
			x"ffffff5b", x"ffffff5a", x"ffffff59", x"ffffff58", x"ffffff57", x"ffffff56", x"ffffff56", x"ffffff55", x"ffffff54", x"ffffff53", x"ffffff52", x"ffffff51", x"ffffff50", x"ffffff4f", x"ffffff4e", x"ffffff4d",
			x"ffffff4c", x"ffffff4b", x"ffffff4a", x"ffffff49", x"ffffff48", x"ffffff47", x"ffffff46", x"ffffff45", x"ffffff44", x"ffffff44", x"ffffff43", x"ffffff42", x"ffffff41", x"ffffff40", x"ffffff3f", x"ffffff3e",
			x"ffffff3d", x"ffffff3c", x"ffffff3b", x"ffffff3a", x"ffffff39", x"ffffff38", x"ffffff37", x"ffffff36", x"ffffff35", x"ffffff34", x"ffffff33", x"ffffff32", x"ffffff31", x"ffffff30", x"ffffff2f", x"ffffff27",
			x"ffffff26", x"ffffff25", x"ffffff24", x"ffffff23", x"ffffff21", x"ffffff20", x"ffffff1f", x"ffffff1e", x"ffffff1d", x"ffffff1c", x"ffffff1b", x"ffffff1a", x"ffffff19", x"ffffff18", x"ffffff17", x"ffffff15",
			x"ffffff14", x"ffffff13", x"ffffff12", x"ffffff11", x"ffffff10", x"ffffff0f", x"ffffff0e", x"ffffff0d", x"ffffff0b", x"ffffff0a", x"ffffff09", x"ffffff08", x"ffffff07", x"ffffff06", x"ffffff05", x"ffffff03",
			x"ffffff02", x"ffffff01", x"ffffff00", x"fffffeff", x"fffffefe", x"fffffefc", x"fffffefb", x"fffffefa", x"fffffef9", x"fffffef8", x"fffffef7", x"fffffef5", x"fffffef4", x"fffffef3", x"fffffef2", x"fffffef0",
			x"fffffeef", x"fffffeee", x"fffffeed", x"fffffeec", x"fffffeea", x"fffffee9", x"fffffee8", x"fffffee7", x"fffffee5", x"fffffee4", x"fffffee3", x"fffffee2", x"fffffee0", x"fffffedf", x"fffffede", x"fffffedd",
			x"fffffedb", x"fffffeda", x"fffffed9", x"fffffed7", x"fffffed6", x"fffffed5", x"fffffed4", x"fffffed2", x"fffffed1", x"fffffed0", x"fffffece", x"fffffecd", x"fffffecc", x"fffffeca", x"fffffec9", x"fffffec8",
			x"fffffec6", x"fffffec5", x"fffffec4", x"fffffec2", x"fffffec1", x"fffffebf", x"fffffebe", x"fffffebd", x"fffffebb", x"fffffeba", x"fffffeb9", x"fffffeb7", x"fffffeb6", x"fffffeb4", x"fffffeb3", x"fffffeb1",
			x"fffffeb0", x"fffffeaf", x"fffffead", x"fffffeac", x"fffffeaa", x"fffffea9", x"fffffea7", x"fffffea6", x"fffffea4", x"fffffea3", x"fffffea1", x"fffffea0", x"fffffe9e", x"fffffe9d", x"fffffe9b", x"fffffe9a",
			x"fffffe98", x"fffffe97", x"fffffe95", x"fffffe94", x"fffffe92", x"fffffe91", x"fffffe8f", x"fffffe8e", x"fffffe8c", x"fffffe8b", x"fffffe89", x"fffffe87", x"fffffe86", x"fffffe84", x"fffffe83", x"fffffe81",
			x"fffffe7f", x"fffffe7e", x"fffffe7c", x"fffffe7b", x"fffffe79", x"fffffe77", x"fffffe76", x"fffffe74", x"fffffe72", x"fffffe71", x"fffffe6f", x"fffffe6d", x"fffffe6c", x"fffffe6a", x"fffffe68", x"fffffe66",
			x"fffffe65", x"fffffe63", x"fffffe61", x"fffffe5f", x"fffffe5e", x"fffffe5c", x"fffffe5a", x"fffffe58", x"fffffe57", x"fffffe55", x"fffffe53", x"fffffe51", x"fffffe4f", x"fffffe4e", x"fffffe4c", x"fffffe4a",
			x"fffffe48", x"fffffe46", x"fffffe44", x"fffffe43", x"fffffe41", x"fffffe3f", x"fffffe3d", x"fffffe3b", x"fffffe39", x"fffffe37", x"fffffe35", x"fffffe33", x"fffffe31", x"fffffe2f", x"fffffe2d", x"fffffe2b",
			x"fffffe29", x"fffffe27", x"fffffe25", x"fffffe23", x"fffffe21", x"fffffe1f", x"fffffe1d", x"fffffe1b", x"fffffe19", x"fffffe17", x"fffffe15", x"fffffe13", x"fffffe11", x"fffffe0f", x"fffffe0d", x"fffffe0b",
			x"fffffe08", x"fffffe06", x"fffffe04", x"fffffe02", x"fffffe00", x"fffffdfe", x"fffffdfb", x"fffffdf9", x"fffffdf7", x"fffffdf5", x"fffffdf3", x"fffffdf0", x"fffffdee", x"fffffdec", x"fffffde9", x"fffffde7",
			x"fffffde5", x"fffffde3", x"fffffde0", x"fffffdde", x"fffffddb", x"fffffdd9", x"fffffdd7", x"fffffdd4", x"fffffdd2", x"fffffdd0", x"fffffdcd", x"fffffdcb", x"fffffdc8", x"fffffdc6", x"fffffdc3", x"fffffdc1",
			x"fffffdbe", x"fffffdbc", x"fffffdb9", x"fffffdb7", x"fffffdb4", x"fffffdb2", x"fffffdaf", x"fffffdac", x"fffffdaa", x"fffffda7", x"fffffda4", x"fffffda2", x"fffffd9f", x"fffffd9c", x"fffffd9a", x"fffffd97",
			x"fffffd94", x"fffffd92", x"fffffd8f", x"fffffd8c", x"fffffd89", x"fffffd86", x"fffffd84", x"fffffd81", x"fffffd7e", x"fffffd7b", x"fffffd78", x"fffffd75", x"fffffd72", x"fffffd6f", x"fffffd6d", x"fffffd6a",
			x"fffffd67", x"fffffd64", x"fffffd61", x"fffffd5e", x"fffffd5a", x"fffffd57", x"fffffd54", x"fffffd51", x"fffffd4e", x"fffffd4b", x"fffffd48", x"fffffd45", x"fffffd41", x"fffffd3e", x"fffffd3b", x"fffffd38",
			x"fffffd34", x"fffffd31", x"fffffd2e", x"fffffd2a", x"fffffd27", x"fffffd24", x"fffffd20", x"fffffd1d", x"fffffd1a", x"fffffd16", x"fffffd13", x"fffffd0f", x"fffffd0c", x"fffffd08", x"fffffd04", x"fffffd01",
			x"fffffcfd", x"fffffcfa", x"fffffcf6", x"fffffcf2", x"fffffcef", x"fffffceb", x"fffffce7", x"fffffce3", x"fffffce0", x"fffffcdc", x"fffffcd8", x"fffffcd4", x"fffffcd0", x"fffffccc", x"fffffcc8", x"fffffcc4",
			x"fffffcc0", x"fffffcbc", x"fffffcb8", x"fffffcb4", x"fffffcb0", x"fffffcac", x"fffffca8", x"fffffca4", x"fffffc9f", x"fffffc9b", x"fffffc97", x"fffffc93", x"fffffc8e", x"fffffc8a", x"fffffc86", x"fffffc81",
			x"fffffc7d", x"fffffc78", x"fffffc74", x"fffffc6f", x"fffffc6b", x"fffffc66", x"fffffc61", x"fffffc5d", x"fffffc58", x"fffffc53", x"fffffc4f", x"fffffc4a", x"fffffc45", x"fffffc40", x"fffffc3b", x"fffffc36",
			x"fffffc31", x"fffffc2c", x"fffffc27", x"fffffc22", x"fffffc1d", x"fffffc18", x"fffffc13", x"fffffc0d", x"fffffc08", x"fffffc03", x"fffffbfe", x"fffffbf8", x"fffffbf3", x"fffffbed", x"fffffbe8", x"fffffbe2",
			x"fffffbdd", x"fffffbd7", x"fffffbd1", x"fffffbcc", x"fffffbc6", x"fffffbc0", x"fffffbba", x"fffffbb4", x"fffffbae", x"fffffba8", x"fffffba2", x"fffffb9c", x"fffffb96", x"fffffb90", x"fffffb8a", x"fffffb84",
			x"fffffb7d", x"fffffb77", x"fffffb70", x"fffffb6a", x"fffffb64", x"fffffb5d", x"fffffb56", x"fffffb50", x"fffffb49", x"fffffb42", x"fffffb3b", x"fffffb34", x"fffffb2d", x"fffffb26", x"fffffb1f", x"fffffb18",
			x"fffffb11", x"fffffb0a", x"fffffb03", x"fffffafb", x"fffffaf4", x"fffffaec", x"fffffae5", x"fffffadd", x"fffffad6", x"ffffface", x"fffffac6", x"fffffabe", x"fffffab6", x"fffffaae", x"fffffaa6", x"fffffa9e",
			x"fffffa96", x"fffffa8d", x"fffffa85", x"fffffa7d", x"fffffa74", x"fffffa6c", x"fffffa63", x"fffffa5a", x"fffffa51", x"fffffa49", x"fffffa40", x"fffffa37", x"fffffa2d", x"fffffa24", x"fffffa1b", x"fffffa12",
			x"fffffa08", x"fffff9fe", x"fffff9f5", x"fffff9eb", x"fffff9e1", x"fffff9d7", x"fffff9cd", x"fffff9c3", x"fffff9b9", x"fffff9af", x"fffff9a4", x"fffff99a", x"fffff98f", x"fffff985", x"fffff97a", x"fffff96f",
			x"fffff964", x"fffff959", x"fffff94e", x"fffff943", x"fffff937", x"fffff92c", x"fffff920", x"fffff914", x"fffff908", x"fffff8fc", x"fffff8f0", x"fffff8e4", x"fffff8d8", x"fffff8cb", x"fffff8bf", x"fffff8b2",
			x"fffff8a5", x"fffff898", x"fffff88b", x"fffff87e", x"fffff870", x"fffff863", x"fffff855", x"fffff847", x"fffff839", x"fffff82b", x"fffff81d", x"fffff80f", x"fffff800", x"fffff7f1", x"fffff7e3", x"fffff7d4",
			x"fffff7c4", x"fffff7b5", x"fffff7a6", x"fffff796", x"fffff786", x"fffff776", x"fffff766", x"fffff756", x"fffff745", x"fffff735", x"fffff724", x"fffff713", x"fffff701", x"fffff6f0", x"fffff6de", x"fffff6cd",
			x"fffff6bb", x"fffff6a8", x"fffff696", x"fffff683", x"fffff671", x"fffff65e", x"fffff64a", x"fffff637", x"fffff623", x"fffff60f", x"fffff5fb", x"fffff5e7", x"fffff5d2", x"fffff5bd", x"fffff5a8", x"fffff593",
			x"fffff57d", x"fffff568", x"fffff552", x"fffff53b", x"fffff525", x"fffff50e", x"fffff4f7", x"fffff4df", x"fffff4c8", x"fffff4b0", x"fffff498", x"fffff47f", x"fffff466", x"fffff44d", x"fffff434", x"fffff41a",
			x"fffff400", x"fffff3e6", x"fffff3cb", x"fffff3b0", x"fffff395", x"fffff37a", x"fffff35e", x"fffff341", x"fffff325", x"fffff308", x"fffff2eb", x"fffff2cd", x"fffff2af", x"fffff290", x"fffff272", x"fffff253",
			x"fffff233", x"fffff213", x"fffff1f3", x"fffff1d2", x"fffff1b1", x"fffff18f", x"fffff16d", x"fffff14b", x"fffff128", x"fffff105", x"fffff0e1", x"fffff0bd", x"fffff098", x"fffff073", x"fffff04e", x"fffff028",
			x"fffff001", x"ffffefda", x"ffffefb2", x"ffffef8a", x"ffffef62", x"ffffef39", x"ffffef0f", x"ffffeee5", x"ffffeeba", x"ffffee8e", x"ffffee62", x"ffffee36", x"ffffee09", x"ffffeddb", x"ffffedad", x"ffffed7e",
			x"ffffed4e", x"ffffed1e", x"ffffeced", x"ffffecbb", x"ffffec89", x"ffffec55", x"ffffec22", x"ffffebed", x"ffffebb8", x"ffffeb82", x"ffffeb4b", x"ffffeb13", x"ffffeadb", x"ffffeaa2", x"ffffea68", x"ffffea2d",
			x"ffffe9f1", x"ffffe9b4", x"ffffe977", x"ffffe938", x"ffffe8f9", x"ffffe8b8", x"ffffe877", x"ffffe835", x"ffffe7f1", x"ffffe7ad", x"ffffe767", x"ffffe721", x"ffffe6d9", x"ffffe690", x"ffffe646", x"ffffe5fb",
			x"ffffe5ae", x"ffffe561", x"ffffe512", x"ffffe4c1", x"ffffe470", x"ffffe41d", x"ffffe3c9", x"ffffe373", x"ffffe31c", x"ffffe2c3", x"ffffe269", x"ffffe20d", x"ffffe1b0", x"ffffe151", x"ffffe0f0", x"ffffe08e",
			x"ffffe02a", x"ffffdfc4", x"ffffdf5c", x"ffffdef2", x"ffffde87", x"ffffde19", x"ffffdda9", x"ffffdd38", x"ffffdcc4", x"ffffdc4e", x"ffffdbd5", x"ffffdb5b", x"ffffdade", x"ffffda5e", x"ffffd9dc", x"ffffd958",
			x"ffffd8d1", x"ffffd847", x"ffffd7ba", x"ffffd72b", x"ffffd698", x"ffffd603", x"ffffd56a", x"ffffd4ce", x"ffffd42f", x"ffffd38d", x"ffffd2e7", x"ffffd23d", x"ffffd190", x"ffffd0de", x"ffffd029", x"ffffcf70",
			x"ffffceb3", x"ffffcdf1", x"ffffcd2b", x"ffffcc61", x"ffffcb92", x"ffffcabd", x"ffffc9e4", x"ffffc906", x"ffffc822", x"ffffc739", x"ffffc64a", x"ffffc555", x"ffffc45a", x"ffffc359", x"ffffc251", x"ffffc142",
			x"ffffc02d", x"ffffbf10", x"ffffbdec", x"ffffbcc0", x"ffffbb8c", x"ffffba4f", x"ffffb90a", x"ffffb7bc", x"ffffb664", x"ffffb503", x"ffffb398", x"ffffb223", x"ffffb0a2", x"ffffaf17", x"ffffad7f", x"ffffabdc",
			x"ffffaa2b", x"ffffa86e", x"ffffa6a3", x"ffffa4c9", x"ffffa2e0", x"ffffa0e8", x"ffff9ee0", x"ffff9cc6", x"ffff9a9b", x"ffff985d", x"ffff960c", x"ffff93a6", x"ffff912b", x"ffff8e9a", x"ffff8bf2", x"ffff8931",
			x"ffff8656", x"ffff8361", x"ffff804f", x"ffff7d1f", x"ffff79d0", x"ffff7660", x"ffff72cd", x"ffff6f16", x"ffff6b38", x"ffff6731", x"ffff6300", x"ffff5ea1", x"ffff5a12", x"ffff554f", x"ffff5057", x"ffff4b26",
			x"ffff45b8", x"ffff4009", x"ffff3a15", x"ffff33d9", x"ffff2d4e", x"ffff2670", x"ffff1f3a", x"ffff17a4", x"ffff0fa9", x"ffff0740", x"fffefe63", x"fffef507", x"fffeeb25", x"fffee0b0", x"fffed59e", x"fffec9e2",
			x"fffebd6e", x"fffeb032", x"fffea21d", x"fffe931c", x"fffe8319", x"fffe71fd", x"fffe5fae", x"fffe4c0c", x"fffe36f8", x"fffe204a", x"fffe07d8", x"fffded71", x"fffdd0de", x"fffdb1e0", x"fffd902d", x"fffd6b71",
			x"fffd434c", x"fffd174d", x"fffce6f0", x"fffcb19a", x"fffc7694", x"fffc3508", x"fffbebf0", x"fffb9a17", x"fffb3e03", x"fffad5e8", x"fffa5f90", x"fff9d83a", x"fff93c75", x"fff887de", x"fff7b4d4", x"fff6bc05",
			x"fff593c1", x"fff42f00", x"fff27be9", x"fff06178", x"ffedbbbf", x"ffea559c", x"ffe5ddb7", x"ffdfd258", x"ffd75a06", x"ffcaf0b8", x"ffb7a887", x"ff973533", x"ff59d9ff", x"fece0447", x"fd05f662", x"e82550d5"
			);
			b_tr <=
			(
			
			x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c",
			x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c",
			x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c", x"0000036c",
			x"0000036c", x"0000036c", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b",
			x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036b", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a",
			x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"0000036a", x"00000369", x"00000369", x"00000369", x"00000369", x"00000369", x"00000369", x"00000369",
			x"00000369", x"00000369", x"00000369", x"00000369", x"00000369", x"00000369", x"00000369", x"00000368", x"00000368", x"00000368", x"00000368", x"00000368", x"00000368", x"00000368", x"00000368", x"00000368",
			x"00000368", x"00000368", x"00000368", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000367", x"00000366", x"00000366",
			x"00000366", x"00000366", x"00000366", x"00000366", x"00000366", x"00000366", x"00000366", x"00000366", x"00000365", x"00000365", x"00000365", x"00000365", x"00000365", x"00000365", x"00000365", x"00000365",
			x"00000365", x"00000364", x"00000364", x"00000364", x"00000364", x"00000364", x"00000364", x"00000364", x"00000364", x"00000363", x"00000363", x"00000363", x"00000363", x"00000363", x"00000363", x"00000363",
			x"00000363", x"00000362", x"00000362", x"00000362", x"00000362", x"00000362", x"00000362", x"00000362", x"00000361", x"00000361", x"00000361", x"00000361", x"00000361", x"00000361", x"00000361", x"00000360",
			x"00000360", x"00000360", x"00000360", x"00000360", x"00000360", x"00000360", x"0000035f", x"0000035f", x"0000035f", x"0000035f", x"0000035f", x"0000035f", x"0000035e", x"0000035e", x"0000035e", x"0000035e",
			x"0000035e", x"0000035e", x"0000035d", x"0000035d", x"0000035d", x"0000035d", x"0000035d", x"0000035d", x"0000035c", x"0000035c", x"0000035c", x"0000035c", x"0000035c", x"0000035c", x"0000035b", x"0000035b",
			x"0000035b", x"0000035b", x"0000035b", x"0000035a", x"0000035a", x"0000035a", x"0000035a", x"0000035a", x"00000359", x"00000359", x"00000359", x"00000359", x"00000359", x"00000358", x"00000358", x"00000358",
			x"00000358", x"00000358", x"00000357", x"00000357", x"00000357", x"00000357", x"00000357", x"00000356", x"00000356", x"00000356", x"00000356", x"00000355", x"00000355", x"00000355", x"00000355", x"00000355",
			x"00000354", x"00000354", x"00000354", x"00000354", x"00000353", x"00000353", x"00000353", x"00000353", x"00000352", x"00000352", x"00000352", x"00000352", x"00000351", x"00000351", x"00000351", x"0000034f",
			x"0000034f", x"0000034f", x"0000034e", x"0000034e", x"0000034e", x"0000034e", x"0000034d", x"0000034d", x"0000034d", x"0000034c", x"0000034c", x"0000034c", x"0000034c", x"0000034b", x"0000034b", x"0000034b",
			x"0000034a", x"0000034a", x"0000034a", x"0000034a", x"00000349", x"00000349", x"00000349", x"00000348", x"00000348", x"00000348", x"00000347", x"00000347", x"00000347", x"00000346", x"00000346", x"00000346",
			x"00000346", x"00000345", x"00000345", x"00000345", x"00000344", x"00000344", x"00000344", x"00000343", x"00000343", x"00000342", x"00000342", x"00000342", x"00000341", x"00000341", x"00000341", x"00000340",
			x"00000340", x"00000340", x"0000033f", x"0000033f", x"0000033f", x"0000033e", x"0000033e", x"0000033d", x"0000033d", x"0000033d", x"0000033c", x"0000033c", x"0000033c", x"0000033b", x"0000033b", x"0000033a",
			x"0000033a", x"0000033a", x"00000339", x"00000339", x"00000338", x"00000338", x"00000337", x"00000337", x"00000337", x"00000336", x"00000336", x"00000335", x"00000335", x"00000334", x"00000334", x"00000334",
			x"00000333", x"00000333", x"00000332", x"00000332", x"00000331", x"00000331", x"00000330", x"00000330", x"00000330", x"0000032f", x"0000032f", x"0000032e", x"0000032e", x"0000032d", x"0000032d", x"0000032c",
			x"0000032c", x"0000032b", x"0000032b", x"0000032a", x"0000032a", x"00000329", x"00000329", x"00000328", x"00000328", x"00000327", x"00000327", x"00000326", x"00000326", x"00000325", x"00000324", x"00000324",
			x"00000323", x"00000323", x"00000322", x"00000322", x"00000321", x"00000321", x"00000320", x"0000031f", x"0000031f", x"0000031e", x"0000031e", x"0000031d", x"0000031d", x"0000031c", x"0000031b", x"0000031b",
			x"0000031a", x"0000031a", x"00000319", x"00000318", x"00000318", x"00000317", x"00000316", x"00000316", x"00000315", x"00000315", x"00000314", x"00000313", x"00000313", x"00000312", x"00000311", x"00000311",
			x"00000310", x"0000030f", x"0000030f", x"0000030e", x"0000030d", x"0000030c", x"0000030c", x"0000030b", x"0000030a", x"0000030a", x"00000309", x"00000308", x"00000307", x"00000307", x"00000306", x"00000305",
			x"00000305", x"00000304", x"00000303", x"00000302", x"00000301", x"00000301", x"00000300", x"000002ff", x"000002fe", x"000002fe", x"000002fd", x"000002fc", x"000002fb", x"000002fa", x"000002f9", x"000002f9",
			x"000002f8", x"000002f7", x"000002f6", x"000002f5", x"000002f4", x"000002f4", x"000002f3", x"000002f2", x"000002f1", x"000002f0", x"000002ef", x"000002ee", x"000002ed", x"000002ec", x"000002eb", x"000002eb",
			x"000002ea", x"000002e9", x"000002e8", x"000002e7", x"000002e6", x"000002e5", x"000002e4", x"000002e3", x"000002e2", x"000002e1", x"000002e0", x"000002df", x"000002de", x"000002dd", x"000002dc", x"000002db",
			x"000002da", x"000002d9", x"000002d8", x"000002d7", x"000002d5", x"000002d4", x"000002d3", x"000002d2", x"000002d1", x"000002d0", x"000002cf", x"000002ce", x"000002cd", x"000002cb", x"000002ca", x"000002c9",
			x"000002c8", x"000002c7", x"000002c6", x"000002c4", x"000002c3", x"000002c2", x"000002c1", x"000002bf", x"000002be", x"000002bd", x"000002bc", x"000002ba", x"000002b9", x"000002b8", x"000002b7", x"000002b5",
			x"000002b4", x"000002b3", x"000002b1", x"000002b0", x"000002af", x"000002ad", x"000002ac", x"000002aa", x"000002a9", x"000002a8", x"000002a6", x"000002a5", x"000002a3", x"000002a2", x"000002a0", x"0000029f",
			x"0000029d", x"0000029c", x"0000029a", x"00000299", x"00000297", x"00000296", x"00000294", x"00000293", x"00000291", x"0000028f", x"0000028e", x"0000028c", x"0000028b", x"00000289", x"00000287", x"00000286",
			x"00000284", x"00000282", x"00000280", x"0000027f", x"0000027d", x"0000027b", x"00000279", x"00000278", x"00000276", x"00000274", x"00000272", x"00000270", x"0000026f", x"0000026d", x"0000026b", x"00000269",
			x"00000267", x"00000265", x"00000263", x"00000261", x"0000025f", x"0000025d", x"0000025b", x"00000259", x"00000257", x"00000255", x"00000253", x"00000251", x"0000024f", x"0000024d", x"0000024a", x"00000248",
			x"00000246", x"00000244", x"00000242", x"0000023f", x"0000023d", x"0000023b", x"00000239", x"00000236", x"00000234", x"00000232", x"0000022f", x"0000022d", x"0000022a", x"00000228", x"00000225", x"00000223",
			x"00000221", x"0000021e", x"0000021b", x"00000219", x"00000216", x"00000214", x"00000211", x"0000020e", x"0000020c", x"00000209", x"00000206", x"00000204", x"00000201", x"000001fe", x"000001fb", x"000001f8",
			x"000001f5", x"000001f3", x"000001f0", x"000001ed", x"000001ea", x"000001e7", x"000001e4", x"000001e1", x"000001de", x"000001da", x"000001d7", x"000001d4", x"000001d1", x"000001ce", x"000001ca", x"000001c7",
			x"000001c4", x"000001c0", x"000001bd", x"000001ba", x"000001b6", x"000001b3", x"000001af", x"000001ac", x"000001a8", x"000001a5", x"000001a1", x"0000019d", x"0000019a", x"00000196", x"00000192", x"0000018e",
			x"0000018a", x"00000187", x"00000183", x"0000017f", x"0000017b", x"00000177", x"00000173", x"0000016e", x"0000016a", x"00000166", x"00000162", x"0000015e", x"00000159", x"00000155", x"00000151", x"0000014c",
			x"00000148", x"00000143", x"0000013e", x"0000013a", x"00000135", x"00000130", x"0000012c", x"00000127", x"00000122", x"0000011d", x"00000118", x"00000113", x"0000010e", x"00000109", x"00000104", x"000000ff",
			x"000000f9", x"000000f4", x"000000ef", x"000000e9", x"000000e4", x"000000de", x"000000d9", x"000000d3", x"000000cd", x"000000c8", x"000000c2", x"000000bc", x"000000b6", x"000000b0", x"000000aa", x"000000a4",
			x"0000009d", x"00000097", x"00000091", x"0000008a", x"00000084", x"0000007d", x"00000077", x"00000070", x"00000069", x"00000062", x"0000005c", x"00000055", x"0000004e", x"00000046", x"0000003f", x"00000038",
			x"00000030", x"00000029", x"00000021", x"0000001a", x"00000012", x"0000000a", x"00000002", x"fffffffa", x"fffffff2", x"ffffffea", x"ffffffe2", x"ffffffda", x"ffffffd1", x"ffffffc9", x"ffffffc0", x"ffffffb7",
			x"ffffffae", x"ffffffa6", x"ffffff9c", x"ffffff93", x"ffffff8a", x"ffffff81", x"ffffff77", x"ffffff6e", x"ffffff64", x"ffffff5a", x"ffffff50", x"ffffff46", x"ffffff3c", x"ffffff32", x"ffffff27", x"ffffff1d",
			x"ffffff12", x"ffffff07", x"fffffefd", x"fffffef1", x"fffffee6", x"fffffedb", x"fffffed0", x"fffffec4", x"fffffeb8", x"fffffeac", x"fffffea0", x"fffffe94", x"fffffe88", x"fffffe7b", x"fffffe6f", x"fffffe62",
			x"fffffe55", x"fffffe48", x"fffffe3b", x"fffffe2d", x"fffffe20", x"fffffe12", x"fffffe04", x"fffffdf6", x"fffffde7", x"fffffdd9", x"fffffdca", x"fffffdbb", x"fffffdac", x"fffffd9d", x"fffffd8e", x"fffffd7e",
			x"fffffd6e", x"fffffd5e", x"fffffd4e", x"fffffd3e", x"fffffd2d", x"fffffd1c", x"fffffd0b", x"fffffcfa", x"fffffce8", x"fffffcd6", x"fffffcc4", x"fffffcb2", x"fffffca0", x"fffffc8d", x"fffffc7a", x"fffffc67",
			x"fffffc53", x"fffffc3f", x"fffffc2b", x"fffffc17", x"fffffc03", x"fffffbee", x"fffffbd9", x"fffffbc3", x"fffffbae", x"fffffb98", x"fffffb81", x"fffffb6b", x"fffffb54", x"fffffb3d", x"fffffb25", x"fffffb0d",
			x"fffffaf5", x"fffffadd", x"fffffac4", x"fffffaab", x"fffffa91", x"fffffa78", x"fffffa5d", x"fffffa43", x"fffffa28", x"fffffa0d", x"fffff9f1", x"fffff9d5", x"fffff9b8", x"fffff99b", x"fffff97e", x"fffff960",
			x"fffff942", x"fffff924", x"fffff905", x"fffff8e5", x"fffff8c5", x"fffff8a5", x"fffff884", x"fffff863", x"fffff841", x"fffff81f", x"fffff7fc", x"fffff7d9", x"fffff7b5", x"fffff791", x"fffff76c", x"fffff746",
			x"fffff720", x"fffff6fa", x"fffff6d3", x"fffff6ab", x"fffff683", x"fffff65a", x"fffff630", x"fffff606", x"fffff5db", x"fffff5af", x"fffff583", x"fffff556", x"fffff529", x"fffff4fa", x"fffff4cb", x"fffff49b",
			x"fffff46b", x"fffff43a", x"fffff407", x"fffff3d4", x"fffff3a1", x"fffff36c", x"fffff336", x"fffff300", x"fffff2c9", x"fffff291", x"fffff257", x"fffff21d", x"fffff1e2", x"fffff1a6", x"fffff169", x"fffff12b",
			x"fffff0eb", x"fffff0ab", x"fffff069", x"fffff027", x"ffffefe3", x"ffffef9e", x"ffffef57", x"ffffef10", x"ffffeec7", x"ffffee7d", x"ffffee31", x"ffffede4", x"ffffed96", x"ffffed46", x"ffffecf5", x"ffffeca2",
			x"ffffec4d", x"ffffebf7", x"ffffeb9f", x"ffffeb46", x"ffffeaeb", x"ffffea8e", x"ffffea2f", x"ffffe9ce", x"ffffe96b", x"ffffe907", x"ffffe8a0", x"ffffe837", x"ffffe7cc", x"ffffe75f", x"ffffe6f0", x"ffffe67e",
			x"ffffe60a", x"ffffe593", x"ffffe51a", x"ffffe49e", x"ffffe420", x"ffffe39f", x"ffffe31b", x"ffffe294", x"ffffe20a", x"ffffe17d", x"ffffe0ec", x"ffffe059", x"ffffdfc2", x"ffffdf27", x"ffffde89", x"ffffdde7",
			x"ffffdd42", x"ffffdc98", x"ffffdbeb", x"ffffdb39", x"ffffda83", x"ffffd9c8", x"ffffd909", x"ffffd845", x"ffffd77b", x"ffffd6ad", x"ffffd5da", x"ffffd501", x"ffffd423", x"ffffd33e", x"ffffd254", x"ffffd163",
			x"ffffd06c", x"ffffcf6e", x"ffffce69", x"ffffcd5d", x"ffffcc49", x"ffffcb2e", x"ffffca0a", x"ffffc8de", x"ffffc7aa", x"ffffc66c", x"ffffc525", x"ffffc3d5", x"ffffc27a", x"ffffc114", x"ffffbfa4", x"ffffbe28",
			x"ffffbca1", x"ffffbb0c", x"ffffb96b", x"ffffb7bd", x"ffffb600", x"ffffb435", x"ffffb25a", x"ffffb06f", x"ffffae74", x"ffffac66", x"ffffaa47", x"ffffa814", x"ffffa5ce", x"ffffa372", x"ffffa100", x"ffff9e77",
			x"ffff9bd5", x"ffff991a", x"ffff9644", x"ffff9351", x"ffff9041", x"ffff8d12", x"ffff89c1", x"ffff864e", x"ffff82b5", x"ffff7ef6", x"ffff7b0e", x"ffff76fa", x"ffff72b9", x"ffff6e46", x"ffff69a0", x"ffff64c3",
			x"ffff5fac", x"ffff5a57", x"ffff54bf", x"ffff4ee2", x"ffff48ba", x"ffff4241", x"ffff3b73", x"ffff3449", x"ffff2cbe", x"ffff24c9", x"ffff1c63", x"ffff1384", x"ffff0a22", x"ffff0032", x"fffef5ab", x"fffeea7f",
			x"fffedea0", x"fffed1ff", x"fffec48c", x"fffeb634", x"fffea6e1", x"fffe967e", x"fffe84ee", x"fffe7216", x"fffe5dd4", x"fffe4804", x"fffe307a", x"fffe1708", x"fffdfb76", x"fffddd87", x"fffdbcf2", x"fffd9966",
			x"fffd7282", x"fffd47d8", x"fffd18e5", x"fffce512", x"fffcabaa", x"fffc6bd8", x"fffc249c", x"fffbd4c2", x"fffb7ad7", x"fffb1513", x"fffaa146", x"fffa1cb7", x"fff983fc", x"fff8d2bf", x"fff8036c", x"fff70ebe",
			x"fff5eb1b", x"fff48b94", x"fff2de70", x"fff0cad5", x"ffee2d0d", x"ffead041", x"ffe66386", x"ffe065be", x"ffd7fe56", x"ffcbaab5", x"ffb87f57", x"ff98345a", x"ff5b15ed", x"fecfa72b", x"fd087328", x"e82be45e"
			);

			c_tr <=
			(
			x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff",
			x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff",
			x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"ffffffff", x"fffffffe", x"fffffffe",
			x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe",
			x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffe", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd",
			x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffd", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc", x"fffffffc",
			x"fffffffc", x"fffffffc", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffb", x"fffffffa", x"fffffffa", x"fffffffa",
			x"fffffffa", x"fffffffa", x"fffffffa", x"fffffffa", x"fffffffa", x"fffffffa", x"fffffffa", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff9", x"fffffff8",
			x"fffffff8", x"fffffff8", x"fffffff8", x"fffffff8", x"fffffff8", x"fffffff8", x"fffffff8", x"fffffff7", x"fffffff7", x"fffffff7", x"fffffff7", x"fffffff7", x"fffffff7", x"fffffff7", x"fffffff6", x"fffffff6",
			x"fffffff6", x"fffffff6", x"fffffff6", x"fffffff6", x"fffffff5", x"fffffff5", x"fffffff5", x"fffffff5", x"fffffff5", x"fffffff5", x"fffffff5", x"fffffff4", x"fffffff4", x"fffffff4", x"fffffff4", x"fffffff4",
			x"fffffff3", x"fffffff3", x"fffffff3", x"fffffff3", x"fffffff3", x"fffffff3", x"fffffff2", x"fffffff2", x"fffffff2", x"fffffff2", x"fffffff2", x"fffffff1", x"fffffff1", x"fffffff1", x"fffffff1", x"fffffff0",
			x"fffffff0", x"fffffff0", x"fffffff0", x"fffffff0", x"ffffffef", x"ffffffef", x"ffffffef", x"ffffffef", x"ffffffee", x"ffffffee", x"ffffffee", x"ffffffee", x"ffffffed", x"ffffffed", x"ffffffed", x"ffffffec",
			x"ffffffec", x"ffffffec", x"ffffffeb", x"ffffffeb", x"ffffffeb", x"ffffffea", x"ffffffea", x"ffffffea", x"ffffffea", x"ffffffe9", x"ffffffe9", x"ffffffe9", x"ffffffe8", x"ffffffe8", x"ffffffe8", x"ffffffe8",
			x"ffffffe7", x"ffffffe7", x"ffffffe7", x"ffffffe6", x"ffffffe6", x"ffffffe6", x"ffffffe5", x"ffffffe5", x"ffffffe5", x"ffffffe4", x"ffffffe4", x"ffffffe4", x"ffffffe3", x"ffffffe3", x"ffffffe2", x"ffffffe2",
			x"ffffffe2", x"ffffffe1", x"ffffffe1", x"ffffffe1", x"ffffffe0", x"ffffffe0", x"ffffffdf", x"ffffffdf", x"ffffffdf", x"ffffffde", x"ffffffde", x"ffffffdd", x"ffffffdd", x"ffffffdd", x"ffffffdc", x"ffffffdc",
			x"ffffffdb", x"ffffffdb", x"ffffffdb", x"ffffffda", x"ffffffda", x"ffffffd9", x"ffffffd9", x"ffffffd8", x"ffffffd8", x"ffffffd7", x"ffffffd7", x"ffffffd6", x"ffffffd6", x"ffffffd5", x"ffffffd5", x"ffffffd4",
			x"ffffffd4", x"ffffffd3", x"ffffffd3", x"ffffffd2", x"ffffffd2", x"ffffffd1", x"ffffffd1", x"ffffffd0", x"ffffffd0", x"ffffffcf", x"ffffffcf", x"ffffffce", x"ffffffce", x"ffffffcd", x"ffffffcc", x"ffffffcc",
			x"ffffffcb", x"ffffffcb", x"ffffffca", x"ffffffca", x"ffffffc9", x"ffffffc8", x"ffffffc8", x"ffffffc7", x"ffffffc6", x"ffffffc6", x"ffffffc5", x"ffffffc5", x"ffffffc4", x"ffffffc3", x"ffffffc3", x"ffffffc2",
			x"ffffffc1", x"ffffffc1", x"ffffffc0", x"ffffffbf", x"ffffffbe", x"ffffffbe", x"ffffffbd", x"ffffffbc", x"ffffffbc", x"ffffffbb", x"ffffffba", x"ffffffb9", x"ffffffb9", x"ffffffb8", x"ffffffb7", x"ffffffb6",
			x"ffffffb6", x"ffffffb5", x"ffffffb4", x"ffffffb3", x"ffffffb2", x"ffffffb1", x"ffffffb1", x"ffffffb0", x"ffffffaf", x"ffffffae", x"ffffffad", x"ffffffac", x"ffffffac", x"ffffffab", x"ffffffaa", x"ffffffa9",
			x"ffffffa8", x"ffffffa7", x"ffffffa6", x"ffffffa5", x"ffffffa4", x"ffffffa3", x"ffffffa2", x"ffffffa1", x"ffffffa0", x"ffffff9f", x"ffffff9e", x"ffffff9d", x"ffffff9c", x"ffffff9b", x"ffffff9a", x"ffffff99",
			x"ffffff98", x"ffffff97", x"ffffff96", x"ffffff95", x"ffffff94", x"ffffff93", x"ffffff92", x"ffffff91", x"ffffff8f", x"ffffff8e", x"ffffff8d", x"ffffff8c", x"ffffff8b", x"ffffff8a", x"ffffff88", x"ffffff87",
			x"ffffff86", x"ffffff85", x"ffffff84", x"ffffff82", x"ffffff81", x"ffffff80", x"ffffff7e", x"ffffff7d", x"ffffff7c", x"ffffff7b", x"ffffff79", x"ffffff78", x"ffffff77", x"ffffff75", x"ffffff74", x"ffffff72",
			x"ffffff71", x"ffffff70", x"ffffff6e", x"ffffff6d", x"ffffff6b", x"ffffff6a", x"ffffff68", x"ffffff67", x"ffffff65", x"ffffff64", x"ffffff62", x"ffffff61", x"ffffff5f", x"ffffff5d", x"ffffff5c", x"ffffff5a",
			x"ffffff59", x"ffffff57", x"ffffff55", x"ffffff54", x"ffffff52", x"ffffff50", x"ffffff4e", x"ffffff4d", x"ffffff4b", x"ffffff49", x"ffffff47", x"ffffff46", x"ffffff44", x"ffffff42", x"ffffff40", x"ffffff3e",
			x"ffffff3c", x"ffffff3a", x"ffffff38", x"ffffff36", x"ffffff34", x"ffffff32", x"ffffff30", x"ffffff2e", x"ffffff2c", x"ffffff2a", x"ffffff28", x"ffffff26", x"ffffff24", x"ffffff22", x"ffffff20", x"ffffff1e",
			x"ffffff1b", x"ffffff19", x"ffffff17", x"ffffff15", x"ffffff12", x"ffffff10", x"ffffff0e", x"ffffff0b", x"ffffff09", x"ffffff07", x"ffffff04", x"ffffff02", x"fffffeff", x"fffffefd", x"fffffefa", x"fffffef8",
			x"fffffef5", x"fffffef3", x"fffffef0", x"fffffeed", x"fffffeeb", x"fffffee8", x"fffffee5", x"fffffee3", x"fffffee0", x"fffffedd", x"fffffeda", x"fffffed7", x"fffffed4", x"fffffed2", x"fffffecf", x"fffffecc",
			x"fffffec9", x"fffffec6", x"fffffec3", x"fffffec0", x"fffffebc", x"fffffeb9", x"fffffeb6", x"fffffeb3", x"fffffeb0", x"fffffead", x"fffffea9", x"fffffea6", x"fffffea3", x"fffffe9f", x"fffffe9c", x"fffffe98",
			x"fffffe95", x"fffffe91", x"fffffe8e", x"fffffe8a", x"fffffe87", x"fffffe83", x"fffffe7f", x"fffffe7b", x"fffffe78", x"fffffe74", x"fffffe70", x"fffffe6c", x"fffffe68", x"fffffe64", x"fffffe60", x"fffffe5c",
			x"fffffe58", x"fffffe54", x"fffffe50", x"fffffe4c", x"fffffe48", x"fffffe43", x"fffffe3f", x"fffffe3b", x"fffffe36", x"fffffe32", x"fffffe2d", x"fffffe29", x"fffffe24", x"fffffe1f", x"fffffe1b", x"fffffe16",
			x"fffffe11", x"fffffe0c", x"fffffe08", x"fffffe03", x"fffffdfe", x"fffffdf9", x"fffffdf4", x"fffffdee", x"fffffde9", x"fffffde4", x"fffffddf", x"fffffdd9", x"fffffdd4", x"fffffdce", x"fffffdc9", x"fffffdc3",
			x"fffffdbe", x"fffffdb8", x"fffffdb2", x"fffffdad", x"fffffda7", x"fffffda1", x"fffffd9b", x"fffffd95", x"fffffd8f", x"fffffd88", x"fffffd82", x"fffffd7c", x"fffffd76", x"fffffd6f", x"fffffd69", x"fffffd62",
			x"fffffd5b", x"fffffd55", x"fffffd4e", x"fffffd47", x"fffffd40", x"fffffd39", x"fffffd32", x"fffffd2b", x"fffffd24", x"fffffd1c", x"fffffd15", x"fffffd0e", x"fffffd06", x"fffffcfe", x"fffffcf7", x"fffffcef",
			x"fffffce7", x"fffffcdf", x"fffffcd7", x"fffffccf", x"fffffcc7", x"fffffcbe", x"fffffcb6", x"fffffcad", x"fffffca5", x"fffffc9c", x"fffffc93", x"fffffc8b", x"fffffc82", x"fffffc78", x"fffffc6f", x"fffffc66",
			x"fffffc5d", x"fffffc53", x"fffffc4a", x"fffffc40", x"fffffc36", x"fffffc2c", x"fffffc22", x"fffffc18", x"fffffc0e", x"fffffc03", x"fffffbf9", x"fffffbee", x"fffffbe4", x"fffffbd9", x"fffffbce", x"fffffbc3",
			x"fffffbb8", x"fffffbac", x"fffffba1", x"fffffb95", x"fffffb89", x"fffffb7e", x"fffffb72", x"fffffb65", x"fffffb59", x"fffffb4d", x"fffffb40", x"fffffb33", x"fffffb27", x"fffffb19", x"fffffb0c", x"fffffaff",
			x"fffffaf2", x"fffffae4", x"fffffad6", x"fffffac8", x"fffffaba", x"fffffaac", x"fffffa9d", x"fffffa8f", x"fffffa80", x"fffffa71", x"fffffa62", x"fffffa52", x"fffffa43", x"fffffa33", x"fffffa23", x"fffffa13",
			x"fffffa03", x"fffff9f2", x"fffff9e1", x"fffff9d1", x"fffff9bf", x"fffff9ae", x"fffff99d", x"fffff98b", x"fffff979", x"fffff967", x"fffff954", x"fffff942", x"fffff92f", x"fffff91c", x"fffff908", x"fffff8f5",
			x"fffff8e1", x"fffff8cd", x"fffff8b8", x"fffff8a4", x"fffff88f", x"fffff87a", x"fffff865", x"fffff84f", x"fffff839", x"fffff823", x"fffff80c", x"fffff7f5", x"fffff7de", x"fffff7c7", x"fffff7af", x"fffff797",
			x"fffff77f", x"fffff766", x"fffff74e", x"fffff734", x"fffff71b", x"fffff701", x"fffff6e7", x"fffff6cc", x"fffff6b1", x"fffff696", x"fffff67a", x"fffff65e", x"fffff642", x"fffff625", x"fffff608", x"fffff5ea",
			x"fffff5cc", x"fffff5ae", x"fffff58f", x"fffff570", x"fffff550", x"fffff530", x"fffff510", x"fffff4ef", x"fffff4cd", x"fffff4ab", x"fffff489", x"fffff466", x"fffff443", x"fffff41f", x"fffff3fb", x"fffff3d7",
			x"fffff3b1", x"fffff38c", x"fffff365", x"fffff33f", x"fffff317", x"fffff2ef", x"fffff2c7", x"fffff29e", x"fffff274", x"fffff24a", x"fffff220", x"fffff1f4", x"fffff1c8", x"fffff19c", x"fffff16f", x"fffff141",
			x"fffff112", x"fffff0e3", x"fffff0b3", x"fffff083", x"fffff051", x"fffff020", x"ffffefed", x"ffffefba", x"ffffef85", x"ffffef51", x"ffffef1b", x"ffffeee5", x"ffffeead", x"ffffee75", x"ffffee3d", x"ffffee03",
			x"ffffedc9", x"ffffed8d", x"ffffed51", x"ffffed14", x"ffffecd6", x"ffffec97", x"ffffec58", x"ffffec17", x"ffffebd5", x"ffffeb92", x"ffffeb4f", x"ffffeb0a", x"ffffeac5", x"ffffea7e", x"ffffea36", x"ffffe9ed",
			x"ffffe9a3", x"ffffe958", x"ffffe90c", x"ffffe8bf", x"ffffe870", x"ffffe821", x"ffffe7d0", x"ffffe77e", x"ffffe72a", x"ffffe6d6", x"ffffe680", x"ffffe629", x"ffffe5d0", x"ffffe576", x"ffffe51b", x"ffffe4be",
			x"ffffe460", x"ffffe400", x"ffffe39f", x"ffffe33d", x"ffffe2d9", x"ffffe273", x"ffffe20c", x"ffffe1a3", x"ffffe138", x"ffffe0cc", x"ffffe05e", x"ffffdfee", x"ffffdf7c", x"ffffdf09", x"ffffde94", x"ffffde1c",
			x"ffffdda3", x"ffffdd28", x"ffffdcab", x"ffffdc2c", x"ffffdbab", x"ffffdb28", x"ffffdaa2", x"ffffda1a", x"ffffd990", x"ffffd904", x"ffffd875", x"ffffd7e4", x"ffffd751", x"ffffd6bb", x"ffffd622", x"ffffd587",
			x"ffffd4e9", x"ffffd449", x"ffffd3a5", x"ffffd2ff", x"ffffd256", x"ffffd1aa", x"ffffd0fb", x"ffffd048", x"ffffcf93", x"ffffceda", x"ffffce1e", x"ffffcd5f", x"ffffcc9c", x"ffffcbd5", x"ffffcb0b", x"ffffca3d",
			x"ffffc96c", x"ffffc896", x"ffffc7bc", x"ffffc6df", x"ffffc5fd", x"ffffc517", x"ffffc42c", x"ffffc33d", x"ffffc249", x"ffffc151", x"ffffc054", x"ffffbf51", x"ffffbe4a", x"ffffbd3d", x"ffffbc2b", x"ffffbb14",
			x"ffffb9f7", x"ffffb8d4", x"ffffb7ab", x"ffffb67c", x"ffffb547", x"ffffb40b", x"ffffb2c9", x"ffffb180", x"ffffb030", x"ffffaed8", x"ffffad7a", x"ffffac14", x"ffffaaa6", x"ffffa930", x"ffffa7b2", x"ffffa62b",
			x"ffffa49c", x"ffffa304", x"ffffa162", x"ffff9fb7", x"ffff9e03", x"ffff9c44", x"ffff9a7b", x"ffff98a7", x"ffff96c9", x"ffff94df", x"ffff92e9", x"ffff90e7", x"ffff8ed9", x"ffff8cbf", x"ffff8a97", x"ffff8861",
			x"ffff861d", x"ffff83cb", x"ffff816a", x"ffff7efa", x"ffff7c79", x"ffff79e8", x"ffff7746", x"ffff7493", x"ffff71cd", x"ffff6ef4", x"ffff6c08", x"ffff6907", x"ffff65f2", x"ffff62c7", x"ffff5f86", x"ffff5c2d",
			x"ffff58bc", x"ffff5533", x"ffff518f", x"ffff4dd1", x"ffff49f7", x"ffff4600", x"ffff41eb", x"ffff3db6", x"ffff3961", x"ffff34eb", x"ffff3052", x"ffff2b94", x"ffff26b0", x"ffff21a4", x"ffff1c70", x"ffff1710",
			x"ffff1184", x"ffff0bca", x"ffff05de", x"fffeffc0", x"fffef96e", x"fffef2e3", x"fffeec1f", x"fffee51f", x"fffedddf", x"fffed65d", x"fffece96", x"fffec686", x"fffebe2b", x"fffeb57f", x"fffeac7f", x"fffea328",
			x"fffe9974", x"fffe8f5f", x"fffe84e4", x"fffe79fe", x"fffe6ea6", x"fffe62d7", x"fffe568a", x"fffe49b8", x"fffe3c5a", x"fffe2e68", x"fffe1fd8", x"fffe10a3", x"fffe00be", x"fffdf01e", x"fffddeb9", x"fffdcc81",
			x"fffdb96a", x"fffda565", x"fffd9063", x"fffd7a52", x"fffd6322", x"fffd4abe", x"fffd3110", x"fffd1602", x"fffcf97a", x"fffcdb5d", x"fffcbb8b", x"fffc99e4", x"fffc7644", x"fffc5082", x"fffc2872", x"fffbfde4",
			x"fffbd0a3", x"fffba073", x"fffb6d11", x"fffb3636", x"fffafb8e", x"fffabcc0", x"fffa7964", x"fffa3109", x"fff9e32c", x"fff98f3d", x"fff93495", x"fff8d27a", x"fff86814", x"fff7f46e", x"fff77670", x"fff6ecd4",
			x"fff65621", x"fff5b0a4", x"fff4fa5b", x"fff430ed", x"fff35196", x"fff25908", x"fff14353", x"fff00bb9", x"ffeeac7a", x"ffed1e8f", x"ffeb594f", x"ffe951f6", x"ffe6fafb", x"ffe4432e", x"ffe11475", x"ffdd5200",
			x"ffd8d5ad", x"ffd36c2c", x"ffcccf11", x"ffc49ba3", x"ffba43e7", x"ffacf5b2", x"ff9b6efe", x"ff83adbc", x"ff625340", x"ff315ad2", x"fee51ffa", x"fe64949c", x"fd710d14", x"fb44ecb1", x"f42b828a", x"a0c99f37"

			);

			else
	--Cycle 0
			if(inp(15) = '0')then
				addr <= unsigned(inp(14 downto 5));
				sign <= '0';
  			else
				addr <= unsigned(not(inp(14 downto 5)));
				sign <= '1';
			end if;
			sin0 <= inp;
			
			--Cycle 1
			in_sq <= signed(sin0)*signed(sin0); --5.11 x 5.11 = 10.22
			if(sign = '0')then
				a_tr1 <= -signed(a_tr(to_integer(addr)));
				c_tr1 <= -signed(c_tr(to_integer(addr)));
  			else
				a_tr1 <= signed(a_tr(to_integer(addr)));
				c_tr1 <= signed(c_tr(to_integer(addr)));
			end if;
			b_tr1 <= signed(b_tr(to_integer(addr)));
			sin1 <= sin0;
			
			--Cycle 2
      a_tr2 <= a_tr1*in_sq; --10.22 x 16.16 = 26.38
      b_tr2 <= b_tr1*signed(sin1); --5.11 x 21.11 = 26.22
      c_tr2 <= c_tr1; --22.10 x 0.0 = 22.10

			--Cycle 3
			outps <=c_tr2 & '0' + a_tr2(59 downto 27) + b_tr2(43 downto 11) ;

		end if;
	end if;
end process ;
			outp <= std_logic_vector(outps(15 downto 0));
end behave;








		

