library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU is
port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        Op: in std_logic_vector(3 downto 0);
        Out_1: out std_logic_vector(31 downto 0);
        Zero: out std_logic;
        Cout: out std_logic;
        Ovf: out std_logic
    );
end ALU;

architecture Behavioral of ALU is
		signal A_int: signed(31 downto 0);
    signal B_int: signed(31 downto 0);
    signal Out_int: signed(31 downto 0);
	 signal sum_33: signed(32 downto 0);
    
	 
begin
    A_int <= signed(A);
    B_int <= signed(B);

 process(A_int, B_int, Op,Out_int,sum_33)
    begin
			
			case Op is
            when "0000" =>
                Out_int <= A_int + B_int;
            when "0001" =>
                Out_int <= A_int - B_int;
				when "0010" =>
                Out_int <= A_int and B_int;
            when "0011" =>
                Out_int <= A_int or B_int;
				when "0100" =>
                Out_int <= not A_int;
            when "1000" =>
                Out_int <= shift_right(A_int, 1);
                Out_int(31) <= A_int(31);
				when "1001" =>
					 Out_int(30 downto 0) <= A_int(31 downto 1);
					 Out_int(31) <= '0';
            when "1010" =>
                Out_int <= shift_left(A_int, 1);
					 Out_int(0)<='0';
				when "1100" =>
                Out_int <= rotate_left(A_int, 1);
            when "1101" =>
                Out_int <= rotate_right(A_int, 1);
            when others =>
                Out_int <= (others=>'X');
         end case;
			
			Out_1 <= std_logic_vector(Out_int);
       
		  if Out_int = 0 then
           Zero <= '1';
        else
           Zero <= '0';
        end if;
		  
		  if (Op="0001") then
	        sum_33 <= (A_int(31) & A_int) - (B_int(31) & B_int);
	        Cout <= sum_33(32);  -- if there is a 33rd bit produced, send it as a Cout flag
        elsif (Op="0000") then
	        sum_33 <= (A_int(31) & A_int) + (B_int(31) & B_int);
	        Cout <= sum_33(32); 
        else
	        Cout <= '0';
        end if;
		  
		  if ((Op = "0001" and A_int < 0 and B_int > 0 and Out_int > 0) or (Op = "0001" and A_int > 0 and B_int < 0 and Out_int < 0) or (Op = "0000" and A_int > 0 and B_int > 0 and Out_int < 0) or (Op = "0000" and A_int < 0 and B_int < 0 and Out_int >= 0)) then
			    Ovf<='1';
			else
			    Ovf<='0';
			end if;
			
      end process;

end Behavioral;

