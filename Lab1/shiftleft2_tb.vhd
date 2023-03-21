library ieee;
use ieee.std_logic_1164.all;
entity ShiftLeft2_TB is
end ShiftLeft2_TB;
architecture ShiftLeft2_TB of ShiftLeft2_TB is
component ShiftLeft2
port(  
     x : in  STD_LOGIC_VECTOR(63 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) 
);
end component;

signal x :STD_LOGIC_VECTOR(63 downto 0) :=x"0000000000000000";
signal y :STD_LOGIC_VECTOR(63 downto 0) :=x"0000000000000000";
begin 
uut: ShiftLeft2 port map(
       x=>x,
       y=>y
);



stim_proc: process
begin 
 x <= x"0000000000000010";
wait for 50 ns;
 x <= x"0101010101010101";
wait for 50 ns;
 x <= x"ffffffffffffffff";
wait for 50 ns;
 x <= x"0000000000000001";
wait;
end process;
end;
