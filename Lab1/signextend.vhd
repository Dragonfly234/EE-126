library ieee;
use ieee.std_logic_1164.all;


entity SignExtend is
port(
     x : in  STD_LOGIC_VECTOR(31 downto 0);
     y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
);
end SignExtend;


architecture behvl of SignExtend is
begin
process(x)
begin
if (x(31)='1') then
y<=x"ffffffff"&x; 
else 
y<=x"00000000"&x;
end if;
end process;
end behvl; 