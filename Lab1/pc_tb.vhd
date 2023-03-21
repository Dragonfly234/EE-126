library ieee;
use ieee.std_logic_1164.all;

entity PC_TB is
end PC_TB;

architecture PC_TB of PC_TB is
component PC
port (
     clk          : in  STD_LOGIC; -- Propogate AddressIn to AddressOut on rising edge of clock
     write_enable : in  STD_LOGIC; -- Only write if '1'
     rst          : in  STD_LOGIC; -- Asynchronous reset! Sets AddressOut to 0x0
     AddressIn    : in  STD_LOGIC_VECTOR(63 downto 0); -- Next PC address
     AddressOut   : out STD_LOGIC_VECTOR(63 downto 0) -- Current PC address
);
end component;

signal clk:STD_LOGIC :='0';
signal write_enable :STD_LOGIC :='0';
signal rst :STD_LOGIC :='0';
signal AddressIn: STD_LOGIC_VECTOR(63 downto 0) :=x"0000000000000000";
signal AddressOut: STD_LOGIC_VECTOR(63 downto 0) :=x"0000000000000000";

begin
   uut:PC port map(
             clk =>clk,
             write_enable =>write_enable,
             rst  =>rst,
             AddressIn =>AddressIn,
             AddressOut =>AddressOut
                );


stim_proc: process
begin
   clk <='0';
   write_enable<='1';
   rst<='1';
   AddressIn <= x"aaaaaaaaaaaaaaaa";
   wait for 50 ns;
  
   clk <= '1';
   write_enable <= '1';
   rst <='0';
   wait for 50 ns;
  

    clk <= '0';
   write_enable<='1';
   rst<='1';
   AddressIn<=x"1234123412341234";
   wait for 50 ns;
  
   clk <= '1';
   write_enable <= '1';
   rst<='1';
   wait for 50 ns;



   clk <= '0';
   write_enable<= '1';
   rst<= '0';
   AddressIn<= x"cccccccccccccccc";
   wait for 50 ns;
   
   clk <= '1';
   write_enable <= '1';
   rst <= '0';
   wait for 50 ns;


   clk <= '0';
   write_enable<= '1';
   rst<= '0';
   AddressIn<= x"4567456745674567";
   wait for 50 ns;
  
   clk <= '0';
   write_enable <= '1';
   rst <= '0';
   
   wait for 50 ns;
   

   clk <='0';
   write_enable <='1';
   rst <='0';
   AddressIn <=x"ffffffffffffffff";
   wait for 50 ns;
  

   clk <='1';
   write_enable <='1';
   rst <='0';
  
   wait for 50 ns;


   clk <='1';
   write_enable <= '0';
   rst <='0';
   AddressIn <= x"aaaaaaaaaaaaaaaa";
   wait for 50 ns;
  

   clk <= '0';
   write_enable <= '0';
   rst <= '0';
   
   wait;
end process;
end;