module tb_Top_Sub();
    parameter N2 = 2;
    parameter N4 = 4;
    parameter N6 = 6;
    
    reg [N6-1:0] a;
    reg reset, dec_btn;
    wire [7:0] seg1_2, seg0_2, seg1_4, seg0_4, seg1_6, seg0_6;
    wire [N2-1:0] value2;
    wire [N4-1:0] value4;
    wire [N6-1:0] value6;
    reg clk;
    always #5 clk = ~clk;

    Top_Sub #(.N(N2)) dut2 (
        .a(a[N2-1:0]), .reset(reset), .dec_btn(dec_btn), .clk(clk),
        .seg1(seg1_2), .seg0(seg0_2), .value(value2)
    );
    
    Top_Sub #(.N(N4)) dut4 (
        .a(a[N4-1:0]), .reset(reset), .dec_btn(dec_btn), .clk(clk),
        .seg1(seg1_4), .seg0(seg0_4), .value(value4)
    );
    
    Top_Sub #(.N(N6)) dut6 (
        .a(a), .reset(reset), .dec_btn(dec_btn), .clk(clk),
        .seg1(seg1_6), .seg0(seg0_6), .value(value6)
    );

    initial begin
        $display("\nIniciando testbench para N=2, N=4 y N=6 bits\n");
        clk = 0;

        // Reset inicial
        a = 3;
        reset = 1; dec_btn = 0; #10;
        reset = 0;
        @(posedge clk);
        $display("RESET aplicado: N2=%0d, N4=%0d, N6=%0d", value2, value4, value6);
        
        // Decremento
        repeat (3) begin
            @(posedge clk);
            dec_btn = 1;
            @(posedge clk);
            dec_btn = 0;
            @(posedge clk);
            $display("DECREMENTO: N2=%0d, N4=%0d, N6=%0d", value2, value4, value6);
        end

        // Underflow
        a = 0;
        reset = 1; #10; reset = 0;
        @(posedge clk);
        
        // Generar underflow
        dec_btn = 1;
        @(posedge clk);
        dec_btn = 0;
        @(posedge clk);
        @(posedge clk); // Espera extra para que el valor se actualice correctamente
        
        if (value2 !== (2**N2 - 1))
            $display("ERROR Underflow (N=2): Esperado %0d, Obtenido %0d", (2**N2 - 1), value2);
        else
            $display("Underflow correcto (N=2): %0d", value2);
        
        if (value4 !== (2**N4 - 1))
            $display("ERROR Underflow (N=4): Esperado %0d, Obtenido %0d", (2**N4 - 1), value4);
        else
            $display("Underflow correcto (N=4): %0d", value4);
        
        if (value6 !== (2**N6 - 1))
            $display("ERROR Underflow (N=6): Esperado %0d, Obtenido %0d", (2**N6 - 1), value6);
        else
            $display("Underflow correcto (N=6): %0d", value6);

        $finish;
    end
endmodule
