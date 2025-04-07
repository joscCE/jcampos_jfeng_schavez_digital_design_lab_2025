module tb_Vga_Controller;

    logic clk;
    logic rst;

    logic Hs, Vs;
    logic [7:0] R, G, B;
    logic [9:0] Q_xz;
    logic [9:0] Q_yz;

    Vga_Controller uut (
        .clk(clk),
        .rst(rst),
        .Hs(Hs),
        .Vs(Vs),
        .R(R),
        .G(G),
        .B(B),
        .Q_xz(Q_xz),
        .Q_yz(Q_yz)
    );

    // Reloj de 25 MHz (20 ns de período)
    initial begin
        clk = 0;
        forever #20 clk = ~clk;
    end

    // Estimulación
    initial begin
        rst = 0;
        #10 rst = 1;
        #10 rst = 0;

        // Máximo tiempo para recorrer 640x480
        // 800 x 525 = 420,000 ciclos
        // 420,000 x 20ns = 8.4 ms
        #8_500_000;  
        $display("🟢 Simulación terminada (aproximadamente 1 frame VGA).");
        $finish;
    end

    // Mostrar solo cuando esté en la zona visible
    always_ff @(posedge clk) begin
        if (Q_xz < 640 && Q_yz < 480) begin
            $display("Qx=%0d Qy=%0d | RGB: %h %h %h | Hs=%b Vs=%b",
                     Q_xz, Q_yz, R, G, B, Hs, Vs);
        end

        // Cortar la simulación cuando llegue al último pixel visible
        if (Q_xz == 639 && Q_yz == 479) begin
            $display("✅ Se recorrió toda la zona visible de 640x480.");
            $finish;
        end
    end

    // Dump para GTKWave
    initial begin
        $dumpfile("vga_controller_tb.vcd");
        $dumpvars(0, tb_Vga_Controller);
    end

endmodule
