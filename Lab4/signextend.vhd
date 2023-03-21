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
      if x(28 downto 22) = "1000100" then  
            if x(21) = '0' then
               y <= x"0000000000000" & x(21 downto 10);
                else
                y <= x"FFFFFFFFFFFFF" & x(21 downto 10);
            end if;
       elsif   x(31 downto 27)= "11111" then
               
                if x(20) = '0'  then
                y <= "0000000000000000000000000000000000000000000000000000000" & x(20 downto 12);
                else
                 y <= "1111111111111111111111111111111111111111111111111111111" & x(20 downto 12) ;
                end if;
      elsif  x(31 downto 24) = "10110100" then               
               
               if x(23) = '0' then
                 y <= "000000000000000000000000000000000000000000000" & x(23 downto 5) ;
                 ELSE
                  y <= "111111111111111111111111111111111111111111111" & x(23 downto 5);
                end if;
      
       elsif (x(31 downto 26) = "000101") then
                 
                  if x(25) = '0' then
                  y <= "00000000000000000000000000000000000000" & x(25 downto 0);
                  ELSE
                   y <= "11111111111111111111111111111111111111" & x(25 downto 0);
                  end if;
       else        
                      y <= x"0000_0000_0000_0001";
end if;
end process;
end behvl; 