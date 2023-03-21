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
if ALUOp="00"then
operation <= "0010";
elsif Opcode="10010001000" then
   operation <= "0010";
elsif Opcode="10001011000" then
    operation <= "0010";
elsif Opcode = "11010001000" then
   operation <= "0110";
elsif Opcode = "10001010000" then
   operation <= "0000";
elsif Opcode = "10101010000" then
   operation <= "0001";
elsif Opcode = "11111000000" then
   operation <= "0010";
elsif Opcode = "11111000010" then
   operation <= "0010";
elsif Opcode = "11001011000" then
   operation <= "0110";
else
    operation <= "1111";
end if;
end process;
end behav1;