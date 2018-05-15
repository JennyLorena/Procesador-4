----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:31 04/26/2018 
-- Design Name: 
-- Module Name:    Psr - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Psr is
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           reset : in  STD_LOGIC;
			  ncwp : in STD_LOGIC;
			  cwp : out  STD_LOGIC; 
           clk : in  STD_LOGIC;
           carry : out  STD_LOGIC);
end Psr;

architecture Behavioral of Psr is

begin
	process(clk)
	begin
		if(rising_edge(clk))then
			if(reset = '1') then
				cwp <= '0';
				carry <= '0';
			else
				if ncwp = '1' then
					cwp <= '1';
				else
					cwp <= '0';
				end if;
				if nzvc(0) = '1' then
					carry <= '1';
				else 
					carry <= '0';
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

