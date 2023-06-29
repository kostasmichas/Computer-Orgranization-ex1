library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Immed16to32 is
	port (Instr : in std_logic_vector(15 downto 0);
			Opcode : in std_logic_vector (5 downto 0);
			Immed : out std_logic_vector(31 downto 0)
			);
end Immed16to32;

architecture Behaviour of Immed16to32 is 

signal temp : std_logic_vector(31 downto 0);

begin

process(Instr, Opcode)
begin

if(OpCode="110010" OR OpCode="110011") then
		temp(31 downto 16) <= (others => '0'); --If andi or ori then zero fill
		temp(15 downto 0) <= Instr;
	elsif(OpCode="111001") then -- If lui then shift left 
		temp(31 downto 16) <= Instr;
		temp(15 downto 0) <= (others => '0'); 
	elsif(OpCode="111000" OR OpCode="110000" OR OpCode="000011"OR OpCode="000111"OR OpCode="001111"OR OpCode="011111") then --sign extension
		temp(31 downto 16) <= (others => Instr(15));
		temp(15 downto 0) <= Instr;
	elsif(OpCode="010000" OR OpCode="010001" OR OpCode="111111") then -- if bne beq b shift left by two and sign extension
		temp(31 downto 18) <= (others => Instr(15));
		temp(17 downto 2) <= Instr; 
		temp(1 downto 0) <= "00"; 
	end if;
	end process;
	Immed <= temp;

end Behaviour;