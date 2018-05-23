----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:16 04/26/2018 
-- Design Name: 
-- Module Name:    PSR - Behavioral 
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

entity PSR is
    Port ( in_salida_psr_modifier : in  STD_LOGIC_VECTOR (3 downto 0); --NZVC
			  ncwp: in STD_LOGIC_VECTOR (1 downto 0):= "00";
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  cwp : out  STD_LOGIC_VECTOR (1 downto 0);
           salida_psr : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

	process(in_salida_psr_modifier, reset,ncwp)
		begin	
			if(reset = '1')then	
				salida_psr <= '0';
			else 
				if(rising_edge(clk))then
				salida_psr <= in_salida_psr_modifier(0);
			end if;
			end if;
end process;
cwp <= ncwp;
end Behavioral;

