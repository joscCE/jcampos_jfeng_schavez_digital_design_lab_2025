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

    // Reloj de 25 MHz
    initial begin
        clk = 0;
        forever #20 clk = ~clk;
    end

    // Estimulación
    initial begin
    rst = 0;
    #10 rst = 1;
    #10 rst = 0;


    #200_000;  
    $finish;
	end

    // Monitor
    initial begin
        $monitor("t=%0t | Hs=%b Vs=%b | R=%h G=%h B=%h | Qx=%d Qy=%d",
                 $time, Hs, Vs, R, G, B, Q_xz, Q_yz);
    end

    // Dump para GTKWave
    initial begin
        $dumpfile("vga_controller_tb.vcd");
        $dumpvars(0, tb_Vga_Controller);
    end

endmodule
