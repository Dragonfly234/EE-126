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
generic(TotalByte : integer := 256);

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
      type ByteArray is array (0 to TotalByte) of STD_LOGIC_VECTOR(7 downto 0); 
      signal dmemBytes : ByteArray;
begin
   process(Clock,RegWrite,WD,WR,RR2,RR1)
   variable addr:integer;
    variable addr1 : integer;
variable addr2 : integer;
   variable first:boolean := true;
begin
      if(first) then
         

         dmemBytes(7)  <= "00000000";
         dmemBytes(6)  <= "00000000";  
         dmemBytes(5)  <= "00000000";  
         dmemBytes(4)  <= "00000000";  
         dmemBytes(3)  <= "00000000";
         dmemBytes(2)  <= "00000000";  
         dmemBytes(1)  <= "00000000";  
         dmemBytes(0)  <= "00000001"; --X0

         dmemBytes(15) <= "00000000";
         dmemBytes(14) <= "00000000";  
         dmemBytes(13) <= "00000000";  
         dmemBytes(12) <= "00000000";  
         dmemBytes(11) <= "00000000";
         dmemBytes(10) <= "00000000";  
         dmemBytes(9)  <= "00000000";  
         dmemBytes(8)  <= "00000000";  --X1



         dmemBytes(23)  <= "00000000";
         dmemBytes(22)  <= "00000000";  
         dmemBytes(21)  <= "00000000";  
         dmemBytes(20)  <= "00000000";  
         dmemBytes(19)  <= "00000000";
         dmemBytes(18)  <= "00000000";  
         dmemBytes(17)  <= "00000000";  
         dmemBytes(16)  <= "00000000"; --x2


         dmemBytes(31)  <= "00000000";
         dmemBytes(30)  <= "00000000";  
         dmemBytes(29)  <= "00000000";  
         dmemBytes(28)  <= "00000000";  
         dmemBytes(27)  <= "00000000";
         dmemBytes(26)  <= "00000000";  
         dmemBytes(25)  <= "00000000";  
         dmemBytes(24)  <= "00000000"; --X3




         dmemBytes(39)  <= "00000000";
         dmemBytes(38)  <= "00000000";  
         dmemBytes(37)  <= "00000000";  
         dmemBytes(36)  <= "00000000";
         dmemBytes(35)  <= "00000000";
         dmemBytes(34)  <= "00000000";  
         dmemBytes(33)  <= "00000000";  
         dmemBytes(32)  <= "00000000"; --X4

         dmemBytes(47)  <= "00000000";
         dmemBytes(46)  <= "00000000";  
         dmemBytes(45)  <= "00000000";  
         dmemBytes(44)  <= "00000000";         
         dmemBytes(43)  <= "00000000";
         dmemBytes(42)  <= "00000000";  
         dmemBytes(41)  <= "00000001";  
         dmemBytes(40)  <= "00000000"; --X5

         dmemBytes(55)  <= "00000000";
         dmemBytes(54)  <= "00000000";  
         dmemBytes(53)  <= "00000000";  
         dmemBytes(52)  <= "00000000";           
         dmemBytes(51)  <= "00000000";
         dmemBytes(50)  <= "00000000";  
         dmemBytes(49)  <= "00000000";  
         dmemBytes(48)  <= "00000000";--X6


         dmemBytes(63)  <= "00000000";
         dmemBytes(62)  <= "00000000";  
         dmemBytes(61)  <= "00000000";  
         dmemBytes(60)  <= "00000000";           
         dmemBytes(59)  <= "00000000";
         dmemBytes(58)  <= "00000000";  
         dmemBytes(57)  <= "00000000";  
         dmemBytes(56)  <= "00000000";--X7



         dmemBytes(71)  <= "00000000";
         dmemBytes(70)  <= "00000000";  
         dmemBytes(69)  <= "00000000";  
         dmemBytes(68)  <= "00000000";           
         dmemBytes(67)  <= "00000000";
         dmemBytes(66)  <= "00000000";  
         dmemBytes(65)  <= "00000000";  
         dmemBytes(64)  <= "00000000";--X8





         dmemBytes(79)  <= "00000000";
         dmemBytes(78)  <= "00000000";  
         dmemBytes(77)  <= "00000000";  
         dmemBytes(76)  <= "00000000";           
         dmemBytes(75)  <= "00000000";
         dmemBytes(74)  <= "00000000";  
         dmemBytes(73)  <= "00000000";  
         dmemBytes(72)  <= "00000000";--X9

dmemBytes(87)  <= "00000000";
dmemBytes(86)  <= "00000000";
dmemBytes(85)  <= "00000000";
dmemBytes(84)  <= "00000000";
dmemBytes(83)  <= "00000000";
dmemBytes(82)  <= "00000000";
dmemBytes(81)  <= "00000000";
dmemBytes(80)  <= "00000001";--X10


dmemBytes(95)  <= "00000000";
dmemBytes(94)  <= "00000000";
dmemBytes(93)  <= "00000000";
dmemBytes(92)  <= "00000000";
dmemBytes(91)  <= "00000000";
dmemBytes(90)  <= "00000000";
dmemBytes(89)  <= "00000000";
dmemBytes(88)  <= "00000010";--X11


dmemBytes(103)  <= "00000000";
dmemBytes(102)  <= "00000000";
dmemBytes(101)  <= "00000000";
dmemBytes(100)  <= "00000000";
dmemBytes(99)  <= "00000000";
dmemBytes(98)  <= "00000000";
dmemBytes(97)  <= "00000000";
dmemBytes(96)  <= "00000100";--X12


dmemBytes(111)  <= "00000000";
dmemBytes(110)  <= "00000000";
dmemBytes(109)  <= "00000000";
dmemBytes(108)  <= "00000000";
dmemBytes(107)  <= "00000000";
dmemBytes(106)  <= "00000000";
dmemBytes(105)  <= "00000000";
dmemBytes(104)  <= "00001000";--X13


dmemBytes(119)  <= "00000000";
dmemBytes(118)  <= "00000000";
dmemBytes(117)  <= "00000000";
dmemBytes(116)  <= "00000000";
dmemBytes(115)  <= "00000000";
dmemBytes(114)  <= "00000000";
dmemBytes(113)  <= "00000000";
dmemBytes(112)  <= "00010000";--X14


dmemBytes(127)  <= "00000000";
dmemBytes(126)  <= "00000000";
dmemBytes(125)  <= "00000000";
dmemBytes(124)  <= "00000000";
dmemBytes(123)  <= "00000000";
dmemBytes(122)  <= "00000000";
dmemBytes(121)  <= "00000000";
dmemBytes(120)  <= "00100000";--X15


dmemBytes(135)  <= "00000000";
dmemBytes(134)  <= "00000000";
dmemBytes(133)  <= "00000000";
dmemBytes(132)  <= "00000000";
dmemBytes(131)  <= "00000000";
dmemBytes(130)  <= "00000000";
dmemBytes(129)  <= "00000000";
dmemBytes(128)  <= "00000000";--X16


dmemBytes(143)  <= "00000000";
dmemBytes(142)  <= "00000000";
dmemBytes(141)  <= "00000000";
dmemBytes(140)  <= "00000000";
dmemBytes(139)  <= "00000000";
dmemBytes(138)  <= "00000000";
dmemBytes(137)  <= "00000000";
dmemBytes(136)  <= "00000000";--X17


dmemBytes(151)  <= "00000000";
dmemBytes(150)  <= "00000000";
dmemBytes(149)  <= "00000000";
dmemBytes(148)  <= "00000000";
dmemBytes(147)  <= "00000000";
dmemBytes(146)  <= "00000000";
dmemBytes(145)  <= "00000000";
dmemBytes(144)  <= "00000000";--X18


dmemBytes(159)  <= "00000000";
dmemBytes(158)  <= "00000000";
dmemBytes(157)  <= "00000000";
dmemBytes(156)  <= "00000000";
dmemBytes(155)  <= "00000000";
dmemBytes(154)  <= "00000000";
dmemBytes(153)  <= "00000000";
dmemBytes(152)  <= "00000000";--X19


dmemBytes(167)  <= "00000000";
dmemBytes(166)  <= "00000000";
dmemBytes(165)  <= "00000000";
dmemBytes(164)  <= "00000000";
dmemBytes(163)  <= "00000000";
dmemBytes(162)  <= "00000000";
dmemBytes(161)  <= "00000000";
dmemBytes(160)  <= "00000000";--X20


dmemBytes(175)  <= "00000000";
dmemBytes(174)  <= "00000000";
dmemBytes(173)  <= "00000000";
dmemBytes(172)  <= "00000000";
dmemBytes(171)  <= "00000000";
dmemBytes(170)  <= "00000000";
dmemBytes(169)  <= "00000000";
dmemBytes(168)  <= "00000000";--X21


dmemBytes(183)  <= "00000000";
dmemBytes(182)  <= "00000000";
dmemBytes(181)  <= "00000000";
dmemBytes(180)  <= "00000000";
dmemBytes(179)  <= "00000000";
dmemBytes(178)  <= "00000000";
dmemBytes(177)  <= "00000000";
dmemBytes(176)  <= "00000000";--X22


dmemBytes(191)  <= "00000000";
dmemBytes(190)  <= "00000000";
dmemBytes(189)  <= "00000000";
dmemBytes(188)  <= "00000000";
dmemBytes(187)  <= "00000000";
dmemBytes(186)  <= "00000000";
dmemBytes(185)  <= "00000000";
dmemBytes(184)  <= "00000000";--X23


dmemBytes(199)  <= "00000000";
dmemBytes(198)  <= "00000000";
dmemBytes(197)  <= "00000000";
dmemBytes(196)  <= "00000000";
dmemBytes(195)  <= "00000000";
dmemBytes(194)  <= "00000000";
dmemBytes(193)  <= "00000000";
dmemBytes(192)  <= "00000000";--X24


dmemBytes(207)  <= "00000000";
dmemBytes(206)  <= "00000000";
dmemBytes(205)  <= "00000000";
dmemBytes(204)  <= "00000000";
dmemBytes(203)  <= "00000000";
dmemBytes(202)  <= "00000000";
dmemBytes(201)  <= "00000000";
dmemBytes(200)  <= "00000000";--X25


dmemBytes(215)  <= "00000000";
dmemBytes(214)  <= "00000000";
dmemBytes(213)  <= "00000000";
dmemBytes(212)  <= "00000000";
dmemBytes(211)  <= "00000000";
dmemBytes(210)  <= "00000000";
dmemBytes(209)  <= "00000000";
dmemBytes(208)  <= "00000000";--X26


dmemBytes(223)  <= "00000000";
dmemBytes(222)  <= "00000000";
dmemBytes(221)  <= "00000000";
dmemBytes(220)  <= "00000000";
dmemBytes(219)  <= "00000000";
dmemBytes(218)  <= "00000000";
dmemBytes(217)  <= "00000000";
dmemBytes(216)  <= "00000000";--X27


dmemBytes(231)  <= "00000000";
dmemBytes(230)  <= "00000000";
dmemBytes(229)  <= "00000000";
dmemBytes(228)  <= "00000000";
dmemBytes(227)  <= "00000000";
dmemBytes(226)  <= "00000000";
dmemBytes(225)  <= "00000000";
dmemBytes(224)  <= "00000000";--X28


dmemBytes(239)  <= "00000000";
dmemBytes(238)  <= "00000000";
dmemBytes(237)  <= "00000000";
dmemBytes(236)  <= "00000000";
dmemBytes(235)  <= "00000000";
dmemBytes(234)  <= "00000000";
dmemBytes(233)  <= "00000000";
dmemBytes(232)  <= "00000000";--X29


dmemBytes(247)  <= "00000000";
dmemBytes(246)  <= "00000000";
dmemBytes(245)  <= "00000000";
dmemBytes(244)  <= "00000000";
dmemBytes(243)  <= "00000000";
dmemBytes(242)  <= "00000000";
dmemBytes(241)  <= "00000000";
dmemBytes(240)  <= "00000000";--X30


dmemBytes(255)  <= "00000000";
dmemBytes(254)  <= "00000000";
dmemBytes(253)  <= "00000000";
dmemBytes(252)  <= "00000000";
dmemBytes(251)  <= "00000000";
dmemBytes(250)  <= "00000000";
dmemBytes(249)  <= "00000000";
dmemBytes(248)  <= "00000000";--X31

first := false;
		end if;




 if Clock = '1' and Clock'event and RegWrite='1' then
     addr:=to_integer(unsigned(WR)) * 8; 
            if(addr<248) then
         dmemBytes(addr+7) <= WD(63 downto 56);
         dmemBytes(addr+6) <= WD(55 downto 48);
         dmemBytes(addr+5) <= WD(47 downto 40);
         dmemBytes(addr+4) <= WD(39 downto 32);
         dmemBytes(addr+3) <= WD(31 downto 24);
         dmemBytes(addr+2) <= WD(23 downto 16);
         dmemBytes(addr+1) <= WD(15 downto 8);
         dmemBytes(addr)   <= WD(7 downto 0);
                    elsif (addr=248) 
                   then report "X31 cannot be writen"severity error;
                     else report "Invalid Register address" severity error;
			end if;  
            elsif  RegWrite='0'  then	       
                         addr1 := to_integer(unsigned(RR1)) * 8;
                         addr2:=to_integer(unsigned(RR2)) * 8;
                       if addr1<248 and addr2<248 then
			RD1 <= dmemBytes(addr1) & dmemBytes(addr1+1)
			& dmemBytes(addr1+2) & dmemBytes(addr1+3)
			& dmemBytes(addr1+4) & dmemBytes(addr1+5)
			& dmemBytes(addr1+6) & dmemBytes(addr1+7);
                        
                    
                     
			RD2 <= dmemBytes(addr2) & dmemBytes(addr2+1)
			& dmemBytes(addr2+2) & dmemBytes(addr2+3)
			& dmemBytes(addr2+4) & dmemBytes(addr2+5)
			& dmemBytes(addr2+6) & dmemBytes(addr2+7);
                  elsif addr1 = 248 or addr2 =248 then 
                    report "X31 cannot be writen" severity error;
                       else report "Invalid Register address" severity error;
			end if;
end if;
	

end process;
        DEBUG_SAVED_REGS <= dmemBytes(152)&dmemBytes(153)&
dmemBytes(154)&dmemBytes(155)&
dmemBytes(156)&dmemBytes(157)&
dmemBytes(158)&dmemBytes(159)&
dmemBytes(160)&dmemBytes(161)&
dmemBytes(162)&dmemBytes(163)&
dmemBytes(164)&dmemBytes(165)&
dmemBytes(166)&dmemBytes(167)&
dmemBytes(168)&dmemBytes(169)&
dmemBytes(170)&dmemBytes(171)&
dmemBytes(172)&dmemBytes(173)&
dmemBytes(174)&dmemBytes(175)&
dmemBytes(176)&dmemBytes(177)&
dmemBytes(178)&dmemBytes(179)&
dmemBytes(180)&dmemBytes(181)&
dmemBytes(182)&dmemBytes(183);
        DEBUG_TMP_REGS  <= dmemBytes(72)&dmemBytes(73)&
dmemBytes(74)&dmemBytes(75)&
dmemBytes(76)&dmemBytes(77)&
dmemBytes(78)&dmemBytes(79)&
dmemBytes(80)&dmemBytes(81)&
dmemBytes(82)&dmemBytes(83)&
dmemBytes(84)&dmemBytes(85)&
dmemBytes(86)&dmemBytes(87)&
dmemBytes(88)&dmemBytes(89)&
dmemBytes(90)&dmemBytes(91)&
dmemBytes(92)&dmemBytes(93)&
dmemBytes(94)&dmemBytes(95)&
dmemBytes(96)&dmemBytes(97)&
dmemBytes(98)&dmemBytes(99)&
dmemBytes(100)&dmemBytes(101)&
dmemBytes(102)&dmemBytes(103);
end behav1;


