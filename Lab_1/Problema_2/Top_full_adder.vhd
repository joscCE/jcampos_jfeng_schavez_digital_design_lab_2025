library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Top_full_adder is
    port(
        a, b    : in  STD_LOGIC_VECTOR(3 downto 0); -- Entradas de 4 bits
        cin     : in  STD_LOGIC;                    -- Carry de entrada
        seg0,seg1       : out STD_LOGIC_VECTOR(7 downto 0); -- Resultado de la suma
        cout    : out STD_LOGIC                     -- Carry de salida final
    );
end entity;

architecture synth of Top_full_adder is
    -- Componente sumador de 1 bit
    component fulladderbit
        port(
            a, b, cin : in  STD_LOGIC;
            s, cout   : out STD_LOGIC
        );
    end component;
	 
	 -- componente decoder
	 component TopDecoder
		port(
				a    : in  STD_LOGIC_VECTOR(3 downto 0);
            seg0, seg1 : out STD_LOGIC_VECTOR(7 downto 0)
		
		
		
		);
		end component;
	 
	

    -- Señales internas para los acarreo entre los bits
    signal c : STD_LOGIC_VECTOR(3 downto 0);
	 signal s : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instancias de fulladderbit para cada bit
    FA0: fulladderbit port map(a(0), b(0), cin,  s(0), c(0));
    FA1: fulladderbit port map(a(1), b(1), c(0), s(1), c(1));
    FA2: fulladderbit port map(a(2), b(2), c(1), s(2), c(2));
    FA3: fulladderbit port map(a(3), b(3), c(2), s(3), cout);
	 
	 
	 
	 decoder_inst: TopDecoder
		port map(
			a => s,
			seg0 => seg0,
			seg1 => seg1
	
		
		);
	 
	 

end architecture;
