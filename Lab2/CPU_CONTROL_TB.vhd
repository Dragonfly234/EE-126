LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY tb_controller IS
END tb_controller;
ARCHITECTURE behavior OF tb_controller IS
component CPUControl 
port(Opcode   : in  STD_LOGIC_VECTOR(10 downto 0);
     Reg2Loc  : out STD_LOGIC;
     CBranch  : out STD_LOGIC;  
     MemRead  : out STD_LOGIC;
     MemtoReg : out STD_LOGIC;
     MemWrite : out STD_LOGIC;
     ALUSrc   : out STD_LOGIC;
     RegWrite : out STD_LOGIC;
     UBranch  : out STD_LOGIC; 
     ALUOp    : out STD_LOGIC_VECTOR(1 downto 0)
);
end component;

SIGNAL Opcode : std_logic_vector(10 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Reg2Loc       : std_logic;
	SIGNAL CBranch          : std_logic;
	SIGNAL UBranch        : std_logic;
	SIGNAL MemRead       : std_logic;
	SIGNAL MemtoReg : std_logic;
	SIGNAL ALUop         : std_logic_vector(1 DOWNTO 0);
	SIGNAL MemWrite      : std_logic;
	SIGNAL ALUsrc        : std_logic;
	SIGNAL RegWrite      : std_logic;
BEGIN
	
	U1_Test : CPUControl
		PORT MAP(
			Opcode       => Opcode,
			Reg2Loc        => Reg2Loc,
			CBranch          => CBranch,
			UBranch        => UBranch,
			MemRead       => MemRead,
			MemtoReg => MemtoReg,
			ALUop         => ALUop,
			MemWrite      => MemWrite,
			ALUsrc        => ALUsrc,
			RegWrite      => RegWrite
		);
		
stim_proc : PROCESS
BEGIN
	Opcode <= "00000000000"; 
	WAIT FOR 100 ns;
	
	Opcode <= "11111000010"; 
	WAIT FOR 100 ns;
	Opcode <= "11111000000"; 
	WAIT FOR 100 ns;
	
        Opcode <= "10110100111"; 
	WAIT FOR 100 ns;
        Opcode <= "10110100000"; 
	
  
         WAIT FOR 100 ns;
	Opcode <= "11000101000"; 
        WAIT FOR 100 ns;
	Opcode <= "11111111111"; 
        WAIT FOR 100 ns;
	Opcode <= "10000100000"; 
wait;
END PROCESS;
END;

