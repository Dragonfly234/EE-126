library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  ID_EX is
port (     
clk : in STD_LOGIC;
rst : in STD_LOGIC;
ID_WB_RegWrite_in:in STD_LOGIC;                     
ID_WB_MemtoReg:in STD_LOGIC;                   
ID_MEM_Ubranch:in STD_LOGIC;                     
ID_MEM_Cbranch:in STD_LOGIC;                     
ID_MEM_MemRead:in STD_LOGIC;                     
ID_MEM_MemWrite:in STD_LOGIC;                     
ID_EX_ALUop:in STD_LOGIC_VECTOR(1 downto 0);                     
ID_EX_ALUsrc:in STD_LOGIC;                     
ID_PC_in: in STD_LOGIC_VECTOR(63 downto 0);                     
ID_RD1: in STD_LOGIC_VECTOR(63 downto 0);                    
ID_RD2: in STD_LOGIC_VECTOR(63 downto 0);                    
ID_SignExtend: in STD_LOGIC_VECTOR(63 downto 0);                     
ID_Instruction31_21: in STD_LOGIC_VECTOR(10 downto 0);                     
ID_Instruction4_0: in STD_LOGIC_VECTOR(4 downto 0);

ID_Instruction9_5: in STD_LOGIC_VECTOR(4 downto 0);
ID_Instruction20_16: in STD_LOGIC_VECTOR(4 downto 0);

EX_WB_RegWrite_in:out STD_LOGIC;                     
EX_WB_MemtoReg:out STD_LOGIC;                   
EX_MEM_Ubranch:out STD_LOGIC;                     
EX_MEM_Cbranch:out STD_LOGIC;                     
EX_MEM_MemRead:out STD_LOGIC;                     
EX_MEM_MemWrite:out STD_LOGIC;                     
EX_EX_ALUop:out STD_LOGIC_VECTOR(1 downto 0);                     
EX_EX_ALUsrc:out STD_LOGIC;                     
EX_PC_in: out STD_LOGIC_VECTOR(63 downto 0);                     
EX_RD1: out STD_LOGIC_VECTOR(63 downto 0);                    
EX_RD2: out STD_LOGIC_VECTOR(63 downto 0);                    
EX_SignExtend: out STD_LOGIC_VECTOR(63 downto 0);                     
EX_Instruction31_21: out STD_LOGIC_VECTOR(10 downto 0);                     
EX_Instruction4_0: out STD_LOGIC_VECTOR(4 downto 0);

EX_Instruction9_5: out STD_LOGIC_VECTOR(4 downto 0);
EX_Instruction20_16: out STD_LOGIC_VECTOR(4 downto 0)

 );
end ID_EX;

architecture behav1 of ID_EX is
begin 
      process(clk,rst)
         begin
               if rst ='1' then
 EX_WB_RegWrite_in  <='0';                     
 EX_WB_MemtoReg     <='0';                   
 EX_MEM_Ubranch     <='0';                     
 EX_MEM_Cbranch     <='0';                     
 EX_MEM_MemRead     <='0';                     
 EX_MEM_MemWrite    <='0';                     
 EX_EX_ALUop        <="00";                     
 EX_EX_ALUsrc       <='0';                     
 EX_PC_in           <=x"0000000000000000";                     
 EX_RD1             <=x"0000000000000000";                    
 EX_RD2             <=x"0000000000000000";                     
 EX_SignExtend      <=x"0000000000000000";                     
 EX_Instruction31_21<="00000000000";                     
 EX_Instruction4_0  <="00000";
 EX_Instruction9_5  <="00000";
 EX_Instruction20_16  <="00000";
              elsif rising_edge(clk) then
                  EX_WB_RegWrite_in<=ID_WB_RegWrite_in;
                  EX_WB_MemtoReg   <=ID_WB_MemtoReg;
                  EX_MEM_Ubranch   <=ID_MEM_Ubranch;
                  EX_MEM_Cbranch   <=ID_MEM_Cbranch;
                  EX_MEM_MemRead   <=ID_MEM_MemRead;
                  EX_MEM_MemWrite  <=ID_MEM_MemWrite;
                  EX_EX_ALUop      <=ID_EX_ALUop;
                  EX_EX_ALUsrc     <=ID_EX_ALUsrc;
                  EX_PC_in         <=ID_PC_in;
                  EX_RD1           <=ID_RD1;
                  EX_RD2           <=ID_RD2;
                  EX_SignExtend    <=ID_SignExtend;
                  EX_Instruction31_21<=ID_Instruction31_21;
                  EX_Instruction4_0  <=ID_Instruction4_0;
                  EX_Instruction9_5  <=ID_Instruction9_5;
                  EX_Instruction20_16  <=ID_Instruction20_16;
                   
                end if;
   end process;
end behav1;
