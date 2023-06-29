LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY IFSTAGETestbench IS
END IFSTAGETestbench;
 
ARCHITECTURE behavior OF IFSTAGETestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

	signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
	signal Instr : std_logic_vector(31 downto 0);
	
	constant Clk_period : time := 10 ns;

  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
		uut: IFSTAGE PORT MAP (
					 PC_Immed => PC_Immed,
					 PC_sel => PC_sel,
					 PC_LdEn => PC_LdEn,
					 Reset => Reset,
					 Clk => Clk,
					 Instr => Instr
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
		reset <='1';
      wait for 100 ns;
		reset <= '0';
		
		PC_Sel<='0';
		PC_LdEn<='1';
		PC_Immed<= "00000000000000000000000000000010";
      wait for clk_period*10;
		PC_Immed <="00000000000000000000000000000000";
		PC_Sel<='1';
		


      wait;
   end process;

END;
