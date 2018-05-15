--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:25:24 05/03/2018
-- Design Name:   
-- Module Name:   C:/Users/JEULM/Desktop/arqui/Proyecto3/Test_psrModiferer.vhd
-- Project Name:  Proyecto1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR_Modifirer
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
 
ENTITY Test_psrModiferer IS
END Test_psrModiferer;
 
ARCHITECTURE behavior OF Test_psrModiferer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_Modifirer
    PORT(
         alu_op : IN  std_logic_vector(5 downto 0);
         alu_Resultado : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         P_Crs1 : IN  std_logic_vector(31 downto 0);
         P_Crs2 : IN  std_logic_vector(31 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal alu_op : std_logic_vector(5 downto 0) := (others => '0');
   signal alu_Resultado : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal P_Crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal P_Crs2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_Modifirer PORT MAP (
          alu_op => alu_op,
          alu_Resultado => alu_Resultado,
          reset => reset,
          P_Crs1 => P_Crs1,
          P_Crs2 => P_Crs2,
          nzvc => nzvc
        );

   -- Clock process definitions
 --  <clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
  begin		
     reset <= '1';
      wait for 100 ns;
			reset <='0';
			alu_op<= "010100";
			P_Crs1 <= x"00010000";
			P_Crs2 <= x"00010001";
			alu_Resultado<="11111111111111111111111111110011";
			
      wait;
   end process;

END;
