library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity HazardDetection is
port(
      ID_EX_MemRead: in STD_LOGIC;
      ID_EX_Rd:in  STD_LOGIC_VECTOR(4 downto 0);
      IF_ID_Rn:in  STD_LOGIC_VECTOR(4 downto 0); 
      IF_ID_Rm:in  STD_LOGIC_VECTOR(4 downto 0); 

      ID_MUX:out STD_LOGIC;
      PC_Write:out STD_LOGIC;
      IF_ID_Write:out STD_LOGIC
);
end HazardDetection;

architecture behav1 of HazardDetection is
begin
    process(ID_EX_MemRead,ID_EX_Rd,IF_ID_Rn,IF_ID_Rm)
       begin
            if(ID_EX_MemRead='1' and ((ID_EX_Rd=IF_ID_Rn) or (ID_EX_Rd=IF_ID_Rm))) then
               ID_MUX <= '1';       
               PC_Write<= '0';
               IF_ID_Write<= '0';
             else
               ID_MUX <= '0';       
               PC_Write<= '1';
               IF_ID_Write<= '1';
             end if;
   end process;
end behav1;