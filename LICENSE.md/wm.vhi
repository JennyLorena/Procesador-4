
-- VHDL Instantiation Created from source file wm.vhd -- 23:40:07 05/14/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT wm
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		ncwp : OUT std_logic;
		rs1w : OUT std_logic_vector(5 downto 0);
		rs2w : OUT std_logic_vector(5 downto 0);
		rdw : OUT std_logic_vector(5 downto 0);
		O7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	Inst_wm: wm PORT MAP(
		rs1 => ,
		rs2 => ,
		rd => ,
		op => ,
		op3 => ,
		cwp => ,
		ncwp => ,
		rs1w => ,
		rs2w => ,
		rdw => ,
		O7 => 
	);


