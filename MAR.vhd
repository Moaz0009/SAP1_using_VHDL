library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity MAR is
  port (Mar_in :in std_logic;
        clk:in std_logic;
        add_in: in std_logic_vector(3 downto 0);
        add_out:out std_logic_vector(3 downto 0));

  end MAR;
  architecture mar_arc of MAR is
    signal content_of_mar : std_logic_vector (3 downto 0):=(others => '0');
    begin 
    process (clk)
    begin
     if rising_edge(clk) then
    if Mar_in= '1' then
    content_of_mar<= add_in;
     end if;
     end if;
    end process;
    add_out<= content_of_mar;
    end mar_arc;
              
    
