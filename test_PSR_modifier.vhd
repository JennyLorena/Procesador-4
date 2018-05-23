--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:03 04/29/2018
-- Design Name:   
-- Module Name:   D:/Proyectos_Xilinx/Procesador2ConConexxion/test_PSR_modifier.vhd
-- Project Name:  Procesador1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR_modifier
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
 
ENTITY test_PSR_modifier IS
END test_PSR_modifier;
 
ARCHITECTURE behavior OF test_PSR_modifier IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_modifier
    PORT(
         in_salida_rf1 : IN  std_logic_vector(31 downto 0);
         in_salida_mux : IN  std_logic_vector(31 downto 0);
         in_salida_uc : IN  std_logic_vector(5 downto 0);
         in_salida_alu : IN  std_logic_vector(31 downto 0);
         salida_PSR_NZVC : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_salida_rf1 : std_logic_vector(31 downto 0) := (others => '0');
   signal in_salida_mux : std_logic_vector(31 downto 0) := (others => '0');
   signal in_salida_uc : std_logic_vector(5 downto 0) := (others => '0');
   signal in_salida_alu : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal salida_PSR_NZVC : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_modifier PORT MAP (
          in_salida_rf1 => in_salida_rf1,
          in_salida_mux => in_salida_mux,
          in_salida_uc => in_salida_uc,
          in_salida_alu => in_salida_alu,
          salida_PSR_NZVC => salida_PSR_NZVC
        );

   -- Clock process definitions
   --<clock>_process :process
  -- begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin	

		in_salida_rf1 <= x"00000000";
		
		in_salida_mux <= x"00000001";
		
		in_salida_uc <= "010000";
		
		in_salida_alu <= x"00000010";
		
		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
