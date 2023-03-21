library ieee;
use ieee.std_logic_1164.all;
entity SignExtend_TB is
end SignExtend_TB;

architecture SignExtend_TB of SignExtend_TB is
component SignExtend
port(
     x : in  STD_LOGIC_VECTOR(31 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
);
end component;

signal x :STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal y :STD_LOGIC_VECTOR(63 downto 0):=x"0000000000000000";

begin 
uut: SignExtend port map(

              x=>x,
              y=>y
);

stim_proc: process
begin
 x<=x"11110000";
wait for 50 ns;
 x<=x"01010101";
wait for 50 ns;
 x<=x"f0001111";
wait for 50 ns;
 x<=x"10110100";
wait;
end process;
end;