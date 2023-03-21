library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
entity registers is
-- This component is described in the textbook, starting on section 4.3 
-- The indices of each of the registers can be found on the LEGv8 Green Card
-- Keep in mind that register 31 (XZR) has a constant value of 0 and cannot be overwritten
-- This should only write on the negative edge of Clock when RegWrite is asserted.
-- Reads should be purely combinatorial, i.e. they don't depend on Clock
-- HINT: Use the provided dmem.vhd as a starting point
generic(TotalNumber : integer := 32);

port(RR1      : in  STD_LOGIC_VECTOR (4 downto 0); 
     RR2      : in  STD_LOGIC_VECTOR (4 downto 0); 
     WR       : in  STD_LOGIC_VECTOR (4 downto 0); 
     WD       : in  STD_LOGIC_VECTOR (63 downto 0);
     RegWrite : in  STD_LOGIC;
     Clock    : in  STD_LOGIC;
     RD1      : out STD_LOGIC_VECTOR (63 downto 0);
     RD2      : out STD_LOGIC_VECTOR (63 downto 0);
     --Probe ports used for testing.
     -- Notice the width of the port means that you are 
     --      reading only part of the register file. 
     -- This is only for debugging
     -- You are debugging a sebset of registers here
     -- Temp registers: $X9 & $X10 & X11 & X12 
     -- 4 refers to number of registers you are debugging
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     -- Saved Registers X19 & $X20 & X21 & X22 
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end registers;

architecture behav1 of registers is
      type ByteArray is array (0 to TotalNumber) of STD_LOGIC_VECTOR(63 downto 0); 
      signal Registers : ByteArray;
begin
   process(Clock,RegWrite,WD,WR,RR2,RR1)
   variable addr:integer;
    variable addr1 : integer;
variable addr2 : integer;
   variable first:boolean := true;
begin
      if(first) then
         

         Registers(0) <= x"0000_0000_0000_0000"; --X0
         Registers(1) <= x"0000_0000_0000_0000"; --X1
         Registers(2) <= x"0000_0000_0000_0000"; --X2
         Registers(3) <= x"0000_0000_0000_0000"; --X3
         Registers(4) <= x"0000_0000_0000_0000"; --X4
         Registers(5) <= x"0000_0000_0000_0000"; --X5
         Registers(6) <= x"0000_0000_0000_0000"; --X6
         Registers(7) <= x"0000_0000_0000_0000"; --X7
         Registers(8) <= x"0000_0000_0000_0000"; --X8
         Registers(9) <= x"0000_0000_0000_0000"; --X9
         Registers(10) <= x"0000_0000_0000_0001"; --X10
         Registers(11) <= x"0000_0000_0000_0002"; --X11
         Registers(12) <= x"0000_0000_0000_0004"; --X12
         Registers(13) <= x"0000_0000_0000_0008"; --X13
         Registers(14) <= x"0000_0000_0000_0010"; --X14
         Registers(15) <= x"0000_0000_0000_0020"; --X15
         Registers(16) <= x"0000_0000_0000_0000"; --X16
         Registers(17) <= x"0000_0000_0000_0000"; --X17
         Registers(18) <= x"0000_0000_0000_0000"; --X18
         Registers(19) <= x"0000_0000_0000_0000"; --X19
         Registers(20) <= x"0000_0000_0000_0000"; --X20
         Registers(21) <= x"0000_0000_0000_0000"; --X21
         Registers(22) <= x"0000_0000_0000_0000"; --X22
         Registers(23) <= x"0000_0000_0000_0000"; --X23
         Registers(24) <= x"0000_0000_0000_0000"; --X24
         Registers(25) <= x"0000_0000_0000_0000"; --X25
         Registers(26) <= x"0000_0000_0000_0000"; --X26
         Registers(27) <= x"0000_0000_0000_0000"; --X27
         Registers(28) <= x"0000_0000_0000_0000"; --X28
         Registers(29) <= x"0000_0000_0000_0000"; --X29
         Registers(30) <= x"0000_0000_0000_0000"; --X30
         Registers(31) <= x"0000_0000_0000_0000"; --X31
first := false;
		end if;




 if Clock = '0' and Clock'event and RegWrite='1' then
     addr:=to_integer(unsigned(WR)); 
            if(addr<31) then
         Registers(addr)<=WD;
                    elsif (addr=31) 
                   then report "X31 cannot be writen"severity error;
                     else report "Invalid Register address" severity error;
			end if;  
          end if; 	                         
end process;
			RD1 <= Registers(to_integer(unsigned(RR1)));                   
			RD2 <= Registers(to_integer(unsigned(RR2)));
        DEBUG_SAVED_REGS <= Registers(19)&Registers(20)&Registers(21)&Registers(22);
        DEBUG_TMP_REGS   <= Registers(9)&Registers(10)&Registers(11)&Registers(12);
end behav1;


