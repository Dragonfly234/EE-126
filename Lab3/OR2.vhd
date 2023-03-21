library IEEE;
use IEEE.std_logic_1164.all;

entity OR2 is

    port(in0 : in std_logic;      
         in1 : in std_logic;     
         output : out std_logic);   

end OR2;



architecture behvl of OR2 is

 begin
    
    output <= in0 OR in1;

end behvl; 
