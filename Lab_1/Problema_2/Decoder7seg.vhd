library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decoder7seg is
    Port (
        a, b : in  STD_LOGIC_VECTOR (3 downto 0);
        seg0, seg1 : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Decoder7seg;

architecture Behavioral of Decoder7seg is
    signal seg0_internal : STD_LOGIC_VECTOR (7 downto 0);
    signal seg1_internal : STD_LOGIC_VECTOR (7 downto 0);
begin
    -- Segmentos del primer dígito
    seg0_internal(7) <= a(1) or a(3) or (not a(2) and not a(0)) or (a(2) and a(0));
    seg0_internal(6) <= not a(2) or (a(1) and a(0)) or (not a(1) and not a(0));
    seg0_internal(5) <= not a(1) or a(2) or a(0);
    seg0_internal(4) <= a(3) or (not a(2) and not a(0)) or (not a(2) and a(1)) or (a(1) and not a(0)) or (a(2) and not a(1) and a(0));
    seg0_internal(3) <= (not a(2) and not a(0)) or (a(1) and not a(0));
    seg0_internal(2) <= a(3) or (a(2) and not a(0)) or (not a(1) and not a(0)) or (a(2) and not a(1));
    seg0_internal(1) <= a(3) or (not a(2) and a(1)) or (a(2) and not a(0)) or (a(2) and not a(1));
    seg0_internal(0) <= '0';
    
    -- Segmentos del segundo dígito
    seg1_internal(7) <= not b(0);
    seg1_internal(6) <= '1';
    seg1_internal(5) <= '1';
    seg1_internal(4) <= not b(0);
    seg1_internal(3) <= not b(0);
    seg1_internal(2) <= not b(0);
    seg1_internal(1) <= '0';
    seg1_internal(0) <= '0';
    
    -- Invertimos la salida para adaptarnos a la DE10-Standard (activa baja)
    seg0 <= not seg0_internal;
    seg1 <= not seg1_internal;

end Behavioral;
