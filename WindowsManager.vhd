----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:16 05/14/2018 
-- Design Name: 
-- Module Name:    WindowsManager - arq_WM 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC_VECTOR (1 downto 0);
           ncwp : out  STD_LOGIC_VECTOR (1 downto 0):="00";
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end WindowsManager;

architecture arq_WM of WindowsManager is

signal rs1Integer,rs2Integer,rdInteger: integer range 0 to 39:=0;

begin

	process(rs1,rs2,rd,cwp,op,op3)
	
	begin if (op = "10") then
				if(op3 = "111100")then--SAVE
					ncwp <= conv_std_logic_vector(conv_integer(cwp) - 1,2);
					
				elsif(op3 = "111101")then--RESTORE
					ncwp <= conv_std_logic_vector(conv_integer(cwp) + 1,2);
					
				end if;
			else
				ncwp <= cwp;			
			end if;
		
		
		if(rs1>="00000" and rs1<="00111") then --Si el registro esta entre los bits 0 y 7 globales
			rs1Integer <= conv_integer(rs1);
		else
			if(rs1>="11000" and rs1<="11111") then --Si el registro esta entrelos bits 24 y 31 entrada
				rs1Integer <= conv_integer(rs1)-(conv_integer(cwp)*16);
		else
			if(rs1>="10000" and rs1<="10111") then --Si es un registro esta entre los bits 16 y 23 local
				rs1Integer <= conv_integer(rs1)+(conv_integer(cwp)*16);
		else
			if(rs1>="01000" and rs1<="01111") then  --Si es un registro esta entre los bits 8 y 15 salida
				rs1Integer <= conv_integer(rs1)+ (conv_integer(cwp)*16);
			end if;
			end if;
			end if;
		end if;
		
		if(rs2>="00000" and rs2<="00111") then --Si el registro esta entre los bits 0 y 7 globales
			rs2Integer <= conv_integer(rs2);
		else
			if(rs2>="11000" and rs2<="11111") then --Si el registro esta entrelos bits 24 y 31 entrada
				rs2Integer <= conv_integer(rs2) - (conv_integer(cwp)*16);			
		else
			if(rs2>="10000" and rs2<="10111") then --Si es un registro esta entre los bits 16 y 23 local
				rs2Integer <= conv_integer(rs2)+ (conv_integer(cwp)*16);
		else
			if(rs2>="01000" and rs2<="01111") then --Si es un registro esta entre los bits 8 y 15 salida 
				rs2Integer <= conv_integer(rs2)+ (conv_integer(cwp)*16);
			end if;
			end if;
			end if;
			
		end if;
		
		if(rd>="00000" and rd<="00111") then --Si el registro esta entre los bits 0 y 7 globales
			rdInteger <= conv_integer(rd);
		else
			if(rd>="11000" and rd<="11111") then --Si el registro esta entrelos bits 24 y 31 entrada
				rdInteger <= conv_integer(rd)  - (conv_integer(cwp)*16);
		else
			if(rd>="10000" and rd<="10111") then --Si es un registro esta entre los bits 16 y 23 local
				rdInteger <= conv_integer(rd)+ (conv_integer(cwp)*16);
		else
			if(rd>="01000" and rd<="01111") then --Si es un registro esta entre los bits 8 y 15 salida 
				rdInteger <= conv_integer(rd)+ (conv_integer(cwp)*16);
			end if;
			end if;
			end if;
		end if;
		
	end process;
	nrs1 <= conv_std_logic_vector(rs1Integer, 6);
	nrs2 <= conv_std_logic_vector(rs2Integer, 6);
	nrd <= conv_std_logic_vector(rdInteger, 6);


end arq_WM;

