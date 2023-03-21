library ieee;
use ieee.std_logic_1164.all;
entity BIT_FULL_ADDER_TB is
end BIT_FULL_ADDER_TB;
 
architecture BIT_FULL_ADDER_TB of BIT_FULL_ADDER_TB is
   component BIT_FULL_ADDER
   port(
       A  : in STD_LOGIC;
       B  : in STD_LOGIC;
     Cin  : in STD_LOGIC;
     Sum  : out STD_LOGIC;
   Carry  : out STD_LOGIC
       );
end component;

signal A  :  STD_LOGIC :='0';
signal B :  STD_LOGIC :='0';
signal Cin : STD_LOGIC :='0';
signal Sum :  STD_LOGIC;
signal Carry :  STD_LOGIC;

begin 
   uut: BIT_FULL_ADDER port map(
                       A =>A,
                       B =>B,
                     Cin =>Cin,
                     Sum =>Sum,
                   Carry =>Carry
);


sim_proc: process
begin
      A <= '0';
      B <= '0';
    Cin <= '0';
wait for 50 ns;

     A <= '0';
      B <= '0';
    Cin <= '1';
wait for 50 ns;

      A <= '0';
      B <= '1';
    Cin <= '0';
wait for 50 ns;


      A <= '0';
      B <= '1';
    Cin <= '1';
wait for 50 ns;

      A <= '1';
      B <= '0';
    Cin <= '0';
wait for 50 ns;


      A <= '1';
      B <= '0';
    Cin <= '1';
wait for 50 ns;



      A <= '1';
      B <= '1';
    Cin <= '0';
wait for 50 ns;

      A <= '1';
      B <= '1';
    Cin <= '1';
wait;
end process;
end;



