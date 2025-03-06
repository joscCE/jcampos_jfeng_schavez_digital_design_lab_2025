library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity tb_Top_full_adder is
end entity;

architecture testbench of tb_Top_full_adder is
    -- Componente bajo prueba (UUT: Unit Under Test)
    component Top_full_adder
        port(
            a, b    : in  STD_LOGIC_VECTOR(3 downto 0);
            cin     : in  STD_LOGIC;
            s       : out STD_LOGIC_VECTOR(3 downto 0);
            cout    : out STD_LOGIC
        );
    end component;

    -- Señales para estímulos y resultados
    signal a_tb, b_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal cin_tb     : STD_LOGIC;
    signal s_tb       : STD_LOGIC_VECTOR(3 downto 0);
    signal cout_tb    : STD_LOGIC;

begin
    -- Instancia del sumador de 4 bits
    UUT: Top_full_adder port map(
        a    => a_tb,
        b    => b_tb,
        cin  => cin_tb,
        s    => s_tb,
        cout => cout_tb
    );

    -- Proceso de estímulos
    stim_proc: process
    begin
        -- Prueba 1: 0000 + 0000 + 0
        a_tb <= "0000"; b_tb <= "0000"; cin_tb <= '0';
        wait for 10 ns;
        
        -- Prueba 2: 0001 + 0001 + 0
        a_tb <= "0001"; b_tb <= "0001"; cin_tb <= '0';
        wait for 10 ns;
        
        -- Prueba 3: 0011 + 0011 + 0
        a_tb <= "0011"; b_tb <= "0011"; cin_tb <= '0';
        wait for 10 ns;
        
        -- Prueba 4: 1111 + 0001 + 0
        a_tb <= "1111"; b_tb <= "0001"; cin_tb <= '0';
        wait for 10 ns;
        
        -- Prueba 5: 1111 + 1111 + 1
        a_tb <= "1111"; b_tb <= "1111"; cin_tb <= '1';
        wait for 10 ns;
        
        -- Finaliza simulación
        wait;
    end process;
end architecture;
