
`timescale 1ns / 1ps

module tb_connect_four;

    // Entradas
    logic clk, rst, p0, p1;
    logic [2:0] player0, player1;
	 logic start;

    // Salidas
    logic Hs, Vs;
    logic VGA_Blank, VGA_Sync_N, VGA_CLK;
    logic [7:0] R, G, B;

    // Instancia del DUT
    connect_four uut (
        .clk(clk),
        .rst(rst),
        .player0(player0),
        .player1(player1),
        .p0(p0),
        .p1(p1),
		  .start(start),
        .Hs(Hs),
        .Vs(Vs),
        .VGA_Blank(VGA_Blank),
        .VGA_Sync_N(VGA_Sync_N),
        .VGA_CLK(VGA_CLK),
        .R(R),
        .G(G),
        .B(B)
    );

    // Generación de reloj 50MHz
    initial clk = 0;
    always #10 clk = ~clk;

    // Proceso de simulación
    initial begin
        // Inicialización
        $display("Iniciando simulación...");
        rst = 1;
		  #50
		  rst = 0;
        p0 = 0;
        p1 = 0;
        player0 = 3'b000;  // Movimiento de jugador 0 (por ejemplo: Presionar botón Izquierda)
        player1 = 3'b000;  // Movimiento de jugador 1 (por ejemplo: Presionar botón Derecha)
        #100;

        // Turno del jugador 0
        $display("Turno del jugador 0");
        p0 = 1;    // Activamos señal de jugador 0
        #50;
        p0 = 0;
        #200;

        // Turno del jugador 1
        $display("Turno del jugador 1");
        p1 = 1;    // Activamos señal de jugador 1
        #50;
        p1 = 0;
        #200;
		  
		  $display("Comenzar juego");
		  start = 0;
		  start = 1;
		  #50
		  start = 0;

        // Final de la simulación
        $display("Fin de simulación.");
        $finish;
    end

endmodule
