`timescale 1ns/1ps

module top_div_tb;

    logic [3:0] a, b;
    logic [3:0] quotient;
    logic error;

    // Prueba
    top_div #(.N(4)) dut (
        .dividend(a),
        .divisor(b),
        .quotient(quotient),
        .error(error)
    );

    initial begin

        // Caso 1: División normal (8 / 2)
        a = 4'b1000;  // 8
        b = 4'b0010;  // 2
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        // Caso 2: División exacta (6 / 3)
        a = 4'b0110;  // 6
        b = 4'b0011;  // 3
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        // Caso 3: División con residuo (7 / 3)
        a = 4'b0111;  // 7
        b = 4'b0011;  // 3
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        // Caso 4: División entre 1 (9 / 1)
        a = 4'b1001;  // 9
        b = 4'b0001;  // 1
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        // Caso 5: División de 0 (0 / 5)
        a = 4'b0000;  // 0
        b = 4'b0101;  // 5
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        // Caso 6: División por 0 (Error esperado)
        a = 4'b0110;  // 6
        b = 4'b0000;  // 0
        #10;
        $display("a = %d, b = %d -> quotient = %d, error = %b", a, b, quotient, error);

        $stop;
    end

endmodule
