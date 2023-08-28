library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity SAP is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end SAP;
architecture collect of SAP is

component control is port 
(clr,clk:in std_logic;
opcode:in std_logic_vector(3 downto 0);
inc,pco,iri,ao,pi,s_a,mai,rd,iro,ai,aluo,bi,hlt:out std_logic);
end component;

component p_c is
port(clk:in std_logic;
pco:in std_logic;
clr:in std_logic;
addr:out std_logic_vector(3 downto 0);
inc:in std_logic);
end component;

component ALU is
  port (clk:in std_logic;
    A, B: in std_logic_vector(7 downto 0);
    S_a: in std_logic;
    aluo: in std_logic;
    Result: out std_logic_vector(7 downto 0));
end component;
component IR is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           IRin: in  STD_LOGIC;       
           IRout: in  STD_LOGIC;         
           inst_in: in  STD_LOGIC_VECTOR (7 downto 0);
           opcode_out : out  STD_LOGIC_VECTOR (3 downto 0);
           add_out : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

--component memory is
 --  port( clr: in std_logic;
--clk: in std_logic;
--re_ad: in std_logic;
 --   add: in std_logic_vector(3 downto 0);
--     data_out: out std_logic_vector(7 downto 0));
--end component;
--component me_ory is
 --   Port ( clk:in std_logic;
--address : in  STD_LOGIC_VECTOR (3 downto 0);
      --     dataout : out  STD_LOGIC_VECTOR (7 downto 0);
          -- re_ad : in  STD_LOGIC);
--end component;
component SAP1_Memory is
 Port ( clk : in STD_LOGIC;
         address : in STD_LOGIC_VECTOR (3 downto 0);
         data_out : out STD_LOGIC_VECTOR (7 downto 0);
          load : in STD_LOGIC);
end component;
component B_Reg is
Port ( clk : in  std_logic;
           B_in : in  std_logic;
           Data_in : in  std_logic_vector (7 downto 0);
           Data_out : out  std_logic_vector  (7 downto 0));
end component;
component MAR is
   port (clk:in std_logic;
Mar_in :in std_logic;
        add_in: in std_logic_vector(3 downto 0);
        add_out:out std_logic_vector(3 downto 0));

  end component;
component AC is
   Port ( clk : in  STD_LOGIC;
           Ac_in : in  STD_LOGIC;
          Ac_out : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout_R : out  STD_LOGIC_VECTOR (7 downto 0);
           dataout_alu : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
component OutReg is
 Port ( clk : in  STD_LOGIC;
           Outp_in : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
signal active_clk:std_logic;
signal bus_data:std_logic_vector(7 downto 0);
signal opre_one,opre_two:std_logic_vector(7 downto 0):=(others=>'0');
signal inc,pco,iri,ao,pi,s_a,mai,rd,iro,ai,aluo,bi:std_logic:='0';
signal hlt:std_logic:='1';
signal mar_out:std_logic_vector(3 downto 0) :=(others=>'0');
signal op_code:std_logic_vector(3 downto 0) :="0000";
begin
active_clk<=hlt and clk;
Pc_mapping : p_c port map (clk => active_clk ,pco => pco ,clr => clr ,addr =>bus_data(3 downto 0) ,inc => inc);
Mar_mapping : MAR port map (clk =>active_clk , Mar_in => mai ,add_in =>bus_data(3 downto 0) ,add_out => mar_out);
--Memory_mapping : me_ory port map (clk=> clk ,address => mar_out ,dataout => memory_alu_out , re_ad=> rd);
Memory_mapping : SAP1_Memory port map (clk=> active_clk ,address => mar_out ,data_out => bus_data , load=> rd);

--Memory_mapping : memory port map (clr => clr,clk=>active_clk ,re_ad=> rd,add => mar_out ,data_out =>bus_data );
IR_mapping : IR port map (clk => active_clk,clr => clr ,IRin =>iri ,IRout => iro , inst_in => bus_data,opcode_out => op_code,add_out =>bus_data(3 downto 0));
Control_unit_mapping : control port map (clr => clr,clk => active_clk,opcode =>op_code , inc => inc ,pco => pco ,iri => iri ,ao => ao ,pi => pi ,s_a => s_a,mai => mai ,rd => rd,iro => iro ,ai => ai,aluo => aluo,bi => bi,hlt => hlt);
Ac_mapping : AC port map (clk => active_clk , Ac_in => ai , Ac_out=>ao , datain =>bus_data , dataout_R => bus_data  ,dataout_alu => opre_one );
Alu_mapping : ALU port map ( clk=> clk ,A => opre_one , B =>opre_two ,s_a => s_a , aluo => aluo , Result => bus_data);
B_register_mapping : B_Reg port map (clk => active_clk ,B_in =>bi ,Data_in => bus_data,Data_out => opre_two );
Out_Put_Register_mapping : OutReg port map (clk => active_clk ,outp_in =>pi ,datain =>bus_data  ,dataout => dataout);
end collect;

--Pc_mapping : p_c port map (clk  ,pco  ,clr  ,opre_inst_add  ,inc);
--Mar_mapping : MAR port map (clk ,mai  ,opre_inst_add, mar_out);
--Memory_mapping : me_ory port map (mar_out  ,memory_alu_out,rd );
--IR_mapping : IR port map (clk ,clr  ,iri  ,iro  ,memory_alu_out  ,op_code ,opre_inst_add );
--Ac_mapping : AC port map (clk ,ai ,ao  ,memory_alu_out  ,ac_to_OR ,opre_one );
--B_register_mapping : B_Reg port map (clk  ,bi  ,memory_alu_out  ,opre_two );
--Alu_mapping : ALU port map (opre_one  ,opre_two ,s_a  ,aluo ,memory_alu_out);
--Out_Put_Register_mapping : OutReg port map (active_clk  ,pi  ,ac_to_OR ,dataout);
--Control_unit_mapping : control port map(clr ,clk  ,op_code ,inc ,pco  ,iri  ,ao  ,pi ,s_a ,mai  ,rd,iro ,ai ,aluo,bi ,hlt );
--end collect;

--active_clk<=hlt and clc;
--Pc_mapping : p_c port map (