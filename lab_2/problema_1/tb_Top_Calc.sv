`timescale 1ns / 1ps

module tb_Top_Calc();

    logic [3:0] a, b, op;
    logic sig, equ;
    logic [7:0] seg1, seg0, seg2, seg3, seg4;
    logic [4:0] flag;
    logic [3:0] expected_result;
    
    Top_Calc uut (
        .a(a), 
        .b(b), 
        .sig(sig), 
        .equ(equ), 
        .seg1(seg1), 
        .seg0(seg0), 
        .seg2(seg2), 
        .seg3(seg3), 
        .seg4(seg4), 
        .flag(flag)
    );
    
    task run_test(input logic [3:0] ta, input logic [3:0] tb, input logic [3:0] top, input logic [3:0] expected_result, input logic [4:0] expected_flags);
        begin
            a = ta;
            b = tb;
            op = top;
            #10 equ = 1; #10 equ = 0; // Ejecuta operación
            #50; // Mayor tiempo de espera
            if (uut.y !== expected_result || uut.flag !== expected_flags) begin
                $display("ERROR: A=%b, B=%b, OP=%b, Resultado esperado=%b, Obtenido=%b, Flags esperadas=%b, Obtenidas=%b", 
                         a, b, op, expected_result, uut.y, expected_flags, uut.flag);
            end else begin
                $display("OK: A=%b, B=%b, OP=%b, Resultado=%b, Flags=%b", a, b, op, uut.y, uut.flag);
            end
        end
    endtask
    
    initial begin
        $display("Inicio de Testbench");
		  
		  equ = 0; 
        
        $display("Suma");
        run_test(4'b0000, 4'b0001, 4'b0000, 4'b0001, 5'b00000); // 0 + 1 = 1
        run_test(4'b0100, 4'b0011, 4'b0000, 4'b0111, 5'b00000); // 4 + 3 = 7
        
        $display("Resta");
        run_test(4'b0110, 4'b0011, 4'b0001, 4'b0011, 5'b00000); // 6 - 3 = 3
        run_test(4'b0011, 4'b0100, 4'b0001, 4'b0001, 5'b01000); // 3 - 4 = -1 con negativo
        
        $display("Multiplicación");
        run_test(4'b0010, 4'b0011, 4'b0010, 4'b0110, 5'b00000); // 2 * 3 = 6
        run_test(4'b0100, 4'b0010, 4'b0010, 4'b1000, 5'b00000); // 4 * 2 = 8
        
        $display("División");
        run_test(4'b1000, 4'b0010, 4'b0011, 4'b0100, 5'b00000); // 8 / 2 = 4
        run_test(4'b0110, 4'b0011, 4'b0011, 4'b0010, 5'b00000); // 6 / 3 = 2
        
        $display("Módulo");
        run_test(4'b1010, 4'b0011, 4'b0100, 4'b0001, 5'b00000); // 10 % 3 = 1
        run_test(4'b0111, 4'b0010, 4'b0100, 4'b0001, 5'b00000); // 7 % 2 = 1
        
        $display("AND");
        run_test(4'b1100, 4'b1010, 4'b0101, 4'b1000, 5'b00000); // 12 AND 10 = 8
        run_test(4'b1100, 4'b0110, 4'b0101, 4'b0100, 5'b00000); // 12 AND 6 = 4
        
        $display("OR");
        run_test(4'b1100, 4'b1010, 4'b0110, 4'b1110, 5'b00000); // 12 OR 10 = 14
        run_test(4'b1100, 4'b0110, 4'b0110, 4'b1110, 5'b00000); // 12 OR 6 = 14
        
        $display("XOR");
        run_test(4'b1100, 4'b1010, 4'b0111, 4'b0110, 5'b00000); // 12 XOR 10 = 6
        run_test(4'b1100, 4'b0110, 4'b0111, 4'b1010, 5'b00000); // 12 XOR 6 = 10
        
        $display("SHIFT LEFT");
        run_test(4'b0010, 4'b0001, 4'b1000, 4'b0100, 5'b00000); // 2 << 1 = 4
        run_test(4'b0011, 4'b0001, 4'b1000, 4'b0110, 5'b00000); // 3 << 1 = 6
        
        $display("SHIFT RIGHT");
        run_test(4'b1000, 4'b0001, 4'b1001, 4'b0100, 5'b00000); // 8 >> 1 = 4
        run_test(4'b0100, 4'b0001, 4'b1001, 4'b0010, 5'b00000); // 4 >> 1 = 2
        
        $display("Fin de Testbench");
        $stop;
    end
    
endmodule
