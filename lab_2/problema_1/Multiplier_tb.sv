
module Multiplier_tb;

    // Definir señales de prueba
    logic [3:0] a, b;
    logic [7:0] p;

    // Instancia del DUT (Device Under Test)
    Multiplier uut (
        .a(a),
        .b(b),
        .p(p)
    );

    // Proceso de prueba
    initial begin
        
        // Casos de prueba
        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b0001; b = 4'b0001; #10;
        a = 4'b0011; b = 4'b0010; #10;
        a = 4'b0101; b = 4'b0011; #10;
        a = 4'b1111; b = 4'b1111; #10;
        a = 4'b1010; b = 4'b0101; #10;
        

    end

endmodule