----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:56 04/08/2018 
-- Design Name: 
-- Module Name:    Alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( Entrada_Uc : in  STD_LOGIC_VECTOR (5 downto 0);
           Entrada_rF1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Entrada_rF2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Carry : in STD_LOGIC;
			  dwr_aLu : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end Alu;

architecture Behavioral of Alu is

begin

process(Entrada_Uc, Entrada_rF1, Entrada_rF2)
begin
 case (Entrada_Uc) is 
	
		
								when "000000" => -- add
										dwr_aLu <= Entrada_rF1 + Entrada_rF2;
								
								when "010000" => -- addcc
										dwr_aLu <= Entrada_rF1 + Entrada_rF2;
								
								when "001000" => -- addX
										dwr_aLu <= Entrada_rF1 + Entrada_rF2 + Carry;
								
								when "011000" => -- addXcc
										dwr_aLu <= Entrada_rF1 + Entrada_rF2 + Carry;
								
								when "000100" => -- sub
										dwr_aLu <= Entrada_rF1 - Entrada_rF2;
								
								when "010100" => -- subcc
										dwr_aLu <= Entrada_rF1 - Entrada_rF2;
								
								when "001100" => -- subX
										dwr_aLu <= Entrada_rF1 - Entrada_rF2 - Carry;
								
								when "011100" => -- subXcc
										dwr_aLu <= Entrada_rF1 - Entrada_rF2 - Carry;
								
								when "000001" => -- and
										dwr_aLu <= Entrada_rF1 and Entrada_rF2;
								
								when "000101" => -- andn
										dwr_aLu <= Entrada_rF1 and not (Entrada_rF2);
								
								when "010101" => --andNcc
										dwr_aLu <= Entrada_rF1 and Entrada_rF2;
								
								when "010001" => --andcc
										dwr_aLu <= Entrada_rF1 and Entrada_rF2;
								
								when "000010" => --or
										dwr_aLu <= Entrada_rF1 or Entrada_rF2;
								
								when "000110" => --orn
									dwr_aLu <= Entrada_rF1 or not (Entrada_rF2);	
									
								when "010010" => --orcc
										dwr_aLu <= Entrada_rF1 or Entrada_rF2;	
								
								when "010110" => --orNcc
										dwr_aLu <= Entrada_rF1 or Entrada_rF2;  
								
								when "000011" => -- xor
										dwr_aLu <= Entrada_rF1 xor Entrada_rF2;
								
								when "000111" => -- xnor
										dwr_aLu <= Entrada_rF1 xnor Entrada_rF2;
								
								when "010011" => -- xorcc
										dwr_aLu <= Entrada_rF1 xor Entrada_rF2;	


								when "111100" => --save 
										dwr_aLu <=   Entrada_rF1 - Entrada_rF2; 
						   
							   when "111101" => --restore
										dwr_aLu  <=   Entrada_rF1 + Entrada_rF2;--restore											
									
								when others => --otras instrucciones
											dwr_aLu <= (others=>'0');


										
						end case;
	end process; 


end Behavioral;