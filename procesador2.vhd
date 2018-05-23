----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:23 04/23/2018 
-- Design Name: 
-- Module Name:    procesador2 - arq_Procesador2 
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

entity procesador2 is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           resultadoProcesador2 : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador2;

architecture arq_Procesador2 of procesador2 is

		COMPONENT sumador
			PORT(
				a : IN std_logic_vector(31 downto 0);
				b : IN std_logic_vector(31 downto 0);          
				c : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT nPc
			PORT(
				entrada_nPc : IN std_logic_vector(31 downto 0);
				reset : IN std_logic;
				clk : IN std_logic;          
				salida_nPc : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT progam_counter_PC
			PORT(
				entrada_PC : IN std_logic_vector(31 downto 0);
				reset : IN std_logic;
				CLK : IN std_logic;          
				salida_PC : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT instruction_memory_IM
			PORT(
				address : IN std_logic_vector(31 downto 0);
				reset : IN std_logic;          
				out_instruction : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT UC
			PORT(
				entrada_OP : IN std_logic_vector(1 downto 0);
				entrada_OP3 : IN std_logic_vector(5 downto 0);          
				salida_uc_op : OUT std_logic_vector(5 downto 0)
				);
		END COMPONENT;
		
		COMPONENT register_file_RF
			PORT(
				entrada_rs1 : IN std_logic_vector(5 downto 0);
				entrada_rs2 : IN std_logic_vector(5 downto 0);
				registro_destino : IN std_logic_vector(5 downto 0);
				reset : IN std_logic;
				entrda_dwr : IN std_logic_vector(31 downto 0);          
				salida_rf1 : OUT std_logic_vector(31 downto 0);
				salida_rf2 : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT MUX_multiplexor
			PORT(
				intput_salida_rf2 : IN std_logic_vector(31 downto 0);
				i : IN std_logic;
				intput_output_SEU_to_MUX : IN std_logic_vector(31 downto 0);          
				output_MUX_to_ALU : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT SEU_unidad_extension_signo
			PORT(
				input_SEU : IN std_logic_vector(12 downto 0);          
				output_to_MUX : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT ALU
			PORT(
				entrada_alu_a : IN std_logic_vector(31 downto 0);
				entrada_alu_b : IN std_logic_vector(31 downto 0);
				uc_op : IN std_logic_vector(5 downto 0); 
				in_carry : IN std_logic;
				salida_alu : OUT std_logic_vector(31 downto 0)
				);
		END COMPONENT;
		
		COMPONENT PSR_modifier
			PORT(
				in_salida_rf1 : IN std_logic_vector(31 downto 0);
				in_salida_mux : IN std_logic_vector(31 downto 0);
				in_salida_uc : IN std_logic_vector(5 downto 0);
				in_salida_alu : IN std_logic_vector(31 downto 0);          
				salida_PSR_NZVC : OUT std_logic_vector(3 downto 0)
			);
		END COMPONENT;
		
		COMPONENT PSR
	PORT(
		in_salida_psr_modifier : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic_vector(1 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		cwp : OUT std_logic_vector(1 downto 0);
		salida_psr : OUT std_logic
		);
	END COMPONENT;
		
			COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic_vector(1 downto 0);          
		ncwp : OUT std_logic_vector(1 downto 0);
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
		

signal sumadorTOnpc,pcTOim,npcTOpc,imTOrfucseu,resultado_alu,rfTOalu,rfTOmux,seuTOmux,muxTOalu: STD_LOGIC_VECTOR (31 downto 0);

signal ucTOalu,WMTOrs1,WMTOrs2,WMTOrd: STD_LOGIC_VECTOR (5 downto 0);

signal PSR_ModTOPSR: STD_LOGIC_VECTOR (3 downto 0);

signal PSRTOWM,WMTOPSR:STD_LOGIC_VECTOR (1 downto 0);

signal carry: std_logic;

begin

	Inst_sumador: sumador PORT MAP(
		a => x"00000001" ,
		b => pcTOim,
		c => sumadorTOnpc
	);
	
	Inst_nPc: nPc PORT MAP(
		entrada_nPc => sumadorTOnpc ,
		reset => reset,
		salida_nPc => npcTOpc ,
		clk => clk
	);
	
	Inst_progam_counter_PC: progam_counter_PC PORT MAP(
		entrada_PC => npcTOpc ,
		reset => reset,
		salida_PC => pcTOim ,
		CLK => CLK
	);
	
	Inst_instruction_memory_IM: instruction_memory_IM PORT MAP(
		address => pcTOim,
		reset => reset,
		out_instruction => imTOrfucseu
	);
	
	Inst_UC: UC PORT MAP(
		entrada_OP => imTOrfucseu (31 downto 30) ,
		entrada_OP3 => imTOrfucseu (24 downto 19) ,
		salida_uc_op => ucTOalu 
	);
	
	Inst_register_file_RF: register_file_RF PORT MAP(
		entrada_rs1 => WMTOrs1,
		entrada_rs2 => WMTOrs2,
		registro_destino => WMTOrd,
		reset => reset ,
		entrda_dwr => resultado_alu,
		salida_rf1 => rfTOalu ,
		salida_rf2 => rfTOmux
	);
	
	Inst_MUX_multiplexor: MUX_multiplexor PORT MAP(
		intput_salida_rf2 => rfTOmux ,
		i => imTOrfucseu (13) ,
		intput_output_SEU_to_MUX => seuTOmux ,
		output_MUX_to_ALU => muxTOalu
	);
	
	Inst_SEU_unidad_extension_signo: SEU_unidad_extension_signo PORT MAP(
		input_SEU => imTOrfucseu (12 downto 0) ,
		output_to_MUX => seuTOmux 
	);
	
	Inst_ALU: ALU PORT MAP(
		entrada_alu_a => rfTOalu ,
		entrada_alu_b => muxTOalu ,
		uc_op => ucTOalu,
		in_carry => carry,
		salida_alu => resultado_alu
	);
	
	Inst_PSR_modifier: PSR_modifier PORT MAP(
		in_salida_rf1 => rfTOalu,
		in_salida_mux => muxTOalu ,
		in_salida_uc => ucTOalu ,
		in_salida_alu => resultado_alu,
		salida_PSR_NZVC => PSR_ModTOPSR
	);	
	
	Inst_PSR: PSR PORT MAP(
		in_salida_psr_modifier => PSR_ModTOPSR ,
		ncwp => WMTOPSR ,
		reset => reset ,
		clk => clk ,
		cwp => PSRTOWM ,
		salida_psr => carry
	);
	
		Inst_WindowsManager: WindowsManager PORT MAP(
		rs1 => imTOrfucseu (18 downto 14) ,
		rs2 => imTOrfucseu (4 downto 0),
		rd => imTOrfucseu (29 downto 25),
		op => imTOrfucseu (31 downto 30),
		op3 => imTOrfucseu (24 downto 19),
		cwp => PSRTOWM,
		ncwp => WMTOPSR ,
		nrs1 => WMTOrs1,
		nrs2 => WMTOrs2,
		nrd => WMTOrd
	);
	
	
resultadoProcesador2 <= resultado_alu ;

end arq_Procesador2;

