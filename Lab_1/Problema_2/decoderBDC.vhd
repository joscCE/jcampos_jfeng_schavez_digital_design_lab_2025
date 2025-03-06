library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoderBDC is
    Port (
        a  : in  STD_LOGIC_VECTOR (3 downto 0);
        y0 : out STD_LOGIC_VECTOR (3 downto 0);
        y1 : out STD_LOGIC_VECTOR (3 downto 0)
    );
end decoderBDC;

architecture Behavioral of decoderBDC is
begin
    -- Output first segment
    y0(0) <= a(0);
    y0(1) <= (not a(3) and a(1)) or (a(3) and a(2) and not a(1));
    y0(2) <= (not a(3) and a(2)) or (a(2) and a(1));
    y0(3) <= a(3) and not a(2) and not a(1);
    
    -- Output second segment
    y1(0) <= (a(3) and a(2)) or (a(3) and a(1));
    y1(1) <= '0';
    y1(2) <= '0';
    y1(3) <= '0';
    
end Behavioral;