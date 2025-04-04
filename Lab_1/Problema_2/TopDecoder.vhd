library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopDecoder is
    Port (
        a    : in  STD_LOGIC_VECTOR (3 downto 0);  -- Entrada de 4 bits
		  o 		: in STD_LOGIC;
        seg0, seg1 : out STD_LOGIC_VECTOR (7 downto 0)  -- Dos displays de 7 segmentos
    );
end TopDecoder;

architecture Behavioral of TopDecoder is


	--funcion display 7 seg 1
	function HexTo7seg1(O: STD_LOGIC) return STD_LOGIC_VECTOR is
	begin
		case O is
			when '1' => return "00000011";
			when others => return "11111111";
		end case;

	
	end function;



    -- Función para decodificar un número hexadecimal a 7 segmentos
    function HexTo7Seg0(a0: STD_LOGIC_VECTOR(3 downto 0); O: STD_LOGIC) return STD_LOGIC_VECTOR is
    begin
			if O = '1' then
            return "01110001"; -- Si O es '1', mostrar F en HEX
        else
            case a0 is
                when "0000" => return "00000010"; -- 0
                when "0001" => return "10011111"; -- 1
                when "0010" => return "00100101"; -- 2
                when "0011" => return "00001101"; -- 3
                when "0100" => return "10011001"; -- 4
                when "0101" => return "01001001"; -- 5
                when "0110" => return "01000001"; -- 6
                when "0111" => return "00011111"; -- 7
                when "1000" => return "00000001"; -- 8
                when "1001" => return "00001001"; -- 9
                when "1010" => return "00010001"; -- A
                when "1011" => return "11000001"; -- B
                when "1100" => return "01100011"; -- C
                when "1101" => return "10000101"; -- D
                when "1110" => return "01100001"; -- E
                when "1111" => return "01110001"; -- F
                when others => return "11111111"; -- Apagado
            end case;
        end if;
    end function;

begin

    -- Asignación a los displays de 7 segmentos
    seg0 <= HexTo7Seg0(a,o);  -- Primer display muestra el valor hexadecimal
    seg1 <= HexTo7seg1(o);     -- Segundo display apagado (puedes ponerlo en "11000000" para mostrar '0')

end Behavioral;
