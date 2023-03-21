library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity pipelinecpu_tb is
end pipelinecpu_tb;

architecture pipelinecpu_tb of pipelinecpu_tb is

component PipelinedCPU0
    port(clk :in STD_LOGIC;
rst :in STD_LOGIC;
DEBUG_PC : out STD_LOGIC_VECTOR(63 downto 0);
DEBUG_INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0);
DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;
signal rst : std_logic;
signal clk :   STD_LOGIC:='0';
signal DEBUG_MEM_CONTENTS : std_logic_vector(64*4 - 1 downto 0);
signal DEBUG_TMP_REGS : std_logic_vector(64*4 - 1 downto 0);
signal DEBUG_PC : STD_LOGIC_VECTOR(63 downto 0);
signal DEBUG_INSTRUCTION : STD_LOGIC_VECTOR(31 downto 0);
signal DEBUG_SAVED_REGS :  STD_LOGIC_VECTOR(64*4 - 1 downto 0);

begin
uut: PipelinedCPU0 port map (clk => clk, rst=>rst, DEBUG_MEM_CONTENTS => DEBUG_MEM_CONTENTS,
DEBUG_SAVED_REGS=>DEBUG_SAVED_REGS,
                          DEBUG_TMP_REGS => DEBUG_TMP_REGS,DEBUG_PC => DEBUG_PC ,DEBUG_INSTRUCTION => DEBUG_INSTRUCTION);
 

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