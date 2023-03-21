LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
entity ALUControl_TB is
end ALUControl_TB;

architecture ALUControl_TB of ALUControl_TB is
component ALUControl
port(
     ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
     Opcode    : in  STD_LOGIC_VECTOR(10 downto 0);
     Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

 signal     ALUOp     :   STD_LOGIC_VECTOR(1 downto 0) := "00";
 signal     Opcode    :   STD_LOGIC_VECTOR(10 downto 0) :="00000000000";
 signal    Operation :   STD_LOGIC_VECTOR(3 downto 0);


begin
uut: ALUControl port map(

               ALUOp => ALUOp,
              Opcode => Opcode,
             Operation =>Operation
                 );

stim_proc: process
begin
         ALUOp <="00";
         Opcode <= "11000000110";
        wait for 50 ns;

          ALUOp <="00";
         Opcode <= "10000110110";
        wait for 50 ns;

         ALUOp <="01";
         Opcode <= "11000000110";
        wait for 50 ns;

          ALUOp <="11";
         Opcode <= "10000110110";
        wait for 50 ns;

         ALUOp <="10";
         Opcode <= "10001011000";
        wait for 50 ns;


         ALUOp <="10";
         Opcode <= "11001011000";
        wait for 50 ns;


         ALUOp <="10";
         Opcode <= "10001010000";
        wait for 50 ns;

         ALUOp <="10";
         Opcode <= "10101010000";
        wait for 50 ns;

          ALUOp <="00";
         Opcode <= "10001010000";
        wait for 50 ns;

         ALUOp <="01";
         Opcode <= "10001010000";
        wait;

end process;
end;

