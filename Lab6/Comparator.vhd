library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Comparator is
port(
	in0 : in std_logic_vector(63 downto 0);
	in1 : in std_logic_vector(63 downto 0);
	output : out std_logic
);
end Comparator;

architecture behav1 of Comparator is
begin
	process(in0,in1)
	begin
		if in0 = in0 then
			output <= '1';
		else 
			output <= '0';
		end if;
	end process;
end behav1;