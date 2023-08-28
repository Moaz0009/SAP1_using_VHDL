library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OutReg is
    Port ( clk : in  STD_LOGIC;
           Outp_in : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end OutReg;

architecture Out_r of OutReg is


signal OUT_content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process (clk)
begin
	if rising_edge(clk) then
		if Outp_in = '1' then
			OUT_content <= datain;
		end if;
	end if;
end process;
dataout <= OUT_content;
end Out_r;

