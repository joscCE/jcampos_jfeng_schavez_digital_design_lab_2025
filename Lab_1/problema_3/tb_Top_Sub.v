module tb_Top_Sub();
    parameter N = 2;  // Cambiar a 2, 4 o 6 para probar diferentes tamaños
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
        a = 'b11;   // Valor de entrada a
        reset = 1;
        dec_btn = 1;  // Inicializamos dec_btn en alto (botón no presionado)
        expected_value = a;
        #10 reset = 0;  // Desactivamos el reset
        
        // Verificación del reset
        #10;
        if (dut.value !== expected_value) begin
            $display("ERROR: Reset failed for N=%0d bits", N);
            $stop;
        end
        
        // Ahora presionamos el botón de decremento una vez
        #10 dec_btn = 0;  // Botón presionado
        #10 dec_btn = 1;  // Botón liberado
        
        expected_value = expected_value - 1;
        
        // Verificamos que el valor se haya decrementado
        #10;
        if (dut.value !== expected_value) begin
            $display("ERROR: Decrement failed for N=%0d at value %0d", N, dut.value);
            $stop;
        end
        
        // Ahora presionamos el botón de decremento una vez más
        #10 dec_btn = 0;  // Botón presionado
        #10 dec_btn = 1;  // Botón liberado
        
        expected_value = expected_value - 1;
        
        // Verificamos que el valor se haya decrementado nuevamente
        #10;
        if (dut.value !== expected_value) begin
            $display("ERROR: Decrement failed for N=%0d at value %0d", N, dut.value);
            $stop;
        end
        
        // Si todo va bien, completamos el test
        $display("Test completed successfully for N=%0d bits", N);
        $finish;
    end
endmodule
