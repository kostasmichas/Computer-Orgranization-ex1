library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg is
    Port ( CLK : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end reg;

architecture Behavioral of reg is

begin
     process
     begin
        Wait until CLK'EVENT AND CLK = '1';
        if WE = '1' then
            Dout<=Data;
        end if;
     end process;



end Behavioral;