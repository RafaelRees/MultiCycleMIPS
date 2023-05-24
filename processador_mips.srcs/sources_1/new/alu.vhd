library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           alu_control : in  STD_LOGIC_VECTOR (3 downto 0);
           alu_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is

begin

process(A, B, alu_control)

begin

    if (alu_control = "0000") then
        alu_out <= A AND B;
    elsif (alu_control = "0001") then
        alu_out <= A OR B;
    elsif (alu_control = "0010") then
        alu_out <= A + B;
    elsif (alu_control = "0110") then
        alu_out <= A - B;
    end if;

if (A=B) then
    Zero <= '1';
else
    Zero <= '0';
end if;

end process;

end Behavioral;
