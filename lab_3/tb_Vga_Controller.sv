module tb_Vga_Controller;

    logic clk;
    logic rst;

    logic Hs, Vs;
    logic VGA_Blank, VGA_Sync_N;
    logic [7:0] R, G, B;
    logic [9:0] Q_xz;
    logic [9:0] Q_yz;

    // Instanciar el módulo VGA
    Vga_Controller uut (
        .clk(clk),
        .rst(rst),
        .Hs(Hs),
        .Vs(Vs),
        .VGA_Blank(VGA_Blank),
        .VGA_Sync_N(VGA_Sync_N),
        .R(R),
        .G(G),
        .B(B),
        .Q_xz(Q_xz),
        .Q_yz(Q_yz)
    );

    // Reloj de 25 MHz (40 ns por ciclo completo)
    initial begin
        clk = 0;
        forever #20 clk = ~clk;
    end

    // Reset inicial
    initial begin
        rst = 1;
        #60 rst = 0;
    end

    // Monitor que imprime todo el recorrido (800x525)
    always_ff @(posedge clk) begin
        $display("Qx=%0d Qy=%0d | RGB=(%02h,%02h,%02h) | Hs=%b Vs=%b | Blank=%b Sync_N=%b",
                  Q_xz, Q_yz, R, G, B, Hs, Vs, VGA_Blank, VGA_Sync_N);

        // Fin de frame completo
        if (Q_xz == 799 && Q_yz == 524) begin
            $display("✅ Se recorrió toda la zona VGA (800x525).");
            $finish;
        end
    end

    // Dump para GTKWave
    initial begin
        $dumpfile("vga_controller_tb.vcd");
        $dumpvars(0, tb_Vga_Controller);
    end

endmodule
