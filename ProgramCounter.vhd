library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is
		signal temp : std_logic_vector(31 downto 0);
begin

     process
     begin
      wait until CLK'EVENT AND clk = '1';
       if(reset='0') then
        if we = '1' then
            temp<=data;
			else
			temp<=temp;
        end if;
		  else
		  temp<="00000000000000000000000000000000";
        end if;
     end process;
	  dout <=temp;
end Behavioral;