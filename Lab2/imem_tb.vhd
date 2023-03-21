LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; 

entity IMEM_TB is
end IMEM_TB;

architecture IMEM_TB of IMEM_TB is
component IMEM
port(
     Address  : in  STD_LOGIC_VECTOR(63 downto 0); 
     ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end component;

 signal    Address  : STD_LOGIC_VECTOR(63 downto 0); 
 signal    ReadData : STD_LOGIC_VECTOR(31 downto 0);

begin
uut:  IMEM port map(
                 Address=>Address,
                 ReadData=>ReadData
                   );
stimu_proc: process
begin
              Address <= x"0000_0000_0000_0004";
              wait for 50 ns;
              Address <= x"0000_0000_0000_0020";	
              wait for 50 ns;
              Address <= x"0000_0000_0000_0008";	
              wait for 50 ns;
              Address <= x"0000_0000_1000_0040";	
              wait for 50 ns;
              wait;

end process;
end;