library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity EX_MEM is
port(
clk : in STD_LOGIC;
rst : in STD_LOGIC;
EX_WB_RegWrite_in:in STD_LOGIC;                     
EX_WB_MemtoReg:in STD_LOGIC; 
EX_MEM_Ubranch:in STD_LOGIC;                     
EX_MEM_Cbranch:in STD_LOGIC;                     
EX_MEM_MemRead:in STD_LOGIC;                     
EX_MEM_MemWrite:in STD_LOGIC;   
EX_AdderResult:in STD_LOGIC_VECTOR(63 downto 0); 
EX_Zero:in STD_LOGIC;
EX_ALUResult:in STD_LOGIC_VECTOR(63 downto 0);
EX_RD2: in STD_LOGIC_VECTOR(63 downto 0);
EX_Instruction4_0: in STD_LOGIC_VECTOR(4 downto 0);

MEM_WB_RegWrite_in:out STD_LOGIC;                     
MEM_WB_MemtoReg:out STD_LOGIC; 
MEM_MEM_Ubranch:out STD_LOGIC;                     
MEM_MEM_Cbranch:out STD_LOGIC;                     
MEM_MEM_MemRead:out STD_LOGIC;                     
MEM_MEM_MemWrite:out STD_LOGIC;   
MEM_AdderResult:out STD_LOGIC_VECTOR(63 downto 0); 
MEM_Zero:out STD_LOGIC;
MEM_ALUResult:out STD_LOGIC_VECTOR(63 downto 0);
MEM_RD2:out STD_LOGIC_VECTOR(63 downto 0);
MEM_Instruction4_0:out STD_LOGIC_VECTOR(4 downto 0)
     );
end EX_MEM;

architecture behav1 of EX_MEM is
begin
      process(clk,rst)
      begin  if rst ='1' then 
MEM_WB_RegWrite_in      <='0';                     
MEM_WB_MemtoReg         <='0'; 
MEM_MEM_Ubranch         <='0';                      
MEM_MEM_Cbranch         <='0';                      
MEM_MEM_MemRead         <='0';                     
MEM_MEM_MemWrite        <='0';   
MEM_AdderResult         <=x"0000000000000000"; 
MEM_Zero                <='0';
MEM_ALUResult           <=x"0000000000000000";
MEM_RD2                 <=x"0000000000000000";
MEM_Instruction4_0      <="00000";
           elsif rising_edge(clk) then
MEM_WB_RegWrite_in      <=EX_WB_RegWrite_in;                     
MEM_WB_MemtoReg         <=EX_WB_MemtoReg;
MEM_MEM_Ubranch         <=EX_MEM_Ubranch;                      
MEM_MEM_Cbranch         <=EX_MEM_Cbranch;                      
MEM_MEM_MemRead         <=EX_MEM_MemRead;                     
MEM_MEM_MemWrite        <=EX_MEM_MemWrite;   
MEM_AdderResult         <=EX_AdderResult; 
MEM_Zero                <=EX_Zero;
MEM_ALUResult           <=EX_ALUResult;
MEM_RD2                 <=EX_RD2;
MEM_Instruction4_0      <=EX_Instruction4_0;
          end if;
  end process;
end behav1;

       