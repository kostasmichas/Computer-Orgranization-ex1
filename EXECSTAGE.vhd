library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arr_pkg.all;



entity EXECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end EXECSTAGE;

architecture Behavioral of EXECSTAGE is


signal mux_in4:datain_t;
signal mux_out4:std_logic_vector(31 downto 0);

component ALU is
port(A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        Op: in std_logic_vector(3 downto 0);
        Out_1: out std_logic_vector(31 downto 0);
        Zero: out std_logic;
        Cout: out std_logic;
        Ovf: out std_logic
    );
end component;

component mux_2to1 is 
port(datain: in datain_t;
     sel: in std_logic;
     dataout: out std_logic_vector(31 downto 0));
      
     
end component;


begin 


mux_in4(1) <= Immed;
mux_in4(0) <= RF_B;


mux2_1: mux_2to1 port map(datain=>mux_in4,sel=>ALU_Bin_sel,dataout=> mux_out4);
al: ALU port map(A=>RF_A,B=>mux_out4,Op=>ALU_func,Out_1=>ALU_out);


end Behavioral;