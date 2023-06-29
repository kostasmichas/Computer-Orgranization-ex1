library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FA32bit is
    port (
        a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0);
        sum : out std_logic_vector(31 downto 0)
    );
	 
	 end entity FA32bit;

architecture bhv of FA32bit is
begin
    process(a, b)
         variable carry : std_logic_vector(32 downto 0) := (others => '0');
    begin
		  carry(0) := '0';
        for i in 0 to 31 loop
		  sum(i) <= a(i) xor b(i) xor carry(i);
        carry(i+1) := (a(i) and b(i)) or (a(i) and carry(i)) or (b(i) and carry(i));
        end loop;
    end process;
end architecture bhv;