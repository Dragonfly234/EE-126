library ieee;
use ieee.std_logic_1164.all;

entity PC is -- 32-bit rising-edge triggered register with write-enable and synchronous reset
-- For more information on what the PC does, see page 251 in the textbook
port(
     clk          : in  STD_LOGIC; -- Propogate AddressIn to AddressOut on rising edge of clock
     write_enable : in  STD_LOGIC; -- Only write if '1'
     rst          : in  STD_LOGIC; -- Asynchronous reset! Sets AddressOut to 0x0
     AddressIn    : in  STD_LOGIC_VECTOR(63 downto 0); -- Next PC address
     AddressOut   : out STD_LOGIC_VECTOR(63 downto 0) -- Current PC address
);
end PC;

architecture behvl of PC is 
begin


process(clk,rst,AddressIn)
begin
if(rst='1')then
  AddressOut <= x"0000000000000000";
  elsif (write_enable = '1') then
  if (clk'event and clk = '1') then
  AddressOut <= AddressIn;
end if;
end if;
end process;
end behvl;

