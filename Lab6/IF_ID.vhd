library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IF_ID is

port(     clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          IF_PC_in:in STD_LOGIC_VECTOR(63 downto 0);
          IF_Instruction_in:in STD_LOGIC_VECTOR(31 downto 0);
          Write_enable : in STD_LOGIC;
          IF_Flush: in STD_LOGIC;
          ID_PC_out:out STD_LOGIC_VECTOR(63 downto 0);
          ID_Instruction_out:out STD_LOGIC_VECTOR(31 downto 0)
    );
end IF_ID;

architecture behav1 of IF_ID is
begin 
     process(clk,rst)
     begin
               if rst='1' then
              ID_PC_out<=x"0000_0000_0000_0000";
              ID_Instruction_out <=x"0000_0000";
           elsif clk = '1' and clk'event then
                if ((Write_enable ='1')and(IF_Flush ='0'))  then
              ID_PC_out<=IF_PC_in;
              ID_Instruction_out <=IF_Instruction_in;
                elsif IF_Flush ='1' then
              ID_Instruction_out <=x"0000_0000";
                 end if;
            end if;
     end process;
end behav1;
    