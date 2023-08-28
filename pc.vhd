library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity p_c is
port(clk:in std_logic;
pco:in std_logic;
clr:in std_logic;
addr:out std_logic_vector(3 downto 0);
inc:in std_logic);
end p_c;
architecture pcc of p_c is
signal inst: std_logic_vector(3 downto 0):=(others => '0');

begin
process(clr,inc,clk)
begin
if clr='1' then inst<="0000" ;
elsif rising_edge (clk) then
if inc='1' then
inst<=inst+1 ;
end if;
end if;
end process;
addr<= inst when pco='1' else (others => '0');
 end pcc;