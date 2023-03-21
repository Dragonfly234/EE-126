library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pipelinecpu1_tb is
end pipelinecpu1_tb;

architecture pipelinecpu1_tb of pipelinecpu1_tb is
component PipelinedCPU1 port 
(
clk :in std_logic;
rst :in std_logic;
--Probe ports used for testing
-- Forwarding control signals
DEBUG_FORWARDA : out std_logic_vector(1 downto 0);
DEBUG_FORWARDB : out std_logic_vector(1 downto 0);
--The current address (AddressOut from the PC)
DEBUG_PC : out std_logic_vector(63 downto 0);
--Value of PC.write_enable
DEBUG_PC_WRITE_ENABLE : out STD_LOGIC;
--The current instruction (Instruction output of IMEM)
DEBUG_INSTRUCTION : out std_logic_vector(31 downto 0);
--DEBUG ports from other components
DEBUG_TMP_REGS : out std_logic_vector(64*4-1 downto 0);
DEBUG_SAVED_REGS : out std_logic_vector(64*4-1 downto 0);
DEBUG_MEM_CONTENTS : out std_logic_vector(64*4-1 downto 0)
);
end component;

signal clk : std_logic;
signal rst : std_logic;
signal DEBUG_FORWARDA :  std_logic_vector(1 downto 0);
signal DEBUG_FORWARDB :  std_logic_vector(1 downto 0);
signal DEBUG_PC :  std_logic_vector(63 downto 0);
signal DEBUG_PC_WRITE_ENABLE :  STD_LOGIC;
signal DEBUG_INSTRUCTION :  std_logic_vector(31 downto 0);
signal DEBUG_TMP_REGS :  std_logic_vector(64*4-1 downto 0);
signal DEBUG_SAVED_REGS :  std_logic_vector(64*4-1 downto 0);
signal DEBUG_MEM_CONTENTS :  std_logic_vector(64*4-1 downto 0);


begin
uut: PipelinedCPU1 port map (
clk => clk, 
rst=>rst, 
DEBUG_MEM_CONTENTS => DEBUG_MEM_CONTENTS,
DEBUG_SAVED_REGS=>DEBUG_SAVED_REGS,
DEBUG_FORWARDA=>DEBUG_FORWARDA,
DEBUG_FORWARDB=>DEBUG_FORWARDB,
DEBUG_TMP_REGS => DEBUG_TMP_REGS,
DEBUG_PC => DEBUG_PC ,
DEBUG_PC_WRITE_ENABLE =>DEBUG_PC_WRITE_ENABLE ,
DEBUG_INSTRUCTION => DEBUG_INSTRUCTION
);

 

stim_proc: process
begin        
     rst <= '1';
     clk<= '1';
    wait for 50 ns; 
    rst <= '0';
     clk<= '1';
    wait for 25 ns;
    rst <= '0';
    clk <= '0';
    wait for 25 ns;
   
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

         clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 
     clk<= '1';
     wait for 50 ns; 
     clk<= '0';
     wait for 50 ns; 

end process;

end;