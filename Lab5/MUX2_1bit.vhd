library ieee;
use ieee.std_logic_1164.all;
entity MUX2_1bit is -- Two by one mux with 32 bit inputs/outputs
port(
    in0    : in STD_LOGIC; -- sel == 0
    in1    : in STD_LOGIC; -- sel == 1
    sel    : in STD_LOGIC; -- selects in0 or in1
    output : out STD_LOGIC
);
end MUX2_1bit;

architecture behvl of MUX2_1bit is
begin
output <= in0 when(sel = '0') else  in1;
end behvl;
