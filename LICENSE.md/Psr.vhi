
-- VHDL Instantiation Created from source file Psr.vhd -- 23:44:36 05/14/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Psr
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		ncwp : IN std_logic;
		clk : IN std_logic;          
		cwp : OUT std_logic;
		carry : OUT std_logic
		);
	END COMPONENT;

	Inst_Psr: Psr PORT MAP(
		nzvc => ,
		reset => ,
		ncwp => ,
		cwp => ,
		clk => ,
		carry => 
	);


