library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Forwarding is port
(
     EX_MEM_Rd:in std_logic_vector(4 downto 0);
     ID_EX_Rn:in std_logic_vector(4 downto 0);
     ID_EX_Rm:in std_logic_vector(4 downto 0);
     EX_MEM_WB_RegWrite: in STD_LOGIC;
     MEM_WB_WB_RegWrite: in STD_LOGIC;
     MEM_WB_Rd: in std_logic_vector(4 downto 0);

     ForwardA:out std_logic_vector(1 downto 0);
     ForwardB:out std_logic_vector(1 downto 0)
);
end Forwarding;

architecture behav1 of Forwarding is
begin
     process(EX_MEM_Rd,ID_EX_Rn,ID_EX_Rm,MEM_WB_WB_RegWrite,EX_MEM_WB_RegWrite,MEM_WB_Rd)
begin
     if(((MEM_WB_WB_RegWrite='1') and (MEM_WB_Rd /= "11111") and (MEM_WB_Rd=ID_EX_Rn))
            and not ((EX_MEM_WB_RegWrite='1')and (EX_MEM_Rd/="11111") and (EX_MEM_Rd = ID_EX_Rn))) then
   
                    ForwardA<="01";
        elsif((EX_MEM_WB_RegWrite='1') and (EX_MEM_Rd/="11111") and (EX_MEM_Rd = ID_EX_Rn)
             and not(((MEM_WB_WB_RegWrite='1') and (MEM_WB_Rd /= "11111") and(MEM_WB_Rd=ID_EX_Rn)))) 
             then
                  ForwardA<="10";
        else
                  ForwardA<="00";
        end if;

    if(((MEM_WB_WB_RegWrite='1') and (MEM_WB_Rd /= "11111") and (MEM_WB_Rd=ID_EX_Rm))
            and not ((EX_MEM_WB_RegWrite='1')and (EX_MEM_Rd/="11111") and (EX_MEM_Rd = ID_EX_Rm))) then
   
                    ForwardB<="01";
        elsif((EX_MEM_WB_RegWrite='1') and (EX_MEM_Rd/="11111") and (EX_MEM_Rd = ID_EX_Rm)
             and not(((MEM_WB_WB_RegWrite='1') and (MEM_WB_Rd /= "11111") and(MEM_WB_Rd=ID_EX_Rm)))) 
             then
                  ForwardB<="10";
        else
                  ForwardB<="00";
        end if;
 
 end process;
end behav1;    