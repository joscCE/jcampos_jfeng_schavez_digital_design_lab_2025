`timescale 1ns / 1ps

module Top_Controller_tb;

    // Señales de prueba
    logic [5:0] a;
    logic [3:0] b;
    logic btn;
    logic reset, dec_btn;
    logic [7:0] seg3, seg1, seg0;

    // Instancia del módulo a probar
    Top_Controller uut (
        .a(a),
        .b(b),
        .btn(btn),
        .reset(reset),
        .dec_btn(dec_btn),
        .seg3(seg3),
        .seg1(seg1),
        .seg0(seg0)
    );

    // Generación de reloj simulado para `btn`
    initial begin
        btn = 0;
        forever #10 btn = ~btn; // Cambia cada 10 ns (simula pulsaciones)
    end

    // Proceso de prueba
    initial begin

        // Inicialización
        a = 6'b000001;
        b = 4'b0001;
        reset = 0;
        dec_btn = 0;
        
        // Esperar un poco antes de iniciar pruebas
        #20;
        
        // **Prueba 1: Modo Decoder**
        $display("Modo Decoder (count = 00)");
        #20;

        // **Prueba 2: Modo Adder**
        $display("Modo Adder (count = 01)");
        #20;
        
        // **Prueba 3: Modo Subtract**
        reset = 1; // Activa el reset
        #5;
        reset = 0;
        dec_btn = 1; // Prueba decremento
        #10;
        dec_btn = 0;
        #20;

        // **Reiniciar ciclo**
        $display("Reiniciando...");
        #40;

        $finish; // Termina la simulación
    end

endmodule
