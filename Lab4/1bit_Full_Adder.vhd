library ieee;
use ieee.std_logic_1164.all;
entity  BIT_FULL_ADDER is 
port(
       A  : in STD_LOGIC;
       B  : in STD_LOGIC;
     Cin  : in STD_LOGIC;
     Sum  : out STD_LOGIC;
   Carry  : out STD_LOGIC
    );
end BIT_FULL_ADDER;

architecture behv1 of BIT_FULL_ADDER is
begin
 Sum <= A XOR B XOR Cin ;
 Carry <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;
end behv1;
