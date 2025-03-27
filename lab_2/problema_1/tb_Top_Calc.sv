`timescale 1ns / 1ps

module tb_Top_Calc;
    parameter N = 4;
    logic [N-1:0] a, b, y_expected, y_obtained;
    logic [3:0] op;
    logic [4:0] f;
    
    ALU #(.N(N)) uut (
        .a(a),
        .b(b),
        .op(op),
        .y(y_obtained),
        .f(f)
    );

    task run_test(input [3:0] operation, input [N-1:0] a_in, input [N-1:0] b_in, input [N-1:0] expected);
        begin
            op = operation;
            a = a_in;
            b = b_in;
            y_expected = expected;
            #10;
            
            $display("\Operación: %b", op);
            $display("a        = %b", a);
            $display("b        = %b", b);
            $display("Esperado = %b", y_expected);
            $display("Obtenido = %b", y_obtained);

            if (y_obtained !== y_expected) 
                $display("❌ ERROR: Resultado incorrecto\n");
            else 
                $display("✅ Test OK\n");
        end
    endtask
    
    initial begin
        $display("========== Iniciando Testbench ==========\n");
        
        // Pruebas de Shift con máscara
        run_test(4'b1000, 4'b1110, 4'b1100, 4'b1110 << (4'b1100 & (N-1)));
        run_test(4'b1000, 4'b1010, 4'b0011, 4'b1010 << (4'b0011 & (N-1)));
        run_test(4'b1001, 4'b1110, 4'b1100, 4'b1110 >> (4'b1100 & (N-1)));
        run_test(4'b1001, 4'b1010, 4'b0011, 4'b1010 >> (4'b0011 & (N-1)));

        // Pruebas adicionales: Suma, Resta, AND, OR, XOR
        run_test(4'b0000, 4'b0011, 4'b0101, 4'b0011 + 4'b0101); // Suma
        run_test(4'b0001, 4'b1010, 4'b0100, 4'b1010 - 4'b0100); // Resta
        run_test(4'b0010, 4'b1100, 4'b1010, 4'b1100 & 4'b1010); // AND
        run_test(4'b0011, 4'b1100, 4'b1010, 4'b1100 | 4'b1010); // OR
        run_test(4'b0100, 4'b1100, 4'b1010, 4'b1100 ^ 4'b1010); // XOR

        $display("========== Testbench Finalizado ==========");
        $finish;
    end
    
endmodule