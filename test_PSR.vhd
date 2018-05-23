--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:36 04/29/2018
-- Design Name:   
-- Module Name:   D:/Proyectos_Xilinx/Procesador2ConConexxion/test_PSR.vhd
-- Project Name:  Procesador1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_PSR IS
END test_PSR;
 
ARCHITECTURE behavior OF test_PSR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         in_salida_psr_modifier : IN  std_logic_vector(3 downto 0);
         reset : IN  std_logic;
         clk : IN  std_logic;
         salida_psr : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in_salida_psr_modifier : std_logic_vector(3 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal salida_psr : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          in_salida_psr_modifier => in_salida_psr_modifier,
          reset => reset,
          clk => clk,
          salida_psr => salida_psr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
	
		
      -- hold reset state for 100 ns.
		
		reset <= '1';
      wait for 100 ns;	
		
		reset <= '0';
		in_salida_psr_modifier <= "0101";
    
		--wait for 100 ns;
      --wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
