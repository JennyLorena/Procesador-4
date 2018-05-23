----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:05 04/26/2018 
-- Design Name: 
-- Module Name:    PSR_modifier - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR_modifier is
    Port ( in_salida_rf1 : in  STD_LOGIC_VECTOR (31 downto 0);
           in_salida_mux : in  STD_LOGIC_VECTOR (31 downto 0);
           in_salida_uc : in  STD_LOGIC_VECTOR (5 downto 0);
           in_salida_alu : in  STD_LOGIC_VECTOR (31 downto 0);
           salida_PSR_NZVC : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_modifier;

architecture Behavioral of PSR_modifier is

begin
	
	process (in_salida_rf1,in_salida_mux,in_salida_uc,in_salida_alu)
	
	 begin

								--addcc                    addxcc                     subcc                    subxcc                   andcc                    nandcc                    orcc                    norcc                    xorcc                    xnorcc    
		  if( in_salida_uc="010000" or in_salida_uc="011000"  or in_salida_uc="010100" or in_salida_uc ="011100" or in_salida_uc="010001" or in_salida_uc="010101" or in_salida_uc="010010" or in_salida_uc="010110" or in_salida_uc="010011" or in_salida_uc="010111")then

				if(in_salida_uc="010001" or in_salida_uc="010101" or in_salida_uc="010010" or in_salida_uc="010110" or in_salida_uc="010011" or in_salida_uc="010111")then
					  salida_PSR_NZVC(3) <= in_salida_alu(31);
                    if in_salida_alu = "00000000000000000000000000000000" then 
                         salida_PSR_NZVC(2) <= '1';
                    else
                         salida_PSR_NZVC(2) <= '0';
                    end if;
						salida_PSR_NZVC(1) <= '0'; 
						salida_PSR_NZVC(0) <= '0';
				end if;	
						
                if in_salida_uc = "010000" or in_salida_uc = "011000" then
                     salida_PSR_NZVC(3) <= in_salida_alu(31);
                    if in_salida_alu = "00000000000000000000000000000000" then 
                         salida_PSR_NZVC(2) <= '1';
                    else
                         salida_PSR_NZVC(2) <= '0';
                    end if;
                     salida_PSR_NZVC(1) <= (in_salida_rf1(31) and in_salida_mux(31) and (not in_salida_alu(31))) or ((not in_salida_rf1(31)) and (not in_salida_mux(31)) and in_salida_alu(31));
                     salida_PSR_NZVC(0) <= (in_salida_rf1(31) and in_salida_mux(31)) or ((not in_salida_alu(31)) and (in_salida_rf1(31) or in_salida_mux(31)));
                end if;
                
                if  in_salida_uc= "010100" or in_salida_uc = "011100" then
                     salida_PSR_NZVC(3) <= in_salida_alu(31);
                    if in_salida_alu = "00000000000000000000000000000000" then 
                        salida_PSR_NZVC(2) <= '1';
                    else
                        salida_PSR_NZVC(2) <= '0';
                    end if;
                     salida_PSR_NZVC(1) <= (in_salida_rf1(31) and (not in_salida_mux(31)) and (not in_salida_alu(31))) or ((not in_salida_rf1(31)) and in_salida_mux(31) and in_salida_alu(31));
                     salida_PSR_NZVC(0) <= ((not in_salida_rf1(31)) and in_salida_mux(31)) or (in_salida_alu(31) and ((not in_salida_rf1(31)) or in_salida_mux(31)));
							end if;						
						
						else 
							salida_PSR_NZVC <= "0000";	
				end if;
	end process;	

end Behavioral;

