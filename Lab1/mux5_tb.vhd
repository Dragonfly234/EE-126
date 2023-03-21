library ieee;
use ieee.std_logic_1164.all;

entity MUX5_TB is 
end MUX5_TB;

architecture MUX5_TB of MUX5_TB is
  component MUX5
  port(    
    in0    : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 0
    in1    : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 1
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC_VECTOR(4 downto 0)
     );
  end component;
 
signal in0 :  STD_LOGIC_VECTOR(4 downto 0):="00000" ;
signal in1 :  STD_LOGIC_VECTOR(4 downto 0):="00000" ;
signal  sel:  std_logic:='0';
signal output :  STD_LOGIC_VECTOR(4 downto 0);

begin 
 uut: MUX5 port map(
               in0 => in0,
               in1 => in1, 
               output => output,
               sel =>sel
                );
stim_proc: process
begin 

  in0 <="00000";
  in1 <="11110";
  sel<= '1';
  wait for 50 ns;

  in0 <="00000";
  in1 <="10100";
  sel<= '1';
  wait for 50 ns;

  in0 <="01100";
  in1 <="10100";
  sel<= '0';
  wait for 50 ns;

  in0 <="10010";
  in1 <="01010";
  sel<= '0';
  wait ;
end process;
END;

