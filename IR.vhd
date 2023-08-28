library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IR is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           IRin: in  STD_LOGIC;       
           IRout: in  STD_LOGIC;         
           inst_in: in  STD_LOGIC_VECTOR (7 downto 0);
           opcode_out : out  STD_LOGIC_VECTOR (3 downto 0);
           add_out : out  STD_LOGIC_VECTOR (3 downto 0));
end IR;

architecture I_R of IR is

signal IR_content : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');

begin

process (clk, clr)
begin
	if clr = '1' then
		IR_content <= (others => '0');
	elsif rising_edge(clk) then
		if IRin = '1' then
			IR_content <= inst_in;
		end if;
	end if;
end process;
opcode_out<= IR_content(7 downto 4);
add_out<= IR_content(3 downto 0) when IRout = '1' else (others => '0');
end I_R;

