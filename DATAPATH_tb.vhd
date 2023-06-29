
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY DATAPATH_tb IS
END DATAPATH_tb;
 
ARCHITECTURE behavior OF DATAPATH_tb IS 
 
    signal clk : std_logic;
	 signal rst :std_logic;
 
    COMPONENT DATAPATH
    PORT(clk : in std_logic;
			rst : in std_logic
        );
    END COMPONENT;
    
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
  
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (clk=>clk, rst=>rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst<='1';
      wait for 100 ns;	
		rst<='0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
