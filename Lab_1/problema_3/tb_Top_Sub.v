module tb_Top_Sub();
    parameter N = 2; // Cambiar a 2, 4 o 6 para probar diferentes tamaños
    reg [N-1:0] a;
    reg reset;
    reg dec_btn;
    wire [7:0] seg1, seg0;
    
    
    Top_Sub #(N) dut (
        .a(a),
        .reset(reset),
        .dec_btn(dec_btn),
        .seg1(seg1),
        .seg0(seg0)
    );
    
    reg [N-1:0] expected_value;
    
    initial begin
        // Inicialización
        a = 'b11;
        reset = 1;
        dec_btn = 0;
        expected_value = a;
        #10 reset = 0;
        
        // Verificación del reset
        #10;
        if (dut.value !== expected_value) begin
            $display("ERROR: Reset failed for %0d bits", N);
            $stop;
        end
        
        // Prueba de decremento
        repeat (2 ** N) begin
            #10 dec_btn = 1; #10 dec_btn = 0;
            expected_value = expected_value - 1;
            
            #10;
            if (dut.value !== expected_value) begin
                $display("ERROR: Decrement failed for N=%0d at value %0d", N, dut.value);
                $stop;
            end
        end
        
        $display("Test completed successfully for N=%0d bits", N);
        $finish;
    end
endmodule