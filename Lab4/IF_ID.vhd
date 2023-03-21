library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IF_ID is

port(     clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          IF_PC_in:in STD_LOGIC_VECTOR(63 downto 0);
          IF_Instruction_in:in STD_LOGIC_VECTOR(31 downto 0);
          ID_PC_out:out STD_LOGIC_VECTOR(63 downto 0);
          ID_Instruction_out:out STD_LOGIC_VECTOR(31 downto 0)
    );
end IF_ID;

architecture behav1 of IF_ID is
begin 
     process(clk,rst)
     begin
           if clk = '1' and clk'event then
              ID_PC_out<=IF_PC_in;
              ID_Instruction_out <=IF_Instruction_in;
            end if;
     end process;
end behav1;
    