-- control unit implementation
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity control is port 
(clr,clk:in std_logic;
opcode:in std_logic_vector(3 downto 0);
inc,pco,iri,ao,pi,s_a,mai,rd,iro,ai,aluo,bi,hlt:out std_logic);
end control;
architecture c_t of control is
signal count:std_logic_vector(0 to 3);
signal rst1,lda,add,sub,outp,t0,t1,t2,t3,t4,t5:std_logic;
begin
process(clr,clk)
begin
if (clr='1')then count<="0000";
elsif(clk'event and clk='1')then count<=count+1;
if(rst1='1') then count<="0000";
end if;
end if;
end process;	
--control signals
t0<=(not( count(0))) and (not( count(1)))and( not( count(2)) ) and (not( count(3)));
t1<=(not( count(0))) and (not( count(1)))and( not( count(2)) ) and (( count(3)));
t2<=(not( count(0))) and (not( count(1)))and( ( count(2)) ) and (not( count(3)));
t3<=(not( count(0))) and (not( count(1)))and(( count(2)) ) and (( count(3)));
t4<=(not( count(0))) and (( count(1)))and( not( count(2)) ) and (not( count(3)));
t5<=(not( count(0))) and (( count(1)))and( not( count(2)) ) and (( count(3)));
--t6<=(not( count(0))) and (( count(1)))and( ( count(2)) ) and (not ( count(3)));
rst1<=(not( count(0))) and (( count(1)))and( not( count(2)) ) and (( count(3)));
--opcode decoding
lda<=(not( opcode(3))) and (not( opcode(2)))and( not( opcode(1)) ) and (not( opcode(0)));
add<=(not( opcode(3))) and (not( opcode(2)))and( not( opcode(1)) ) and (( opcode(0)));
sub<=(not( opcode(3))) and (not( opcode(2)))and( ( opcode(1)) ) and (not( opcode(0)));
outp<=(not( opcode(3))) and (not( opcode(2)))and( ( opcode(1)) ) and (( opcode(0)));
hlt<=not ((( opcode(3))) and (( opcode(2)))and( ( opcode(1)) ) and (( opcode(0))));
-- output signal
inc<=t1;
pco<=t0;
iri<=t2;
ao<=outp and t3;
pi<=outp and t3;
s_a<=sub and t5;
mai<=t0 or (lda and t3) or (add and t3) or (sub or t3);
rd<=t2 or (lda and t4) or (add and t4) or (sub and t4);
iro<= (lda and t3) or (add and t3) or (sub and t3);
ai<=(lda and t4) or (add and t5) or (sub and t5);
aluo<= (add and t5) or (sub and t5);
bi<= ( add and t4) or (sub and t4);

end c_t;
