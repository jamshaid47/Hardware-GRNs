-- ============= genlfsr.vhd ============== 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity ln_sq_add is 
   
 port 
    ( 
    clk   : in  std_logic; 
    reset : in  std_logic; 
    inp   : in  std_logic_vector(15 downto 0);
	  M     : out std_logic_vector(15 downto 0);
    C     : out std_logic_vector(15 downto 0);
    outp  : out std_logic_vector(15 downto 0)
    ); 
 end ln_sq_add; 
 
architecture beh of ln_sq_add is 
 
TYPE 		data_array16 IS ARRAY (integer range <>) OF std_logic_vector(15 downto 0);
                                                                                                                                                                                                                                      
signal  	M_tr 	: 	data_array16(0 to 119);
      
signal  	C_tr 	: 	data_array16(0 to 119);		

signal sinp, sinp1, sinp2, sinp3  : std_logic_vector(15 downto 0);

signal add1_01, add1_02, add1_03, add1_04, add1_05: signed(1 downto 0);
signal add1_06, add1_07, add1_08, add1_09, add1_10: signed(1 downto 0);
signal add5_01: signed(5 downto 0);
signal op16_1 : unsigned(15 downto 0);
signal op16_2 : unsigned(15 downto 0);
signal sw   :  unsigned(5 downto 0);
signal sadd, sadd1 :  unsigned(4 downto 0);
signal sadd3 :  unsigned(6 downto 0);
signal sadd_lsb :  unsigned(1 downto 0);
signal sign, sign1 : std_logic;


signal add3_01: signed(4 downto 0);

begin

process (clk, reset) 
  
variable op16 : unsigned(15 downto 0);
    
variable dumm   : integer range 0 to 1000;



variable and14, and13, and12, and11, and10, and09, and08, and07: std_logic; 
variable and06, and05, and04, and03, and02, and01: std_logic; 

variable or14, or13, or12, or11, or10, or09, or08, or07: std_logic; 
variable or06, or05, or04, or03, or02, or01: std_logic; 


variable add2_01, add2_02, add2_03: signed(3 downto 0);

variable dum_m, dum_c :std_logic_vector(127 downto 0);
variable m_add, m_add_b   :  unsigned(5 downto 0);

variable prod1: signed(1 downto 0);
begin  -- process lfsr1 
	if clk'event and clk = '1' then  -- rising clock edge 
		if reset  ='1' then
			M_tr 	<=
			(
			x"fa3e", x"f9e5", x"facc", x"fb76", x"f85a", x"f9b0", x"fa9e", x"fb4e",
			x"f815", x"f976", x"fa6b", x"fb21", x"f7c7", x"f934", x"fa33", x"faee",
			x"f770", x"f8ea", x"f9f2", x"fab5", x"f70d", x"f896", x"f9a9", x"fa74",
			x"f69b", x"f835", x"f954", x"fa27", x"f617", x"f7c4", x"f8f0", x"f9ce",
			x"f57a", x"f73d", x"f878", x"f962", x"f4bc", x"f697", x"f7e5", x"f8dc",
			x"f3ce", x"f5c7", x"f729", x"f831", x"f29b", x"f4b6", x"f630", x"f74a",
			x"f0f6", x"f337", x"f4cd", x"f5fb", x"ee82", x"f0e9", x"f296", x"f3d2",
			x"ea41", x"eca0", x"ee29", x"ef25", x"1046", x"100a", x"1026", x"10a8",
			x"08b0", x"090d", x"098f", x"0a48", x"0583", x"05d8", x"0646", x"06da",
			x"03b7", x"03f7", x"0449", x"04b6", x"0291", x"02c0", x"02fb", x"0349",
			x"01cb", x"01ed", x"0217", x"024f", x"0143", x"015b", x"0179", x"01a1",
			x"00e4", x"00f5", x"010a", x"0126", x"00a1", x"00ad", x"00bc", x"00d0",
			x"0072", x"007a", x"0085", x"0093", x"0050", x"0056", x"005e", x"0068",
			x"0039", x"003d", x"0042", x"0049", x"0028", x"002b", x"002f", x"0034",
			x"001c", x"001f", x"0021", x"0025", x"0014", x"0016", x"0017", x"001a"
			);
      
	
			C_tr <=		
			( 
			x"5e68", x"5e68", x"5dbb", x"5d26", x"5c70", x"5b9a", x"5ae7", x"5a4e",
			x"5991", x"58b4", x"57fc", x"575d", x"569b", x"55b6", x"54f8", x"5453",
			x"538a", x"529d", x"51d7", x"512d", x"505b", x"4f66", x"4e98", x"4de6",
			x"4d0c", x"4c0c", x"4b35", x"4a7c", x"4998", x"488c", x"47ab", x"46e9",
			x"45f9", x"44e0", x"43f3", x"4327", x"422b", x"4101", x"4007", x"3f2f",
			x"3e24", x"3ce8", x"3bdf", x"3af8", x"39dc", x"388b", x"376f", x"3678",
			x"3547", x"33df", x"32ae", x"31a6", x"3060", x"2edf", x"2d9e", x"2c89",
			x"2b3b", x"29bf", x"2899", x"27bc", x"069b", x"06cf", x"06bb", x"0669",
			x"060e", x"05bc", x"055a", x"04e7", x"0487", x"043d", x"03eb", x"038e",
			x"0344", x"030c", x"02cf", x"028a", x"0254", x"022c", x"01ff", x"01ce",
			x"01a7", x"018a", x"016a", x"0148", x"012c", x"0117", x"0101", x"00e8",
			x"00d4", x"00c6", x"00b6", x"00a4", x"0096", x"008c", x"0080", x"0074",
			x"006a", x"0063", x"005b", x"0052", x"004b", x"0046", x"0040", x"003a",
			x"0035", x"0031", x"002d", x"0029", x"0026", x"0023", x"0020", x"001d",
			x"001b", x"0019", x"0017", x"0015", x"0013", x"0011", x"0010", x"000f"		
			);		
		else
			--Cycle 0
			sinp <= inp;
			
			and14 := sinp(14) and sinp(15);
			and13 := sinp(13) and and14;
			and12 := sinp(12) and and13;
			and11 := sinp(11) and and12;
			and10 := sinp(10) and and11;
			and09 := sinp(9) and and10;
			and08 := sinp(8) and and09;
			and07 := sinp(7) and and08;

			and06 := sinp(6) and and07;
			and05 := sinp(5) and and06;
			and04 := sinp(4) and and05;
			and03 := sinp(3) and and04;
			and02 := sinp(2) and and03;
			and01 := sinp(1) and and02;
			

			or14 := sinp(14) or sinp(15);
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
			add1_01 <= ('0' & and14) + ('0' & and13) + ('0' & and12); 
			add1_02 <= ('0' & and11) + ('0' & and10) + ('0' & and09); 
			add1_03 <= ('0' & and08) + ('0' & and07) + ('0' & and06); 
			add1_04 <= ('0' & and05) + ('0' & and04) + ('0' & and03); 
			add1_05 <= ('0' & and02) + ('0' & and01);
       

			add1_06 <= ('0' & or01) + ('0' & or02) + ('0' & or03);    
			add1_07 <= ('0' & or04) + ('0' & or05) + ('0' & or06); 
			add1_08 <= ('0' & or07) + ('0' & or08) + ('0' & or09); 
			add1_09 <= ('0' & or10) + ('0' & or11) + ('0' & or12); 
			add1_10 <= ('0' & or13) + ('0' & or14); 


		

			add2_01 := ("00" & add1_01) + ("00" & add1_02) + ("00" & add1_03) +("00" & add1_04) ;
			add2_02 := ("00" & add1_05) + ("00" & add1_06) + ("00" & add1_07) + ("00" & add1_08);
			add2_03 := ("00" & add1_09) + ("00" & add1_10) + ("000" & sinp1(15));



			--Cycle 2
			sinp2 <= sinp1;
			add3_01 <= ('0' & add2_01) + ('0' & add2_02) + ('0' & add2_03);
			m_add := unsigned('0' & add3_01);
    
			--Cycle 3
			if sinp2(15) >= '1' then
				sw <= m_add-15;
				sinp3 <= std_logic_vector(-signed(sinp2));
				sign <= '1';
			else
				sw <= 14-m_add;
				sinp3 <= sinp2;
				sign <= '0';
			end if; 
			sadd <= m_add(4 downto 0);
			op16 := SHIFT_LEFT(unsigned(sinp3), to_integer(sw));	

			--Cycle 4
  		  sadd_lsb <= op16(13 downto 12);
			sadd1 <= sadd;
			op16_1 <= op16;
			sign1 <= sign;  

			--Cycle 5
		
			if(sign1 = '0') then
				sadd3(1 downto 0) <= sadd_lsb and not(op16_1(15)& op16_1(15));
			else
				sadd3(1 downto 0) <= 3- sadd_lsb and not(op16_1(15)& op16_1(15));
  			end if;
			sadd3(6 downto 2) <=  sadd1;
			op16_2 <= op16_1;
   
      
			--Cycle 6
			M <= M_tr(to_integer(sadd3));
			C <= C_tr(to_integer(sadd3));  
			outp <= std_logic_vector(op16_2); 
--			outp <= std_logic_vector("0000000000" & sw); 
		end if;
	end if;  
end process; 
 
 
end beh; 

