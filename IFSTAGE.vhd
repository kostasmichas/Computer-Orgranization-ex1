library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arr_pkg.all;
use ieee.numeric_std.all;


entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is


signal pc_out : std_logic_vector (31 downto 0) := (others => '0');
signal pc_in : std_logic_vector(31 downto 0);
signal mux_in1 :datain_t;


component ProgramCounter is
port(clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
              
end component;

component mux_2to1 is
port( datain : in datain_t;
      sel : in  STD_LOGIC;
      dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IF_MEM is
port( clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

component FA32bit is
port (
        a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0);
        sum : out std_logic_vector(31 downto 0)
    );
end component;

begin
PC_plus_4 : FA32bit port map(a => pc_out, b=> "00000000000000000000000000000100", sum=>mux_in1(0));
Immed_plus_Out: FA32bit port map (a => mux_in1(0), b=> PC_Immed, sum=>mux_in1(1));
mux: mux_2to1 port map (datain=>mux_in1, sel=>PC_sel, dataout => pc_in);
PC : ProgramCounter port map (clk=>Clk, reset=>Reset, we=>PC_LdEn, data=>pc_in, dout=>pc_out);
Mem : IF_MEM port map(clka=>Clk, addra=> pc_out(11 downto 2), douta=>Instr);

 
end Behavioral;