library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopDecoder is
    Port (
        a    : in  STD_LOGIC_VECTOR (3 downto 0);
        seg0, seg1 : out STD_LOGIC_VECTOR (7 downto 0)
    );
end TopDecoder;

architecture Behavioral of TopDecoder is
    -- Variables intermedias
    signal y0, y1 : STD_LOGIC_VECTOR (3 downto 0);

    -- Declaración de componentes
    component decoderBDC
        Port (
            a  : in  STD_LOGIC_VECTOR (3 downto 0);
            y0, y1 : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Decoder7seg
        Port (
            a, b : in  STD_LOGIC_VECTOR (3 downto 0);
            seg0, seg1 : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

begin
    -- Instancia del BCD decoder
    bdc_decoder : decoderBDC
        port map (
            a  => a,
            y0 => y0,
            y1 => y1
        );

    -- Instancia del módulo Decoder7seg
    seg_decoder : Decoder7seg
        port map (
            a    => y0,
            b    => y1,
            seg0 => seg0,
            seg1 => seg1
        );

end Behavioral;
