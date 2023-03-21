library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
entity SingleCycleCPU is
port(clk :in STD_LOGIC;
     rst :in STD_LOGIC;
     --Probe ports used for testing
     --The current address (AddressOut from the PC)
     DEBUG_PC : out STD_LOGIC_VECTOR(63 downto 0);
     --The current instruction (Instruction output of IMEM)
     DEBUG_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0);
     --DEBUG ports from other components
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end SingleCycleCPU;

architecture behvl of SingleCycleCPU is
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
     --Probe ports used for testing.
     -- Notice the width of the port means that you are 
     --      reading only part of the register file. 
     -- This is only for debugging
     -- You are debugging a sebset of registers here
     -- Temp registers: $X9 & $X10 & X11 & X12 
     -- 4 refers to number of registers you are debugging
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     -- Saved Registers X19 & $X20 & X21 & X22 
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

signal MUX64_out_PC : std_logic_vector(63 downto 0);
signal MUX64_out_ALU : std_logic_vector(63 downto 0);
signal MUX64_out_WD : std_logic_vector(63 downto 0);
signal MUX5_out: std_logic_vector(4 downto 0);
signal PC_out : std_logic_vector(63 downto 0);
signal add_out_PC : std_logic_vector(63 downto 0);
signal IMEM_out : std_logic_vector(31 downto 0);
signal ReadData01_out : std_logic_vector(63 downto 0);
signal ReadData02_out : std_logic_vector(63 downto 0);
signal SignExtend_out : std_logic_vector(63 downto 0);
signal Shiftleft2_out : std_logic_vector(63 downto 0);
signal add_out_shiftleft2 : std_logic_vector(63 downto 0);
signal ALU_result : std_logic_vector(63 downto 0);
signal ALU_zero : STD_LOGIC;
signal ALUControl_out : std_logic_vector(3 downto 0);
signal DMEM_out : std_logic_vector(63 downto 0);
signal Reg2Loc : STD_LOGIC;
signal Regwrite : STD_LOGIC;
signal ALUSrc : STD_LOGIC;
signal CBranch : STD_LOGIC;
signal UBranch : STD_LOGIC;
signal ALUOp: std_logic_vector(1 downto 0);
signal MemWrite : STD_LOGIC;
signal MemRead : STD_LOGIC;
signal MemtoReg : STD_LOGIC;
signal OR2_out : STD_LOGIC;
signal AND2_out : STD_LOGIC;
signal DEBUG_TMP_REGS_out :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_SAVED_REGS_out:  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_MEM_CONTENTS_out :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);


begin 
PC_1:PC port map(
                 write_enable => '1',
	         clk => clk,
                 rst => rst,      
                 addressIn => MUX64_out_PC (63 downto 0),
		 addressOut => PC_out(63 downto 0)
		 );


IMEM_1:IMEM port map(
                     Address => PC_out(63 downto 0),
                     ReadData => IMEM_OUT(31 downto 0)
		   );


MUX5_1:MUX5 port map(
                     sel => Reg2Loc,
		     in0 => IMEM_OUT(20 downto 16),
                     in1 => IMEM_OUT(4 downto 0),
		     output => MUX5_out(4 downto 0)
                    );

registers_1:registers  port map(
     RR1      =>IMEM_OUT(9 downto 5),
     RR2      =>MUX5_out(4 downto 0),
     WR       =>IMEM_OUT(4 downto 0),
     WD        => MUX64_out_WD(63 downto 0),
     RegWrite  => RegWrite,
     Clock    =>clk,
     RD1      =>ReadData01_out(63 downto 0),
     RD2      =>ReadData02_out(63 downto 0),
     DEBUG_TMP_REGS => DEBUG_TMP_REGS_out(64*4 - 1 downto 0),
     DEBUG_SAVED_REGS => DEBUG_SAVED_REGS_out(64*4 - 1 downto 0)
                              );

SignExtend_1:SignExtend port map
(
     x =>IMEM_OUT(31 downto 0),
     y =>SignExtend_out(63 downto 0)
    );

MUX64_ALU_1:MUX64 port map
(
    in0=>ReadData02_out(63 downto 0),
    in1=>SignExtend_out(63 downto 0),
    sel=>ALUSrc,
    output =>MUX64_out_ALU(63 downto 0)
);


MUX64_WD_2:MUX64 port map
(
    in0=>ALU_result(63 downto 0),
    in1=>DMEM_out(63 downto 0),
    sel=>MemtoReg,
    output =>MUX64_out_WD(63 downto 0)
);

MUX64_PC_3:MUX64 port map
(
    in0=>add_out_PC(63 downto 0),
    in1=>add_out_shiftleft2(63 downto 0),
    sel=>OR2_out,
    output =>MUX64_out_PC(63 downto 0)
);

ALU_1:ALU port map
(
     in0       =>ReadData01_out(63 downto 0),
     in1       =>MUX64_out_ALU(63 downto 0),
     operation =>ALUControl_out(3 downto 0),
     result    =>ALU_result(63 downto 0),
     zero      =>ALU_zero
    );
ALUControl_1:ALUControl port map
(
     ALUOp     =>ALUOp(1 downto 0),
     Opcode    =>IMEM_OUT(31 downto 21),
     Operation =>ALUControl_out(3 downto 0)
    );


DEME_1:DMEM port map
(
     WriteData          => ReadData02_out(63 downto 0),
     Address            =>ALU_result(63 downto 0), 
     MemRead            => MemRead, 
     MemWrite           => MemWrite, 
     Clock              =>clk,
     ReadData           =>DMEM_out(63 downto 0), 
     DEBUG_MEM_CONTENTS =>DEBUG_MEM_CONTENTS_out(64*4 - 1 downto 0)
);

CPUControl_1:CPUControl port map
(Opcode       =>IMEM_OUT(31 downto 21),
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
Shiftleft2_1:Shiftleft2 port map
(  
     x => SignExtend_out(63 downto 0),
     y => Shiftleft2_out(63 downto 0) 
);


ADD_leftShift_1:ADD port map
(
     in0    => PC_out(63 downto 0),
     in1    => Shiftleft2_out,
     output => add_out_shiftleft2(63 downto 0)
);

ADD_PC_1: ADD port map
(
     in1    => PC_out(63 downto 0),
     in0    => x"0000_0000_0000_0004",
     output => add_out_PC(63 downto 0)
);

AND2_1:AND2 port map
(
      in0    =>CBranch,
      in1    =>ALU_zero,
      output =>AND2_out
);
OR2_1:OR2 port map
(
      in0    =>AND2_out,
      in1    =>UBranch,
      output =>OR2_out
);
DEBUG_MEM_CONTENTS <= DEBUG_MEM_CONTENTS_out(64*4 - 1 downto 0);      
DEBUG_SAVED_REGS <= DEBUG_SAVED_REGS_out(64*4 - 1 downto 0);       
DEBUG_TMP_REGS  <= DEBUG_TMP_REGS_out(64*4 - 1 downto 0);
DEBUG_PC   <= PC_out(63 downto 0); 
DEBUG_INSTRUCTION <= IMEM_OUT(31 downto 0);
end behvl;