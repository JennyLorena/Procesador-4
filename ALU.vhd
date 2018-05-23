----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:18:03 04/08/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( entrada_alu_a : in  STD_LOGIC_VECTOR (31 downto 0);
           entrada_alu_b : in  STD_LOGIC_VECTOR (31 downto 0);
           uc_op : in  STD_LOGIC_VECTOR (5 downto 0);
			  in_carry : IN std_logic;
           salida_alu : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end ALU;

architecture Behavioral of ALU is

begin
	process (entrada_alu_a, entrada_alu_b, uc_op)
		begin
			case (uc_op) is
				when "000000" => -- add
					salida_alu <= entrada_alu_a + entrada_alu_b;
					
				when "010000" => -- ADDcc
				salida_alu <= entrada_alu_a + entrada_alu_b;
				
				when "001000" => -- ADDx
				salida_alu <= entrada_alu_a + entrada_alu_b + in_carry;
				
				when "011000" => --addxcc 
					salida_alu <= entrada_alu_a + entrada_alu_b + in_carry;
					
				when "000100" => --sub
					salida_alu <= entrada_alu_a - entrada_alu_b;
					
				when "010100" => --subc
					salida_alu <= entrada_alu_a - entrada_alu_b;
					
				when "001100" => -- subx
					salida_alu <= entrada_alu_a - entrada_alu_b - in_carry;
					
				when "011100" => --subxcc
					salida_alu <= entrada_alu_a - entrada_alu_b - in_carry;
					
				when "000001" => -- and				
					salida_alu <= entrada_alu_a and entrada_alu_b;
					
				when "010001" => -- ANDcc
					salida_alu <= entrada_alu_a and entrada_alu_b;					
				
					
				when "000101" => -- nand
					salida_alu <= entrada_alu_a nand entrada_alu_b;
					
				when "010101" => --nandcc
					salida_alu <= entrada_alu_a nand entrada_alu_b;
					
				when "000010" => --or
					salida_alu <= entrada_alu_a or entrada_alu_b;
					
				when "010010" => --orcc
					salida_alu <= entrada_alu_a or entrada_alu_b;
		
					
				when "000110" => --nor
					salida_alu <= entrada_alu_a nor entrada_alu_b;
				
				when "010110" => --norcc
					salida_alu <= entrada_alu_a nor entrada_alu_b;
		
					
				when "000011" => --xor
					salida_alu <= entrada_alu_a xor entrada_alu_b;
				
				when "010011" => --xorcc
					salida_alu <= entrada_alu_a xor entrada_alu_b;
		
					
				when "000111" => --xnor
					salida_alu <= entrada_alu_a xnor entrada_alu_b;
					
				when "010111" => --xnorcc
					salida_alu <= entrada_alu_a xnor entrada_alu_b;

				when "111100" => --save
					salida_alu <= entrada_alu_a - entrada_alu_b;
					
				when "111101" => --restore
					salida_alu <= entrada_alu_a + entrada_alu_b;
				
					
				when others => --otras instrucciones
					salida_alu <= (others => '0');
			
			end case;
	
	end process;


end Behavioral;

