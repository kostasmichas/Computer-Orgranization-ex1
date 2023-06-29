library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package array1_pkg is
    type datain_t1 is array (0 to 1) of std_logic_vector(4 downto 0);
end array1_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.array1_pkg.all;

entity mux5bit_2to1 is
    Port ( dtin : in datain_t1;
           sel : in  STD_LOGIC;
           dtout : out  STD_LOGIC_VECTOR (4 downto 0));
end mux5bit_2to1;

architecture Behavioral of mux5bit_2to1 is

begin
process(sel, dtin)

    begin
        case sel is
            when '0' => dtout<=dtin(0);
            when '1' => dtout<=dtin(1);
            when others => dtout<="00000";
        end case;
    end process;

end Behavioral;