library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ALU is
-- Implement: AND, OR, ADD (signed), SUBTRACT (signed)
--    as described in Section 4.4 in the textbook.
-- The functionality of each instruction can be found on the 'ARM Reference Data' sheet at the
--    front of the textbook (or the Green Card pdf on Canvas).
port(
     in0       : in     STD_LOGIC_VECTOR(63 downto 0);
     in1       : in     STD_LOGIC_VECTOR(63 downto 0);
     operation : in     STD_LOGIC_VECTOR(3 downto 0);
     result    : buffer STD_LOGIC_VECTOR(63 downto 0);
     zero      : buffer STD_LOGIC;
     overflow  : buffer STD_LOGIC
    );
end ALU;

architecture behav1 of ALU is 


signal  ADDresult :  STD_LOGIC_VECTOR(63 downto 0);
component ADD is
port(
     in0    : in  STD_LOGIC_VECTOR(63 downto 0);
     in1    : in  STD_LOGIC_VECTOR(63 downto 0);
     output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;

begin 
     
      
      ADDER:ADD port map(in0=>in0,in1=>in1,output=>ADDresult); 
     process(operation,in0,in1,result,ADDresult)
begin
   case operation is
        when "0000" =>
                      result <= in0 and in1;
                      overflow <='0';             
        when "0001" =>
                      result <= in0 or in1;
                      overflow <='0'; 
        when "0010" =>
                   
                     result <= ADDresult;      
                     if in0(63) = '0' and in1(63) = '0' then
                               if result(63) = '1' then
                                    overflow<='1';
                               else overflow<= '0';
                                   end if;

                      elsif  in0(63) = '1' and in1(63) = '1' then
                               if result(63) = '0' then
                                    overflow<='1';
                               else  overflow<='0';
                                   end if;
                      end if;
 
         when "0110" => 
                         result <= in0-in1;
                      
                       if in0(63) = '0' and in1(63) = '1' then
                               if result(63) = '1' then
                                    overflow<='1';
                               else overflow<='0';
                                   end if;

                      elsif  in0(63) = '1' and in1(63) = '0' then
                               if result(63) = '0' then
                                    overflow<='1';
                               else overflow<='0';
                                   end if;
                              end if;
         when others =>
			null;
	    end case;
       if result = "0000000000000000" then
		zero <= '1';
	else
		zero <= '0';
	end if;
end process;
end behav1;