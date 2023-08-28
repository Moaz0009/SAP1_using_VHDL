library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AC is
    Port ( clk : in  STD_LOGIC;
           Ac_in : in  STD_LOGIC;
          Ac_out : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout_R : out  STD_LOGIC_VECTOR (7 downto 0);
           dataout_alu : out  STD_LOGIC_VECTOR (7 downto 0));
end AC;

architecture A_c of AC is

signal AC_content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process (clk)
begin
	if rising_edge(clk) then
		if Ac_in = '1' then
			AC_content <= datain;
		end if;
	end if;
end process;
dataout_alu <= AC_content;
dataout_R <= AC_content when Ac_out = '1' else (others => '0');
end A_c;

