library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end MIPS;

architecture Behavioral of MIPS is

    signal se_in : std_logic_vector (15 downto 0) := x"0000";
    signal se_out : std_logic_vector (31 downto 0) := x"00000000";

begin

    --U1: entity work.mux2 (Behavioral)
        --port map(
            --mux_in0 =>,
            --mux_in1 =>,
            --mux_ctl =>,
            --mux_out =>
            --);
            
    --U2: entity work.sign_extender (Behavioral)
        --port map(
            --se_in =>,
            --se_out =>
            --);
            
    
end Behavioral;
