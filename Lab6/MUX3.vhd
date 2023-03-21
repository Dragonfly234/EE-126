library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity MUX3 is
port( 
sel: in std_logic_vector(1 downto 0); 
in0: in std_logic_vector(63 downto 0); 
in1: in std_logic_vector(63 downto 0);
in2: in std_logic_vector(63 downto 0); 
output: out std_logic_vector(63 downto 0)
); 
end MUX3;

----------------------------------------------------

architecture behav1 of MUX3 is
begin
process(sel,in0,in1,in2)
begin
  if sel = "00" then
        output <= in0;
  elsif sel = "01" then
        output <= in1;
  elsif sel = "10" then
        output <= in2;

  end if;
end process;
end behav1;	