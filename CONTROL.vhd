library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
port (Instr : in std_logic_vector (31 downto 0);
		Reset: in std_logic;
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
end CONTROL;

architecture Behavioral of CONTROL is

signal OpCode : std_logic_vector(5 downto 0); 
type state is (nop, choose_state, ALU_state, ALU_state_stage2, LoadImm_state, LoadImm_state_stage2, LogImm_state, LogImm_state_stage2, b1, b2, l1, l1_stage2, l2, l2_stage2, s1, s1_stage2, s2, s2_stage2, restart_state, restart_state2);
signal current_state, next_state: state;

begin
process(Instr, current_state, OpCode)
begin


case current_state is
	when choose_state =>
		OpCode <= Instr(31 downto 26);
		MemWE<="0";
		RF_WrEn<='0';
		isWord<='0';
		PC_Sel <='0';
		
		If OpCode = "111000" or OpCode ="111001"  then
		   RF_B_sel <='1';
			next_state <= LoadImm_state;
		elsif Opcode = "111011" or Opcode = "110000" or Opcode = "110010" then
			RF_B_sel <='1';
			next_state <=LogImm_state;
		elsif Opcode = "111111" then
			RF_B_sel <='1';
			next_state <=b1;
		elsif Opcode = "010000" or Opcode = "010001"then
			RF_B_sel <='1';
			next_state<=b2;
		elsif Opcode = "000011" then
			RF_B_sel <='1';
			next_state <=l1;
		elsif Opcode = "000111" then
			RF_B_sel <='1';
			next_state<=s1;
		elsif Opcode = "001111" then
			RF_B_sel <='1';
			next_state<=l2;
		elsif Opcode = "011111" then
			RF_B_sel <='1';
			next_state<=s2;
		elsif Opcode = "100000" then
		   RF_B_sel <='0';
			next_state<=ALU_state;
		elsif Instr = "00000000000000000000000000000000" then
			next_state<=nop;
		else
			next_state<=choose_state;
			
			end if;	
		
		when ALU_state =>
		ALU_Bin_sel<='0';
		next_state <= ALU_state_stage2;
		
		
	when ALU_state_stage2 =>
		RF_WrEn<='1';
		RF_WriteData_sel<='0';
		next_state <= restart_state;
		
		
	when LoadImm_state =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state <= LoadImm_state_stage2;
		
	when LoadImm_state_stage2 =>
		RF_WrEn<='1';
		RF_WriteData_sel<='0';
		next_state<=restart_state;
		
		
	when LogImm_state =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state <= LogImm_state_stage2;
		
	when LogImm_state_stage2 =>
		RF_WrEn<='1';
		RF_WriteData_sel<='0';
		next_state<=restart_state;
		
		
	when b1 =>
		PC_sel<='1';
		next_state<=restart_state;
	when b2 =>
		if Opcode = "010000" then --beq
			if RFA = RFB then
				PC_sel<='1';
			else 
				PC_sel<='0';
			end if;
			
			elsif OpCode ="010001" then --bne
			if RFA = RFB then
				PC_sel<='0';
			else 
				PC_sel<='1';
			end if;
			
		end if;
		next_state<=restart_state;
		
	when l1 =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state<= l1_stage2;
		
	when l1_stage2 =>
		RF_WrEn<='1';
		RF_WriteData_sel<='1';
		next_state<=restart_state;
		
	when l2 =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state<= l2_stage2;
		
	when l2_stage2 =>

		RF_WrEn<='1';
		RF_WriteData_sel<='1';
		isWord<='1';
		MemWE <="0";
		next_state<=restart_state;
		
	when s1 =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state<= s1_stage2;
		
	when s1_stage2 =>
		MemWE <="1";
		next_state<=restart_state;
		
	when s2 =>
		RF_B_sel<='1';
		ALU_Bin_sel<='1';
		next_state<= s2_stage2;
		
	when s2_stage2 =>
		RF_WriteData_sel<='1';
		isWord<='1';
		PC_sel<='0';
		MemWE <="1";
		next_state<=restart_state;
		
	when restart_state =>
		PC_LdEN <= '1';
		next_state<=restart_state2;
	when restart_state2 =>
		PC_LdEn<='0';
		next_state<=choose_state;
		
	when nop =>
		RF_WrEn	<='0';
		MemWE <= "0";
		PC_Sel	<= '0';
		next_state	<= restart_state;
		
	end case;
end process;
process(Clk)
begin
if Clk='1' and Reset ='0' then
  current_state<=next_state;
elsif Clk = '0' and Reset ='0' then
  current_state <=current_state;
 else
	current_state<=choose_state;
end if;
end process;

end Behavioral;