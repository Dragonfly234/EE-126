LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity CPUControl is
-- Functionality should match the truth table shown in Figure 4.22 of the textbook, inlcuding the
--    output 'X' values.
-- The truth table in Figure 4.22 omits the unconditional branch instruction:
--    UBranch = '1'
--    MemWrite = RegWrite = '0'
--    all other outputs = 'X'	
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
end CPUControl;

ARCHITECTURE Behav1 OF CPUControl IS
BEGIN
	PROCESS (opcode)
	BEGIN
		regWrite <= '0'; 
		CASE opcode IS
			WHEN "11111000010" => --LDUR
				Reg2Loc       <= 'X';
                                ALUsrc        <= '1';
                                MemtoReg      <= '1';
                                RegWrite      <= '1';
                                MemRead       <= '1';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "00";
			WHEN "11111000000" => -- STUR
				Reg2Loc       <= '1';
                                ALUsrc        <= '1';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '1';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "00"  ;
			
			WHEN "10110100000" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ;
  
			WHEN "10110100001" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ;

			WHEN "10110100010" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ;
                       
			WHEN "10110100011" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01" ;
                              
                               WHEN "10110100100" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ;
                               WHEN "10110100101" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ; 
                               WHEN "10110100110" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ; 
                               WHEN "10110100111" => --CBZ
				Reg2Loc       <= '1';
                                ALUsrc        <= '0';
                                MemtoReg      <= 'X';
                                RegWrite      <= '0';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '1';
				UBranch       <= '0';
                                ALUop         <= "01"  ; 
                              
                               WHEN "10001010000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                regWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
                                WHEN "10001011000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
                                WHEN "10101010000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
                                WHEN "10101011000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ;
                                WHEN "11001010000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ;
                                WHEN "11001011000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                regWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ;
                                WHEN "11101010000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
                                WHEN "11101011000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
                                WHEN "00000000000" => --R-format
				Reg2Loc       <= '0';
                                ALUsrc        <= '0';
                                MemtoReg      <= '0';
                                RegWrite      <= '1';
                                MemRead       <= '0';
                                MemWrite      <= '0';
				CBranch       <= '0';
				UBranch       <= '0';
                                ALUop         <= "10"  ; 
               WHEN "11010001000" => 
				Reg2Loc        <= '0';
				CBranch       <= '1';
				UBranch        <= '0';
				MemRead       <= '0';
				MemtoReg      <= '0';
				ALUop         <= "10";
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '0' ;  
                             WHEN "00010100000" => 
				Reg2Loc         <= '0';
				CBranch       <= '1';
				UBranch        <= '0';
				MemRead       <= '0';
				MemtoReg      <= '0';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '0' ;
			      WHEN OTHERS => NULL; 
				Reg2Loc  <= '0';
				CBranch        <= '0';
				UBranch        <= '0';
				MemRead       <= '0';
				MemtoReg      <= '0';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '0';
				RegWrite      <= '0' ;			
			
		END CASE;
	END PROCESS;
END Behav1;
                   

 