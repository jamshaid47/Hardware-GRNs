library ieee; 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


entity sin_cos is
	port 
		(
		clk			:	in 	std_logic;
		reset	      :	in 	std_logic;
		in_ang 		:	in 	std_logic_vector(15 downto 4);  
		out_sin 	   :	out 	std_logic_vector (15 downto 0);
  		out_cos 	   :	out 	std_logic_vector (15 downto 0)
		);


	end sin_cos ;

architecture behave of sin_cos is

type 		data_array16 is array (integer range <>) of std_logic_vector(15 downto 0);

signal  	sin_rom 	: 	data_array16(0 to 1023);
signal	sin0 : std_logic_vector(15 downto 4); 
signal   ind_sin, ind_cos  : unsigned(9 downto 0);
signal   sign_sin, sign_cos : std_logic;

begin 

--main process that that starts with start of internal clock,
process (reset, clk)

begin
	if (clk'event and clk = '1') then
		if(reset = '1')then
			sin_rom <=
			(
			x"0000", x"0032", x"0065", x"0097", x"00c9", x"00fc", x"012e", x"0160", 
			x"0193", x"01c5", x"01f7", x"0229", x"025c", x"028e", x"02c0", x"02f3",
			x"0325", x"0357", x"038a", x"03bc", x"03ee", x"0420", x"0453", x"0485", 
			x"04b7", x"04ea", x"051c", x"054e", x"0580", x"05b3", x"05e5", x"0617",
			x"0649", x"067c", x"06ae", x"06e0", x"0712", x"0745", x"0777", x"07a9", 
			x"07db", x"080e", x"0840", x"0872", x"08a4", x"08d6", x"0909", x"093b",
			x"096d", x"099f", x"09d1", x"0a03", x"0a36", x"0a68", x"0a9a", x"0acc", 
			x"0afe", x"0b30", x"0b62", x"0b95", x"0bc7", x"0bf9", x"0c2b", x"0c5d",
			x"0c8f", x"0cc1", x"0cf3", x"0d25", x"0d57", x"0d89", x"0dbb", x"0ded", 
			x"0e1f", x"0e51", x"0e83", x"0eb5", x"0ee7", x"0f19", x"0f4b", x"0f7d",
			x"0faf", x"0fe1", x"1013", x"1045", x"1077", x"10a9", x"10da", x"110c", 
			x"113e", x"1170", x"11a2", x"11d4", x"1206", x"1237", x"1269", x"129b",
			x"12cd", x"12fe", x"1330", x"1362", x"1394", x"13c5", x"13f7", x"1429", 
			x"145b", x"148c", x"14be", x"14ef", x"1521", x"1553", x"1584", x"15b6",
			x"15e8", x"1619", x"164b", x"167c", x"16ae", x"16df", x"1711", x"1742", 
			x"1774", x"17a5", x"17d7", x"1808", x"1839", x"186b", x"189c", x"18ce",
			x"18ff", x"1930", x"1962", x"1993", x"19c4", x"19f5", x"1a27", x"1a58", 
			x"1a89", x"1aba", x"1aec", x"1b1d", x"1b4e", x"1b7f", x"1bb0", x"1be1",
			x"1c12", x"1c43", x"1c75", x"1ca6", x"1cd7", x"1d08", x"1d39", x"1d6a", 
			x"1d9b", x"1dcc", x"1dfc", x"1e2d", x"1e5e", x"1e8f", x"1ec0", x"1ef1",
			x"1f22", x"1f52", x"1f83", x"1fb4", x"1fe5", x"2015", x"2046", x"2077", 
			x"20a7", x"20d8", x"2109", x"2139", x"216a", x"219a", x"21cb", x"21fb",
			x"222c", x"225c", x"228d", x"22bd", x"22ee", x"231e", x"234f", x"237f", 
			x"23af", x"23e0", x"2410", x"2440", x"2470", x"24a1", x"24d1", x"2501",
			x"2531", x"2561", x"2591", x"25c1", x"25f1", x"2622", x"2652", x"2682", 
			x"26b1", x"26e1", x"2711", x"2741", x"2771", x"27a1", x"27d1", x"2801",
			x"2830", x"2860", x"2890", x"28c0", x"28ef", x"291f", x"294f", x"297e", 
			x"29ae", x"29dd", x"2a0d", x"2a3c", x"2a6c", x"2a9b", x"2acb", x"2afa",
			x"2b2a", x"2b59", x"2b88", x"2bb8", x"2be7", x"2c16", x"2c45", x"2c74", 
			x"2ca4", x"2cd3", x"2d02", x"2d31", x"2d60", x"2d8f", x"2dbe", x"2ded",
			x"2e1c", x"2e4b", x"2e7a", x"2ea9", x"2ed8", x"2f06", x"2f35", x"2f64", 
			x"2f93", x"2fc1", x"2ff0", x"301f", x"304d", x"307c", x"30aa", x"30d9",
			x"3107", x"3136", x"3164", x"3193", x"31c1", x"31ef", x"321e", x"324c", 
			x"327a", x"32a8", x"32d7", x"3305", x"3333", x"3361", x"338f", x"33bd",
			x"33eb", x"3419", x"3447", x"3475", x"34a3", x"34d1", x"34ff", x"352c", 
			x"355a", x"3588", x"35b5", x"35e3", x"3611", x"363e", x"366c", x"3699",
			x"36c7", x"36f4", x"3722", x"374f", x"377d", x"37aa", x"37d7", x"3804", 
			x"3832", x"385f", x"388c", x"38b9", x"38e6", x"3913", x"3940", x"396d",
			x"399a", x"39c7", x"39f4", x"3a21", x"3a4e", x"3a7a", x"3aa7", x"3ad4", 
			x"3b01", x"3b2d", x"3b5a", x"3b86", x"3bb3", x"3bdf", x"3c0c", x"3c38",
			x"3c65", x"3c91", x"3cbd", x"3cea", x"3d16", x"3d42", x"3d6e", x"3d9a", 
			x"3dc6", x"3df2", x"3e1e", x"3e4a", x"3e76", x"3ea2", x"3ece", x"3efa",
			x"3f26", x"3f51", x"3f7d", x"3fa9", x"3fd4", x"4000", x"402c", x"4057", 
			x"4083", x"40ae", x"40d9", x"4105", x"4130", x"415b", x"4187", x"41b2",
			x"41dd", x"4208", x"4233", x"425e", x"4289", x"42b4", x"42df", x"430a", 
			x"4335", x"4360", x"438a", x"43b5", x"43e0", x"440a", x"4435", x"4460",
			x"448a", x"44b5", x"44df", x"4509", x"4534", x"455e", x"4588", x"45b3", 
			x"45dd", x"4607", x"4631", x"465b", x"4685", x"46af", x"46d9", x"4703",
			x"472d", x"4756", x"4780", x"47aa", x"47d4", x"47fd", x"4827", x"4850", 
			x"487a", x"48a3", x"48cd", x"48f6", x"491f", x"4949", x"4972", x"499b",
			x"49c4", x"49ed", x"4a16", x"4a3f", x"4a68", x"4a91", x"4aba", x"4ae3", 
			x"4b0c", x"4b34", x"4b5d", x"4b86", x"4bae", x"4bd7", x"4bff", x"4c28",
			x"4c50", x"4c79", x"4ca1", x"4cc9", x"4cf1", x"4d1a", x"4d42", x"4d6a", 
			x"4d92", x"4dba", x"4de2", x"4e0a", x"4e32", x"4e59", x"4e81", x"4ea9",
			x"4ed1", x"4ef8", x"4f20", x"4f47", x"4f6f", x"4f96", x"4fbe", x"4fe5", 
			x"500c", x"5034", x"505b", x"5082", x"50a9", x"50d0", x"50f7", x"511e",
			x"5145", x"516c", x"5192", x"51b9", x"51e0", x"5207", x"522d", x"5254", 
			x"527a", x"52a1", x"52c7", x"52ed", x"5314", x"533a", x"5360", x"5386",
			x"53ac", x"53d2", x"53f8", x"541e", x"5444", x"546a", x"5490", x"54b6", 
			x"54db", x"5501", x"5527", x"554c", x"5572", x"5597", x"55bc", x"55e2",
			x"5607", x"562c", x"5652", x"5677", x"569c", x"56c1", x"56e6", x"570b", 
			x"572f", x"5754", x"5779", x"579e", x"57c2", x"57e7", x"580c", x"5830",
			x"5855", x"5879", x"589d", x"58c2", x"58e6", x"590a", x"592e", x"5952", 
			x"5976", x"599a", x"59be", x"59e2", x"5a06", x"5a29", x"5a4d", x"5a71",
			x"5a94", x"5ab8", x"5adb", x"5aff", x"5b22", x"5b45", x"5b69", x"5b8c", 
			x"5baf", x"5bd2", x"5bf5", x"5c18", x"5c3b", x"5c5e", x"5c81", x"5ca3",
			x"5cc6", x"5ce9", x"5d0b", x"5d2e", x"5d50", x"5d73", x"5d95", x"5db7", 
			x"5dda", x"5dfc", x"5e1e", x"5e40", x"5e62", x"5e84", x"5ea6", x"5ec8",
			x"5ee9", x"5f0b", x"5f2d", x"5f4e", x"5f70", x"5f92", x"5fb3", x"5fd4", 
			x"5ff6", x"6017", x"6038", x"6059", x"607a", x"609b", x"60bc", x"60dd",
			x"60fe", x"611f", x"6140", x"6160", x"6181", x"61a2", x"61c2", x"61e3", 
			x"6203", x"6223", x"6244", x"6264", x"6284", x"62a4", x"62c4", x"62e4",
			x"6304", x"6324", x"6344", x"6363", x"6383", x"63a3", x"63c2", x"63e2", 
			x"6401", x"6420", x"6440", x"645f", x"647e", x"649d", x"64bc", x"64db",
			x"64fa", x"6519", x"6538", x"6557", x"6576", x"6594", x"65b3", x"65d1", 
			x"65f0", x"660e", x"662d", x"664b", x"6669", x"6687", x"66a5", x"66c3",
			x"66e1", x"66ff", x"671d", x"673b", x"6759", x"6776", x"6794", x"67b1", 
			x"67cf", x"67ec", x"680a", x"6827", x"6844", x"6861", x"687e", x"689b",
			x"68b8", x"68d5", x"68f2", x"690f", x"692b", x"6948", x"6965", x"6981", 
			x"699e", x"69ba", x"69d6", x"69f3", x"6a0f", x"6a2b", x"6a47", x"6a63",
			x"6a7f", x"6a9b", x"6ab7", x"6ad3", x"6aee", x"6b0a", x"6b25", x"6b41", 
			x"6b5c", x"6b78", x"6b93", x"6bae", x"6bc9", x"6be4", x"6c00", x"6c1a",
			x"6c35", x"6c50", x"6c6b", x"6c86", x"6ca0", x"6cbb", x"6cd5", x"6cf0", 
			x"6d0a", x"6d25", x"6d3f", x"6d59", x"6d73", x"6d8d", x"6da7", x"6dc1",
			x"6ddb", x"6df5", x"6e0f", x"6e28", x"6e42", x"6e5b", x"6e75", x"6e8e", 
			x"6ea7", x"6ec1", x"6eda", x"6ef3", x"6f0c", x"6f25", x"6f3e", x"6f57",
			x"6f70", x"6f88", x"6fa1", x"6fba", x"6fd2", x"6feb", x"7003", x"701b", 
			x"7034", x"704c", x"7064", x"707c", x"7094", x"70ac", x"70c4", x"70db",
			x"70f3", x"710b", x"7122", x"713a", x"7151", x"7169", x"7180", x"7197", 
			x"71ae", x"71c5", x"71dc", x"71f3", x"720a", x"7221", x"7238", x"724e",
			x"7265", x"727c", x"7292", x"72a8", x"72bf", x"72d5", x"72eb", x"7301", 
			x"7317", x"732d", x"7343", x"7359", x"736f", x"7385", x"739a", x"73b0",
			x"73c5", x"73db", x"73f0", x"7405", x"741b", x"7430", x"7445", x"745a", 
			x"746f", x"7484", x"7498", x"74ad", x"74c2", x"74d6", x"74eb", x"74ff",
			x"7514", x"7528", x"753c", x"7550", x"7565", x"7579", x"758d", x"75a0", 
			x"75b4", x"75c8", x"75dc", x"75ef", x"7603", x"7616", x"762a", x"763d",
			x"7650", x"7663", x"7676", x"7689", x"769c", x"76af", x"76c2", x"76d5", 
			x"76e7", x"76fa", x"770d", x"771f", x"7731", x"7744", x"7756", x"7768",
			x"777a", x"778c", x"779e", x"77b0", x"77c2", x"77d4", x"77e5", x"77f7", 
			x"7808", x"781a", x"782b", x"783c", x"784e", x"785f", x"7870", x"7881",
			x"7892", x"78a3", x"78b3", x"78c4", x"78d5", x"78e5", x"78f6", x"7906", 
			x"7917", x"7927", x"7937", x"7947", x"7957", x"7967", x"7977", x"7987",
			x"7997", x"79a6", x"79b6", x"79c6", x"79d5", x"79e4", x"79f4", x"7a03", 
			x"7a12", x"7a21", x"7a30", x"7a3f", x"7a4e", x"7a5d", x"7a6c", x"7a7a",
			x"7a89", x"7a97", x"7aa6", x"7ab4", x"7ac2", x"7ad1", x"7adf", x"7aed", 
			x"7afb", x"7b09", x"7b17", x"7b24", x"7b32", x"7b40", x"7b4d", x"7b5b",
			x"7b68", x"7b75", x"7b83", x"7b90", x"7b9d", x"7baa", x"7bb7", x"7bc4", 
			x"7bd1", x"7bdd", x"7bea", x"7bf7", x"7c03", x"7c0f", x"7c1c", x"7c28",
			x"7c34", x"7c40", x"7c4c", x"7c58", x"7c64", x"7c70", x"7c7c", x"7c88", 
			x"7c93", x"7c9f", x"7caa", x"7cb6", x"7cc1", x"7ccc", x"7cd7", x"7ce2",
			x"7ced", x"7cf8", x"7d03", x"7d0e", x"7d18", x"7d23", x"7d2e", x"7d38", 
			x"7d43", x"7d4d", x"7d57", x"7d61", x"7d6b", x"7d75", x"7d7f", x"7d89",
			x"7d93", x"7d9d", x"7da6", x"7db0", x"7db9", x"7dc3", x"7dcc", x"7dd5", 
			x"7ddf", x"7de8", x"7df1", x"7dfa", x"7e02", x"7e0b", x"7e14", x"7e1d",
			x"7e25", x"7e2e", x"7e36", x"7e3e", x"7e47", x"7e4f", x"7e57", x"7e5f", 
			x"7e67", x"7e6f", x"7e77", x"7e7e", x"7e86", x"7e8e", x"7e95", x"7e9d",
			x"7ea4", x"7eab", x"7eb2", x"7eba", x"7ec1", x"7ec8", x"7ece", x"7ed5", 
			x"7edc", x"7ee3", x"7ee9", x"7ef0", x"7ef6", x"7efd", x"7f03", x"7f09",
			x"7f0f", x"7f15", x"7f1b", x"7f21", x"7f27", x"7f2d", x"7f32", x"7f38", 
			x"7f3d", x"7f43", x"7f48", x"7f4e", x"7f53", x"7f58", x"7f5d", x"7f62",
			x"7f67", x"7f6c", x"7f70", x"7f75", x"7f7a", x"7f7e", x"7f83", x"7f87", 
			x"7f8b", x"7f8f", x"7f94", x"7f98", x"7f9c", x"7f9f", x"7fa3", x"7fa7",
			x"7fab", x"7fae", x"7fb2", x"7fb5", x"7fb9", x"7fbc", x"7fbf", x"7fc2", 
			x"7fc5", x"7fc8", x"7fcb", x"7fce", x"7fd1", x"7fd3", x"7fd6", x"7fd8",
			x"7fdb", x"7fdd", x"7fe0", x"7fe2", x"7fe4", x"7fe6", x"7fe8", x"7fea", 
			x"7fec", x"7fed", x"7fef", x"7ff1", x"7ff2", x"7ff3", x"7ff5", x"7ff6",
			x"7ff7", x"7ff8", x"7ff9", x"7ffa", x"7ffb", x"7ffc", x"7ffd", x"7ffe", 
			x"7ffe", x"7fff", x"7fff", x"7fff", x"7fff", x"7fff", x"7fff", x"7fff"
			);

			else
			 --Cycle 0
			 sin0 <= in_ang;

			 --Cycle 1
			 if (sin0(15 downto 12) < x"4") then
				  ind_sin  <= unsigned(sin0(13 downto 4));
				  ind_cos  <= 1023 - unsigned(sin0(13 downto 4));
				  sign_sin <= '0';
				  sign_cos <= '0';
			 elsif (sin0(15 downto 12) < x"8") then
				  ind_sin  <= 1023 - unsigned(sin0(13 downto 4));
				  ind_cos  <= unsigned(sin0(13 downto 4));
				  sign_sin <= '0';
				  sign_cos <= '1';
			 elsif (sin0(15 downto 12) < x"c") then
				  ind_sin  <= unsigned(sin0(13 downto 4));
			 	 ind_cos  <= 1023 - unsigned(sin0(13 downto 4));
				  sign_sin <= '1';
				  sign_cos <= '1';
			 else
				  ind_sin  <= 1023 - unsigned(sin0(13 downto 4));
				  ind_cos  <= unsigned(sin0(13 downto 4));
				  sign_sin <= '1';
				  sign_cos <= '0';
			 end if;
	
			 --Cycle 2
			 if (sign_sin = '0') then
				  out_sin <= sin_rom(to_integer(ind_sin));
			 else
				  out_sin <= std_logic_vector(unsigned(not(sin_rom(to_integer(ind_sin)))) + 1);
			 end if;

			 if (sign_cos = '0') then
				  out_cos <= sin_rom(to_integer(ind_cos));
			 else
				out_cos <= std_logic_vector(unsigned(not(sin_rom(to_integer(ind_cos)))) + 1);
			 end if;
			end if;
		end if;
end process ;
end behave;













		
