library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package arra_pkg is
	type mux32to1_outputs_t is array (0 to 1) of std_logic_vector(31 downto 0);
	type cModule_outputs_t is array (0 to 1) of std_logic;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arra_pkg.all;
use work.array_pkg.all;
use work.arr_pkg.all;


entity RF is
Port ( Ard1 : in  STD_LOGIC_vector (4 downto 0);
           Ard2 : in  STD_LOGIC_vector (4 downto 0);
           Awr : in  STD_LOGIC_vector (4 downto 0);
           Dout1 : out  STD_LOGIC_vector (31 downto 0);
           Dout2 : out  STD_LOGIC_vector (31 downto 0);
           Din : in  STD_LOGIC_vector (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is

signal decoder_out :std_logic_vector(31 downto 0);
signal register_outputs : array32of32bits;
signal mux32to1_outputs : datain_t;
signal cModule_outputs : cModule_outputs_t;
signal WriteEnableAndDecOut : std_logic_vector (0 to 31);

component reg is
port (CLK : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux_32to1 is
port (data_in : in array32of32bits;
		sel: in std_logic_vector (4 downto 0);
		data_out: out std_logic_vector(31 downto 0));
end component;

component decoder_5to32 is
port ( a: in std_logic_vector (4 downto 0);
		y : out std_logic_vector (31 downto 0));
end component;
		
component mux_2to1 is
port (datain: in datain_t;
		sel: in std_logic;
		dataout: out std_logic_vector(31 downto 0));
end component;

component Compare_Module is
port ( data_write: in std_logic_vector (4 downto 0);
		data_read: in std_logic_vector(4 downto 0);
		WriteEnable: in std_logic;
		out_data: out std_logic);
end component;

begin

decoder : decoder_5to32 port map( a=>Awr, y => decoder_out);

	WriteEnableAndDecOut(0) <= '1';
	WriteEnableAndDecOut(1) <= WrEn and decoder_out(1);
	WriteEnableAndDecOut(2) <= WrEn and decoder_out(2);
	WriteEnableAndDecOut(3) <= WrEn and decoder_out(3);
	WriteEnableAndDecOut(4) <= WrEn and decoder_out(4);
	WriteEnableAndDecOut(5) <= WrEn and decoder_out(5);
	WriteEnableAndDecOut(6) <= WrEn and decoder_out(6);
	WriteEnableAndDecOut(7) <= WrEn and decoder_out(7);
	WriteEnableAndDecOut(8) <= WrEn and decoder_out(8);
	WriteEnableAndDecOut(9) <= WrEn and decoder_out(9);
	WriteEnableAndDecOut(10) <= WrEn and decoder_out(10);
	WriteEnableAndDecOut(11) <= WrEn and decoder_out(11);
	WriteEnableAndDecOut(12) <= WrEn and decoder_out(12);
	WriteEnableAndDecOut(13) <= WrEn and decoder_out(13);
	WriteEnableAndDecOut(14) <= WrEn and decoder_out(14);
	WriteEnableAndDecOut(15) <= WrEn and decoder_out(15);
	WriteEnableAndDecOut(16) <= WrEn and decoder_out(16);
	WriteEnableAndDecOut(17) <= WrEn and decoder_out(17);
	WriteEnableAndDecOut(18) <= WrEn and decoder_out(18);
	WriteEnableAndDecOut(19) <= WrEn and decoder_out(19);
	WriteEnableAndDecOut(20) <= WrEn and decoder_out(20);
	WriteEnableAndDecOut(21) <= WrEn and decoder_out(21);
	WriteEnableAndDecOut(22) <= WrEn and decoder_out(22);
	WriteEnableAndDecOut(23) <= WrEn and decoder_out(23);
	WriteEnableAndDecOut(24) <= WrEn and decoder_out(24);
	WriteEnableAndDecOut(25) <= WrEn and decoder_out(25);
	WriteEnableAndDecOut(26) <= WrEn and decoder_out(26);
	WriteEnableAndDecOut(27) <= WrEn and decoder_out(27);
	WriteEnableAndDecOut(28) <= WrEn and decoder_out(28);
	WriteEnableAndDecOut(29) <= WrEn and decoder_out(29);
	WriteEnableAndDecOut(30) <= WrEn and decoder_out(30);
	WriteEnableAndDecOut(31) <= WrEn and decoder_out(31);

	register0: reg port map(CLK => Clk, WE =>WriteEnableAndDecOut(0), Data => "00000000000000000000000000000000", Dout => register_outputs(0));
	
	
	
	registers : for i in 1 to 31 generate 
				single_register : reg port map(CLK => Clk,
															WE => WriteEnableAndDecOut(i),
															Data => Din,
															Dout => register_outputs(i));
					end generate registers;

	mux32to1_1 : mux_32to1 port map(sel =>Ard1,
												data_in => register_outputs,
												data_out=>mux32to1_outputs(0));
												
	mux32to1_2 : mux_32to1 port map( sel =>Ard2,
												data_in => register_outputs,
												data_out=>mux32to1_outputs(1));
												
	cmp1 : Compare_Module port map(data_write => Awr,
											 data_read => Ard1,
											 WriteEnable => WrEn,
											 out_data => cModule_outputs(0));
	cmp2 : Compare_Module port map(data_write => Awr,
											 data_read => Ard2,
											 WriteEnable => WrEn,
											 out_data => cModule_outputs(1));
	
	mux2to1_1 : mux_2to1 port map( sel => cModule_outputs(0),
											datain(0) => mux32to1_outputs(0),
											datain(1) => Din,
											dataout => Dout1);



	mux2to1_2 : mux_2to1 port map( sel => cModule_outputs(1),
											datain(0) => mux32to1_outputs(1),
											datain(1) => Din,
											dataout => Dout2);

end Behavioral;


