LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; 
entity IMEM is
-- The instruction memory is a byte addressable, little-endian, read-only memory
-- Reads occur continuously
-- HINT: Use the provided dmem.vhd as a starting point
generic(NUM_BYTES : integer := 128);
-- NUM_BYTES is the number of bytes in the memory (small to save computation resources)
port(
     Address  : in  STD_LOGIC_VECTOR(63 downto 0); -- Address to read from
     ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end IMEM;

architecture behav1 of IMEM is
type ByteArray is array (0 to NUM_BYTES) of STD_LOGIC_VECTOR(7 downto 0); 
signal ImemBytes:ByteArray;
begin
   process(Address)
   variable addr:integer;
   variable first:boolean := true;
begin
      if(first) then
         
         ImemBytes(7)  <= "00000000";
         ImemBytes(6)  <= "00000000";  
         ImemBytes(5)  <= "00000000";  
         ImemBytes(4)  <= "11111111";  
         ImemBytes(3)  <= "00000000";
         ImemBytes(2)  <= "00000000";  
         ImemBytes(1)  <= "00000000";  
         ImemBytes(0)  <= "00000001";  --least significant has the lowest address

         ImemBytes(15) <= "00000000";
         ImemBytes(14) <= "00000000";  
         ImemBytes(13) <= "00000000";  
         ImemBytes(12) <= "00000000";  
         ImemBytes(11) <= "00000000";
         ImemBytes(10) <= "00100000";  
         ImemBytes(9)  <= "00001000";  
         ImemBytes(8)  <= "00001000";  

         ImemBytes(23)  <= "00000000";
         ImemBytes(22)  <= "00000000";  
         ImemBytes(21)  <= "00000000";  
         ImemBytes(20)  <= "00000000";  
         ImemBytes(19)  <= "00000000";
         ImemBytes(18)  <= "00000000";  
         ImemBytes(17)  <= "00000000";  
         ImemBytes(16)  <= "00000000";  

         ImemBytes(31)  <= "00000000";
         ImemBytes(30)  <= "00000000";  
         ImemBytes(29)  <= "00000000";  
         ImemBytes(28)  <= "00000000";  
         ImemBytes(27)  <= "00000000";
         ImemBytes(26)  <= "00000000";  
         ImemBytes(25)  <= "00000000";  
         ImemBytes(24)  <= "00000000";  
         
         ImemBytes(39)  <= "00000000";
         ImemBytes(38)  <= "00000000";  
         ImemBytes(37)  <= "00000000";  
         ImemBytes(36)  <= "00000000";
         ImemBytes(35)  <= "00000000";
         ImemBytes(34)  <= "00100000";  
         ImemBytes(33)  <= "00001000";  
         ImemBytes(32)  <= "00001000"; 

         ImemBytes(47)  <= "00000000";
         ImemBytes(46)  <= "00000000";  
         ImemBytes(45)  <= "00000000";  
         ImemBytes(44)  <= "00000000";         
         ImemBytes(43)  <= "00000000";
         ImemBytes(42)  <= "00000000";  
         ImemBytes(41)  <= "00000001";  
         ImemBytes(40)  <= "00000000";  

         ImemBytes(55)  <= "00000000";
         ImemBytes(54)  <= "00000000";  
         ImemBytes(53)  <= "00000000";  
         ImemBytes(52)  <= "00000000";           
         ImemBytes(51)  <= "00000000";
         ImemBytes(50)  <= "00000000";  
         ImemBytes(49)  <= "00000000";  
         ImemBytes(48)  <= "00000000";

         ImemBytes(63)  <= "00000000";
         ImemBytes(62)  <= "00000000";  
         ImemBytes(61)  <= "00000000";  
         ImemBytes(60)  <= "00000000";           
         ImemBytes(59)  <= "00000000";
         ImemBytes(58)  <= "00000000";  
         ImemBytes(57)  <= "00000000";  
         ImemBytes(56)  <= "00000000";

         ImemBytes(64)  <= "00000000";
         ImemBytes(127)  <= "00000000";  
         ImemBytes(126)  <= "00000000";  
         ImemBytes(125)  <= "00000000";  
         ImemBytes(124)  <= "00000000";
         ImemBytes(123)  <= "00000000";  
         ImemBytes(122)  <= "00000000";  
         ImemBytes(121)  <= "00000001";  --least significant has the lowest address

         ImemBytes(72) <= "00000000";
         ImemBytes(71) <= "00000000";  
         ImemBytes(70) <= "00000000";  
         ImemBytes(69) <= "00000000";  
         ImemBytes(68) <= "00000000";
         ImemBytes(67) <= "00000000";  
         ImemBytes(66)  <= "00000000";  
         ImemBytes(65)  <= "00000000";  

         ImemBytes(80)  <= "00000000";
         ImemBytes(79)  <= "00000000";  
         ImemBytes(78)  <= "00000000";  
         ImemBytes(77)  <= "00000000";  
         ImemBytes(76)  <= "00000000";
         ImemBytes(75)  <= "00000000";  
         ImemBytes(74)  <= "00000000";  
         ImemBytes(73)  <= "00000000";  

         ImemBytes(88)  <= "00000000";
         ImemBytes(87)  <= "00000000";  
         ImemBytes(86)  <= "00000000";  
         ImemBytes(85)  <= "00000000";  
         ImemBytes(84)  <= "00000000";
         ImemBytes(83)  <= "00000000";  
         ImemBytes(82)  <= "00000000";  
         ImemBytes(81)  <= "00000000";  
         
         ImemBytes(96)  <= "00000000";
         ImemBytes(95)  <= "00000000";  
         ImemBytes(94)  <= "00000000";  
         ImemBytes(93)  <= "00000000";
         ImemBytes(92)  <= "00000000";
         ImemBytes(91)  <= "00000000";  
         ImemBytes(90)  <= "00000000";  
         ImemBytes(89)  <= "00000000"; 

         ImemBytes(104)  <= "00000000";
         ImemBytes(103)  <= "00000000";  
         ImemBytes(102)  <= "00000000";  
         ImemBytes(101)  <= "00000000";         
         ImemBytes(100)  <= "00000000";
         ImemBytes(99)  <= "00000000";  
         ImemBytes(98)  <= "00000001";  
         ImemBytes(97)  <= "00000000";  

         ImemBytes(112)  <= "00000000";
         ImemBytes(111)  <= "00000000";  
         ImemBytes(110)  <= "00000000";  
         ImemBytes(109)  <= "00000000";           
         ImemBytes(108)  <= "00000000";
         ImemBytes(107)  <= "00000000";  
         ImemBytes(106)  <= "00000000";  
         ImemBytes(105)  <= "00000000";

         ImemBytes(120)  <= "00000000";
         ImemBytes(119)  <= "00000000";  
         ImemBytes(118)  <= "00000000";  
         ImemBytes(117)  <= "00000000";           
         ImemBytes(116)  <= "00000000";
         ImemBytes(115)  <= "00000000";  
         ImemBytes(114)  <= "00000000";  
         ImemBytes(113)  <= "00000000";
       first := false; 
      end if;

    addr:=to_integer(unsigned(Address)); 
   if (addr+7 < NUM_BYTES) then 
   ReadData <= ImemBytes(addr+3) & ImemBytes(addr+2)&
               ImemBytes(addr+1) & ImemBytes(addr+0);
    else report "Invalid DMEM addr. Attempted to read 4-bytes starting at address " &
            integer'image(addr) & " but only " & integer'image(NUM_BYTES) & " bytes are available"
            severity error;
   end if;

end process;


end behav1;


