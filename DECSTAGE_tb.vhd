LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY DECSTAGE_tb IS
END DECSTAGE_tb;
 
ARCHITECTURE behavior OF DECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
 
   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Instr<="11100000000000100000000000000110";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		ALU_out<="00000000000000000000000000000100";
		MEM_out<="00000000000000000000000000000000";
		RF_B_Sel<='0';
		wait for Clk_period*10;
		
		
		Instr<="11100000010000101000000000000110";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		ALU_out<="00000000000000000000000000000100";
		MEM_out<="00000000000000000000000000000000";
		RF_B_Sel<='0';
		
		wait for Clk_period*10;
		
		Instr(31 downto 26) <= "000000";
		Instr(25 downto 21) <="00001";
		Instr(20 downto 16) <="00001";
		Instr(15 downto 11) <="00000";
		Instr(10 downto 0) <="01100011001";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		ALU_out<="00000000000000000000000000000110";
		MEM_out<="00000000000000000000000000000000";
		RF_B_Sel<='0';


      wait;
   end process;

END;
