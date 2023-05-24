library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux3 is
    Generic (
        N : integer := 32
    );
Port (
         mux_in0 : in  std_logic_vector(N-1 downto 0);
         mux_in1 : in  std_logic_vector(N-1 downto 0);
         mux_in2 : in  std_logic_vector(N-1 downto 0);
         mux_ctl : in  std_logic_vector;
         mux_out : out std_logic_vector(N-1 downto 0)
     );
end mux3;

architecture Behavioral of mux3 is

begin

  mux_out <= mux_in0 when (mux_ctl = "00") else
             mux_in1 when (mux_ctl = "01") else
             mux_in2 when (mux_ctl = "10");

end Behavioral;
