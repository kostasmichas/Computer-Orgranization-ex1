library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package arr_pkg is
    type datain_t is array (0 to 1) of std_logic_vector(31 downto 0);
end arr_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arr_pkg.all;


entity mux_2to1 is
port (     datain: in datain_t;
            sel: in std_logic;
            dataout: out std_logic_vector(31 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is

begin
process(sel, datain)
    begin
        case sel is
            when '0' => dataout<=datain(0);
            when '1' => dataout<=datain(1);
            when others => dataout<="00000000000000000000000000000000";
        end case;
    end process;

end Behavioral;

