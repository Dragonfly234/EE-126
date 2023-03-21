library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.numeric_std.ALL;

entity DEME_TB is
generic(NUM_BYTES : integer := 64);
end DEME_TB;

architecture DEME_TB of DEME_TB is
component DMEM
port(
     WriteData          : in  STD_LOGIC_VECTOR(63 downto 0); -- Input data
     Address            : in  STD_LOGIC_VECTOR(63 downto 0); -- Read/Write address
     MemRead            : in  STD_LOGIC; -- Indicates a read operation
     MemWrite           : in  STD_LOGIC; -- Indicates a write operation
     Clock              : in  STD_LOGIC; -- Writes are triggered by a rising edge
     ReadData           : out STD_LOGIC_VECTOR(63 downto 0); -- Output data
     --Probe ports used for testing
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;


signal     WriteData          :   STD_LOGIC_VECTOR(63 downto 0):=x"0000_0000_0000_0000"; 
signal     Address            :   STD_LOGIC_VECTOR(63 downto 0):=x"0000_0000_0000_0000"; 
signal     MemRead            :   STD_LOGIC:='0'; 
signal     MemWrite           :   STD_LOGIC:='0'; 
signal     Clock              :   STD_LOGIC:='0'; 
signal     ReadData           :  STD_LOGIC_VECTOR(63 downto 0); 
signal     DEBUG_MEM_CONTENTS :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);

begin
uut: DMEM port map(

                 WriteData=>WriteData,
                 Address=>Address,
                 MemRead=>MemRead,
                 MemWrite=>MemWrite,
                 Clock=>Clock,
                 ReadData=>ReadData,
                 DEBUG_MEM_CONTENTS=>DEBUG_MEM_CONTENTS
);
sim_proc: process
begin    
       
        MemWrite  <= '0'; 
        MemRead <= '1';
        Address   <= x"0000000000000000";
	WriteData <= x"1111222200000000";

	WAIT FOR 50 ns;
	
        MemWrite <='1';
	MemRead <= '0';
        WriteData <= x"1111222200000001";
        Address   <= x"000000000000000A";
        WAIT FOR 50 ns;
	

        MemWrite  <='0'; 
        MemRead <= '1';
        Address   <= x"0000000000000050";
	WriteData <= x"1111222200000000";

        wait;
END PROCESS;
 Clock <= not Clock after 25 ns;
END;