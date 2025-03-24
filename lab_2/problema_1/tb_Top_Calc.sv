module tb_Top_Calc();

    logic clk, rst, sig, equ;
    logic [3:0] a, b;
    logic [7:0] seg1, seg0, seg2;

    // Instancia del DUT (Device Under Test)
    Top_Calc dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .sig(sig),
        .equ(equ),
        .seg1(seg1),
        .seg0(seg0),
        .seg2(seg2)
    );

    // Generación del clock
    always #5 clk = ~clk; // Periodo de 10 unidades de tiempo

    // Proceso de prueba
    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        sig = 0;
        equ = 0;
        a = 4'd5;  // Operando A
        b = 4'd3;  // Operando B
        #10 rst = 0; // Liberar reset

        // Test: SUMA (5 + 3 = 8)
        assert (seg2 == 8'b11000000) else $error("Error en SUMA, seg2 incorrecto");
        #10 equ = 1; #10 equ = 0;
        assert ({seg1, seg0} == 16'b1100000010100100) else $error("Error en resultado SUMA"); // 8 en 7 segmentos
        
        // Cambio a RESTA (5 - 3 = 2)
        #10 sig = 1; #10 sig = 0;
        assert (seg2 == 8'b11111001) else $error("Error en RESTA, seg2 incorrecto");
        #10 equ = 1; #10 equ = 0;
        assert ({seg1, seg0} == 16'b1100000010100100) else $error("Error en resultado RESTA"); // 2 en 7 segmentos

        // Cambio a MULTIPLICACIÓN (5 * 3 = 15)
        #10 sig = 1; #10 sig = 0;
        assert (seg2 == 8'b10100100) else $error("Error en MULTIPLICACIÓN, seg2 incorrecto");
        #10 equ = 1; #10 equ = 0;
        assert ({seg1, seg0} == 16'b1111100111000000) else $error("Error en resultado MULTIPLICACIÓN"); // 15 en 7 segmentos

        // Cambio a DIVISIÓN (5 / 3 = 1)
        #10 sig = 1; #10 sig = 0;
        assert (seg2 == 8'b10110000) else $error("Error en DIVISIÓN, seg2 incorrecto");
        #10 equ = 1; #10 equ = 0;
        assert ({seg1, seg0} == 16'b1111100111000000) else $error("Error en resultado DIVISIÓN"); // 1 en 7 segmentos

        // Finaliza la simulación
        #50 $finish;
    end

endmodule
