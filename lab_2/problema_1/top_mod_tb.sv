`timescale 1ns/1ps

module top_mod_tb;

    logic [3:0] a, b;
    logic [3:0] remainder_mod;
    logic error_mod;

    //
    top_mod #(.N(4)) dut (
        .dividend(a),
        .divisor(b),
        .remainder(remainder_mod),
        .error(error_mod)
    );

    // Prueba
    initial begin

        // Caso 1: Módulo normal (8 % 2)
        a = 4'b1000;  // 8
        b = 4'b0010;  // 2
        #10;
        $display("a = %d, b = %d -> modulo = %d, error_mod = %b", a, b, remainder_mod, error_mod);

        // Caso 2: Módulo exacto (6 % 3)
        a = 4'b0110;  // 6
        b = 4'b0011;  // 3
        #10;
        $display("a = %d, b = %d -> modulo = %d, error_mod = %b", a, b, remainder_mod, error_mod);

        // Caso 3: Módulo con residuo (7 % 3)
        a = 4'b0111;  // 7
        b = 4'b0011;  // 3
        #10;
        $display("a = %d, b = %d -> modulo = %d, error_mod = %b", a, b, remainder_mod, error_mod);

        // Caso 4: Módulo de 0 (0 % 5)
        a = 4'b0000;  // 0
        b = 4'b0101;  // 5
        #10;
        $display("a = %d, b = %d -> modulo = %d, error_mod = %b", a, b, remainder_mod, error_mod);

        // Caso 5: Módulo por 0 (Error esperado)
        a = 4'b0110;  // 6
        b = 4'b0000;  // 0
        #10;
        $display("a = %d, b = %d -> remainder_mod = %d, error_mod = %b", a, b, remainder_mod, error_mod);

        $stop;
    end

endmodule
