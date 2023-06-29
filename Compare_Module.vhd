library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Compare_Module is
Port ( data_write : in  STD_LOGIC_VECTOR (4 downto 0);
           data_read : in  STD_LOGIC_VECTOR (4 downto 0);
           WriteEnable : in  STD_LOGIC;
           Out_data : out  STD_LOGIC);
end Compare_Module;

architecture Behavioral of Compare_Module is

begin
process(WriteEnable,data_read,data_write)
    begin
    if WriteEnable = '1' then
        if data_read = data_write then
            Out_data<='1';
        else
            Out_data <='0';
          end if;
     else
       Out_data <= '0';
    end if;
end process;

end Behavioral;

