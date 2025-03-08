module tb_Top_Sub();
    parameter N = 6; // Cambiar a 2, 4 o 6 para pruebas
    
    reg [N-1:0] a;
    reg reset, dec_btn;
    wire [7:0] seg1, seg0;
    wire [N-1:0] value;
    
    Top_Sub #(.N(N)) dut (
        .a(a),
        .reset(reset),
        .dec_btn(dec_btn),
        .seg1(seg1),
        .seg0(seg0)
    );
    
    initial begin
        $display("Iniciando testbench para N=%0d bits", N);
        
        // Caso 1: Reset inicializa el valor
        a = 'd3; // Valor inicial, ajustable
        reset = 1; dec_btn = 0; #10;
        reset = 0;
        if (dut.value !== a) 
            $display("ERROR: Reset fallido. Esperado %0d, obtenido %0d", a, dut.value);
        else 
            $display("Reset correcto: %0d", dut.value);
        
        // Caso 2: Decremento
        repeat (N) begin
            dec_btn = 1; #10; dec_btn = 0; #10;
            if (dut.value !== a - 1) 
                $display("ERROR: Decremento fallido. Esperado %0d, obtenido %0d", a - 1, dut.value);
            else 
                $display("Decremento correcto: %0d", dut.value);
            a = a - 1;
        end
        
        // Caso 3: Verificar underflow (cuando llega a 0)
        reset = 1; #10; reset = 0;
        a = 0;
        dec_btn = 1; #10; dec_btn = 0; #10;
        if (dut.value !== {N{1'b1}}) 
            $display("ERROR: Underflow fallido. Esperado %0d, obtenido %0d", {N{1'b1}}, dut.value);
        else 
            $display("Underflow correcto: %0d", dut.value);
        
        $display("Testbench finalizado correctamente.");
        $finish;
    end
endmodule
