library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.array1_pkg.all;
use work.arr_pkg.all;



entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC; 
			  Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end DECSTAGE;

architecture Behavioral of DECSTAGE is

signal mux_in2: datain_t1;
signal mux_out2: std_logic_vector(4 downto 0);
signal mux_out3 :std_logic_vector(31 downto 0);
signal mux_in3: datain_t;
signal mux_in4 :datain_t;
signal opcode: std_logic_vector(5 downto 0);
signal Rs : std_logic_vector (4 downto 0);
signal Rd : std_logic_vector (4 downto 0);
signal Rt: std_logic_vector (4 downto 0);
signal Immediate : std_logic_vector (15 downto 0);
signal buffer1 : std_logic_vector(31 downto 0);

component RF is
port(Ard1 : in  STD_LOGIC_vector (4 downto 0);
           Ard2 : in  STD_LOGIC_vector (4 downto 0);
           Awr : in  STD_LOGIC_vector (4 downto 0);
           Dout1 : out  STD_LOGIC_vector (31 downto 0);
           Dout2 : out  STD_LOGIC_vector (31 downto 0);
           Din : in  STD_LOGIC_vector (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

component mux_2to1 is
port(datain: in datain_t;
            sel: in std_logic;
            dataout: out std_logic_vector(31 downto 0));

end component;


component mux5bit_2to1 is
port(dtin : in datain_t1;
           sel : in  STD_LOGIC;
           dtout : out  STD_LOGIC_VECTOR (4 downto 0));

end component;

component Immed16to32 is
port(Instr : in std_logic_vector(15 downto 0);
		OpCode : in std_logic_vector(5 downto 0);
		Immed :out std_logic_vector(31 downto 0)
		);
end component;

begin
Rs<=Instr(25 downto 21);
Rd<=Instr(20 downto 16);
Rt<=Instr(15 downto 11);
Immediate <= Instr(15 downto 0);
mux_in2(0)<= Rt;
mux_in2(1)<= Rd;
mux_in3(0)<=ALU_out;
mux_in3(1)<=MEM_out;
opcode <= Instr(31 downto 26);


mux1: mux5bit_2to1 port map(dtin =>mux_in2,sel=>RF_B_sel,dtout=>mux_out2);
mux2: mux_2to1 port map(datain=>mux_in3,sel=>RF_WrData_sel,dataout=>mux_out3);
Immed1 : Immed16to32 port map(Instr => Immediate, OpCode => opcode, Immed=>Immed);
regf: RF port map(Ard1=>Rs,Ard2 =>mux_out2,Awr=>Rd,Dout1=>RF_A,Dout2=>RF_B,Din=>mux_out3,WrEn=>RF_WrEn,Clk=>Clk);


end Behavioral;