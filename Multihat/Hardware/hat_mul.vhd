library ieee; 

USE ieee.std_logic_arith.ALL;
use ieee.std_logic_1164.all; 
use ieee.std_logic_signed.all; 


 
entity hat_mul is 
   
 port 
    ( 
    reset : in  std_logic; 
    clk   : in  std_logic; 
    in_32  : in std_logic_vector(31 downto 0);
    out_16  : out std_logic_vector(15 downto 0)
    ); 
 end hat_mul; 
 
architecture beh2 of hat_mul is 
 
signal Z,Z1,Z2 : std_logic_vector(15 downto 0); 

   
begin  -- beh 

	process (clk, reset) 
	variable a,b,c : std_logic; 
  	begin  -- process lfsr1 

	if clk'event and clk = '1' then  -- rising clock edge 
        a := (in_32(20)or in_32(21)or in_32(22))and in_32(23);
        b := in_32(24)and in_32(25)and in_32(26);

 --Produce a thin HAT 
        Z(12 downto 0) <= in_32(12 downto 0); 
        Z(15) <= in_32(15);

        if(a ='0')then
          Z(14) <= in_32(14);
          Z(13) <= in_32(13);
        else
          Z(14) <= in_32(15);
          Z(13) <= in_32(15);
        end if;
 
 --Produce a standard HAT 
        Z1(13 downto 0) <= Z(13 downto 0); 
        Z1(15) <= Z(15);

        if(b ='1')then
          Z1(14) <= Z(14);
        else
           Z1(14) <= Z(15);
        end if;

		--Produce a thick HAT        
        Z2(12 downto 0) <= Z1(12 downto 0); 
        Z2(15) <= Z1(15);
        
		if(((Z1(14) xor Z1(15)) and not(Z1(13) xor Z1(14))) = '1' )then
			
			if(((in_32(27) xor Z1(15)) and not(in_32(28) xor in_32(27))) = '1' )then
				Z2(13) <= in_32(29);
				Z2(14) <= in_32(30);
			else
				Z2(13) <= in_32(27);
				Z2(14) <= in_32(28);
			end if;
		else
			Z2(13) <= Z1(13);
			Z2(14) <= Z1(14);
	end if;
		end if; 
   	out_16 <= Z2; 
	end process ; 
 
 
end beh2; 
