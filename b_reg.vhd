library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity B_Reg is
    Port ( clk : in  std_logic;
           B_in : in  std_logic;
           Data_in : in  std_logic_vector (7 downto 0);
           Data_out : out  std_logic_vector  (7 downto 0));
end B_Reg;

architecture Breg of B_Reg is

signal B_content : std_logic_vector  (7 downto 0) := (others => '0');

begin
process (clk)
begin
 if rising_edge(clk) then
  if B_in = '1' then
   B_content <= Data_in;
  end if;
 end if;
end process;
Data_out <= B_content;
end ;
