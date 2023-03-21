LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
entity ALUControl is
-- Functionality should match truth table shown in Figure 4.13 in the textbook.
-- Check table on page2 of Green Card.pdf on canvas. Pay attention to opcode of operations and type of operations. 
-- If an operation doesn't use ALU, you don't need to check for its case in the ALU control implemenetation.	
--  To ensure proper functionality, you must implement the "don't-care" values in the funct field,
-- for example when ALUOp = '00", Operation must be "0010" regardless of what Funct is.
port(
     ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
     Opcode    : in  STD_LOGIC_VECTOR(10 downto 0);
     Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALUControl;

architecture behav1 of ALUControl is
begin
col : process(ALUOp,Opcode)
begin
if ALUOp="00" then 
 Operation <= "0010";
elsif ALUOp(0)='1'then 
Operation <= "0111";
elsif Opcode = "10001011000"then 
Operation <= "0010";
elsif Opcode = "11001011000"then 
Operation <= "0110";
elsif Opcode = "10001010000"then 
Operation <= "0000"; 
elsif Opcode = "10101010000"then 
Operation <= "0001";
else 
Operation <="XXXX";
end if;
end process;
end behav1;