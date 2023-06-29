library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH is
	port(clk: in std_logic; rst :std_logic);
end DATAPATH;



architecture Behavioral of DATAPATH is

signal Immed_signal: std_logic_vector(31 downto 0);
signal Instr_signal : std_logic_vector(31 downto 0);
signal tempALU_out : std_logic_vector(31 downto 0);
signal tempMEM_out : std_logic_vector(31 downto 0);
signal rf_a_out: std_logic_vector(31 downto 0);
signal rf_b_out: std_logic_vector(31 downto 0);
signal alu_funcop: std_logic_vector(3 downto 0);
signal opcode : std_logic_vector(5 downto 0 );
signal rf_w_s :std_logic;
signal pc_s :std_logic;
signal alu_b_s :std_logic;
signal mwe:std_logic_vector(0 downto 0);
signal isw :std_logic;
signal rf_w_e:std_logic;
signal pc_l_e:std_logic;
signal rf_b_s:std_logic;

component CONTROL is
port(Instr : in std_logic_vector (31 downto 0);
	Reset : in std_logic;
	RFA: in std_logic_vector (31 downto 0);
	RFB: in std_logic_vector(31 downto 0);
	Clk : in std_logic;
	RF_WriteData_sel : out std_logic;
	MemWE : out std_logic_vector(0 downto 0);
	ALU_Bin_sel : out std_logic;
	PC_sel : out std_logic;
	PC_LdEn : out std_logic;
	RF_WrEn : out std_logic;
	isWord :out std_logic;
	RF_B_sel: out std_logic
	);
end component;

component IFSTAGE is
port(PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE is
port(Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC; 
			  Clk : in  STD_LOGIC;
			  Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end component;

component EXECSTAGE is
port(RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));

end component;

component MEM_STAGE is
port(clk : in  STD_LOGIC;
			  isWord : in std_logic;
           Mem_WrEN : in  STD_LOGIC_VECTOR(0 downto 0);
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));

end component;

begin
process(Instr_signal,opcode)
begin

opcode <= Instr_signal(31 downto 26);
if opcode ="110000" or opcode="000011" or opcode="000111" or opcode="001111" or opcode="011111" or opcode ="111000" or opcode ="111001" then
   alu_funcop <= "0000";
elsif opcode="110010" then
   alu_funcop <="0010";
elsif opcode="110011" then 
   alu_funcop <="0011";
else 
   alu_funcop <=Instr_signal(3 downto 0);
end if;

end process;

if_s :IFSTAGE port map(PC_Immed =>Immed_signal,PC_sel =>pc_s,PC_LdEn =>pc_l_e,Reset =>rst ,Clk=>Clk ,Instr =>Instr_signal);
dec_s :DECSTAGE port map(Instr=>Instr_signal,RF_WrEn=>rf_w_e,ALU_out=>tempALU_out,MEM_out =>tempMEM_out,RF_WrData_sel=>rf_w_s,RF_B_sel =>rf_b_s,Clk =>clk ,Immed =>Immed_signal,RF_A =>rf_a_out ,RF_B =>rf_b_out);
exec_s: EXECSTAGE port map(RF_A=>rf_a_out,RF_B=>rf_b_out,Immed=>Immed_signal,ALU_Bin_sel=>alu_b_s,ALU_func=>alu_funcop,ALU_out=>tempALU_out);
mem_s : MEM_STAGE port map(clk => clk,isWord=>isw,Mem_WrEn=>mwe,ALU_MEM_Addr =>tempALU_out,MEM_DataIn=>rf_b_out,MEM_DataOut=>tempMEM_out);    
ctrl : CONTROL port map(Instr =>Instr_signal, Reset =>rst,RFA=>rf_a_out,RFB=>rf_b_out,Clk=>clk,RF_WriteData_sel=>rf_w_s,MemWE =>mwe,ALU_Bin_sel=>alu_b_s,PC_sel=>pc_s,PC_LdEn=>pc_l_e ,RF_WrEn =>rf_w_e, isWord=> isw ,RF_B_sel=>rf_b_s);
 
end Behavioral;