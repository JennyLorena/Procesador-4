----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:52 04/22/2018 
-- Design Name: 
-- Module Name:    Conexion_Procesador - arq_Conexion_Procesador 
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

entity Conexion_Procesador is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Resultado_Procesador2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Conexion_Procesador;

architecture arq_Conexion_Procesador of Conexion_Procesador is

COMPONENT Sumador
	PORT(
		entrada_sum1 : IN std_logic_vector(31 downto 0);
		entrada_sum2 : IN std_logic_vector(31 downto 0);          
		salida_sumador : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT nPc
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		entrada_nPc : IN std_logic_vector(31 downto 0);          
		salida_nPc : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


COMPONENT pC
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		entrada_PC : IN std_logic_vector(31 downto 0);          
		salida_PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT InstruccionesMemoria
	PORT(
		direccion : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		instruccion : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT UnidadControl
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida_UC : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT Register_File
	PORT(
		reg_s_1 : IN std_logic_vector(4 downto 0);
		reg_s_2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		reset : IN std_logic;
		dwr : IN std_logic_vector(31 downto 0);          
		salida_1 : OUT std_logic_vector(31 downto 0);
		salida_2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT muxx
	PORT(
		i : IN std_logic;
		dato_seu : IN std_logic_vector(31 downto 0);
		crs2 : IN std_logic_vector(31 downto 0);          
		salida_mux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT SEU
	PORT(
		Entrada_Seu : IN std_logic_vector(12 downto 0);          
		Salida_Mux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT Alu
	PORT(
		Entrada_Uc : IN std_logic_vector(5 downto 0);
		Entrada_rF1 : IN std_logic_vector(31 downto 0);
		Entrada_rF2 : IN std_logic_vector(31 downto 0);
		Carry : in STD_LOGIC;
		dwr_aLu : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT PSR_Modifirer
	PORT(
		alu_op : IN std_logic_vector(5 downto 0);
		alu_Resultado : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		P_Crs1 : IN std_logic_vector(31 downto 0);
		P_Crs2 : IN std_logic_vector(31 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
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


	
signal SumadorToNpc, nPcToPc, pcToIm, imToURs, aluResult1, RFtoAlu, RFtoMux, SeuToMux, MuxToAlu :STD_LOGIC_VECTOR (31 downto 0);
signal aluop1,rs1wmtorf, rs2wmtorf, rdwmtorf: STD_LOGIC_VECTOR (5 downto 0);
signal wmtopsr, psrtowm, psrToalu: STD_LOGIC;--creo senals de 1
signal psrmodifier_psr: STD_LOGIC_VECTOR(3 downto 0);--creo senals de 4

begin

Inst_Sumador: Sumador PORT MAP(
		entrada_sum1 => x"00000001",
		entrada_sum2 => nPcToPc,
		salida_sumador => SumadorToNpc
	);
	
	
	Inst_nPc: nPc PORT MAP(
		clk => clk,
		reset => reset,
		entrada_nPc => SumadorToNpc,
		salida_nPc => nPcToPc
	);

	Inst_pC: pC PORT MAP(
		clk => clk,
		reset => reset,
		entrada_PC => nPcToPc,
		salida_PC => pcToIm
	);

	Inst_InstruccionesMemoria: InstruccionesMemoria PORT MAP(
		direccion => pcToIm,
		reset => reset,
		instruccion => imToURs
	);
	
	Inst_UnidadControl: UnidadControl PORT MAP(
		op => imToURs(31 downto 30),
		op3 => imToURs(24 downto 19),
		salida_UC => aluop1
	);

	Inst_Register_File: Register_File PORT MAP(
		reg_s_1 => imToURS(18 downto 14) ,
		reg_s_2 => imToURS(4 downto 0),
		rd => imToURS(29 downto 25),
		reset => reset,
		dwr => aluResult1,
		salida_1 => RFtoAlu,
		salida_2 => RFtoMux
	);
	
	Inst_muxx: muxx PORT MAP(
		i => imToURs(13),
		dato_seu => SeuToMux,
		crs2 => RFtoMux,
		salida_mux => MuxToAlu
	);

	Inst_SEU: SEU PORT MAP(
		Entrada_Seu => imToURs(12 downto 0),
		Salida_Mux => SeuToMux
	);

	Inst_Alu: Alu PORT MAP(
		Entrada_Uc => aluop1,
		Entrada_rF1 => RFtoAlu,
		Entrada_rF2 => MuxToAlu,
		Carry => psrToalu,
		dwr_aLu => aluResult1
	);
	Inst_PSR_Modifirer: PSR_Modifirer PORT MAP(
		alu_op => aluop1 ,
		alu_Resultado => aluResult1,
		reset => reset ,
		P_Crs1 =>RFtoAlu ,
		P_Crs2 =>MuxToAlu ,
		nzvc => psrmodifier_psr
	);
	Inst_Psr: Psr PORT MAP(
		nzvc =>psrmodifier_psr ,
		reset => reset,
		clk => clk,
		carry => psrToalu,
		ncwp => wmtopsr,
		cwp => psrtowm
		
	);
	
	
	Inst_wm: wm PORT MAP(
		rs1 => imToURs(18 downto 14),
		rs2 => imToURs(4 downto 0),
		rd => imToURs(29 downto 25),
		op => imToURs(31 downto 30),
		op3 => imToURs(24 downto 19),
		cwp => psrtowm,
		ncwp => wmtopsr,
		rs1w => rs1wmtorf,
		rs2w => rs2wmtorf,
		rdw => rdwmtorf
		
	);
	
	
Resultado_Procesador2 <= aluResult1;
	
	
end arq_Conexion_Procesador;