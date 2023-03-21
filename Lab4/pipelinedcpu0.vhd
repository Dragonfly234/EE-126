library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity PipelinedCPU0 is
port(
     clk : in STD_LOGIC;
     rst : in STD_LOGIC;
     --Probe ports used for testing
     --The current address (AddressOut from the PC)
     DEBUG_PC : out STD_LOGIC_VECTOR(63 downto 0);
     --The current instruction (Instruction output of IMEM)
     DEBUG_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0);
     --DEBUG ports from other components
     DEBUG_TMP_REGS     : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_SAVED_REGS   : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end PipelinedCPU0;

architecture behav1 of PipelinedCPU0 is
component PC is
port(
     clk          : in  STD_LOGIC; -- Propogate AddressIn to AddressOut on rising edge of clock
     write_enable : in  STD_LOGIC; -- Only write if '1'
     rst          : in  STD_LOGIC; -- Asynchronous reset! Sets AddressOut to 0x0
     AddressIn    : in  STD_LOGIC_VECTOR(63 downto 0); -- Next PC address
     AddressOut   : out STD_LOGIC_VECTOR(63 downto 0) -- Current PC address
);
end component;

component ADD is
port(
     in0    : in  STD_LOGIC_VECTOR(63 downto 0);
     in1    : in  STD_LOGIC_VECTOR(63 downto 0);
     output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;


component ALU is
port(
     in0       : in     STD_LOGIC_VECTOR(63 downto 0);
     in1       : in     STD_LOGIC_VECTOR(63 downto 0);
     operation : in     STD_LOGIC_VECTOR(3 downto 0);
     result    : buffer STD_LOGIC_VECTOR(63 downto 0);
     zero      : buffer STD_LOGIC;
     overflow  : buffer STD_LOGIC
    );
end component;

component ALUControl is
port(
     ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
     Opcode    : in  STD_LOGIC_VECTOR(10 downto 0);
     Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

component AND2 is
port (
      in0    : in  STD_LOGIC;
      in1    : in  STD_LOGIC;
      output : out STD_LOGIC -- in0 and in1
);
end component;

component CPUControl is
port(Opcode   : in  STD_LOGIC_VECTOR(10 downto 0);
     Reg2Loc  : out STD_LOGIC;
     CBranch  : out STD_LOGIC;  --conditional
     MemRead  : out STD_LOGIC;
     MemtoReg : out STD_LOGIC;
     MemWrite : out STD_LOGIC;
     ALUSrc   : out STD_LOGIC;
     RegWrite : out STD_LOGIC;
     UBranch  : out STD_LOGIC; -- This is unconditional
     ALUOp    : out STD_LOGIC_VECTOR(1 downto 0)
);
end component;

component DMEM is
generic(NUM_BYTES : integer := 64);
-- NUM_BYTES is the number of bytes in the memory (small to save computation resources)
port(
     WriteData          : in  STD_LOGIC_VECTOR(63 downto 0); -- Input data
     Address            : in  STD_LOGIC_VECTOR(63 downto 0); -- Read/Write address
     MemRead            : in  STD_LOGIC; -- Indicates a read operation
     MemWrite           : in  STD_LOGIC; -- Indicates a write operation
     Clock              : in  STD_LOGIC; -- Writes are triggered by a rising edge
     ReadData           : out STD_LOGIC_VECTOR(63 downto 0); -- Output data
     --Probe ports used for testing
     -- Four 64-bit words: DMEM(0) & DMEM(4) & DMEM(8) & DMEM(12)
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;

component IMEM is
port(
     Address  : in  STD_LOGIC_VECTOR(63 downto 0); -- Address to read from
     ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end component;

component MUX5 is
port(
    in0    : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 0
    in1    : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 1
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC_VECTOR(4 downto 0)
);
end component;

component MUX64 is
port(
    in0    : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 0
    in1    : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 1
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;

component registers is
port(RR1      : in  STD_LOGIC_VECTOR (4 downto 0); 
     RR2      : in  STD_LOGIC_VECTOR (4 downto 0); 
     WR       : in  STD_LOGIC_VECTOR (4 downto 0); 
     WD       : in  STD_LOGIC_VECTOR (63 downto 0);
     RegWrite : in  STD_LOGIC;
     Clock    : in  STD_LOGIC;
     RD1      : out STD_LOGIC_VECTOR (63 downto 0);
     RD2      : out STD_LOGIC_VECTOR (63 downto 0);
     --Probe ports used for testing
     -- $t0 & $t1 & t2 & t3
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     -- $s0 & $s1 & s2 & s3
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;

component Shiftleft2 is
port(  
     x : in  STD_LOGIC_VECTOR(63 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- x << 2
);
end component;

component SignExtend is
port(
     x : in  STD_LOGIC_VECTOR(31 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
);
end component;

component OR2 is

    port(in0 : in std_logic;      
         in1 : in std_logic;     
         output : out std_logic);   

end component;

component IF_ID is

port(     clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          IF_PC_in:in STD_LOGIC_VECTOR(63 downto 0);
          IF_Instruction_in:in STD_LOGIC_VECTOR(31 downto 0);
          ID_PC_out:out STD_LOGIC_VECTOR(63 downto 0);
          ID_Instruction_out:out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component  ID_EX is
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
EX_Instruction4_0: out STD_LOGIC_VECTOR(4 downto 0)
 );
end component;

component EX_MEM is
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
end component;

component MEM_WB is
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
end component;

signal MUX64_IF_out : std_logic_vector(63 downto 0);
signal PC_out : std_logic_vector(63 downto 0);
signal IF_IMEM : std_logic_vector(31 downto 0);
signal ID_PC : std_logic_vector(63 downto 0);
signal ID_Instruction: std_logic_vector(31 downto 0);
signal Reg2Loc : STD_LOGIC;
signal MUX5_out: std_logic_vector(4 downto 0);
signal  WB_WR : std_logic_vector(4 downto 0);
signal MUX64_WB_out : std_logic_vector(63 downto 0);
signal ID_RD1 : std_logic_vector(63 downto 0);
signal ID_RD2 : std_logic_vector(63 downto 0);
signal ID_SignExtend : std_logic_vector(63 downto 0);
signal DEBUG_TMP_REGS_out :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_SAVED_REGS_out:  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_MEM_CONTENTS_out :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal Regwrite : STD_LOGIC;
signal ALUSrc : STD_LOGIC;
signal CBranch : STD_LOGIC;
signal UBranch : STD_LOGIC;
signal ALUOp: std_logic_vector(1 downto 0);
signal MemWrite : STD_LOGIC;
signal MemRead : STD_LOGIC;
signal MemtoReg : STD_LOGIC;
signal EX_WB_RegWrite : STD_LOGIC;
signal EX_WB_MemtoReg : STD_LOGIC;
signal EX_MEM_Ubranch : STD_LOGIC;
signal EX_MEM_Cbranch : STD_LOGIC;
signal EX_MEM_MemWrite : STD_LOGIC;
signal EX_EX_ALUop : STD_LOGIC_VECTOR(1 downto 0); 
signal EX_EX_ALUsrc : STD_LOGIC;
signal EX_PC:   STD_LOGIC_VECTOR(63 downto 0);                     
signal EX_RD1:  STD_LOGIC_VECTOR(63 downto 0);                    
signal EX_RD2:  STD_LOGIC_VECTOR(63 downto 0);
signal EX_SignExtend:  STD_LOGIC_VECTOR(63 downto 0);                     
signal EX_Instruction31_21:  STD_LOGIC_VECTOR(10 downto 0);                     
signal EX_Instruction4_0:  STD_LOGIC_VECTOR(4 downto 0);
signal MUX64_EX_out:  STD_LOGIC_VECTOR(63 downto 0);
signal Shiftleft2_out:  STD_LOGIC_VECTOR(63 downto 0);
signal EX_ADD_out:  STD_LOGIC_VECTOR(63 downto 0);
signal EX_ALUResult:  STD_LOGIC_VECTOR(63 downto 0);
signal EX_ALUZero:  STD_LOGIC; 
signal ALUControl_out : std_logic_vector(3 downto 0);
signal MEM_WB_RegWrite: STD_LOGIC;                     
signal MEM_WB_MemtoReg: STD_LOGIC; 
signal MEM_MEM_Ubranch: STD_LOGIC;                     
signal MEM_MEM_Cbranch: STD_LOGIC;                     
signal MEM_MEM_MemRead: STD_LOGIC;                     
signal MEM_MEM_MemWrite: STD_LOGIC; 
signal MEM_AdderResult: STD_LOGIC_VECTOR(63 downto 0); 
signal MEM_Zero: STD_LOGIC;
signal MEM_ALUResult: STD_LOGIC_VECTOR(63 downto 0);
signal MEM_RD2: STD_LOGIC_VECTOR(63 downto 0);
signal MEM_Instruction4_0: STD_LOGIC_VECTOR(4 downto 0);
signal MEM_DMEM_out : std_logic_vector(63 downto 0);
signal WB_WB_RegWrite:STD_LOGIC;                     
signal WB_WB_MemtoReg:STD_LOGIC;
signal WB_RD: STD_LOGIC_VECTOR(63 downto 0);
signal WB_ALUResult: STD_LOGIC_VECTOR(63 downto 0);
signal WR:  STD_LOGIC_VECTOR(4 downto 0);
signal ADD_IF_out: STD_LOGIC_VECTOR(63 downto 0);
signal AND2_out:STD_LOGIC; 
signal OR2_out:STD_LOGIC; 
signal EX_MEM_MemRead:STD_LOGIC; 
begin
PC_1:PC port map(
                 write_enable => '1',
	         clk => clk,
                 rst => rst,      
                 addressIn => MUX64_IF_out (63 downto 0),
		 addressOut => PC_out(63 downto 0)
		 );

IMEM_1:IMEM port map(
                     Address => PC_out(63 downto 0),
                     ReadData => IF_IMEM(31 downto 0)
		   );

IF_ID_1:IF_ID port map(
	         clk => clk,
                 rst => rst, 
             IF_PC_in =>PC_out(63 downto 0),
          IF_Instruction_in=> IF_IMEM(31 downto 0),
          ID_PC_out=>ID_PC,
          ID_Instruction_out=>ID_Instruction(31 downto 0)
                     );

MUX5_1:MUX5 port map(
                     sel =>Reg2Loc,
		     in0 => ID_Instruction(20 downto 16),
                     in1 => ID_Instruction(4 downto 0),
		     output => MUX5_out(4 downto 0)
                    );

registers_1:registers  port map(
     RR1      =>ID_Instruction(9 downto 5),
     RR2      =>MUX5_out(4 downto 0),
     WR       =>WB_WR(4 downto 0),
     WD        =>MUX64_WB_out(63 downto 0),
     RegWrite  =>WB_WB_RegWrite,
     Clock    =>clk,
     RD1      =>ID_RD1(63 downto 0),
     RD2      =>ID_RD2(63 downto 0),
     DEBUG_TMP_REGS => DEBUG_TMP_REGS_out(64*4 - 1 downto 0),
     DEBUG_SAVED_REGS => DEBUG_SAVED_REGS_out(64*4 - 1 downto 0)
                              );

SignExtend_1:SignExtend port map
(
     x =>ID_Instruction(31 downto 0),
     y =>ID_signExtend(63 downto 0)
 );

ID_EX_1: ID_EX port map(
clk =>clk,
rst => rst,
ID_WB_RegWrite_in=>RegWrite,                    
ID_WB_MemtoReg=>MemtoReg,                   
ID_MEM_Ubranch=>Ubranch,                    
ID_MEM_Cbranch=>Cbranch,                   
ID_MEM_MemRead=>MemRead,                     
ID_MEM_MemWrite=>MemWrite,                    
ID_EX_ALUop=>ALUop,                     
ID_EX_ALUsrc=>ALUsrc,                    
ID_PC_in=>ID_PC,                    
ID_RD1=>ID_RD1(63 downto 0),                   
ID_RD2=>ID_RD2(63 downto 0),                   
ID_SignExtend=>ID_SignExtend(63 downto 0),                    
ID_Instruction31_21 => ID_instruction(31 downto 21),                     
ID_Instruction4_0=> ID_instruction(4 downto 0),

EX_WB_RegWrite_in=>EX_WB_RegWrite,                     
EX_WB_MemtoReg=>EX_WB_MemtoReg,                   
EX_MEM_Ubranch=>EX_MEM_Ubranch,                    
EX_MEM_Cbranch=>EX_MEM_Cbranch,                    
EX_MEM_MemRead=>EX_MEM_MemRead,                    
EX_MEM_MemWrite=>EX_MEM_MemWrite,                     
EX_EX_ALUop=>EX_EX_ALUop(1 downto 0),                    
EX_EX_ALUsrc=>EX_EX_ALUsrc,                     
EX_PC_in=> EX_PC(63 downto 0),                    
EX_RD1=>EX_RD1(63 downto 0),                   
EX_RD2=>EX_RD2(63 downto 0),                    
EX_SignExtend=>EX_SignExtend(63 downto 0),                    
EX_Instruction31_21=>EX_Instruction31_21(10 downto 0),                    
EX_Instruction4_0=> EX_Instruction4_0(4 downto 0)
);


CPUControl_1:CPUControl port map
(    Opcode   =>ID_Instruction(31 downto 21),
     Reg2Loc  =>Reg2Loc,
     CBranch  =>CBranch, 
     MemRead  =>MemRead,
     MemtoReg =>MemtoReg,
     MemWrite =>MemWrite,
     ALUSrc   =>ALUSrc,
     RegWrite =>RegWrite,
     UBranch  =>UBranch, 
     ALUOp    => ALUOp(1 downto 0)
);

MUX64_EX:MUX64 port map
(
    in0=>EX_RD2(63 downto 0),
    in1=>EX_SignExtend(63 downto 0),
    sel=>EX_EX_ALUsrc,
    output =>MUX64_EX_out(63 downto 0)
);

Shiftleft2_1:Shiftleft2 port map
(  
     x => EX_SignExtend(63 downto 0),
     y => Shiftleft2_out(63 downto 0) 
);

ADD_EX:ADD port map
(
     in0    => EX_PC(63 downto 0),
     in1    => Shiftleft2_out(63 downto 0),
     output => EX_ADD_out(63 downto 0)
);

ALU_1:ALU port map
(
     in0       =>EX_RD1(63 downto 0),
     in1       =>MUX64_EX_out(63 downto 0),
     operation =>ALUControl_out(3 downto 0),
     result    =>EX_ALUResult(63 downto 0),
     zero      =>EX_ALUZero
   );

ALUControl_1:ALUControl port map
(
     ALUOp     =>ALUOp(1 downto 0),
     Opcode    =>EX_Instruction31_21,
     Operation =>ALUControl_out(3 downto 0)
    );


EX_MEM_1:EX_MEM port map
(
clk =>clk,
rst =>rst,
EX_WB_RegWrite_in=>EX_WB_RegWrite,                     
EX_WB_MemtoReg=>EX_WB_MemtoReg, 
EX_MEM_Ubranch=>EX_MEM_Ubranch,                     
EX_MEM_Cbranch=>EX_MEM_Cbranch,                     
EX_MEM_MemRead=>EX_MEM_MemRead,                     
EX_MEM_MemWrite=>EX_MEM_MemWrite,   
EX_AdderResult=>EX_ADD_out,
EX_Zero=>EX_ALUZero,
EX_ALUResult=>EX_ALUResult(63 downto 0),
EX_RD2=> EX_RD2(63 downto 0),
EX_Instruction4_0=>EX_Instruction4_0(4 downto 0),

MEM_WB_RegWrite_in=>MEM_WB_RegWrite,                    
MEM_WB_MemtoReg=>MEM_WB_MemtoReg, 
MEM_MEM_Ubranch=>MEM_MEM_Ubranch,                    
MEM_MEM_Cbranch=>MEM_MEM_Cbranch,                     
MEM_MEM_MemRead=>MEM_MEM_MemRead,                    
MEM_MEM_MemWrite=>MEM_MEM_MemWrite,   
MEM_AdderResult=>MEM_AdderResult(63 downto 0), 
MEM_Zero=>MEM_Zero,
MEM_ALUResult=>MEM_ALUResult(63 downto 0),
MEM_RD2=>MEM_RD2(63 downto 0),
MEM_Instruction4_0=>MEM_Instruction4_0(4 downto 0)
);

DEME_1:DMEM port map
(
     WriteData          =>MEM_RD2(63 downto 0),
     Address            =>MEM_ALUResult(63 downto 0), 
     MemRead            => MEM_MEM_MemRead, 
     MemWrite           => MEM_MEM_MemWrite, 
     Clock              =>clk,
     ReadData           =>MEM_DMEM_out(63 downto 0), 
     DEBUG_MEM_CONTENTS =>DEBUG_MEM_CONTENTS_out(64*4 - 1 downto 0)
);

MEM_WB_1: MEM_WB port map
(
clk =>clk,
rst =>rst,
MEM_WB_RegWrite_in=>MEM_WB_RegWrite,
MEM_WB_MemtoReg=>MEM_WB_MemtoReg,
MEM_RD=>MEM_DMEM_out(63 downto 0),
MEM_ALUResult=>MEM_ALUResult(63 downto 0),
MEM_Instruction4_0=>MEM_Instruction4_0(4 downto 0),

WB_WB_RegWrite_in=>WB_WB_RegWrite,                    
WB_WB_MemtoReg=>WB_WB_MemtoReg,
WB_RD=>WB_RD(63 downto 0),
WB_ALUResult=>WB_ALUResult(63 downto 0),
WR=> WB_WR(4 downto 0)
);

ADD_IF: ADD port map
(
     in1    => PC_out(63 downto 0),
     in0    => x"0000_0000_0000_0004",
     output => ADD_IF_out(63 downto 0)
);

AND2_1:AND2 port map
(
      in0    =>MEM_MEM_CBranch,
      in1    =>MEM_zero,
      output =>AND2_out
);
OR2_1:OR2 port map
(
      in0    =>AND2_out,
      in1    =>MEM_MEM_UBranch,
      output =>OR2_out
);

MUX64_WB:MUX64 port map
(
    in0=>WB_ALUResult(63 downto 0),
    in1=>WB_RD(63 downto 0),
    sel=>WB_WB_MemtoReg,
    output =>MUX64_WB_out(63 downto 0)
);
MUX64_IF:MUX64 port map
(
    in0=>ADD_IF_out(63 downto 0),
    in1=>MEM_AdderResult(63 downto 0),
    sel=>OR2_out,
    output =>MUX64_IF_out(63 downto 0)
);



DEBUG_MEM_CONTENTS <= DEBUG_MEM_CONTENTS_out(64*4 - 1 downto 0);      
DEBUG_SAVED_REGS <= DEBUG_SAVED_REGS_out(64*4 - 1 downto 0);       
DEBUG_TMP_REGS  <= DEBUG_TMP_REGS_out(64*4 - 1 downto 0);
DEBUG_PC   <= PC_out(63 downto 0); 
DEBUG_INSTRUCTION <= IF_IMEM(31 downto 0);
end behav1;