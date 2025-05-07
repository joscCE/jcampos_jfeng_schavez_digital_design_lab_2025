
module tb_connect_four;

    logic clk;
    logic rstin;
    logic [2:0] player0in, player1in;
    logic p0in, p1in;
    logic startin;

    logic Hs, Vs;
    logic VGA_Blank, VGA_Sync_N, VGA_CLK;
    logic [7:0] R, G, B;
    logic [3:0] debug_colum;
    logic [7:0] seg0, seg1;
	 

	 always #10 clk = ~clk;  // 50 MHz


    // Instancia del DUT (Device Under Test)
    connect_four dut (
        .clk(clk),
        .rstin(rstin),
        .player0in(player0in),
        .player1in(player1in),
        .p0in(p0in),
        .p1in(p1in),
        .startin(startin),
        .Hs(Hs),
        .Vs(Vs),
        .VGA_Blank(VGA_Blank),
        .VGA_Sync_N(VGA_Sync_N),
        .VGA_CLK(VGA_CLK),
        .R(R),
        .G(G),
        .B(B),
        .debug_colum(debug_colum),
        .seg0(seg0),
        .seg1(seg1)
    );
	
    initial begin
        // Inicialización
        clk = 0;
        rstin = 1;
        player0in = 3'b111;
        player1in = 3'b111;
        p0in = 0;
        p1in = 0;
        startin = 1;

        // Reset activo
        #100;
		  rstin = 0;
		  #10_000_000;
		  rstin = 1;
		  #100;
		  
		  // Start Game
		  
        $display("\n>>> Iniciando juego con boton START");
		  
		  #100;
		  startin = 0;
		  #15_000_000;
		  #100;
		  
		  $display("Start: %b", dut.start);
		  
		  startin = 1;
		  #15_000_000;
		  
		  $display("Start: %b", dut.start);
		  
		  #100
		  
        $display("\n>>> Jugador 0 selecciona columna presionando 'R'");
        player0in = 3'b101; // R presionado
        #40;
        player0in = 3'b111;

        #300;
		  
		  $display("\n>>> Jugador 0 selecciona play ");
        player0in = 3'b011; // R presionado
        #40;
        player0in = 3'b111;
		  $display("Movimiento: %b", dut.Reg_Play.Q);

        #300;
		  
		  

        #1000;

        $display(">>> Fin de la simulacion");
        $finish;
    end
	 



endmodule
