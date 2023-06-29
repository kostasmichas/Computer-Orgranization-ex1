library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package array_pkg is
type array32of32bits is array (0 to 31) of std_logic_vector(31 downto 0);
end;

library ieee;
use ieee.std_logic_1164.all;
use work.array_pkg.all;

entity mux_32to1 is
port (
    data_in: in array32of32bits;
    sel: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(31 downto 0)
  );
end mux_32to1;

architecture Behavioral of mux_32to1 is

begin
process (sel,data_in)
  begin
    case sel is
	   when "00000" => data_out <= data_in(0);
      when "00001" => data_out <= data_in(1);
      when "00010" => data_out <= data_in(2);
      when "00011" => data_out <= data_in(3);
      when "00100" => data_out <= data_in(4);
      when "00101" => data_out <= data_in(5);
		when "00110" => data_out <= data_in(6);
      when "00111" => data_out <= data_in(7);
      when "01000" => data_out <= data_in(8);
		when "01001" => data_out <= data_in(9);
		when "01010" => data_out <= data_in(10);
      when "01011" => data_out <= data_in(11);
      when "01100" => data_out <= data_in(12);
      when "01101" => data_out <= data_in(13);
		when "01110" => data_out <= data_in(14);
      when "01111" => data_out <= data_in(15);
      when "10000" => data_out <= data_in(16);
		when "10001" => data_out <= data_in(17);
      when "10010" => data_out <= data_in(18);
      when "10011" => data_out <= data_in(19);
		 when "10100" => data_out <= data_in(20);
      when "10101" => data_out <= data_in(21);
		when "10110" => data_out <= data_in(22);
      when "10111" => data_out <= data_in(23);
      when "11000" => data_out <= data_in(24);
      when "11001" => data_out <= data_in(25);
		when "11010" => data_out <= data_in(26);
      when "11011" => data_out <= data_in(27);
      when "11100" => data_out <= data_in(28);
      when "11101" => data_out <= data_in(29);
		when "11110" => data_out <= data_in(30);
      when "11111" => data_out <= data_in(31);
      when others => data_out <= x"00000000";
    end case;
  end process;
		
		
end Behavioral;

