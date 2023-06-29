--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FA32bi_tb IS
END FA32bi_tb;
 
ARCHITECTURE behavior OF FA32bi_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FA32bit
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         sum : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal sum : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FA32bit PORT MAP (
          a => a,
          b => b,
          sum => sum
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a<= "00000000000000000000000000000001";
		b<= "00000000000000000000000000000010";
		
		wait for 20ns;
		a<= "00000000000000000000000000100001";
		b<= "00000000000000000000000010000010";
		
      -- insert stimulus here 

      wait;
   end process;

END;
