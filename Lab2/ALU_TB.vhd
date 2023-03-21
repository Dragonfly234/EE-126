library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity tb_alu is 
end tb_alu;

architecture behavior of tb_alu is
component ALU
     PORT(
          in0 : in STD_LOGIC_VECTOR(63 downto 0);
           in1 : in STD_LOGIC_VECTOR(63 downto 0);
           operation : in STD_LOGIC_VECTOR(3 downto 0);
           result : buffer STD_LOGIC_VECTOR(63 downto 0);
           zero : buffer STD_LOGIC;
           overflow : buffer STD_LOGIC

         );
end component;    

      signal   in0 : STD_LOGIC_VECTOR(63 downto 0);
      signal   in1 : STD_LOGIC_VECTOR(63 downto 0);
      signal   operation :  STD_LOGIC_VECTOR(3 downto 0);
      signal   result :  STD_LOGIC_VECTOR(63 downto 0);
      signal   zero :  STD_LOGIC;
      signal   overflow : STD_LOGIC;

      
begin
      uut:  ALU 
      port map (
                 in0 => in0,
                 in1 => in1,
                 operation => operation,
                 result => result,
                 zero => zero,
                 overflow => overflow
               );


      stim_proc: process
      begin
         
         operation <= "0000"; 
         in0 <= x"1111_1111_1111_1111";
         in1 <= x"0000_0000_0000_0001"; 
         wait for 50 ns;  
         
         operation <= "0001"; 
         in0 <= x"1111_1011_1111_1111";
         in1 <= x"0000_0000_0000_0001"; 
         wait for 50 ns; 

         operation <= "0010"; 
         in0 <= x"1111_1111_0000_0000";
         in1 <= x"0000_0000_0000_0001"; 
         wait for 50 ns; 
         
         operation <= "0010"; 
         in0 <= x"7FFF_FFFF_FFFF_FFFF";
         in1 <= x"0000_0000_0000_0001"; 
         wait for 50 ns; 

          operation <= "0110"; 
         in0 <= x"F111_1011_1111_1111";
         in1 <= x"0010_0000_0000_CCC1"; 
         wait for 50 ns; 
         
         operation <= "0110"; 
         in0 <= x"FFFF_FFFF_FFFF_FFFF";
         in1 <= x"0000_0000_0000_0001"; 
         wait for 50 ns; 
         
         operation <= "0110"; 
         in0 <= x"1000000000000000";
         in1 <= x"1000000000000000"; 
         wait for 50 ns; 

         operation <= "0110"; 
         in0 <= x"8000000000000000";
         in1 <= x"0000000000000001"; 
         wait for 50 ns; 

         operation <= "0110"; 
         in0 <= x"0000000000000001";
         in1 <= x"0000000000000001"; 
         wait for 50 ns; 
       end process;   
 end; 