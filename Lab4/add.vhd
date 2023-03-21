library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity ADD is
port(
     in0    : in  STD_LOGIC_VECTOR(63 downto 0);
     in1    : in  STD_LOGIC_VECTOR(63 downto 0);
     output : out STD_LOGIC_VECTOR(63 downto 0)
);
end ADD;

architecture behv1 of ADD is
   component BIT_FULL_ADDER port
   (
       A  : in STD_LOGIC;
       B  : in STD_LOGIC;
     Cin  : in STD_LOGIC;
     Sum  : out STD_LOGIC;
   Carry  : out STD_LOGIC
                 );
end component;

signal temp:STD_LOGIC_VECTOR(64 downto 0);
 begin
  temp(0)<='0';
   ADDbuild:for i in 0 to 63 generate
 adderi:
     BIT_FULL_ADDER  port map
     (
      
       A => in0(i),
       B => in1(i),
       Cin => temp(i),
     Carry => temp(i+1),
     Sum => output(i)
    );
end generate ADDbuild;
end behv1;   



  