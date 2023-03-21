library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity MEM_WB is
port(
clk : in STD_LOGIC;
rst : in STD_LOGIC;
MEM_WB_RegWrite_in:in STD_LOGIC;                     
MEM_WB_MemtoReg:in STD_LOGIC;
MEM_RD:in STD_LOGIC_VECTOR(63 downto 0);
MEM_ALUResult:in STD_LOGIC_VECTOR(63 downto 0);
MEM_Instruction4_0: in STD_LOGIC_VECTOR(4 downto 0);

WB_WB_RegWrite_in:out STD_LOGIC;                     
WB_WB_MemtoReg:out STD_LOGIC;
WB_RD:out STD_LOGIC_VECTOR(63 downto 0);
WB_ALUResult:out STD_LOGIC_VECTOR(63 downto 0);
WR: out STD_LOGIC_VECTOR(4 downto 0)
);
end MEM_WB;
architecture behav1 of MEM_WB is
begin
     process(clk,rst)
        begin 
                if rst='1' then
WB_WB_RegWrite_in<='0';                     
WB_WB_MemtoReg   <='0';
WB_RD            <=x"0000000000000000";
WB_ALUResult     <=x"0000000000000000";
WR               <="00000";
            elsif rising_edge(clk) then

WB_WB_RegWrite_in<=MEM_WB_RegWrite_in;                  
WB_WB_MemtoReg   <=MEM_WB_MemtoReg;
WB_RD            <=MEM_RD ;
WB_ALUResult     <=MEM_ALUResult;
WR               <=MEM_Instruction4_0;
            end if;
       end process;
end behav1;

