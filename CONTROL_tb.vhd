LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CONTROL_tb IS
END CONTROL_tb;
 
ARCHITECTURE behavior OF CONTROL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RFA : IN  std_logic_vector(31 downto 0);
         RFB : IN  std_logic_vector(31 downto 0);
         Clk : IN  std_logic;
         RF_WriteData_sel : OUT  std_logic;
         MemWE : OUT  std_logic_vector(0 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         isWord : OUT  std_logic;
         RF_B_sel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RFA : std_logic_vector(31 downto 0) := (others => '0');
   signal RFB : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal RF_WriteData_sel : std_logic;
   signal MemWE : std_logic_vector(0 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal isWord : std_logic;
   signal RF_B_sel : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Instr => Instr,
          RFA => RFA,
          RFB => RFB,
          Clk => Clk,
          RF_WriteData_sel => RF_WriteData_sel,
          MemWE => MemWE,
          ALU_Bin_sel => ALU_Bin_sel,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          isWord => isWord,
          RF_B_sel => RF_B_sel
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
      wait for 100 ns;	
		

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
