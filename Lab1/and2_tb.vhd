library ieee;
use ieee.std_logic_1164.all;

entity and2_tb is
end and2_tb;

ARCHITECTURE AND2_tb of AND2_tb IS
    COMPONENT AND2 
    PORT(
       signal  in0: IN std_logic;
       signal  in1: IN std_logic;
       signal  output: OUT std_logic
        );
   end COMPONENT;
       signal  in0:  std_logic:='0';
       signal  in1:  std_logic:='0';
       signal  output: std_logic;

BEGIN 
   uut: AND2 PORT MAP(
               in0 => in0,
               in1 => in1, 
               output => output
                );

stim_proc : process 
BEGIN 
  in0 <='0';
  in1 <='0';
  wait for 50 ns;

  in0 <='0';
  in1 <='1';
  wait for 50 ns;


  in0 <='1';
  in1 <='0';
  wait for 50 ns;


  in0 <='1';
  in1 <='1';
  wait;
end process;
END;