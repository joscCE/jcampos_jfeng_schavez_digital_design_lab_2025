`timescale 1ns/1ps
module ALU_tb;
    parameter N = 4;
    logic [N-1:0] a, b;
    logic [3:0] op;
    logic [N-1:0] y;
    logic [4:0] f;
    
    ALU #(.N(N)) uut (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .f(f)
    );
    
    task check;
        input [N-1:0] expected_y;
        input [4:0] expected_f;
        begin
            #10;
            if (y !== expected_y || f !== expected_f) begin
                $display("Test failed for op = %b, a = %b, b = %b", op, a, b);
                $display("Expected y = %b, f = %b, but got y = %b, f = %b", expected_y, expected_f, y, f);
            end else begin
                $display("Test passed for op = %b, a = %b, b = %b", op, a, b);
            end
        end
    endtask
    
    initial begin
        $display("Starting ALU testbench...");
        
		  
		  $display("ADDITION");
        // ADDITION
        a = 4'b0011; b = 4'b0001; op = 4'b0000; check(4'b0100, 5'b00000); // 3 + 1 = 4 (sin acarreo)
        a = 4'b1111; b = 4'b0001; op = 4'b0000; check(4'b0000, 5'b00111); // 15 + 1 = 16 (acarreo y cero)
        $display("");
		  
        // SUBTRACTION
		  $display("SUBTRACTION");
        a = 4'b0100; b = 4'b0001; op = 4'b0001; check(4'b0011, 5'b00000); // 4 - 1 = 3 (sin negativo)
        a = 4'b0001; b = 4'b0010; op = 4'b0001; check(4'b0001, 5'b01000); // 1 - 2 = -1 (negativo)
        $display("");
		  
        // MULTIPLICATION
		  $display("MULTIPLICATION");
        a = 4'b0011; b = 4'b0010; op = 4'b0010; check(4'b0110, 5'b00000); // 3 * 2 = 6 (sin desbordamiento)
        a = 4'b1111; b = 4'b0010; op = 4'b0010; check(4'b1110, 5'b00001); // 15 * 2 = 30 (desbordamiento)
        $display("");
		  
        // DIVISION
		  $display("DIVISION");
        a = 4'b1000; b = 4'b0010; op = 4'b0011; check(4'b0100, 5'b00000); // 8 / 2 = 4 (sin error)
        a = 4'b1000; b = 4'b0000; op = 4'b0011; check(4'b0000, 5'b10100); // 8 / 0 = error (división por cero)
        $display("");
		  
        // MODULO
		  $display("MODULO");
        a = 4'b1001; b = 4'b0011; op = 4'b0100; check(4'b0000, 5'b00100); // 9 % 3 = 0 (sin error)
        a = 4'b1010; b = 4'b0000; op = 4'b0100; check(4'bxxxx, 5'b10000); // 10 % 0 = error (modulo por cero)
        $display("");
		  
        // AND
		  $display("AND");
        a = 4'b1100; b = 4'b1010; op = 4'b0101; check(4'b1000, 5'b00000); // 12 & 10 = 8 (sin error)
        a = 4'b1111; b = 4'b0000; op = 4'b0101; check(4'b0000, 5'b00100); // 15 & 0 = 0 (resultado cero)
        $display("");
		  
        // OR
		  $display("OR");
        a = 4'b1100; b = 4'b1010; op = 4'b0110; check(4'b1110, 5'b00000); // 12 | 10 = 14 (sin error)
        a = 4'b0000; b = 4'b0000; op = 4'b0110; check(4'b0000, 5'b00100); // 0 | 0 = 0 (resultado cero)
        $display("");
		  
        // XOR
		  $display("XOR");
        a = 4'b1100; b = 4'b1010; op = 4'b0111; check(4'b0110, 5'b00000); // 12 ^ 10 = 6 (sin error)
        a = 4'b1111; b = 4'b1111; op = 4'b0111; check(4'b0000, 5'b00100); // 15 ^ 15 = 0 (resultado cero)
        $display("");
		  
        // SHIFT LEFT
		  $display("SHIFT LEFT");
        a = 4'b0011; b = 4'b0001; op = 4'b1000; check(4'b0110, 5'b00000); // 3 << 1 = 6 (sin error)
        a = 4'b0001; b = 4'b0011; op = 4'b1000; check(4'b1000, 5'b00000); // 1 << 3 = 8 (sin error)
        $display("");
		  
        // SHIFT RIGHT
		  $display("SHIFT RIGHT");
        a = 4'b1000; b = 4'b0001; op = 4'b1001; check(4'b0100, 5'b00000); // 8 >> 1 = 4 (sin error)
        a = 4'b1000; b = 4'b0011; op = 4'b1001; check(4'b0001, 5'b00000); // 8 >> 3 = 1 (sin error)
        $display("");
		  
        $display("ALU testbench completed.");
        $finish;
    end
endmodule
