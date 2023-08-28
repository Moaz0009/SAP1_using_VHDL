library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity memory is
port( clr: in std_logic;
clk: in std_logic;
re_ad: in std_logic;
      add: in std_logic_vector(3 downto 0);
     data: out std_logic_vector(7 downto 0));
end memory;
architecture mem of memory is
signal word0,word1,word2,word3,word4,word5,word6,word7,word8,word9,word10,word11,word12,word13,word14,word15: std_logic_vector(7 downto 0);
begin
data<=(others => 'g');
word0<="00001001";
word1<="00011010";
word2<="00111111";
word3<="11111111";
word4<="11111111";
word5<="11111111";
word6<="11111111";
word7<="11111111";
word8<="11111111";
word9<="00000101";
word10<="00000011";
word11<="11111111";
word12<="11111111";
word13<="11111111";
word14<="11111111";
word15<="11111111";
process(re_ad,clk,clr)
begin
if clr='1' then
data<="00000000";
elsif falling_edge (clk) then
if re_ad='1' then 
if add="0000" then
data<=word0;
elsif add="0001" then
data<=word1;
elsif add="0010" then
data<=word2;
elsif add="0011" then
data<=word3;
elsif add="0100" then
data<=word4;
elsif add="0101" then
data<=word5;
elsif add="0110" then
data<=word6;
elsif add="0111" then
data<=word7;
elsif add="1000" then
data<=word8;
elsif add="1001" then
data<=word9;
elsif add="1010" then
data<=word10;
elsif add="1011" then
data<=word11;
elsif add="1100" then
data<=word12;
elsif add="1101" then
data<=word13;
elsif add="1110" then
data<=word14;
elsif add="1111" then
data<=word15;
end if;
--else
--data<="00000000";
end if;
end if;
end process;
end mem;
