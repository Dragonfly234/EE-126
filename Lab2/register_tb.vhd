library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.numeric_std.ALL;

entity registers_tb is
generic(TotalByte : integer := 256);
end registers_tb;

architecture registers_tb of registers_tb is
component registers
port (RR1      : in  STD_LOGIC_VECTOR (4 downto 0); 
     RR2      : in  STD_LOGIC_VECTOR (4 downto 0); 
     WR       : in  STD_LOGIC_VECTOR (4 downto 0); 
     WD       : in  STD_LOGIC_VECTOR (63 downto 0);
     RegWrite : in  STD_LOGIC;
     Clock    : in  STD_LOGIC;
     RD1      : out STD_LOGIC_VECTOR (63 downto 0);
     RD2      : out STD_LOGIC_VECTOR (63 downto 0);
     DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
     DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;

    signal RR1      :   STD_LOGIC_VECTOR (4 downto 0):="00000"; 
  signal   RR2      :   STD_LOGIC_VECTOR (4 downto 0):="00000"; 
  signal   WR       :   STD_LOGIC_VECTOR (4 downto 0):="00000"; 
  signal   WD       :   STD_LOGIC_VECTOR (63 downto 0):=X"0000000000000000"; 
   signal  RegWrite :   STD_LOGIC :='0';
  signal   Clock    :   STD_LOGIC :='0';
   signal  RD1      :  STD_LOGIC_VECTOR (63 downto 0);
   signal  RD2      :  STD_LOGIC_VECTOR (63 downto 0);
   signal  DEBUG_TMP_REGS :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
   signal  DEBUG_SAVED_REGS :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);
  

 

begin

uut: registers port map(
                 RR1=>RR1,
                 RR2=>RR2,
                 WR=>WR,
                 WD=>WD,
                 RegWrite=>RegWrite,
                 Clock=>Clock,
                 RD1=>RD1,
                 RD2=>RD2,
                 DEBUG_TMP_REGS=>DEBUG_TMP_REGS,
                 DEBUG_SAVED_REGS=>DEBUG_SAVED_REGS             
);

sim_proc: process
begin
        RegWrite <= '0';
        RR1   <= "01001"; --X9
        RR2   <= "01010"; --X10
	wait FOR 50 ns;
	
        RegWrite <= '1';
        WR<="10011";
        WD<=X"FFFFFFFFFFFFFFFF";
	wait FOR 50 ns;

        RegWrite <= '1';
        WR<="10011";
        WD<=X"0000000000000000";
	wait for 50 ns;

        RegWrite <= '0';
        RR1   <= "10011"; --X9
        RR2   <= "10011"; --X10
	wait;

END PROCESS;
 Clock <= not Clock after 25 ns;
END;
