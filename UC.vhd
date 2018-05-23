----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:20:17 04/08/2018 
-- Design Name: 
-- Module Name:    UC - Behavioral 
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

entity UC is
    Port ( entrada_OP : in  STD_LOGIC_VECTOR (1 downto 0);
           entrada_OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           salida_uc_op : out  STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

begin
    process(entrada_OP,entrada_OP3)
  begin
if (entrada_OP="10")then
			       
					 case entrada_OP3 is 
				
							when "000000" => -- ADD
								salida_uc_op  <= "000000";

							when "000100" => -- SUB
								 salida_uc_op <= "000100";
								 
							when "000001" => -- AND
								salida_uc_op <= "000001";
								 
							when "000101" => -- ANDN
								salida_uc_op <= "000101";
								 
							when "000010" => -- OR
								salida_uc_op <= "000010";
								
							when "000110" => -- ORN
								salida_uc_op <= "000110";
								 
							when "000011" => -- XOR
								salida_uc_op  <= "000011"; 
								
							when "000111" => -- XORN
								salida_uc_op <= "000111";
							
							when "010000" => -- ADDcc
								salida_uc_op <= "010000";
								
							when "001000" => -- ADDx
								salida_uc_op <= "001000";
							
							when "010001" => -- ANDcc
								salida_uc_op <= "010001";
								
							when "011000" =>--addxcc
								salida_uc_op <= "011000";
								
							when "010100" =>--subcc
								salida_uc_op <= "010100";
								
							when "001100" => --subx
								salida_uc_op <= "001100";
							
							when "011100" =>--subxcc
								salida_uc_op <= "011100";								
															
							when "010101" =>--nandcc
								salida_uc_op <= "010101";
								
							when "010010" =>--orcc
								salida_uc_op <= "010010";
								
							when "010110" =>--norcc
								salida_uc_op <= "010110";
								
							when "010011" =>--xorcc
								salida_uc_op <= "010011";
								
							when "010111" =>--xnorcc
								salida_uc_op <= "010111";
								
							when "111100" => --save
								salida_uc_op <= "111100";
					
							when "111101" => --restore
								salida_uc_op <= "111101";
								
							when others => 
								salida_uc_op <= "111111"; 

						end case;
						 
		end if; 

end process; 


end Behavioral;

