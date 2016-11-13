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

type 		data_array18 is array (integer range <>) of std_logic_vector(17 downto 0);

signal   in_sq : signed(31 downto 0); 
signal  	M_l 	: 	data_array18(0 to 3);
signal  	C_l	: 	data_array18(0 to 3);
signal  	M_nl 	: 	data_array18(0 to 15);
signal  	C_nl	: 	data_array18(0 to 15);

signal	  sin0, sin1, sin2: signed(15 downto 0); 
signal	  sign0, sign1, sign2, sign3, sign4 : std_logic; 
signal   sM, sC : signed(17 downto 0); 
signal   sC1 : signed(19 downto 0); 
signal   outps : signed(33 downto 0); 
signal   outps1: signed(19 downto 0); 
signal   outps2: signed(15 downto 0); 
signal   addr : unsigned(1 downto 0);  


begin 

--main process that that starts with start of internal clock,
process (reset, clk)
begin
	if (clk'event and clk = '1') then
		if(reset = '0')then
			M_l <=
			(
			"000001001100111111", "000001001110000000", "000001010000001101", "000001010100000111"
			);

			M_nl <=
			(
			"000001011011100000", "000001101000100111", "000001111110111001", "000010011101010100",
			"000011000111001101", "000100000100001111", "000101011010011011", "000111010010010110",
			"001001101100111101", "001100000011100100", "001110011101010011", "010000101011010000",
			"010001011110010111", "010101110011110110", "010111001100001100", "011001101011010010"
			);

			C_l <=
			(
			"000000000000000000", "111111111111111000", "111111111111010101", "111111111101110111"
      );

			C_nl <=
			(
			"111111111010001010", "111111110001110001", "111111100001100100", "111111001000110100",
			"111110100100111001", "111101101101101001", "111100011101001101", "111010101011001011",
			"111000010101110000", "110110000010111010", "110011101100010101", "110001100000101010",
			"110000101110010000", "101100011100000110", "101011000100101011", "101000100111000110"			
			);


		else
	
	    --Cycle 0
			if(inp(15) = '0')then
				sin0 <= signed(inp);
				sign0 <= '0';
  			else
				sin0 <= -signed(inp);
				sign0 <= '1';
			end if;
			
      --Cycle 1
      addr <= unsigned(sin0(13 downto 12));			
      sin1 <= sin0;
		  sign1 <= sign0;
    
	    --Cycle 2
		  if(sin1(14) = '0')then
			   sM <= signed(M_l(to_integer(addr)));
		     sC <= signed(C_l(to_integer(addr)));
		  else
				 if(sin1 < 28419)then
				  if(sin1 < 20964)then
				    sM <= signed(M_nl(0));
				    sC <= signed(C_nl(0));
				  elsif(sin1 < 24413)then
				    sM <= signed(M_nl(1));
				    sC <= signed(C_nl(1));
				  elsif(sin1 < 26895)then
				    sM <= signed(M_nl(2));
				    sC <= signed(C_nl(2));
				  else
				    sM <= signed(M_nl(3));
				    sC <= signed(C_nl(3));	
				  end if;	     

				    
				 elsif(sin1 < 31716)then
				  if(sin1 < 29705)then
				    sM <= signed(M_nl(4));
				    sC <= signed(C_nl(4));
				  elsif(sin1 < 30623)then
				    sM <= signed(M_nl(5));
				    sC <= signed(C_nl(5));
				  elsif(sin1 < 31270)then
				    sM <= signed(M_nl(6));
				    sC <= signed(C_nl(6));
				  else
				    sM <= signed(M_nl(7));
				    sC <= signed(C_nl(7));
          end if;
        				    
				 elsif(sin1 < 32310)then
				  if(sin1 < 31999)then
				    sM <= signed(M_nl(8));
				    sC <= signed(C_nl(8));
				  elsif(sin1 < 32146)then
				    sM <= signed(M_nl(9));
				    sC <= signed(C_nl(9));
				  elsif(sin1 < 32245)then
				    sM <= signed(M_nl(10));
				    sC <= signed(C_nl(10));
				  else
				    sM <= signed(M_nl(11));
				    sC <= signed(C_nl(11));
          end if;
				    
				 else
				  if(sin1 < 32376)then
				    sM <= signed(M_nl(12));
				    sC <= signed(C_nl(12));
				  elsif(sin1 < 32425)then
				    sM <= signed(M_nl(13));
				    sC <= signed(C_nl(13));
				  elsif(sin1 < 32458)then
				    sM <= signed(M_nl(14));
				    sC <= signed(C_nl(14));
				  else
				    sM <= signed(M_nl(15));
				    sC <= signed(C_nl(15));
          end if;
      end if;
      end if;
      sin2 <= sin1;
		  sign2 <= sign1;

	    --Cycle 3
		  sign3 <= sign2;
  			outps <= sM*sin2; --5.13 * 4.12 = 9.25
			sC1 <= sC & '0' & '0';  
			
			--Cycle 4
		  sign4 <= sign3;
			outps1 <= (outps(32 downto 13)) + sC1 ;

			--Cycle 5
			if(sign4 = '1')then
			   outps2 <= -(outps1(15 downto 0));
			else
			   outps2 <= outps1(15 downto 0);
      end if;			   
	end if;
end if;
end process ;
			outp <= std_logic_vector(outps2);
end behave;










		

