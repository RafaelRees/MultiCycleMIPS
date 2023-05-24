library IEEE;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity instruction_register is
    Port ( 
           input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           sig : in  STD_LOGIC;
		   CLK : in STD_LOGIC
		  );
end instruction_register;

architecture Behavioral of instruction_register is

begin

process(input, sig, CLK)

begin
if rising_edge(CLK) and sig='1' then
output<=input;
end if;
end process;

end Behavioral;

