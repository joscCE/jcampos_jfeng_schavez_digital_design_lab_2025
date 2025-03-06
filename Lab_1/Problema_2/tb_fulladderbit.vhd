library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_fulladderbit is
end entity;

architecture sim of tb_fulladderbit is
    -- Declaración del componente bajo prueba
    component fulladderbit
        port (
            a, b, cin : in STD_LOGIC;
            s, cout   : out STD_LOGIC
        );
    end component;

    -- Señales para las entradas y salidas
    signal a, b, cin : STD_LOGIC;
    signal s, cout   : STD_LOGIC;

begin
    -- Instanciación del módulo fulladderbit
    dut: fulladderbit 
        port map (
            a    => a, 
            b    => b, 
            cin  => cin, 
            s    => s, 
            cout => cout
        );

    -- Proceso para aplicar estímulos
    process
    begin
        -- Caso 1: 0 + 0 + 0
        a <= '0'; b <= '0'; cin <= '0';
        wait for 10 ns;

        -- Caso 2: 0 + 1 + 0
        a <= '0'; b <= '1'; cin <= '0';
        wait for 10 ns;

        -- Caso 3: 1 + 0 + 0
        a <= '1'; b <= '0'; cin <= '0';
        wait for 10 ns;

        -- Caso 4: 1 + 0 + 1
        a <= '1'; b <= '0'; cin <= '1';
        wait for 10 ns;

        -- Caso 5: 1 + 1 + 0
        a <= '1'; b <= '1'; cin <= '0';
        wait for 10 ns;

        -- Caso 6: 1 + 1 + 1
        a <= '1'; b <= '1'; cin <= '1';
        wait for 10 ns;

        wait; -- Espera infinita
    end process;

end architecture;
